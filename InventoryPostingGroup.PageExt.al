pageextension 50154 InventoryPostingGroup extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(Lab; Rec.Lab)
            {
                ApplicationArea = All;
            }
        }
    }
}
