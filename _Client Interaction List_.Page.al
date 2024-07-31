page 50847 "Client Interaction List"
{
    AutoSplitKey = true;
    CardPageID = "Client Interaction Card";
    PageType = ListPart;
    SourceTable = "Client Interaction Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                }
                field("Interaction Type Desc."; Rec."Interaction Type Desc.")
                {
                }
                field("Interaction Resolution Desc."; Rec."Interaction Resolution Desc.")
                {
                }
                field("Interaction Type No."; Rec."Interaction Type No.")
                {
                }
                field("Interaction Resolution No."; Rec."Interaction Resolution No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Assigned to User"; Rec."Assigned to User")
                {
                }
                field("Last Updated Date and Time"; Rec."Last Updated Date and Time")
                {
                }
                field("Assign Remarks"; Rec."Assign Remarks")
                {
                }
                field("Date of Interaction"; Rec."Date of Interaction")
                {
                }
                field("Client No."; Rec."Client No.")
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
                field(Notes; Rec.Notes)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}
