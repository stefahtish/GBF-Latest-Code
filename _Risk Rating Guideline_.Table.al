table 50516 "Risk Rating Guideline"
{
    fields
    {
        field(1; Rating; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Critical, Major, Moderate, Minor, Insignificant;
            OptionCaption = 'Critical,Major,Moderate,Minor,Insignificant';
        }
        field(2; "Financial"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Regulatory; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Legal; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Reputational; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Customer; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; People; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Reporting; Text[2000])
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
