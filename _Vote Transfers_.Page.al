page 50290 "Vote Transfers"
{
    CardPageID = "Vote Transfer";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Votebook Transfer";
    SourceTableView = WHERE(Posted = CONST(false));
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
                field(Date; Rec.Date)
                {
                }
                field("Source Vote"; Rec."Source Vote")
                {
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                }
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
    actions
    {
    }
}
