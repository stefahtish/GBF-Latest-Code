table 50706 Religion
{
    Caption = 'Religion';
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
        field(3; Religion; Text[400])
        {
            Caption = 'Religion';
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
        fieldgroup(DropDown; "code", Religion)
        {
        }
    }
}
