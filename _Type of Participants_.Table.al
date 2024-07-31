table 50634 "Type of Participants"
{
    Caption = 'Type of Participants';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Participants, ActivityCategory;
        }
        field(3; Local; Boolean)
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
