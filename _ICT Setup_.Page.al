page 50558 "ICT Setup"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "ICT Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Incidence Nos"; Rec."Incidence Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Screenshot Path"; Rec."Screenshot Path")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registry E-Mail"; Rec."Registry E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registry CC"; Rec."Security E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registry BCC"; Rec."Registry BCC")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Escalation E-mail"; Rec."Escalation E-mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Nos"; Rec."Workplan Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activity Workplan Nos"; Rec."Activity Workplan Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("Corporate Communication")
            {
                field("Communication Nos"; Rec."Communication Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Communication E-Mail"; Rec."Communication E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
