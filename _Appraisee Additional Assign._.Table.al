table 50708 "Appraisee Additional Assign."
{
    Caption = 'Appraisee Additional Assignment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Assignment; Text[2048])
        {
            Caption = 'Assignment';
            DataClassification = ToBeClassified;
        }
        field(4; "Date Assigned"; Date)
        {
            Caption = 'Date Assigned';
            DataClassification = ToBeClassified;
        }
        field(5; "Assigned By"; Code[300])
        {
            Caption = 'Assigned By';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(6; "Implementation Status"; Text[2048])
        {
            Caption = 'Implementation Status';
            DataClassification = ToBeClassified;
        }
        field(7; "Date Of Completion"; Date)
        {
            Caption = 'Date Of Completion';
            DataClassification = ToBeClassified;
        }
        field(8; Evidence; Text[1048])
        {
            Caption = 'Evidence';
            DataClassification = ToBeClassified;
        }
        field(9; Remarks; Text[2048])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(10; "Agreed Performance Target"; Text[2048])
        {
            Caption = 'Agreed Performance Target';
            DataClassification = ToBeClassified;
        }
        field(11; "Performance Indicator"; Text[100])
        {
            Caption = 'Performance Indicator';
            DataClassification = ToBeClassified;
        }
        field(12; "Achieved Results"; Text[2000])
        {
            Caption = 'Achieved Results';
            DataClassification = ToBeClassified;
        }
        field(13; "Ratings Of % Level"; Decimal)
        {
            Caption = 'Ratings Of % Level';
            DataClassification = ToBeClassified;
        }
        field(14; "Performance Appraisal Score"; Decimal)
        {
            Caption = 'Performance Appraisal Score';
            DataClassification = ToBeClassified;
        }
        field(15; "Moderated Score"; Decimal)
        {
            Caption = 'Moderated Score';
            DataClassification = ToBeClassified;
        }
        field(16; Adhoc; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Appraisal No", "Date Assigned", Assignment, "Agreed Performance Target", "Assigned By", Adhoc, "Line No.")
        {
            Clustered = true;
        }
    }
}
