page 51414 "Self Service RoleCenter"
{
    Caption = 'Self Service RoleCenter';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part("Approval Cues"; "Approval Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Self Service Cues"; "Self Service Cue")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
        }
        area(sections)
        {
            group(Payments)
            {
                action(Imprests)
                {
                    RunObject = Page "Imprests-General";
                }
                action("Imprest Surrenders ")
                {
                    RunObject = Page "Imprest Surrenders-General";
                }
                action("Staff Claim List ")
                {
                    RunObject = Page "Staff Claim List-General";
                }
            }
            group(Requistions)
            {
                action("Purchase Request List ")
                {
                    RunObject = Page "Purchase Request List-General";
                }
                action("Store Request List ")
                {
                    RunObject = Page "Store Request List-General";
                }
            }
            group("Leave Process")
            {
                action("Leave Applications List")
                {
                    RunObject = Page "Self-Service Leave Application";
                }
                action("Open Reliever Approvals")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Self Service Application 1";
                    //RunPageLink = Status = filter("Reliever Open");
                }
                action("Reliever Approved Leave Applications")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Self-Service Leave Application";
                    //  RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
                }
                action("Leave Planner")
                {
                    RunObject = page "Self Service Leave Planner";
                }
            }
            group("Training")
            {
                action("Training Requests List ")
                {
                    RunObject = Page "Training Request List-General";
                }
                action("Post Training Evaluation List")
                {
                    ApplicationArea = all;
                    RunObject = page "Post Training List";
                }
            }
            group("Performance Management")
            {
                action("Target Setup List ~ New")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "New Targets List";
                }
                action("Target Under Review")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Targets Under Review";
                }
                action("Approved Targets List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Approved Targets List";
                }
                action("Appraisal List - New")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List";
                }
                action("Appraisal List - Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = Status = CONST("Pending Approval");
                }
                action("Appraisal Periods")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Periods";
                }
                action("Managerial Core Values/competence")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Managerial Core Values Setup";
                }
                action("Core Values/Competece")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Core Value/Competence Setup";
                }
                action("Rating Scale")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Rating Scale List";
                }
                action("Appraisal Preamble Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Preamble Setup";
                }
            }
            group("Reports")
            {
                action(Payslip)
                {
                    Caption = 'My Payslip';
                    RunObject = report "New Payslipx-Self Service";
                }
                action(P9)
                {
                    Caption = 'My P9';
                    RunObject = report "P9A Report-Self Service";
                }
                action(CustomerStatement)
                {
                    Caption = 'My Customer Statement';
                    RunObject = report "Customer Statement";
                }
            }
        }
    }
}
