table 50489 Stations
{
    Caption = 'Stations';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Station; Text[50])
        {
            Caption = 'Station';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Station)
        {
            Clustered = true;
        }
    }
}
