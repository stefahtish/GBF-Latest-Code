page 51352 ProjectClosedlists
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = ProjectClosedcard;
    SourceTable = ProjectIdentification;
    Caption = 'Projects Closed';
    //Sourcetableview = where("project Status" = filter(closed), "Project Approval Status" = filter(approved));
    SourceTableView = where("Project Closed"=const(true));
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
                field(ProjectStatus; Rec."Project Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Project Manager"; Rec."Project Manager code")
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
                    Caption = 'Archive';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to close this Case?', false) = true then Rec."Project Status":=Rec."Project Status"::Closed;
                        Rec.Modify;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if GuiAllowed then begin
            if UserSetup.Get(Rec.UserId)then begin
                Rec.SetRange("Project Manager code", UserSetup."Employee No.");
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', Rec.UserId);
    end;
    var UserSetup: Record "User Setup";
}
