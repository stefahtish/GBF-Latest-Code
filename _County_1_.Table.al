table 50746 "County_1"
{
    fields
    {
        field(1; County; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "County Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; County)
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
