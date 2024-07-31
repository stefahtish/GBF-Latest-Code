table 50523 "Perfomance rating matrix"
{
    fields
    {
        field(1; Code; Code[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Start"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Grade; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}
