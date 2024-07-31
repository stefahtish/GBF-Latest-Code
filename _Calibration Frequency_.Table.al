table 50337 "Calibration Frequency"
{
    Caption = 'Calibration Frequency';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Frequency; Text[100])
        {
            Caption = 'Frequency';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Frequency)
        {
            Clustered = true;
        }
    }
}
