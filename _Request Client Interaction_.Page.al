page 50864 "Request Client Interaction"
{
    PageType = List;
    CardPageID = "Request Interaction Card";
    SourceTable = "Client Interaction Header";
    SourceTableView = where("Interaction Type" = filter(Request));
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
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                }
                field("Interaction Type No."; Rec."Interaction Type No.")
                {
                }
                field("Interaction Cause No."; Rec."Interaction Cause No.")
                {
                }
                field("Interaction Resolution No."; Rec."Interaction Resolution No.")
                {
                }
                field("Major Category"; Rec."Major Category")
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
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Last Updated Date and Time"; Rec."Last Updated Date and Time")
                {
                }
                field("Escalation Level No."; Rec."Escalation Level No.")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Complaint")
            {
                Caption = '&Complaint';

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
    trigger OnOpenPage()
    begin
        // SetRange(Status, Status::Closed);
        //SETRANGE("User ID",USERID);
    end;

    procedure GetClientInterNo() IntCode: Code[10]
    begin
        IntCode := Rec."Interact Code";
    end;

    procedure RecGet(var RecClientLine: Record "Client Interaction Header")
    begin
    end;
}
