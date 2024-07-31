page 50569 "Session Events"
{
    Caption = 'Change Log Entry';
    PageType = List;
    SourceTable = "Session Event";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Session ID"; Rec."Session ID")
                {
                }
                field("Event Type"; Rec."Event Type")
                {
                }
                field("Event Datetime"; Rec."Event Datetime")
                {
                }
                field("Client Type"; Rec."Client Type")
                {
                }
                field("Database Name"; Rec."Database Name")
                {
                }
                field("Client Computer Name"; Rec."Client Computer Name")
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
