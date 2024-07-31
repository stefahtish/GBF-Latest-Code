page 50858 "Interactions Escalation List"
{
    CardPageID = "Interaction Escalation Setup";
    PageType = ListPart;
    SourceTable = "Interactions Escalation Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Channel No."; Rec."Channel No.")
                {
                }
                field("Channel Name"; Rec."Channel Name")
                {
                }
                field("Level Code"; Rec."Level Code")
                {
                }
                field("Level Duration - Hours"; Rec."Level Duration - Hours")
                {
                }
                field("Distribution E-mail for Level"; Rec."Distribution E-mail for Level")
                {
                }
                field("Level Alert Time"; Rec."Level Alert Time")
                {
                }
            }
        }
    }
    actions
    {
    }
}
