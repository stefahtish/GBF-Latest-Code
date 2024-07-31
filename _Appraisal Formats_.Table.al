table 50237 "Appraisal Formats"
{
    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Values,Core Competences,Curriculum Delivery,Research,Initiative & Willingness,Managerial & Supervisory';
            OptionMembers = Values, "Core Competences", "Curriculum Delivery", Research, "Initiative & Willingness", "Managerial & Supervisory";
        }
        field(2; Indicator; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Type, Indicator)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
