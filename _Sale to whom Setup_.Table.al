table 50614 "Sale to whom Setup"
{
    Caption = 'Sale to whom Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Description)
        {
            Clustered = true;
        }
    }
}
