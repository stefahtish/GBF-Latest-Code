table 50528 "Audit Categories"
{
    Caption = 'Audit Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Code[100])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Category)
        {
            Clustered = true;
        }
    }
}
