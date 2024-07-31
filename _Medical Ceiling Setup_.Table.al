table 50150 "Medical Ceiling Setup"
{
    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;
        }
        field(2; "Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Salary Scale")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
