table 50401 "Imprest Deduction"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Imprest Deduction Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";

            trigger OnValidate()
            begin
                GenerateOverdueImprest;
            end;
        }
        field(4; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(7; "Posted By"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved, Released;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Imprest Deduction Nos");
            NoSeriesMgt.InitSeries(HRSetup."Imprest Deduction Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        PayrollPeriodX.SetRange("Close Pay", false);
        if PayrollPeriodX.FindFirst then Validate("Payroll Period", PayrollPeriodX."Starting Date");
        "Date Created":=Today;
        "Created By":=UserId;
    end;
    var HRSetup: Record "Human Resources Setup";
    PayrollPeriodX: Record "Payroll PeriodX";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure GenerateOverdueImprest(): Boolean var
        HRSetup: Record "Human Resources Setup";
        Imprest: Record Payments;
        ImprestSurrender: Record Payments;
        DeductionLine: Record "Imprest Deduction Line";
        DateDue: Date;
        LineNo: Integer;
        SurrenderedAmount: Decimal;
        Generated: Boolean;
    begin
        Generated:=false;
        HRSetup.Get;
        HRSetup.TestField("Imprest Due Days");
        DateDue:=CalcDate(StrSubstNo('-%1D', Format(HRSetup."Imprest Due Days")), Today);
        DeductionLine.Reset;
        DeductionLine.SetRange("Document No.", "No.");
        if DeductionLine.FindFirst then DeductionLine.DeleteAll;
        LineNo:=0;
        Imprest.Reset;
        Imprest.SetRange("Payment Type", Imprest."Payment Type"::Imprest);
        Imprest.SetFilter("Due Date", '..%1', DateDue);
        Imprest.SetRange(Posted, true);
        Imprest.SetRange(Surrendered, false);
        Imprest.SetRange("Payroll Transfered", false);
        if Imprest.FindFirst then repeat SurrenderedAmount:=0;
                LineNo+=10000;
                DeductionLine.Init;
                DeductionLine."Document No.":="No.";
                DeductionLine."Line No.":=LineNo;
                DeductionLine."Imprest No":=Imprest."No.";
                DeductionLine."Payroll Period":="Payroll Period";
                ImprestSurrender.Reset;
                ImprestSurrender.SetRange("Payment Type", Imprest."Payment Type"::"Imprest Surrender");
                ImprestSurrender.SetRange("Imprest Issue Doc. No", Imprest."No.");
                ImprestSurrender.SetRange(Posted, true);
                if ImprestSurrender.FindFirst then repeat ImprestSurrender.CalcFields("Actual Amount Spent", "Cash Receipt Amount");
                        SurrenderedAmount+=ImprestSurrender."Actual Amount Spent";
                        SurrenderedAmount+=ImprestSurrender."Cash Receipt Amount";
                    until ImprestSurrender.Next = 0;
                Imprest.CalcFields("Imprest Amount");
                DeductionLine.Amount:=Imprest."Imprest Amount" - SurrenderedAmount;
                if DeductionLine.Amount > 0 then begin
                    DeductionLine.Insert;
                    DeductionLine.Validate("Employee No.", Imprest."Staff No.");
                    DeductionLine.Modify;
                    Generated:=true;
                end;
            until Imprest.Next = 0;
        if Generated then exit(true)
        else
            exit(false);
    end;
}
