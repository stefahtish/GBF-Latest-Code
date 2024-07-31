table 50318 "Professional Memberships"
{
    fields
    {
        field(1; Name; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[500])
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
