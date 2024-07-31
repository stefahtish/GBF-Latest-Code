table 50143 "Tender Mandatory Requirements"
{
    fields
    {
        field(1; "Tender No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Mandatory Requirement"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Tender No", "Mandatory Requirement")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
