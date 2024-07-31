table 50385 "Hotel Bill Header"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Bill Nos");
                    "No Series":='';
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";
        }
        field(5; "Total Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Bill Nos");
            NoSeriesMgt.InitSeries(HRSetup."Bill Nos", xRec."No Series", 0D, No, "No Series");
        end;
        "Created By":=UserId;
        Date:=Today;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
}
