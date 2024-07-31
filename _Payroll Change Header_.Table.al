table 50382 "Payroll Change Header"
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
                    PaySeries.TestManual(HRSetup."Payroll Change Nos");
                    "No Series":='';
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(6; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
        }
        field(8; "No Series"; Code[50])
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
        HRSetup.Get;
        if No = '' then begin
            HRSetup.TestField("Payroll Change Nos");
            PaySeries.InitSeries(HRSetup."Payroll Change Nos", xRec."No Series", 0D, No, "No Series")end;
    end;
    var PaySeries: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
}
