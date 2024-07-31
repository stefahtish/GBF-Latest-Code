table 50703 "Managerial Values"
{
    Caption = 'Managerial Values';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Core Managerial Values"; Text[2048])
        {
            Caption = 'Core Managerial Values';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
