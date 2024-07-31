page 51402 "Project Risk"
{
    PageType = ListPart;
    Caption = 'Project Risk';
    SourceTable = "ProjectRisk";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Current Status"; Rec."Current Status 1")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                    ApplicationArea = All;
                }
                field("Previous Status"; Rec."Previous Status 1")
                {
                    ToolTip = 'Specifies the value of the Previous Status field.';
                    ApplicationArea = All;
                }
                field("Project Risks"; Rec."Project Risks")
                {
                    ToolTip = 'Specifies the value of the Project Risks field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
