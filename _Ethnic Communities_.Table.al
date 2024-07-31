table 50272 "Ethnic Communities"
{
    DrillDownPageID = "Ethnic Communities";
    LookupPageID = "Ethnic Communities";

    fields
    {
        field(1; "Ethnic Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ethnic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Ethnic Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Ethnic Code", "Ethnic Name")
        {
        }
    }
}
