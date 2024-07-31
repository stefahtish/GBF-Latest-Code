page 50259 "Delegate User Profile"
{
    CardPageID = "Delegate Profile";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Delegate User Profile";
    SourceTableView = WHERE(Status = FILTER(New));
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
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}
