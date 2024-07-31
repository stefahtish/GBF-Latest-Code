page 51398 "ProjectStatus"
{
    PageType = ListPart;
    Caption = 'Project Overal Status';
    SourceTable = "OverallProjectSummarry";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Current Status (%)"; Rec."Current Status")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                    ApplicationArea = All;
                }
                field("Previous Status (%)"; Rec."Previous Status")
                {
                    ToolTip = 'Specifies the value of the Previous Status field.';
                    ApplicationArea = All;
                }
                field("Overal Status Summary (%)"; Rec."Overal Status Summary")
                {
                    ToolTip = 'Specifies the value of the Overall Status Summary field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
