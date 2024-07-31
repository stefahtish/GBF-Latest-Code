page 51343 ProjectManagementList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    EDITABLE = FALSE;
    CardPageId = ProjectDataCaptureCard;
    SourceTable = Projectman;
    Sourcetableview = where("Project approval status"=filter("approved"), "project status"=filter(open));
    RefreshOnActivate = true;
    Caption = 'Project Approved List';

    layout
    {
        area(Content)
        {
            repeater(Projects)
            {
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.';
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.';
                    ApplicationArea = All;
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ToolTip = 'Specifies the value of the Project Start Date field.';
                    ApplicationArea = All;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ToolTip = 'Specifies the value of the Project End Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ApprovalStatus; Rec."Project Approval Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                //Style = favorable;
                }
                field("Project Manager"; Rec."Project Manager name")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                //ApplicationArea = All;
                trigger OnAction();
                begin
                end;
            }
        }
    }
}
