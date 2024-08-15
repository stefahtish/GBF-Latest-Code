page 50509 "HR Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
            }
            part("Employee Cues"; "Employee Payroll Cue")
            {
                ApplicationArea = Basic, Suite;
            }
            part("HR Management Cues"; "HR Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }
    actions
    {
        area(processing)
        {
            action("Disciplinary Actions ")
            {
                Image = Holiday;
            }
            action("Staff Absence ")
            {
                Image = Absence;
                RunObject = Report "Employee - Staff Absences";
            }

            action("HRSetup")
            {
                RunObject = page "Human Resources Setup";
            }
            action("Payroll Requests")
            {
                Image = Reuse;
                RunObject = Page "Payroll Requests";
            }

        }
        area(embedding)
        {
            action("Approvals Activities")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Approvals Activities";
                ToolTip = 'Executes the Approvals Activities action';
            }
        }
        area(sections)
        {
            group("Employee Manager")
            {
                Caption = 'Employee Manager';
                action("Employee List - Active")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee List";
                    Caption = 'Active Employee List';
                    RunPageLink = "Employment Status" = FILTER(Active);
                }

                action("Employee List - Inactive")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee List Modified";
                    RunPageLink = "Employment Status" = FILTER(Inactive);
                }
                action("Employee List - Permanently Inactive")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee List Modified";
                    RunPageLink = "Employment Status" = FILTER("Permanently Inactive");
                }

                action("Employee Contracts")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee Contracts";
                }

                action("Updated Employee Contracts")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Updated Employee Contracts";
                }

                action("Absence Registration")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Absence Registration";
                }
                action("Notify All Employees")
                {
                    ApplicationArea = All;
                    RunObject = Report "Notify All Employees";
                }
                group("Employee Setups")
                {
                    Caption = 'Employee Personal Information Setups';
                    action("Ethnic Communities")
                    {
                        ApplicationArea = All;
                        RunObject = Page "Ethnic Communities";
                    }
                    action("Counties")
                    {
                        ApplicationArea = All;
                        RunObject = Page "County List";
                    }
                    action("Districts")
                    {
                        ApplicationArea = all;
                        RunObject = page Districts;
                    }
                    action(Religion)
                    {
                        ApplicationArea = all;
                        RunObject = page Religion;
                    }
                }
            }

            group("Company Information ")
            {
                Image = Departments;
                action("Company Activities ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Company Activities";
                }
                action("Base Calender List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Base Calendar List";
                }
                action("Board of Director ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Board of Directors";
                }
                action("Rules & Regulations ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Rules & Regulations";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';

                action("Approval Entries")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Approval Request Entries";
                }
            }

            group("Jobs ")
            {
                Image = Job;
                action("Staff Establishment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Jobs';
                    RunObject = Page "Company Job List";
                }
                action("Vacant Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Vacant Positions";
                }
                action("Job Specification List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Job Specification List";
                    Visible = false;
                }
                action("Job Industries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employment Industries';
                    RunObject = page "Company Job Industries";
                    Image = Setup;
                }
                action("Fields of Study")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Fields of Study";
                    Image = Setup;
                }
                action("Academic Qualifications")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Academic Qualifications";
                    image = SetPriorities;
                }
                action("Professional Memberships")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Prof Membership";
                    Image = Setup;
                }

            }
            group("Recruitment ")
            {
                Image = HRSetup;
                group("Lists")
                {
                    action("Recruitment Request List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Recruitment Request List";
                    }
                    action("Open Positions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Approved Recruitment Requests";
                        RunPageLink = "Shortlisting started" = const(false);
                    }
                    action("Applicants List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Applicants List";
                        Caption = 'Recruitment Long listing';
                        RunPageLink = Applied = const(false);
                    }
                    action("Submitted Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Applicants List";
                        RunPageLink = Applied = const(true);
                    }
                    action("Qualified Applicants")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Qualified Applicants";
                        RunPageLink = Applied = const(true), Qualified = const(true);
                    }
                    action("Job Applications List")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Jobs Applied";
                        RunPageLink = Submitted = const(false);
                    }
                    action("Submitted Job Application")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Jobs Applied";
                        RunPageLink = Submitted = const(true);
                    }

                    action("Recruitment Shortlist ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Recruitment Shortlist";
                        RunPageLink = "Shortlisting Closed" = const(false);
                    }
                    action("Closed Recruitment Shortlist ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Recruitment Shortlist";
                        RunPageLink = "Shortlisting Closed" = const(true);
                    }

                    action("Interview List ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Interview List";
                    }
                    action("Completed Interviews")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Completed Interviews-Passed";
                    }

                }
                group("Recruitment Archive")
                {
                    action("Approved Recruitment Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Approved Recruitment Requests";
                    }
                    action("Qualified Interview")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Qualified Interviewed";
                    }
                    action("Non-Qualified Interview")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Non-Qualified Interviewed";
                    }
                    action("Failed Completed Interviews")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Completed Interviews-Failed";
                    }
                }

                group("Recruitment Setups")
                {
                    action("Qualification Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Qualifications Setup";
                    }
                    action("Interview Committees")
                    {
                        ApplicationArea = All;
                        RunObject = page "Interview Commttees";
                    }
                    action("Recruitment Stages ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Recruitment Stages";
                    }
                    action("Interview Panel Members")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Interview Panel Members";
                        Caption = 'Interview Committee';
                        Visible = false;
                    }
                    action("Test Parameters ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Test Parameters";
                    }
                    action("Score Setup ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Score Setup";
                    }
                    action("Interview Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Interview Setup";
                    }
                    action(Languages)
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Recruitment Languages";
                        Caption = 'Applicant Languages';
                    }
                }
                group("Recruitment Reports")
                {
                    action("Applicant Report Summury")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Applicant Report Summary";
                        Caption = 'Applicant Report Summary';
                    }
                    action("Incomplete Application Summury")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        RunObject = report "In-Complete Applicant Report";
                        Caption = 'In-Complete Applicant Report';
                    }
                    action("Qualification Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Qualification Report";
                        Caption = 'Qualification Report';
                    }
                    action("Submitted Application Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Recruitment Listing";
                        Caption = 'Submitted Application List';
                    }
                }

            }
            group("Empoyee Transfers and Deployment")
            {
                action("Open Employee Transfer list")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Employee Transfer List";
                    RunPageLink = Status = filter(New);
                }
                action("Pending Employee Transfer list")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Employee Transfer List";
                    RunPageLink = Status = filter("Pending Approval");
                }
                action("Approved Employee Transfer list")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Employee Transfer List";
                    RunPageLink = Status = filter(Released);
                }
                action("Posted Employee Transfer list")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Employee Transfer List";
                    RunPageLink = Transferred = filter(true);
                }
            }

            group("Leave Management")
            {
                Image = Administration;
                group("Leave")
                {
                    action("Leave Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Leave Adjustments")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(false);
                    }

                    action("Leave Recall")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = const(false);
                    }
                }
                group("Reliever Approvals")
                {
                    action("Open Reliever Approvals")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = filter("Reliever Open");
                    }
                    action("Reliever Approved Leave Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
                    }
                }
                group("Leave Tasks")
                {
                    action("Assign Leave Days")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = codeunit "HR Management";
                    }
                }
                group("Leave Reports")
                {
                    action("Leave Balances")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Leave Balance";
                    }
                    action("Leave Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "HR Staff Leave Statement";
                    }
                }

                group("Leave Planner")
                {
                    action("Open Leave Planner")
                    {
                        RunObject = page "Leave Planner List";
                        RunPageLink = Submitted = const(false);
                    }
                    action("Submitted Leave Planner")
                    {
                        RunObject = page "Leave Planner List";
                        RunPageLink = Submitted = const(true);
                    }
                    action("Leave Plan Report")
                    {
                        RunObject = report "Leave Plan Report";
                    }
                }
                group("Leave Archive")
                {
                    action("Approved Leave Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = filter(Released);
                    }
                    action("Posted Leave Adjustments")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(true);
                    }
                    action("Completed Leave Recalls")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = const(true);
                    }
                }

                group("Leave Setups")
                {
                    action("Leave Types")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Types Setup";
                    }

                    action("Leave Period")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Leave Period";
                    }
                }

            }

            group("Disciplinary Management")
            {
                action("Employee Disciplinary")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee Disciplinary List";
                    RunPageLink = Posted = const(false);
                }
                action("Escalated Employee Case")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Escalated Employee Case";
                    RunPageLink = Posted = const(false);
                }

                action("Disciplinary Incidences")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Disciplinary Cases";
                }

                action("Closed Disciplinary Cases")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Closed Disciplinary Cases";
                }

                action("Disciplinary Actions")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Disciplinary Actions";
                }
                action("Disciplinary Cases Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Disciplinary Cases";
                }
                group(Setup)
                {
                    action("Committee Member Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Committee Setup List";
                    }

                }

            }
            group("Performance Management")
            {
                group("Targets Setup")
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

                }
                action("Appraisal List - New")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List";
                }

                action("Appraisal List - Objectives Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = Status = CONST("Pending Approval");
                }
                action("Appraisal List Under Review")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - UnderReview-F";
                }
                action("Appraisal List - Further review")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = "Appraisal Status" = FILTER("Further review");
                }
                group("Appraisals List Under Review")
                {
                    Visible = false;
                    action("Appraisal List Under Review - Q1")
                    {
                        RunObject = page "Appraisal List UnderReview Q1";
                    }
                    action("Appraisal List Under Review - Q2")
                    {
                        RunObject = page "Appraisal List UnderReview Q2";
                    }
                    action("Appraisal List Under Review - Q3")
                    {
                        RunObject = page "Appraisal List UnderReview Q3";
                    }
                    action("Appraisal List Under Review - Q4")
                    {
                        RunObject = page "Appraisal List UnderReview Q4";
                    }

                }
                action("Escalated Appraisals")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = "Appraisal Status" = FILTER(Escalated);
                }
                action("Completed Escalated Appraisals")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Completed";
                }
                action("Appraisal List - Completed")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List - Completed";
                }

                // action("Appraisal Types")
                // {
                //     RunObject = page "Appraisal Types";
                // }


                group("Appraisal Setup")
                {
                    action(Periods)
                    {
                        ApplicationArea = all;
                        RunObject = page "Appraisal Periods";
                    }
                    action("period Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Appraisal Periods";

                    }
                    group("Core Values/Competence")
                    {
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
                    group("Rewards & Recorgnition Setup")
                    {
                        action("Types of Recognitions")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Types of Recognitions List";
                        }
                        group("Types of Rewards")
                        {
                            action("Monitery Reward")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Monitory Reward";
                            }
                            action("Non Monitery Reward")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Non Monitory Reward";
                            }

                        }
                        action("Types of Sanction")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Types of Sanction List";
                        }

                    }
                }
            }
            group("Training Management")
            {
                Image = Capacities;

                group("Training Needs")
                {
                    action("Training Budget")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Plan";
                    }
                    action("New Training Needs")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Needs Open";
                    }
                    action("Budget Comparision")
                    {
                        ApplicationArea = All;
                        Image = Report;
                        RunObject = REPORT 50516;
                    }

                    action("On-Going Training Needs")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = FILTER(Application);
                    }
                    action("Closed Training Needs")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = FILTER(Closed);
                    }
                    action("Open Training Needs Requisitions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(New);

                    }
                    action("Applied Training Needs Requisitions")
                    {
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(Created);
                        ApplicationArea = Basic, Suite;
                    }

                    action("Rejected Training Needs Requisitions")
                    {
                        RunObject = page "Training Needs Requisitions";
                        RunPageLink = Status = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                    }

                }

                group("Training Applications")
                {
                    action("Training Request List ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Training Request List";
                    }
                    action("Approved Training Request List ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Approved Training Request List";
                    }
                }

                group("Training Evaluation")
                {
                    action("Training Evaluations")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Evaluation List";

                    }
                }
                group("Post Training Evaluation")
                {
                    action("Post Training Evaluation List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Post Training List";
                    }
                    action("Submitted Post Training Evaluation List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Post Training Evaluation List";
                    }
                    action("Archived Post Training Evaluation List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Archived Post Training List";
                    }
                }
                group("Training Setups")
                {
                    action("Training expense codes")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Expense Code";
                    }
                    action("Training Areas")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Training Areas";
                    }
                }
                group("Training Reports")
                {
                    action("Training Shedule")
                    {
                        ApplicationArea = all;
                        Image = Report;
                        RunObject = report "Training Schedule";
                    }
                    action("Training Application Report")
                    {
                        Visible = false;
                        ApplicationArea = Basic;
                        Caption = 'Training Applications';
                        RunObject = Report "HR Training Application";

                    }
                    action("HR Budget Comparision")
                    {
                        ApplicationArea = All;
                        Image = Report;
                        RunObject = REPORT 50516;
                    }

                }

            }

            group("Fleet Management")
            {
                Visible = false;
                group("Transport Management")
                {
                    action("Fleet List")
                    {
                        Visible = false;
                        RunObject = Page "Fleet List";
                    }
                    action("Transport Requests List")
                    {
                        RunObject = Page "Trip Listing";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Transport Requests List")
                    {
                        RunObject = Page "Trip Listing";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Transport Requests")
                    {
                        RunObject = Page "Trip Listing";
                        RunPageLink = Status = filter(Released), "Transport Status" = filter(<> Completed);
                    }

                }
                group(DriverLogging)
                {
                    Caption = 'Driver Logging';
                    action("Open Driver Loggings")
                    {
                        RunObject = page "Driver Logging Sheet";
                        RunPageLink = Submitted = const(false);
                    }
                    action("Submitted Driver Loggings")
                    {
                        RunObject = page "Driver Logging Sheet";
                        RunPageLink = Submitted = const(true);
                    }
                }

                group("Driver Incident Logging")
                {
                    action("Incidents")
                    {
                        RunObject = page "Transport incidents";
                        RunPageLink = Reported = const(false);
                    }
                    action("Reported Incidents")
                    {
                        RunObject = page "Transport incidents";
                        RunPageLink = Reported = const(true);
                    }
                }
                group(FuelAllocation)
                {
                    Caption = 'Fuel Allocation';
                    action("Open Fuel Allocations")
                    {
                        RunObject = page "Fuel Allocations";
                        RunPageLink = Allocated = const(false);
                    }
                    action("Fuel Allocations")
                    {
                        RunObject = page "Fuel Allocations";
                        RunPageLink = Allocated = const(true);
                    }
                    action("Fuel Allocation Period")
                    {
                        RunObject = page "Fuel Allocation Periods";
                    }
                }
                group(FuelTransfer)
                {
                    Caption = 'Fuel Transfer';
                    action("Open Fuel Transfer")
                    {
                        RunObject = page "Fuel Transfer";
                        RunPageLink = Transferred = const(false);
                    }
                    action("Fuel Transfers")
                    {
                        RunObject = page "Fuel Transfer";
                        RunPageLink = Transferred = const(true);
                    }
                }
                group("Maintenance Request")
                {
                    action("Maintenance Request List")
                    {
                        RunObject = page "Maintenance Request List";
                        RunPageLink = Status = filter(<> Approved);
                    }
                    action("Asset Maintenance Request List")
                    {
                        RunObject = page "Asset Maintenance Request List";
                        RunPageLink = Status = filter(<> Approved);
                    }

                }
                group("Transport Management Archive")
                {
                    action("Completed Travels")
                    {
                        RunObject = Page "Completed Travels";
                    }
                    action("Approved Maintenance Request List")
                    {
                        RunObject = page "Maintenance Request List";
                        RunPageLink = Status = const(Approved);
                    }
                    action("Approved Asset Maintenance Request List")
                    {
                        RunObject = page "Asset Maintenance Request List";
                        RunPageLink = Status = const(Approved);
                    }
                }
                group("Transport Management Reports")
                {
                    action("Vehicle Trips")
                    {
                        RunObject = Report "Vehicle Trips";
                    }
                    action("Transport Requests")
                    {
                        RunObject = Report "Transport Requests";

                    }
                    action("Vehicle Condations")
                    {
                        RunObject = Report "Vehicle Conditions";

                    }
                }
            }


            group("Acting & Promotion ")
            {
                Image = ResourcePlanning;
                action("Acting Duties List ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Acting Duties List";
                    RunPageLink = Status = FILTER(<> Approved | Rejected);
                }
                action("Acting Duties List Approved ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Acting Duties List";
                    RunPageLink = Status = FILTER(Approved);
                }
                action("Promotion List ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Promotion List";
                }
                action("Promotion List Approved ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Promotion List Approved";
                }
                action("Acting Duties Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Acting Report";
                }
                action("Promotion Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Employee acting and promotion";
                }

            }

            group("Employee Benefits")
            {
                group("Medical Scheme")
                {
                    action("Medical Covers")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Medical Cover List";
                    }

                    action("Medical Claims")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Medical Claims List";
                    }

                    action("Medical Ceiling Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Medical Ceiling Setup";
                    }
                }
            }
            group("Payroll Setups")
            {
                Visible = false;

                Image = Departments;

                action("HR Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Human Resources Setup";
                }
                action("Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Pay Period";
                }
                action(Earnings)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Earning;
                }
                action(Deductions)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Deduction;
                }
                action("Bracket Tables")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Bracket Table";
                }
                action(Stations)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Dimensions;
                }
                action(Institutions)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page Institutionsz;
                    Visible = false;
                }
                action("Salary Scale")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Salary Scale";
                }
                action("Salary Pointers")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Salary pointer";
                    Visible = false;
                }
                action("Employee Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Emp Posting Group";
                }
                action("Employee Payment Types")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Emp Payment Types";
                }
                action("Casual Pay Periods")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Casual Pay Period";
                    Visible = false;
                }
                action("Bank Cheque Register")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Banks Cheque Register";
                }
                action("Loan Product Types")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Loan Product Types-Payroll";
                }
                action(Banks)
                {
                    Caption = 'Banks';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Banks;
                }
                action("Bank Branches")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Bank Branches List";
                }
                action("Payroll Leave Category")
                {
                    Caption = 'Leave Category';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Payroll Leave Category";
                }
                action("POP codes")
                {
                    RunObject = page "POP codes";
                    ApplicationArea = All;
                    ToolTip = 'Executes the POP codes action';
                }
            }
            group("Payroll Approval")
            {
                Visible = false;
                action("Open Payroll Approvals")
                {
                    RunObject = page "Employee Payroll Approval";
                    RunPageLink = Status = filter(Open | "Pending Approval");
                    ToolTip = 'Executes the Open Payroll Approvals action';
                    ApplicationArea = All;
                }
                action("Approved Payroll Approvals")
                {
                    RunObject = page "Employee Payroll Approval";
                    RunPageLink = Status = filter(Approved);
                    ToolTip = 'Executes the Approved Payroll Approvals action';
                    ApplicationArea = All;
                }
            }
            group("Payroll Payment Vouchers")
            {
                Visible = false;

                action("Payment Voucher List")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Payment Vouchers";
                    RunPageView = where("PV Type" = CONST(Payroll));
                    ToolTip = 'Executes the Payment Voucher List action';
                }
                action("Pending Payment Vouchers")
                {
                    RunObject = Page "Pending Payment Vouchers1";
                    ToolTip = 'Executes the Pending Payment Voucher action';
                    RunPageView = where("PV Type" = CONST(Payroll));
                    ApplicationArea = All;
                }
                action("Approved Payment Vouchers")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Approved Payment Vouchers1";
                    RunPageView = where("PV Type" = CONST(Payroll));
                    ToolTip = 'Executes the Approved Payment Voucher action';
                }
                action("Posted Payment Vouchers")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Posted Payment Vouchers1";
                    RunPageView = where("PV Type" = CONST(Payroll));
                    ToolTip = 'Executes the Posted Payment Voucher action';
                }
                action("Interbank transfer")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Approved InterBank Transfer";
                    RunPageView = where("PV Type" = CONST(Payroll));
                }
                action("Posted Interbank transfer")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Posted InterBank Transfer";
                    RunPageView = where("PV Type" = CONST(Payroll));
                }
            }
            group("Payroll EFTs")
            {
                Visible = false;
                action("Payroll EFT File Generations")
                {
                    ApplicationArea = "Basic,Suite";
                    RunObject = page "Payroll EFT File Generations";
                    RunPageView = where(Posted = CONST(false));
                }
                action("Posted EFT File Generations")
                {
                    RunObject = Page "Payroll EFT File Generations";
                    RunPageView = where(Posted = CONST(true));
                    ApplicationArea = All;
                }
            }
            group(Employee)
            {
                Caption = 'Employees';
                Image = HumanResources;
                action("All Employees")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Employees';
                    RunObject = Page "Employee List";
                }
                action("Staff Employees")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee List-Filtered";
                }
                action("Committees")
                {
                    Visible = false;
                    ApplicationArea = All;
                    RunObject = Page "Committee";
                }
                action("Mail Bulk Payslips")
                {
                    Visible = false;
                    ApplicationArea = All;
                    RunObject = Report "Mail Bulk Payslips";
                }
                action("Mail Bulk p9")
                {
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = Report "Mail Bulk P9s";
                }
                group("Periodic Activities ")
                {
                    Visible = false;
                    action("Payroll Run ")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Column;
                        Visible = false;
                        RunObject = Report "Payroll Run1";
                    }

                    /* action("Transfer To Journal-old")
                    {
                        Caption = 'Transfer To Journal-old';
                        RunObject = report "Transfer to Journal";
                    } */

                    action("Transfer To Journal-Employees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer To Journal - Employees';
                        RunObject = report "Transfer Journal to GL-New";
                    }

                    action("General Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "General Journal";
                    }

                    // action("Email List")
                    // {
                    //     RunObject = page "Email List";
                    // }
                    action("Export To Bank-Employees")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Payroll Export To Bank";
                    }
                    action("Update Assn Matrix")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Validate Payroll Run";
                    }

                }

                group("Employee Reports")
                {
                    Visible = false;
                    group("Bank Details")
                    {
                        action("Employee Bank Details")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Employee Bank Details";
                        }

                    }
                    group("Management Reports ")
                    {
                        Caption = 'Management Reports';
                        action("New Payslips ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = NewBank;
                            RunObject = Report "New Payslipx";
                        }
                        action("Earnings Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report Earnings;
                        }
                        action("Deduction Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = Report Deductions;
                        }
                        action("EFT Report")
                        {
                            ApplicationArea = All;
                            Caption = 'EFT File';
                            RunObject = Report "Generate EFT";
                        }
                        action("Net Pay Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Net Pay Bank Transfer";
                        }
                        action("Net Salaries Report")
                        {
                            ApplicationArea = All;
                            Image = Report;
                            RunObject = Report "Net Salaries Report";
                        }

                        action("Employee Below Pay")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Employee Below Pay";
                        }
                        action("Employee List - all")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee List';
                            Image = "Report";
                            RunObject = Report "Employee - List";
                        }
                        action("SACCO  Reports")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Sacco Report";
                        }
                        action("Gross Earnings nd Deductios")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Gross Earnings & Deductions";
                        }
                    }
                    group("Statutory Reports")
                    {
                        Visible = false;
                        Caption = 'Statutory Reports';
                        action("Monthly Payee Report ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Monthly PAYE Reportx";
                        }
                        action("NSSF Reporting ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "NSSF Reporting";
                        }
                        action("NHIF ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = Migration;
                            RunObject = Report NHIF;
                        }
                        action(HELBReport)
                        {
                            Caption = 'HELB Report';
                            Image = "Report";
                            ApplicationArea = Basic, Suite;
                            RunObject = report HELB;
                        }
                        action(NITAReport)
                        {
                            Caption = 'NITA Report';
                            Image = "Report";
                            ApplicationArea = Basic, Suite;
                            RunObject = report NITA;
                        }
                        action("Pension Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Pension Report";
                        }
                    }
                    group("Annual Statutory Reports")
                    {
                        Visible = false;
                        Caption = 'Annual Statutory Reports';
                        action("P9A Report ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = ResourcePlanning;
                            RunObject = Report "P9A Report";
                        }
                        action(P10Report)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = Report P10;
                        }
                    }
                    group("Reconciliation Reports")
                    {
                        Visible = false;
                        Caption = 'Reconciliation Reports';
                        action("Monthly Difference Report")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Report "Payroll Reconciliation";
                        }
                        action("Employees Removed ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = ChangeCustomer;
                            RunObject = Report "Employees Removed";
                        }
                        action("Summary By Centre")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Report "Summary By Center_1";
                        }
                        action("Payroll Reconciliation Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = Reconcile;
                            RunObject = Report "Payroll Reconciliation Summary";
                        }
                        action("Master Roll Report")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Report "Master Roll Report";
                        }
                        action("Detailed Master Roll Report")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Report "Detailed MasterRoll";
                        }
                    }
                    group("Leave -Reports")
                    {
                        Caption = 'Leave Reports';
                        action("leave balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Leave Balances';
                            RunObject = Report "Leave Balance";
                        }
                        action("leave-Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Leave Statements';
                            RunObject = Report "HR Staff Leave Statement";
                        }
                    }
                    group("Loan reports")
                    {
                        Visible = false;
                        action("Coop loan I Report")
                        {
                            RunObject = report "Coop loan I Report";
                        }
                        action("Coop loan II Report")
                        {
                            RunObject = report "Coop loan II Report";
                        }
                        action("Car Loan Report")
                        {
                            RunObject = report "Loan Report";
                        }
                        action("KCB Loan Report")
                        {
                            RunObject = report "KCB Loan Report";
                        }
                        action("Self Helb Report")
                        {
                            Visible = false;
                            RunObject = report "loan Report";
                        }
                        action("Salary Advance 1 Report")
                        {
                            RunObject = report "loan Report";
                        }
                    }

                    group("Imprest Deductions")
                    {
                        Caption = 'Imprest Deduction';
                        action("Imprest Deduction")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Imprest Deduction";
                        }
                    }
                }


            }
            group(Trustees)
            {
                Visible = false;
                Caption = 'Board Members';
                Image = HumanResources;
                action("Trustee Employees")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Board Members';
                    RunObject = page "Trustee Employees";
                }

                group("Setups")
                {
                    action("Pay Period Trustees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pay Period - Board Members';
                        RunObject = page "Pay Period Trustees";
                    }
                }

                group("Trustee Payment Reversal")
                {
                    Caption = 'Board Payment Reversal';
                    action("Trustee Payment Reversals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals";
                    }

                    action("Posted Trustee Payment Reversals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals-Post";
                    }
                }
                group("Board Committees")
                {
                    Visible = false;
                    action("Open board committees")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Board Committee List";
                    }

                }

                group("Periodic Activities")
                {
                    Visible = false;
                    action("Payroll Run-Trustees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Run - Board Members';
                        RunObject = report "Payroll Run Trustees";
                    }
                    action("Transfer To Journal-Trustee")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer To Journal - Board Members';
                        RunObject = report "Transfer to Journal - Trustee";
                    }

                    action("Open General Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "General Journal";
                    }
                    action("Board Sitting Allowances")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Board Attendance Register List";
                        RunPageLink = Status = const(Open);
                    }
                    action("Pending Board Sitting Allowances")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Board Attendance Register List";
                        RunPageLink = Status = const("Pending Approval");
                    }
                    action("Approved Board Sitting Allowances")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Board Attendance Register List";
                        RunPageLink = Status = const(Released);
                    }

                    action("Export To Bank")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Payroll Export To Bank";
                    }
                }

                group(Reports)
                {
                    Visible = false;
                    group("Bank-Details")
                    {
                        action("Board Bank Details")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Trustee Bank Details";
                        }

                    }
                    group("Management-Reports ")
                    {
                        Visible = false;
                        Caption = 'Management Reports';

                        action("Board Payslips ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = NewBank;
                            RunObject = Report "Trustee Payslipx";
                        }
                        action("Earnings -Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Earnings Report';
                            Image = "Report";
                            RunObject = Report "Trustee Earnings";
                        }
                        action("Deduction-Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = Report TrusteeDeductions;
                        }
                        // action("Gross Earnings $ Deductions")
                        // {
                        //     Image = Report;
                        //     RunObject = report "Gross Earnings and Deductions";
                        // }
                        action("Net- Pay Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Net Pay report';
                            Image = "Report";
                            RunObject = Report "Trustee Net Pay Bank Transfer";
                        }

                        action("Board Below Pay")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Trustee Below Pay";
                        }
                        action("Board List ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Trustee - List";
                        }
                        action("SACCO Reports")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = "Report";
                            RunObject = Report "Trustee Sacco Report";
                        }
                    }
                    group("Statutory-Reports")
                    {
                        Visible = false;
                        Caption = 'Statutory Reports';
                        action("Monthly Payee - Report ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Montly payee report';
                            Image = "Report";
                            RunObject = Report "Trustee Monthly PAYE Report";
                        }
                        action("NSSF-Reporting ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'NSSF reporting';
                            Image = "Report";
                            RunObject = Report "Trustee NSSF Reporting";
                        }
                        action(NHIF)
                        {
                            ApplicationArea = Basic, Suite;
                            Image = Migration;
                            RunObject = Report TrusteeNHIF;
                        }
                        action("NITA-Report")
                        {
                            Caption = 'NITA Report';
                            Image = "Report";
                            ApplicationArea = Basic, Suite;
                            RunObject = report TrusteeNITA;
                        }
                        action("HELB Report")
                        {
                            Caption = 'HELB Report';
                            Image = "Report";
                            ApplicationArea = Basic, Suite;
                            RunObject = report TrusteeHELB;
                        }
                        action("Pension-Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pension Report';
                            Image = "Report";
                            RunObject = Report "Trustee Pension Report";
                        }
                    }
                    group("Annual-Statutory Reports")
                    {
                        Visible = false;
                        Caption = 'Annual Statutory Reports';
                        action("P9A-Report ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'P9A Report';
                            Image = ResourcePlanning;
                            RunObject = Report "P9A Report-Trustees";
                        }
                        action("P10-Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = Report TrusteeP10;
                        }
                    }
                    group("Reconciliation-Reports")
                    {
                        Visible = false;
                        Caption = 'Reconciliation Reports';
                        action("Monthly-Difference Report")
                        {
                            RunObject = Report "Trustee Payroll Reconciliation";
                        }
                        action("Board-Removed ")
                        {
                            Caption = 'Board members removed';
                            Image = ChangeCustomer;
                            RunObject = Report "Trustees Removed";
                        }
                        action("Summary-By Centre")
                        {
                            Caption = 'Summary By Centre';
                            RunObject = Report "Trustee Summary By Center_1";
                        }
                        action("Payroll- Reconciliation Summary")
                        {
                            Caption = 'Payroll Reconciliation Summary';
                            Image = Reconcile;
                            RunObject = Report "Trustee Payroll Rec Summary";
                        }
                        action("Master-Roll Report-Old")
                        {
                            Caption = 'Master Roll Report';
                            RunObject = Report "Master Roll Report-Trustees";
                            Visible = false;
                        }
                        action("Master Roll-Board")
                        {
                            Caption = 'Master Roll Report';
                            RunObject = report "Master Roll-Board Members";
                        }
                    }

                    action("PAYE Report-Trustees")
                    {
                        Visible = false;
                        Caption = 'PAYE Report - Board Members';
                        RunObject = report "PAYE Report - Primary";
                    }

                }
            }


            group(Action77)
            {
                Caption = 'Contracts';
                action(Contracts)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Employee Contracts";
                }
                action("Updated Contracts")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Updated Employee Contracts";
                }
            }

            group("Loan ")
            {
                Visible = false;
                Image = Calculator;
                group("Loan Applications")
                {

                    action("Loan Applications - New")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Loan Application List-Payroll";
                    }
                    action("Loan Applciations - Issued")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Posted Loan List-Payroll";
                    }
                }
                group("Loan Interest Processing")
                {
                    action("Interest Processing")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Interest List-Payroll";
                    }
                    action("Posted Loan Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Posted Loan Interests-Payroll";
                    }
                    action("Reversed Loan Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Reversed Loan Interests-Payrol";
                    }
                }
                group("Loan Setups")
                {
                    action("Loan Product Types ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Loan Product Types-Payroll";
                    }
                }
            }
            group("Periodic Activity")
            {
                Visible = false;
                Image = History;
                action("Import Earnings & Deductions")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Import Earnings & Deductions";
                }
                action("Imported Earnings & Deductions")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Imported Earnings & Deductions";
                }
                action("Email List ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Email List";
                }

            }

            group("Self service")
            {
                group(Payments)
                {
                    action(Imprest)
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
                    action("Transport Request")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Transport requests -General";
                    }

                }
                group("Performance Managements")
                {
                    action("Target Setup List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "New Targets List";
                    }
                    action("Targets Under Review")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Targets Under Review";
                    }
                    action("Approved Target List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Approved Targets List";
                    }
                }

                group("Leave Process")
                {
                    action("Leave Applications List")
                    {
                        RunObject = Page "Self-Service Leave Application";
                    }

                    action("Open Reliever Approvals ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Self Service Application 1";
                        //RunPageLink = Status = filter("Reliever Open");
                    }
                    action("Reliever Approved Leave Applications ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Self-Service Leave Application";
                        RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
                    }
                    action("Leave Planner ")
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
                    action("Post Training Evaluation ")
                    {
                        ApplicationArea = all;
                        RunObject = page "Post Training List";
                    }

                }
                // group("Training Reports")
                // {
                //     action("Training Shedule")
                //     {
                //         RunObject = report "Training Schedule";
                //     }
                //     // action("Post Training Evaluation ")
                //     // {
                //     //     ApplicationArea = all;
                //     //     RunObject = page "Post Training List";
                //     // }
                //     action("Training Application")
                //     {
                //         ApplicationArea = Basic;
                //         Caption = 'Training Applications';
                //         RunObject = Report "HR Training Application";
                //     }
                // }

                group("Reports ")
                {
                    Visible = false;
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
        area(reporting)
        {
            action("Employee Contracts ")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                RunObject = Report "Employee - Contracts";
            }
            action("Employee List ")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Report "Employee - List";
            }
            action("Employee Qualifications ")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Report "Employee - Qualifications";
            }
            action("Employee Relatives ")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Report "Employee - Relatives";
            }
            group(Disciplinary)
            {
                Caption = 'Disciplinary';
                action("Disciplinary Cases ")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Cancel;
                }
            }

        }
        area(creation)
        {
            action("Change password")
            {
            }
        }
    }
}
profile HRBPIT
{
    ProfileDescription = 'HR Role Center';
    RoleCenter = "HR Role Center";
    Caption = 'HR Role Center';
}
