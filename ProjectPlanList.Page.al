page 51348 ProjectPlanList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = ProjectPlanCard;
    SourceTable = ProjectIdentification;
    Caption = 'Project Implemetation';
    sourcetableview = where("Under implementation"=const(true));
    RefreshOnActivate = true;
    Editable = false;

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
                    Visible = false;
                }
                field("Project Estimated Cost"; Rec."Project Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Project Estimated Cost field.';
                    ApplicationArea = All;
                    Caption = 'Estimated Budget';
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing) //navigation
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
// trigger OnOpenPage()
// begin
//     if GuiAllowed then begin
//         if UserSetup.Get(UserId) then begin
//             SetRange("Project Manager", UserSetup."Employee No.");
//         end;
//     end else
//         Error('%1 does not exist in the Users Setup', UserId);
// end;
// var
//     UserSetup: Record "User Setup";
}
