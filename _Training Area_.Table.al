table 50316 "Training Area"
{
    fields
    {
        field(1; "Description"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Description)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
}
