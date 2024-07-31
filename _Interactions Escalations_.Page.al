page 50879 "Interactions Escalations"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Interaction Escalations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Escalation Employee No."; Rec."Escalation Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Escalation Employee Name"; Rec."Escalation Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Escalation Email"; Rec."Escalation Email")
                {
                    ApplicationArea = All;
                }
                // field(Notes; Notes)
                // {
                // }
                // field(User; User)
                // {
                // }
                field(DateTime; Rec.DateTime)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("First Notification"; Rec."First Notification")
                {
                    ApplicationArea = All;
                }
                field("Second Notification"; Rec."Second Notification")
                {
                    ApplicationArea = All;
                }
                field("Last Notification Date"; Rec."Last Notification Date")
                {
                    ApplicationArea = All;
                }
                // field("Resolution Status"; "Resolution Status")
                // {
                // }
                // field("Resolution Time"; "Resolution Time")
                // {
                // }
            }
        }
    }
    actions
    {
    }
}
