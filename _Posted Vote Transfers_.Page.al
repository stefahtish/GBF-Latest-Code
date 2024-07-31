page 50292 "Posted Vote Transfers"
{
    CardPageID = "Vote Transfer Post";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Votebook Transfer";
    SourceTableView = WHERE(Posted = CONST(true));
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
