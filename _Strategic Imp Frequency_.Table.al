table 50311 "Strategic Imp Frequency"
{
    Caption = 'Strategic Implementation Frequency';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
