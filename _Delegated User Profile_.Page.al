page 50261 "Delegated User Profile"
{
    CardPageID = "Delegate Profile";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Delegate User Profile";
    SourceTableView = WHERE(Status = FILTER(Assigned));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
            }
        }
    }
    actions
    {
    }
}
