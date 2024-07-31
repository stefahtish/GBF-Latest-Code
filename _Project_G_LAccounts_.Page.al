page 51347 "Project_G/LAccounts"
{
    PageType = ListPart;
    Caption = 'G/L Accounts';
    SourceTable = ProjectManagementGLAccounts;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Project GL Account"; Rec."Project GL Account")
                {
                    ToolTip = 'Specifies the value of the Project GL Account field.';
                    ApplicationArea = All;
                }
                field("G/L Name"; Rec."G/L Name")
                {
                    ToolTip = 'Specifies the value of the G/L Name field.';
                    ApplicationArea = All;
                }
                field("G/L Actual Cost"; Rec."G/L Actual Cost")
                {
                    ToolTip = 'Specifies the value of the G/L Actual Cost field.';
                    ApplicationArea = All;
                }
                field("G/L Budgeted Cost"; Rec."G/L Budgeted Cost")
                {
                    ToolTip = 'Specifies the value of the G/L Budgeted Cost field.';
                    ApplicationArea = All;
                    Caption = 'G/L Budgeted Amount';
                }
            }
        }
    }
}
