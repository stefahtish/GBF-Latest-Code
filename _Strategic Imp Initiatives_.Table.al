table 50313 "Strategic Imp Initiatives"
{
    Caption = 'Strategic Implementation Initiatives';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SNo."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Initiatives; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ObjectiveCode; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Strategic Objectives"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Timelines; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Target No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Self Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Performance Appraisal Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Moderated Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Mark Out of Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "SNo.", Initiatives, ObjectiveCode, "Target No.", "Employee No.", "Appraisal Period")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "SNo.", Initiatives)
        {
        }
    }
}
