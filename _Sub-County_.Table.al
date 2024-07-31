table 50485 "Sub-County"
{
    DrillDownPageID = "Sub-County List";
    LookupPageID = "Sub-County List";

    fields
    {
        field(1; "Sub-County Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Country Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(4; "County Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Region; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Station; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
    }
    keys
    {
        key(Key1; "Country Code", Region, "County Code", "Sub-County Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
