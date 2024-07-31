table 50518 "Risk RAG Status Guideline"
{
    fields
    {
        field(1; Option; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "VERY HIGH", HIGH, AMBER, GREEN;
            OptionCaption = 'VERY HIGH,HIGH,AMBER,GREEN';
        }
        field(2; Treatment; Text[2000])
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
