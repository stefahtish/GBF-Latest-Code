table 50517 "Risk Likelihood Guideline"
{
    fields
    {
        field(1; Rating; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Very High", High, Medium, Low, "Very Low";
            OptionCaption = 'Very High,High,Medium,Low,Very Low';
        }
        field(2; Likelihood; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Rating)
        {
            Clustered = true;
        }
    }
}
