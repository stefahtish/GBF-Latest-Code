table 50488 Market
{
    DrillDownPageID = "Sub-County List";
    LookupPageID = "Sub-County List";

    fields
    {
        field(1; "Market Code"; Code[20])
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
        field(6; "Sub-County Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Country Code", Region, "County Code", "Sub-County Code", "Location Code", "Market Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
