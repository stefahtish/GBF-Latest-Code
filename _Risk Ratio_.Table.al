table 50512 "Risk Ratio"
{
    fields
    {
        field(1; "Risk Category"; Code[20])
        {
            TableRelation = "Risk Categories";
            DataClassification = ToBeClassified;
        }
        field(2; "Min.Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Max.Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Risk Category")
        {
        }
    }
    fieldgroups
    {
    }
}
