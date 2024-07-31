table 50500 "Risk Rating"
{
    fields
    {
        field(1; Rating; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Descriptor; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Rating)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
