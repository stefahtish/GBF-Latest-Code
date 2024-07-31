table 50468 "Resolution Steps"
{
    DrillDownPageID = "Resolution Steps List";
    LookupPageID = "Resolution Steps List";

    fields
    {
        field(1; "Interaction Resol. Code"; Code[20])
        {
            TableRelation = "Interaction Resolution"."No.";
        }
        field(2; "Step Number"; Integer)
        {
        }
        field(3; "Resolution Description"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Interaction Resol. Code", "Step Number")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
