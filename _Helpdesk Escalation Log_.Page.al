page 50713 "Helpdesk Escalation Log"
{
    Caption = 'Helpdesk Escalation Log';
    PageType = List;
    SourceTable = "ICT Escalations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Enabled = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Escalation Option"; Rec."Escalation Option")
                {
                    ApplicationArea = All;
                }
                field("Escalator No."; Rec."Escalator No.")
                {
                    ApplicationArea = All;
                }
                field("Escalator User ID"; Rec."Escalator User ID")
                {
                    ApplicationArea = All;
                }
                field("Escalator Name"; Rec."Escalator Name")
                {
                    ApplicationArea = All;
                }
                field("Escalation Email"; Rec."Escalation Email")
                {
                    ApplicationArea = All;
                }
                field("Escalation date"; Rec."Escalation date")
                {
                    ApplicationArea = All;
                }
                field("Escalation Time"; Rec."Escalation Time")
                {
                    ApplicationArea = All;
                }
                field("Resolution Date"; Rec."Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Resolution time"; Rec."Resolution time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
