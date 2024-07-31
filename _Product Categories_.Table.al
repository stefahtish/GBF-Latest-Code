table 50617 "Product Categories"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Category; Text[100])
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
