table 50270 "Ethnic Groups"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ethnic Group"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code", "Ethnic Group")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
