table 50227 "Leave Bal Adjustment Header"
{
    DrillDownPageId = "Leave Adjustment List";
    LookupPageId = "Leave Adjustment List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; EnteredBy; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if EnteredBy = '' then begin
                    EnteredBy:=UserId;
                end;
            end;
        }
        field(9; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Leave Brought Forward,Leave Adjustment';
            OptionMembers = " ", "Leave Brought Forward", "Leave Adjustment";
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Leave Adjustment Nos");
            NoSeriesMgt.InitSeries(HRSetup."Leave Adjustment Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
        EnteredBy:=UserId;
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            MaturityDate:=CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;
        "Maturity Date":=MaturityDate;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    AccPeriod: Record "Accounting Period";
    MaturityDate: Date;
}
