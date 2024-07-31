table 50144 "Bidder Mandatory Requirements"
{
    fields
    {
        field(1; "Tender No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Company Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Mandatory Requirement"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Complied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Tender No", "Company Name", "Mandatory Requirement")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
