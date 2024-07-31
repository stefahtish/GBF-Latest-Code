table 50388 "Bill Types"
{
    fields
    {
        field(1; "Bill Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "G/L Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Bill Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
