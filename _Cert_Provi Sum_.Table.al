table 50536 "Cert_Provi Sum"
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
