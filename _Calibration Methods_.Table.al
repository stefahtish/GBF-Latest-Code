table 50336 "Calibration Methods"
{
    Caption = 'Calibration Methods';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Method; Text[100])
        {
            Caption = 'Method';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Method)
        {
            Clustered = true;
        }
    }
}
