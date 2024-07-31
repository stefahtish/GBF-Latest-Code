page 50866 "Interaction List"
{
    CardPageID = "Client Interaction Card";
    PageType = List;
    SourceTable = "Client Interaction Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Interact Code"; Rec."Interact Code")
                {
                }
                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("Interaction Type No."; Rec."Interaction Type No.")
                {
                }
                field("Interaction Resolution No."; Rec."Interaction Resolution No.")
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Assigned to User"; Rec."Assigned to User")
                {
                }
                field("Last Updated Date and Time"; Rec."Last Updated Date and Time")
                {
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                }
                field("Is Escalated"; Rec."Is Escalated")
                {
                }
                field("Interaction Type Desc."; Rec."Interaction Type Desc.")
                {
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
                field("Assigned Flag"; Rec."Assigned Flag")
                {
                }
                field("Escalation Level No."; Rec."Escalation Level No.")
                {
                }
                field("Escalation Level Name"; Rec."Escalation Level Name")
                {
                }
                field("Escalation Clock"; Rec."Escalation Clock")
                {
                }
                field("Interaction Resolution Desc."; Rec."Interaction Resolution Desc.")
                {
                }
                field("Assign Remarks"; Rec."Assign Remarks")
                {
                }
                field("Client Name"; Rec."Client Name")
                {
                }
                field("Client Type"; Rec."Client Type")
                {
                }
                field("Client Phone No."; Rec."Client Phone No.")
                {
                }
                field("Client Email"; Rec."Client Email")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                }
                field("Client Feedback"; Rec."Client Feedback")
                {
                }
                field("Reviewing Officer Remarks"; Rec."Reviewing Officer Remarks")
                {
                }
                field("Interaction Cause No."; Rec."Interaction Cause No.")
                {
                }
                field("Interaction Cause Desc."; Rec."Interaction Cause Desc.")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Client")
            {
                Caption = '&Client';

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Client Interaction Card";
                    RunPageLink = "Interact Code" = FIELD("Interact Code");
                }
            }
        }
    }
}
