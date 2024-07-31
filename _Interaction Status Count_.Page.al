page 50874 "Interaction Status Count"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Integer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control9)
            {
                ShowCaption = false;

                field(TotalLogged; TotalLogged)
                {
                    Caption = 'Total Logged';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(TotalAssigned; TotalAssigned)
                {
                    Caption = 'Total Assigned';
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field(TotalEscalated; TotalEscalated)
                {
                    Caption = 'Total Escalated';
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field(TotalAwaitingThirdParty; TotalAwaitingThirdParty)
                {
                    Caption = 'Total Awaiting 3rd Party';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(TotalClosed; TotalClosed)
                {
                    Caption = 'Total Closed';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(TotalRegistry; TotalRegistry)
                {
                    Caption = 'Total Registry';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(TotalAwaitingAssign; TotalAwaitingAssign)
                {
                    Caption = 'Total Awaiting Assignment';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        TotalLogged := ClientInteractionHeader.CountInteractions(0);
        TotalAssigned := ClientInteractionHeader.CountInteractions(1);
        TotalEscalated := ClientInteractionHeader.CountInteractions(2);
        TotalAwaitingThirdParty := ClientInteractionHeader.CountInteractions(3);
        TotalClosed := ClientInteractionHeader.CountInteractions(4);
        TotalRegistry := ClientInteractionHeader.CountInteractions(5);
        TotalAwaitingAssign := ClientInteractionHeader.CountInteractions(6);
        // MESSAGE(FORMAT(TotalLogged));
    end;

    var
        TotalLogged: Integer;
        TotalAssigned: Integer;
        TotalEscalated: Integer;
        TotalAwaitingThirdParty: Integer;
        TotalClosed: Integer;
        TotalRegistry: Integer;
        TotalAwaitingAssign: Integer;
        ClientInteractionHeader: Record "Client Interaction Header";
}
