table 50559 "Means of Handling Setup"
{
    Caption = 'Means of Handling Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Modes of Handling"; Code[50])
        {
            Caption = 'Modes of Handling';
            DataClassification = ToBeClassified;
        }
        field(2; "Means of Handling"; Option)
        {
            Caption = 'Means of Handling';
            DataClassification = ToBeClassified;
            OptionMembers = " ", "On Transit", Premise;
        }
        field(3; "No vehicle registration no"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Modes of Handling")
        {
            Clustered = true;
        }
    }
}
