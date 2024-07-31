page 50513 "Contract Management RC"
{
    Caption = 'Contract Management RC';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Approval Cues"; "Approval Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action("Approval Request Entries")
            {
                RunObject = Page "Approval Request Entries";
            }
            action("Approval Entries")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Approval Entries';
                RunObject = Page "Approval Entries";
                RunPageLink = Procurement = const(true);
            }
        }
        area(sections)
        {
            group("Self service")
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
                    action("Petty Cash")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Petty Cash List-General";
                    }
                    action("Petty Cash Surrenders")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Petty Cash Surrenders-Gen";
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
                    action("Request for payment form")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Payment Form Requests General";
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
                action("Budget Approval List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Budget Approval List";
                }
            }
            Group("Contract Management")
            {
                Group("Contract Creation1")
                {
                    Caption = 'Contract Creation';

                    action("Contract Creation")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects List";
                        //RunPageView = where(field());
                    }
                    action("Contracts Verified")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects Verified";
                    }
                    action("Direct Contracts")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contracts List";
                    }
                    action("Direct Contracts Verified")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Projects Verified";
                    }
                }
                action("Running Contracts")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Projects Approved";
                }
                action("Direct Running Contracts")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Direct Running Contracts";
                }
                action("Contract Extension Requests")
                {
                    Caption = 'Contract Change Requests';
                    ApplicationArea = all;
                    RunObject = page "Contract Change List";
                }
                group("Contract Extension")
                {
                    action("Open Contract Extensions")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Open Contract Extensions";
                    }
                    action("Pending Contract Extensions")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Pending Contract Extensions";
                    }
                    action("Contracts Extended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Contracts Extended";
                    }
                    action("Direct Contract Extension")
                    {
                        Caption = 'Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where("Extension Status" = const(Open));
                    }
                    action("Direct Contract  Ext Pending")
                    {
                        Caption = 'Pending Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Direct Contract Ext Approved")
                    {
                        Caption = 'Approved Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where(Status = const(Approved));
                    }
                }
                group("Contract Suspension")
                {
                    action("Open Contract Suspensions")
                    {
                        Visible = false;
                        Caption = 'Contract Suspensions';
                        Image = List;
                        ApplicationArea = all;
                        //RunObject = page "Open Contract Suspensions";
                    }
                    action("Pending Contract Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Pending Contract Suspensions";
                    }
                    action("Contract Suspended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects Suspended";
                    }
                    action("Direct Contract Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        Caption = 'Open Direct Contract Suspensions';
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                        RunPageView = WHERE(Status = CONST("Pending Suspension"));
                    }
                    action("Pending Direct Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                        RunPageView = WHERE(type = CONST("Suspension"), Status = const("Pending Approval"));

                        ;
                    }
                    action("Direct Contracts Suspended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                    }
                }
                action("Contracts Terminated")
                {
                    ApplicationArea = all;
                    RunObject = page "Contracts Terminated";
                }
                action("Terminated Direct Contracts")
                {
                    Caption = 'Terminated Direct Contracts';
                    Image = List;
                    ApplicationArea = all;
                    RunObject = page "Direct Contracts Terminated";
                }
                action("Contracts Finished")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Projects Finished";
                }
                action("Direct Contracts Finished")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Finished Direct Contracts";
                }
                action("Contract Report")
                {
                    Caption = 'Contract Register';
                    Image = Report;
                    ApplicationArea = all;
                    RunObject = report "Contract Register";
                }
                action("Contract General Conditions Setup")
                {
                    ApplicationArea = all;
                    Caption = 'General Contract Condtions Setup';
                    RunObject = page "Contract General Conditions";
                }
                action("Contract Terms And Conditions")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Terms And Conditions';
                    RunObject = page "Contract Terms And Conditions";
                }
                action("Contract Committees")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Committee';
                    RunObject = page "Contract Committee List";
                }
            }
            group("Group41")
            {
                Caption = 'Setup';

                action("Purchases & Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchases & Payables Setup';
                    RunObject = page "Purchases & Payables Setup";
                }
                action("Order Due days Setup")
                {
                    ApplicationArea = basic, suite;
                    RunObject = page "Order Due days Threshold";
                }
            }
        }
    }
}
