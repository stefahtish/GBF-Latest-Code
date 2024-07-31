table 50363 "Bracket TablesX"
{
    fields
    {
        field(1; "Bracket Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Bracket Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Effective Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Effective End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Annual; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Fixed,Graduating Scale';
            OptionMembers = "Fixed", "Graduating Scale";
        }
    }
    keys
    {
        key(Key1; "Bracket Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
