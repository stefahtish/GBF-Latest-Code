table 50705 Districts
{
    Caption = 'Districts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; code, Name)
        {
        }
    }
}
