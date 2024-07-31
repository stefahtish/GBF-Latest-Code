table 50534 "Cert_Contract Amount"
{
    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Delivarable; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Conract No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "In Progress", Accepted, "Not Due", Due;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Consoltancy Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Provisional Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Conract No.", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
