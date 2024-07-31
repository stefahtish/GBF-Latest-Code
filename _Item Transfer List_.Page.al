page 50215 "Item Transfer List"
{
    CardPageID = "Item Transfer";
    PageType = List;
    SourceTable = "Item Transfer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Item; Rec.Item)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Receiving Employee"; Rec."Receiving Employee")
                {
                }
                field("Receiving Name"; Rec."Receiving Name")
                {
                }
                field("Company To"; Rec."Company To")
                {
                }
                field("Company From"; Rec."Company From")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
            }
        }
    }
    actions
    {
    }
}
