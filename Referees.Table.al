table 50254 Referees
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Names; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Company; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Telephone No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
