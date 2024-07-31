table 50509 "Risk Domain"
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
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Impact Code", "Domain Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
