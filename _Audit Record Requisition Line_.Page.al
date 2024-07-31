page 50912 "Audit Record Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Code"; Rec."Audit Code")
                {
                }
                field("Audit Description"; Rec."Audit Description")
                {
                }
                field("Assessment Rating"; Rec."Assessment Rating")
                {
                }
                field("Audit Type"; Rec."Audit Type")
                {
                }
                field("Audit Type Description"; Rec."Audit Type Description")
                {
                }
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}
