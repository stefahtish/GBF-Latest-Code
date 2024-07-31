table 50387 "Bill Levies"
{
    fields
    {
        field(1; "Bill Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bill Types";
        }
        field(2; "Levy Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Levy Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "G/L Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "Percentage Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
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
