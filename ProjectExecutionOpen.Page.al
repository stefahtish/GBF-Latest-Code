page 51351 ProjectExecutionOpen
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    CardPageId = ProjectExecutionMonitoring;
    SourceTable = ProjectIdentification;
    Caption = 'Monitoring,Evaluation & Audit Card';
    Sourcetableview = where("Under Monitoring & Evaluation"=const(true));

    //RefreshOnActivate = true;
    //Editable = false;
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
                field(ProjectStatus; Rec."Project Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Project Manager"; Rec."Project Manager name")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                }
                field("Under Monitoring & Evaluation"; Rec."Under Monitoring & Evaluation")
                {
                    ToolTip = 'Specifies the value of the Under Monitoring & Evaluation field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    //ApplicationArea = All;
                    visible = false;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    // actions
    // {
    //     area(Processing)//navigation
    //     {
    //         action(ActionName)
    //         {
    //             //ApplicationArea = All;
    //             trigger OnAction();
    //             begin
    //             end;
    //         }
    //     }
    // }
    actions
    {
        area(Processing)
        {
            group(Approvals)
            {
                action(Close)
                {
                    Caption = 'Close';
                    Visible = false;
                // trigger OnAction()
                // begin
                //     if Confirm('Are you sure you want to close this Project?', false) = true then
                //         "Project Status" := "Project Status"::Closed;
                //     Modify;
                // end;
                }
            }
        }
    }
    // trigger OnOpenPage()
    // begin
    //     if GuiAllowed then begin
    //         if UserSetup.Get(UserId) then begin
    //             SetRange("Project Manager code", UserSetup."Employee No.");
    //         end;
    //     end else
    //         Error('%1 does not exist in the Users Setup', UserId);
    // end;
    var
//UserSetup: Record "User Setup";
}
