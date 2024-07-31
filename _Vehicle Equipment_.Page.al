page 50408 "Vehicle Equipment"
{
    PageType = ListPart;
    SourceTable = "Vehicle Equipment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vehicle No"; Rec."Vehicle No")
                {
                    Visible = false;
                }
                field(Item; Rec.Item)
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field(Available; Rec.Available)
                {
                }
            }
        }
    }
    actions
    {
    }
}
