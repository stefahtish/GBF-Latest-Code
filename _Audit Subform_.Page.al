page 50898 "Audit Subform"
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
                field("Audit Type"; Rec."Audit Type")
                {
                }
                field("Audit Type Description"; Rec."Audit Type Description")
                {
                }
                field("Assessment Rating"; Rec."Assessment Rating")
                {
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                }
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                }
            }
        }
    }
    actions
    {
    }
}
