tableextension 50119 ItemExt extends Item
{
    fields
    {
        field(50000; "Item G/L Budget Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50001; Location; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50002; "Batch No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Manufacture Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}
