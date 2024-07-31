table 50567 "Resource Allocation Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AllocationNo; Code[20])
        {
            Caption = 'AllocationNo';
            DataClassification = ToBeClassified;
        }
        field(2; "Type";enum "Purchase Line Type")
        {
        }
        field(3; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Item Category Code"=field(Category));

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("No.")then begin
                    Description:=Item.Description;
                    "Unit cost":=Item."Unit Cost";
                end;
            end;
        }
        field(4; "Description"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Category; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Unit cost");
                if "Unit cost" <> 0 then Amount:="Unit cost" * Quantity;
            end;
        }
        field(7; "Unit cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; AllocationNo, Type, "No.")
        {
            Clustered = true;
        }
    }
}
