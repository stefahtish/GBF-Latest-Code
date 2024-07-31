table 50119 Destination
{
    DrillDownPageID = "Destination Code";

    fields
    {
        field(1; "Destination Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Destination Name"; Text[50])
        {
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "Local", Foreign;
        }
        field(4; "Other Area"; Boolean)
        {
        }
        field(5; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
    }
    keys
    {
        key(Key1; "Destination Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
