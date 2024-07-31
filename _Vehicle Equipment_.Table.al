table 50268 "Vehicle Equipment"
{
    fields
    {
        field(1; "Vehicle No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Item; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(3; "Item Description"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Available; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Vehicle No", Item)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
