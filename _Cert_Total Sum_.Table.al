table 50537 "Cert_Total Sum"
{
    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Delivarable; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Conract No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Accepted, "Not Due", Due;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Total; Decimal)
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
