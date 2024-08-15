page 51276 "General Management Cues"
{
    Caption = 'General Management Cues';
    PageType = CardPart;
    SourceTable = "General Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Imprest)
            {
                field(Imprests; Rec.Imprests)
                {
                    Caption = 'Open';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Imprests"; Rec."Pending Imprests")
                {
                    Caption = 'Pending';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Imprest"; Rec."Approved Imprest")
                {
                    Caption = 'Approved';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            cuegroup("Imprests Surrenders")
            {
                Caption = 'Imprest Surrenders';

                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    Caption = 'Open';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Imprest Surrenders-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Imprest Surrenders"; Rec."Pending Imprest Surrenders")
                {
                    Caption = 'Pending';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Imprest Surrenders";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Imprest Surrenders"; Rec."Approved Imprest Surrenders")
                {
                    Caption = 'Approved';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Imprest Surrenders-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            cuegroup("Store request")
            {
                field("Store Request List"; Rec."Store Request List")
                {
                    DrillDownPageId = "Store Request List-General";
                }
                field("Approved Store Request"; Rec."Approved Store Request")
                {
                    DrillDownPageId = "Store Request List-General";
                }
            }
            cuegroup("Staff claims")
            {
                field("Staff Claims List"; Rec."Staff Claims List")
                {
                    DrillDownPageId = "Staff Claim List-General";
                }
                field("Pending Staff Claim List"; Rec."Pending Staff Claim List")
                {
                    DrillDownPageId = "Pending Staff Claim List";
                }
                field("Approved Staff Claim"; Rec."Approved Staff Claim")
                {
                    DrillDownPageId = "Approved Staff Claim";
                }
            }
            cuegroup("Purchase Request")
            {
                field("Purchase Request List"; Rec."Purchase Request List")
                {
                    DrillDownPageId = "Purchase Request List-General";
                }
                field("Purchase Request Approved"; Rec."Purchase Request Approved")
                {
                    DrillDownPageId = "Purchase Request List-General";
                }
            }
            cuegroup("Training Request")
            {
                field("Training Request List"; Rec."Training Request List")
                {
                    DrillDownPageId = "Training Request List-General";
                }
                field("Approved Training Request List"; Rec."Approved Training Request List")
                {
                    DrillDownPageId = "Training Request List-General";
                }
            }
            cuegroup("Travel Request")
            {
                field("Transport Requests"; Rec."Transport Requests")
                {
                    DrillDownPageId = "Transport requests -General";
                }
                field("Approved Travel Requests"; Rec."Approved Travel Requests")
                {
                    DrillDownPageId = "Transport requests -General";
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                }
            }
            cuegroup("Project Management")
            {
                Caption = 'Project Management';
                Visible = true;

                field("Open Projects"; Rec."Open Projects")
                {
                    ToolTip = 'Specifies the value of the Open Projects field.';
                    ApplicationArea = All;
                    DrilldownpageID = "ProjectManagementList";
                }
                field("Projects Pending Approval"; Rec."Projects Pending Approval")
                {
                    ToolTip = 'Specifies the value of the Projects Pending Approval field.';
                    ApplicationArea = All;
                    DrilldownpageID = "ProjectManagementList";
                }
                field("Approved Projects"; Rec."Approved Projects")
                {
                    ToolTip = 'Specifies the value of the Approved Projects field.';
                    ApplicationArea = All;
                    DrilldownpageID = "ProjectManagementList";
                }
                field("Projects in Progress"; Rec."Projects in Progress")
                {
                    ToolTip = 'Specifies the value of the Projects in Progress field.';
                    ApplicationArea = All;
                    DrilldownpageID = ProjectWorkinProgress;
                }
                field("Projects in Progress(Overdue)"; Rec."Projects in Progress(Overdue)")
                {
                    ToolTip = 'Specifies the value of the Projects in Progress(Overdue) field.';
                    ApplicationArea = All;
                    DrilldownpageID = ProjectWorkinProgressOverdue;
                    Caption = 'Projects Overdue';
                }
                field("Closed Projects"; Rec."Closed Projects")
                {
                    ToolTip = 'Specifies the value of the Closed Projects field.';
                    ApplicationArea = All;
                    DrilldownpageID = ProjectClosedlists;
                }
            }
            cuegroup("Contract Management")
            {
                Caption = 'Contract Management';
                Visible = true;

                field("Open Contracts"; Rec."Open Contracts")
                {
                    ToolTip = 'Specifies the value of the Open Contracts field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects List";
                }
                field("Running Contracts"; Rec."Running Contracts")
                {
                    ToolTip = 'Specifies the value of the Running Contracts field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects Approved";
                }
                field("Completed Contracts"; Rec."Completed Contracts")
                {
                    ToolTip = 'Specifies the value of the Completed Contracts field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects Finished";
                }
                field("Contracts Pending Verification"; Rec."Contracts Pending Verification")
                {
                    ToolTip = 'Specifies the value of the Contracts Pending Verification field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects Pending Verification";
                }
                field("Suspended Contracts"; Rec."Suspended Contracts")
                {
                    ToolTip = 'Specifies the value of the Suspended Contracts field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects Suspended";
                }
                field("Verified Contracts"; Rec."Verified Contracts")
                {
                    ToolTip = 'Specifies the value of the Verified Contracts field.';
                    ApplicationArea = All;
                    DrilldownpageID = "Projects Verified";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID Filter", UserId);
            end;
        end;
        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
