table 50508 "Risk Impact Descriptors"
{
    fields
    {
        field(1; "Impact Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Domain Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Impact Descriptior"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Impact Code", "Domain Code", "Impact Descriptior")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
