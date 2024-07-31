table 50539 "Work Progress"
{
    DrillDownPageID = "Work Progress";
    LookupPageID = "Work Progress";

    fields
    {
        field(1; "% Progress"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "% Progress")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
