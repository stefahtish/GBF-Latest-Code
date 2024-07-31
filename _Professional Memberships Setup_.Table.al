table 50294 "Professional Memberships Setup"
{
    fields
    {
        field(1; Name; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
