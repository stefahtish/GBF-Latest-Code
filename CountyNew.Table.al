table 50457 CountyNew
{
    DrillDownPageId = "County List";
    LookupPageId = "County List";

    fields
    {
        field(1; "County Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; County; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Country; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Country, "County Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; County, "County Code")
        {
        }
    }
}
