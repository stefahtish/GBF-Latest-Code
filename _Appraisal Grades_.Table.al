table 50235 "Appraisal Grades"
{
    fields
    {
        field(1; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Rating; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Score)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
