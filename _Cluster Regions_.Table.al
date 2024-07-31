table 50592 "Cluster Regions"
{
    Caption = 'Cluster Regions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Cluster Code"; Code[100])
        {
            Caption = 'Cluster Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Cluster Code")
        {
            Clustered = true;
        }
    }
}
