table 50618 "Product SubCategories"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; SubCategory; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; SubCategory)
        {
            Clustered = true;
        }
    }
}
