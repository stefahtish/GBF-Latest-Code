pageextension 50103 ItemCardPageExt extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Item G/L Budget Account"; Rec."Item G/L Budget Account")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Batch No"; Rec."Batch No")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Manufacture Date"; Rec."Manufacture Date")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = Basic, Suite;
            }
            field(Location; Rec.Location)
            {
                ApplicationArea = Basic, Suite;
                visible = false;
            }
        }
        addafter(ItemPicture)
        {
            part("Item Picture FactBox"; "Item Picture FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
    }
}
