table 50519 "Risk RAG Status"
{
    fields
    {
        field(1; Option; Option)
        {
            OptionMembers = "VERY HIGH", HIGH, AMBER, LOW;
            OptionCaption = 'VERY HIGH,HIGH,AMBER,LOW';
        }
        field(2; "Gross Risk start"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Gross Risk end"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Option)
        {
            Clustered = true;
        }
    }
}
