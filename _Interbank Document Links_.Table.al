table 50656 "Interbank Document Links"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; URL; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Document Name"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
