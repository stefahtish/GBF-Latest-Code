table 50338 "User Incidences Assets"
{
    Caption = 'User Incdences Assets';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Incident Ref"; Code[20])
        {
            Caption = 'Incident Ref';
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
        }
        field(3; "FA No."; Code[20])
        {
            Caption = 'FA No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Tag Number"; Text[100])
        {
            Caption = 'Tag Number';
            DataClassification = ToBeClassified;
        }
        field(5; "Serial Number"; Text[100])
        {
            Caption = 'Serial Number';
            DataClassification = ToBeClassified;
        }
        field(6; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Incident Ref", "Employee No.", "FA No.")
        {
            Clustered = true;
        }
    }
}
