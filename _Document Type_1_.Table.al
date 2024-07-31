table 50458 "Document Type_1"
{
    fields
    {
        field(1; "Document Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
