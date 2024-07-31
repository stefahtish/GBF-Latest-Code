table 50471 "Interaction Channel"
{
    DrillDownPageID = "Interaction Channels";
    LookupPageID = "Interaction Channels";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Day Start Time"; Time)
        {
        }
        field(4; "Day End Time"; Time)
        {
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
