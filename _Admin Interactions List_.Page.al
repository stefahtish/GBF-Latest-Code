page 50868 "Admin Interactions List"
{
    CardPageID = "Client Interaction Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Client Interaction Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interact Code"; Rec."Interact Code")
                {
                }
                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Client Name"; Rec."Client Name")
                {
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
                field("Interaction Type Description"; Rec."Interaction Type No.")
                {
                }
                field("Assigned to User"; Rec."Assigned to User")
                {
                }
                field("Datetime Claim Assigned"; Rec."Datetime Claim Assigned")
                {
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                }
            }
            // group("Interactions Status Count")
            // {
            //     Caption = 'Interactions Status Count';
            //     Visible = false;
            //     field("Logged, Assigned, Escalated"; NoOfTotalStatus)
            //     {
            //         Style = Strong;
            //         StyleExpr = TRUE;
            //     }
            //     field("Registry, Awaiting Assign"; NoOfTotalStatusII)
            //     {
            //         Style = Favorable;
            //         StyleExpr = TRUE;
            //     }
            //     field("Await 3rd Party, Closed"; NoOfTotalStatusIII)
            //     {
            //         Style = StrongAccent;
            //         StyleExpr = TRUE;
            //     }
            // }
            // group(Control8)
            // {
            //     ShowCaption = false;
            //     Visible = false;
            //     field(TotalLogged; TotalLogged)
            //     {
            //         Caption = 'Total Logged';
            //     }
            // field(TotalAssigned; TotalAssigned)
            // {
            //     Caption = 'Total Assigned';
            //     Style = Favorable;
            //     StyleExpr = TRUE;
            // }
            //     field(TotalEscalated; TotalEscalated)
            //     {
            //         Caption = 'Total Escalated';
            //         Style = Standard;
            //         StyleExpr = TRUE;
            //     }
            // field(TotalAwaitingThirdParty; TotalAwaitingThirdParty)
            // {
            //     Caption = 'Total Awaiting 3rd Party';
            //     Style = Attention;
            //     StyleExpr = TRUE;
            // }
            // field(TotalClosed; TotalClosed)
            // {
            //     Caption = 'Total Closed';
            //     Style = Strong;
            //     StyleExpr = TRUE;
            // }
            //     field(TotalRegistry; TotalRegistry)
            //     {
            //         Caption = 'Total Registry';
            //         Style = StandardAccent;
            //         StyleExpr = TRUE;
            //     }
            //     field(TotalAwaitingAssign; TotalAwaitingAssign)
            //     {
            //         Caption = 'Total Awaiting Assignment';
            //         Style = Unfavorable;
            //         StyleExpr = TRUE;
            //     }
            // }
        }
        area(factboxes)
        {
            part(Control24; "Oper. Case User Reg ListPart")
            {
            }
            part(Control26; "Interaction Status Count")
            {
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        // if UserSetup.Get(UserId) then begin
        //     if not UserSetup."Interactions Admin" then
        //         Error('You do not have permissions to view this page');
        // end else
        //     Error('User does not exist in user setup');
        TotalLogged := Rec.CountInteractions(0);
        TotalAssigned := Rec.CountInteractions(1);
        TotalEscalated := Rec.CountInteractions(2);
        TotalAwaitingThirdParty := Rec.CountInteractions(3);
        TotalClosed := Rec.CountInteractions(4);
        TotalRegistry := Rec.CountInteractions(5);
        TotalAwaitingAssign := Rec.CountInteractions(6);
        NoOfTotalStatus := 'Total Logged: ' + Format(TotalLogged) + '; Total Assigned: ' + Format(TotalAssigned) + '; Total Escalated: ' + Format(TotalEscalated);
        NoOfTotalStatusII := 'Total Registry: ' + Format(TotalRegistry) + '; Total Awaiting Assign: ' + Format(TotalAwaitingAssign);
        NoOfTotalStatusIII := 'Total Awaiting Third Party: ' + Format(TotalAwaitingThirdParty) + '; Total Closed: ' + Format(TotalClosed);
    end;

    var
        UserSetup: Record "User Setup";
        TotalLogged: Integer;
        TotalAssigned: Integer;
        TotalEscalated: Integer;
        TotalAwaitingThirdParty: Integer;
        TotalClosed: Integer;
        TotalRegistry: Integer;
        TotalAwaitingAssign: Integer;
        Text0001: Label '%1,%2,%3,%4,%5,%6,%7';
        NoOfTotalStatus: Text;
        NoOfTotalStatusII: Text;
        NoOfTotalStatusIII: Text;
        NoOfTotalStatusIV: Text;
}
