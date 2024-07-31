table 50122 "EFT File Naming"
{
    fields
    {
        field(1; Value; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Character; Code[5])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Value)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
