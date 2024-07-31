table 50365 "Loan Product Type"
{
    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate (Annual)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: 10;
        }
        field(4; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Flat Rate,Reducing Balance,Amortised';
            OptionMembers = " ", "Flat Rate", "Reducing Balance", Amortised;
        }
        field(5; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No of Instalment"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Loan No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(8; Rounding; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Nearest,Down,Up';
            OptionMembers = Nearest, Down, Up;
        }
        field(28; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 4;
            DataClassification = ToBeClassified;
        // MaxValue = 1;
        // MinValue = 0.0001;
        }
        field(29; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Advance,Other Loan';
            OptionMembers = Null, Advance, "Other Loan";
        }
        field(30; "Calculate Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Interest Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(32; "Deduction Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(33; Internal; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(35; "Interest Receivable Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(36; TPS; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Monthly,Quaterly,Semi-Annually,Annually,Biennial';
            OptionMembers = Monthly, Quaterly, "Semi-Annually", Annually, Biennial;
        }
        field(38; "Principal Receivable PG"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(39; "Interest Posting Group"; Code[50])
        {
            Caption = 'Interest Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Loan Category")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if not TPS then begin
            HRsetup.Get;
            HRsetup.TestField("Loan Product Type Nos.");
            NoSeriesMgt.InitSeries(HRsetup."Loan Product Type Nos.", xRec."No Series", 0D, Code, "No Series");
        end;
    end;
    var SalesSetup: Record "Sales & Receivables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    HRsetup: Record "Human Resources Setup";
}
