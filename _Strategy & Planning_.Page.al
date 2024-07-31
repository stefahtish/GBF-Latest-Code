page 51362 "Strategy & Planning"
{
    PageType = RoleCenter;
    Caption = 'Project Management';
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(reporting)
        {
            separator(Action28)
            {
            }
        }
        area(embedding)
        {
        }
        area(creation)
        {
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            separator(Action38)
            {
            }
        }
        // separator(History)
        // {
        //     Caption = 'History';
        //     IsHeader = true;
        // }
        //     // action("Navi&gate")
        //     // {
        //     //     ApplicationArea = Basic, Suite;
        //     //     Caption = 'Navi&gate';
        //     //     Image = Navigate;
        //     //     RunObject = Page Navigate;
        //     //     ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
        //     // }
        // }
        area(sections)
        {
            group(Approvals)
            {
            }
            group("Self service")
            {
                group(Imprest)
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
                        //   RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
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
            group("Project Management")
            {
                Caption = 'Project Management';
                Image = FiledPosted;

                Group("Projects")
                {
                    action("Project Details Entry1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Projects';
                        RunObject = page ProjectDataCaptureList;
                    }
                    action("Projects Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projects Pending Approval';
                        RunObject = page ProjectSPendingApproval;
                    }
                    action("Projects Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projects Approved';
                        RunObject = page ProjectManagementList;
                    }
                    action("Projects Rejected")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projects Rejected';
                        RunObject = page ProjectRejectedList;
                    }
                }
                action("Project Identification")
                {
                    applicationarea = basic, suite;
                    RunObject = page ProjectIdentification;
                }
                action("Project Initiation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Initiation';
                    RunObject = page ProjectInitiationList;
                }
                action("Project Implementation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Implementation';
                    RunObject = page ProjectPlanList;
                }
                group("Project Monitoring,Evaluation,Audit & Reporting")
                {
                    action("Open Projects")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Project Monitoring,Evaluation,Audit';
                        RunObject = page ProjectExecutionOpen;
                    }
                    action("Projects in Progress")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projects in Progress';
                        RunObject = page ProjectWorkinProgress;
                        visible = false;
                    }
                    action("Projects in Progress Overdue")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projects in Progress(Overdue)';
                        RunObject = page ProjectWorkinProgressOverdue;
                        visible = false;
                    }
                    action("Project Report")
                    {
                        Visible = false;
                        Image = Report;
                        ApplicationArea = all;
                        RunObject = report "Project Management";
                    }
                }
                Group("Project Closure")
                {
                    action("Project Review")
                    {
                        //ApplicationArea = Assembly;
                        Caption = 'Project Review';
                        RunObject = page ProjectClosedlists;
                        visible = false;
                    }
                    action("Project Closed")
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Project Closed';
                        RunObject = page ProjectClosedlists;
                    }
                }
                Group(Setup)
                {
                    action("Setup1")
                    {
                        ApplicationArea = all;
                        Caption = 'Project Type';
                        RunObject = page Projecttype;
                    }
                    action("Setup2")
                    {
                        ApplicationArea = all;
                        Caption = 'Charge Out Rates';
                        RunObject = page ProjectChargeOutRate;
                    }
                }
            }
        }
    }
}
