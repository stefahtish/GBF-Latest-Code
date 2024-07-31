table 50341 "Appraisal Performance Factors"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; code; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; code)
        {
            Clustered = true;
        }
    }
}
