table 50697 "Project Lines"
{
    Caption = 'Project Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            // AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Objective"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Data Collection Method"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Limitation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Project No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
