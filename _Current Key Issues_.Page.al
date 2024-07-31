page 51400 "Current Key Issues"
{
    PageType = ListPart;
    Caption = 'Current Key Issues Affecting Project';
    SourceTable = "KeyIssuesCurrent";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Current Key Issues"; Rec."Current Key Issues")
                {
                    ToolTip = 'Specifies the value of the Key Issues Currently Affecting The System field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
