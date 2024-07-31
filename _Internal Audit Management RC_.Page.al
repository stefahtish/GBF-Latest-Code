page 51220 "Internal Audit Management RC"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = All;
            }
            part("Risk Management Cue"; "Risk Management Cues")
            {
                ApplicationArea = All;
            }
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Request To Approve")
            {
                Caption = 'Request To Approve';
                ApplicationArea = Basic, Suite;
                RunObject = Page "Requests to Approve";
            }
            action(ChampionSetup)
            {
                Caption = 'Risk Champions';
                ApplicationArea = Basic, Suite;
                RunObject = Page "Internal Audit Champions";
            }
            action("Project Setup")
            {
                Caption = 'Projects';
                ApplicationArea = Basic, Suite;
                RunObject = Page "Projects List";
            }
        }
        area(sections)
        {
            group("Self service")
            {
                action(Imprests)
                {
                    RunObject = Page "Imprests-General";
                }
                action("Imprest Surrenders ")
                {
                    RunObject = Page "Imprest Surrenders-General";
                }
                action("Request for payment form")
                {
                    RunObject = page "Payment Form Requests General";
                }
                action("Staff Claim List ")
                {
                    RunObject = Page "Staff Claim List-General";
                }
                action("Purchase Request List ")
                {
                    RunObject = Page "Purchase Request List-General";
                }
                action("Store Request List ")
                {
                    RunObject = Page "Store Request List-General";
                }
                action("Petty Cash")
                {
                    RunObject = page "Petty Cash List-General";
                }
                action("Petty Cash Surrenders")
                {
                    RunObject = page "Petty Cash Surrenders-Gen";
                }
                action("Leave Applications List")
                {
                    RunObject = Page "Leave Application List-General";
                }
                action("Transport Request")
                {
                    RunObject = Page "Transport requests -General";
                }
                action("Training Requests List ")
                {
                    RunObject = Page "Training Request List-General";
                }
                action("Risk Identification")
                {
                    RunObject = page "Risks List General";
                }
                action("Risk Survey")
                {
                    RunObject = page "Risk Surveys General";
                }
                action("Incident Reporting")
                {
                    RunObject = page "Incident Reports General";
                }
                action("ICT Helpdesk")
                {
                    RunObject = page "ICT Support Incidences General";
                }
                action("Visitor's Interaction Books")
                {
                    RunObject = page "Enquiries General";
                }
            }
            group("Audit Management")
            {
                group("Audit")
                {
                    group("Audit Plans")
                    {
                        group("Quarterly Audit")
                        {
                            action("Open Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Quarterly Audit Plan List";
                                RunPageLink = Posted = const(false);
                            }
                            action("Submitted Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Quarterly Audit Plan List";
                                RunPageLink = Posted = const(true);
                            }
                        }
                        group("Annual Audit")
                        {
                            action("Open Annual Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Audit Plan List";
                                RunPageLink = Posted = const(false);
                            }
                            action("Submitted Annual Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Audit Plan List";
                                RunPageLink = Posted = const(true);
                            }
                        }
                        group("Strategic Plan Audit")
                        {
                            action("Strategic Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Strategic Audit Plan List";
                                RunPageLink = Posted = const(false);
                            }
                            action("Submitted Strategic Audit Plans")
                            {
                                ApplicationArea = All;
                                RunObject = page "Strategic Audit Plan List";
                                RunPageLink = Posted = const(true);
                            }
                        }
                    }
                    group("Audit Programs")
                    {
                        action("Open Audit Programs")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Programs";
                            RunPageLink = Status = FILTER(Open);
                        }
                        action("Pending Audit Programs")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Programs";
                            RunPageLink = Status = FILTER("Pending Approval");
                        }
                        action("Approved Audit Programs")
                        {
                            ApplicationArea = All;
                            RunObject = page "Approved Audit Programs";
                        }
                    }
                    group("Audit Working Papers")
                    {
                        action("Open Audit Working Papers")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Work Papers";
                            RunPageLink = Status = filter(open);
                        }
                        action("Pending Audit Working Papers")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Work Papers";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Reviewed Audit Work Papers")
                        {
                            RunObject = page "Reviewed Audit Work Papers";
                        }
                    }
                    group("Auditee Reports")
                    {
                        action("Open Auditee Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Auditee Reports";
                            RunPageLink = Status = filter(open);
                        }
                        action("Pending Auditee Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Auditee Reports";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Reviewed Auditee Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Auditee Reports";
                            RunPageLink = Status = filter(Released);
                        }
                    }
                    group("Audit Reports")
                    {
                        action("Open Audit Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Reports";
                            RunPageLink = Status = filter(open);
                        }
                        action("Pending Audit Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Reports";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Reviewed Audit Reports")
                        {
                            ApplicationArea = All;
                            RunObject = page "Audit Reports";
                            RunPageLink = Status = filter(Released);
                        }
                        action("Closed Audit Reports")
                        {
                            RunObject = page "Closed Audit Reports";
                        }
                    }
                    group("Special Investigation Audits")
                    {
                        action("Open Special Investigation Audit")
                        {
                            ApplicationArea = All;
                            RunObject = page "Inspection Reports";
                            RunPageLink = Status = filter(open);
                        }
                        action("Pending Special Investigation Audit")
                        {
                            ApplicationArea = All;
                            RunObject = page "Inspection Reports";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Reviewed Special Investigation Audit")
                        {
                            RunObject = page "Inspection Reports";
                            RunPageLink = Status = filter(Released);
                        }
                    }
                }
                group(AuditNotifications)
                {
                    Caption = 'Audit Notifications';

                    action("Audit Notifications")
                    {
                        ApplicationArea = All;
                        RunObject = page "Audit Notifications";
                        RunPageLink = Sent = const(false);
                    }
                    action("Sent Audit Notifications")
                    {
                        ApplicationArea = All;
                        RunObject = page "Sent Audit Notifications";
                    }
                }
                group(AuditRecommendations)
                {
                    Caption = 'Audit Recommendations';

                    action("Audit Recommendations")
                    {
                        ApplicationArea = All;
                        RunObject = page "Audit Recommendations";
                    }
                }
                group("Audit Setup")
                {
                    action("Audit Periods")
                    {
                        ApplicationArea = All;
                        RunObject = page "Audit periods";
                    }
                    action("Audit Setups")
                    {
                        Caption = 'Setup';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Audit Setup";
                    }
                    action("Audit types")
                    {
                        ApplicationArea = All;
                        RunObject = page "Audit Types";
                    }
                    action("Audit categories")
                    {
                        ApplicationArea = All;
                        RunObject = page "Audit categories";
                    }
                }
            }
            group(RiskManagement)
            {
                Caption = 'Risk Management';

                group(Risk)
                {
                    Caption = 'Risk';

                    action(RiskIdent)
                    {
                        Caption = 'Identification';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risks List";
                        RunPageLink = "Document Status" = FILTER(New);
                    }
                    action(RiskAssessment)
                    {
                        Caption = 'Risk Assessment';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Champion List";
                        RunPageLink = "Document Status" = FILTER(HOD);
                    }
                    action(Escalated)
                    {
                        Caption = 'Risks under Board review';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Champion List";
                        RunPageLink = "Document Status" = FILTER("Board Review");
                    }
                    action(Auditor)
                    {
                        Caption = 'Risks under Auditor review';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Champion List";
                        RunPageLink = "Document Status" = FILTER(Auditor);
                    }
                    action(MD)
                    {
                        Caption = 'Risks under MD';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Champion List";
                        RunPageLink = "Document Status" = FILTER(MD);
                    }
                    action(Resolved)
                    {
                        Caption = 'Resolved Risks';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Champion List";
                        RunPageLink = "Document Status" = FILTER(Resolved);
                    }
                    action("Closed Risks")
                    {
                        Caption = 'Closed Risks';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Closed Risks";
                    }
                    action("Closed Risks - Registers")
                    {
                        Caption = 'Closed risks from registers';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Archived Risk Register";
                    }
                }
                group(Projects)
                {
                    Caption = 'Project Risk';

                    action(ProjectRiskReview)
                    {
                        Caption = 'Project Risk Review';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Project Manager Risk List";
                    }
                }
                group(Survey)
                {
                    Caption = 'Risk Survey';

                    action("Open Risk Surveys")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Surveys";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Risk Surveys")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Surveys";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Risk Surveys")
                    {
                        Caption = 'Approved Risk Surveys';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Surveys";
                        RunPageLink = Status = filter(Released);
                    }
                }
                group("Risk Registers")
                {
                    action(FinanceRiskRegister)
                    {
                        Caption = 'Finance Department Risk Register';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Department Risk register II";
                        RunPageLink = "Shortcut Dimension 2 Code" = filter('FINANCE');
                    }
                    action(ICTRiskRegister)
                    {
                        Caption = 'ICT Department Risk Register';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Department Risk register II";
                        RunPageLink = "Shortcut Dimension 2 Code" = filter('ICT');
                    }
                    action(TechnicalRiskRegister)
                    {
                        Caption = 'Technical Department Risk Register';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Department Risk register II";
                        RunPageLink = "Shortcut Dimension 2 Code" = filter('TECHNICAL|LAB');
                    }
                    action(AdministrationRiskRegister)
                    {
                        Caption = 'Administration Department Risk Register';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Department Risk register II";
                        RunPageLink = "Shortcut Dimension 2 Code" = filter('ADMINISTRATION');
                    }
                    action(HRRiskRegister)
                    {
                        Caption = 'HR Department Risk Register';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Department Risk register II";
                        RunPageLink = "Shortcut Dimension 2 Code" = filter('HR');
                    }
                    // action(ProjectRiskRegister)
                    // {
                    //     Caption = 'Project Risk Register';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = Page "Project Risk Register";
                    // }
                    // action(RiskRegisterArchive)
                    // {
                    //     Caption = 'Risk Register Archive';
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = Page "Archived Risk Register";
                    // }
                }
            }
            group(Incidences)
            {
                Caption = 'Incidences';

                action(Incidents)
                {
                    Caption = 'Incidences';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports";
                    RunPageLink = Sent = filter(false);
                }
                action(PendingInc)
                {
                    Caption = 'Pending Incidences';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports - Pending";
                    RunPageLink = Sent = filter(true);
                }
                action(SolvedInc)
                {
                    Caption = 'Incidences under review';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports - Solved";
                    RunPageLink = Sent = filter(true);
                }
                action(EscalatedInc)
                {
                    Caption = 'Escalated Incidences';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports-Escalated";
                    RunPageLink = Sent = filter(true);
                }
                action(ClosedInc)
                {
                    Caption = 'Closed Incidences';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports- Closed";
                    RunPageLink = Sent = filter(true);
                }
                action(ReportedInc)
                {
                    Caption = 'Reported Incidences';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Incident Reports";
                    RunPageLink = Sent = filter(true);
                }
            }
            group(Setups)
            {
                Caption = 'Risk and Incident Setups';

                action("Incident Priority")
                {
                    Caption = 'Incident Priority setup';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Incident Priority Setup";
                }
                action("Risk Category")
                {
                    Caption = 'Risk Category';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Risk Categories";
                }
                action("Risk Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Annual Risk Setup";
                }
                action(RiskLikelihood)
                {
                    Caption = 'Risk Likelihood';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Risk Likelihood";
                }
                action(RiskImpact)
                {
                    Caption = 'Risk Impacts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Risk Impacts";
                }
                action(RiskRAG)
                {
                    Caption = 'Risk RAG Setup';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Risk RAG Status Setup";
                }
                group(Guidelines)
                {
                    action("Risk Impact Guidelines")
                    {
                        Caption = 'Risk assessment rating Guideline';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Rating Guideline";
                    }
                    action("Risk Likelihood Guidelines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk Likelihood Guideline";
                    }
                    action("Risk RAG Status Guidelines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk RAG Status Guideline";
                    }
                    action("Risk KRI Guidelines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Risk KRI Guideline Setup";
                    }
                }
            }
            group(Compliance)
            {
                Visible = false;
                Caption = 'Compliance';

                action(ComplianceList)
                {
                    Caption = 'Compliance';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Compliance Registers";
                }
                action(ComplianceReport)
                {
                    Caption = 'Compliance Report';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Compliance Register";
                }
            }
            group("Payroll Reports")
            {
                Visible = false;

                action("Monthly PAYE Report - Staff")
                {
                    Image = Report;
                    RunObject = report "Monthly PAYE Reportx";
                }
                action("Monthly PAYE Report - Board Members")
                {
                    Image = Report;
                    RunObject = report "Trustee Monthly PAYE Report";
                }
            }
        }
        area(reporting)
        {
            action("RiskImpactGuidelines")
            {
                Caption = 'Risk assessment rating Guideline';
                ApplicationArea = Basic, Suite;
                RunObject = report "Risk Assessment Impact Report";
            }
            action("RiskLikelihoodGuidelines")
            {
                Caption = 'Risk Likelihood Guidelines';
                ApplicationArea = Basic, Suite;
                RunObject = report "Risk Likelihood Guide Report";
            }
            action("RiskMatrixGuidelines")
            {
                Caption = 'Risk Matrix Guidelines';
                ApplicationArea = Basic, Suite;
                RunObject = report "Risk Rating Matrix Report";
            }
            action("RiskRAGStatusGuidelines")
            {
                Caption = 'Risk RAG Status Guidelines';
                ApplicationArea = Basic, Suite;
                RunObject = report "Risk RAG Guideline Report";
            }
            action("RiskKRIStatusGuidelines")
            {
                Caption = 'Risk KRI Guidelines';
                ApplicationArea = Basic, Suite;
                RunObject = report "Risk KRI Guideline Report";
            }
            // action("Risk Matrix")
            // {
            //     RunObject = report "Risk Matrix";
            // }
            action("Charter Risk")
            {
                RunObject = report "Charter Risk";
            }
            // action("Risk Assessment")
            // {
            //     RunObject = report "Risk Assessment";
            // }
            action("Risk Assessment Report")
            {
                RunObject = report "Risk Assessment Report";
            }
            action("Risk Assessment List")
            {
                RunObject = report "Risk Assessment List";
            }
            action("Risk Identification Report")
            {
                RunObject = report "Risk Identification";
            }
            action("Risk KRI(s)")
            {
                RunObject = report "Risk KRI(s)";
            }
            action("Risk Responses Plan")
            {
                RunObject = report "Risk Responses Plan";
            }
            // action("Risk Repsonse Status Report")
            // {
            //     RunObject = report "Risk Response Status Report";
            // }
            action("ERM Process Report")
            {
                RunObject = report "ERM Process Report";
            }
            action("Tolerance & Appetite")
            {
                RunObject = report "Tolerance & Appetite";
            }
            action("Residual Risk Rating Report")
            {
                RunObject = report "Residual Risk Rating Report";
            }
        }
    }
}
