page 50490 "Payroll Role Centre"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Payroll Cues"; "Employee Payroll Cue")
            {
                ApplicationArea = Basic, Suite;
            }
            group(Control6)
            {
                ShowCaption = false;
            }
            group(Control4)
            {
                ShowCaption = false;
            }
            part("Approval Cues"; "Approval Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(reporting)
        {
        }
        area(sections)
        {
            group("Company Information")
            {
                action("Company Activities")
                {
                    RunObject = Page "Company Activities";
                }
                action(Dimensions)
                {
                    RunObject = Page Dimensions;
                }
                action("Board of Directors")
                {
                    RunObject = Page "Board of Directors";
                }
                action("Rules & Regulations")
                {
                    RunObject = Page "Rules & Regulations";
                }
                action("HR Calendar")
                {
                    RunObject = Page "Base Calendar List";
                }
            }
            group("Payroll Setups")
            {
                Image = Departments;

                action("HR Setup")
                {
                    RunObject = page "Human Resources Setup";
                }
                action("Payroll Period")
                {
                    RunObject = Page "Pay Period";
                }
                action(Earnings)
                {
                    RunObject = Page Earning;
                }
                action(Deductions)
                {
                    RunObject = Page Deduction;
                }
                action("Bracket Tables")
                {
                    RunObject = Page "Bracket Table";
                }
                action(Stations)
                {
                    RunObject = Page Dimensions;
                }
                action(Institutions)
                {
                    RunObject = page Institutionsz;
                    Visible = false;
                }
                action("Salary Scale")
                {
                    RunObject = Page "Salary Scale";
                }
                action("Salary Pointers")
                {
                    RunObject = Page "Salary pointer";
                    Visible = false;
                }
                action("Employee Posting Groups")
                {
                    RunObject = Page "Emp Posting Group";
                }
                action("Employee Payment Types")
                {
                    RunObject = Page "Emp Payment Types";
                }
                action("Casual Pay Periods")
                {
                    RunObject = Page "Casual Pay Period";
                    Visible = false;
                }
                action("Bank Cheque Register")
                {
                    RunObject = Page "Banks Cheque Register";
                }
                action("Loan Product Types")
                {
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
                    RunObject = page "Bank Branches List";
                }
            }
            group(Employee)
            {
                Caption = 'Employees';
                Image = HumanResources;

                action("All Employees")
                {
                    Caption = 'All Employees';
                    RunObject = Page "Employee List";
                }
                action("Staff Employees")
                {
                    RunObject = page "Employee List-Filtered";
                }
                group("Periodic Activities ")
                {
                    action("Payroll Run ")
                    {
                        Image = Column;
                        RunObject = Report "Payroll Run1";
                    }
                    action("Transfer To Journal-Employees")
                    {
                        Caption = 'Transfer To Journal - Employees';
                        RunObject = report "Transfer Journal to GL-New";
                    }
                    action("General Journal")
                    {
                        RunObject = page "General Journal";
                    }
                    action("Email List")
                    {
                        RunObject = page "Email List";
                    }
                    action("Export To Bank-Employees")
                    {
                        RunObject = xmlport "Payroll Export To Bank";
                    }
                }
                group("Employee Reports")
                {
                    group("Bank Details")
                    {
                        action("Employee Bank Details")
                        {
                            Image = "Report";
                            RunObject = Report "Employee Bank Details";
                        }
                    }
                    group("Management Reports ")
                    {
                        Caption = 'Management Reports';

                        action("New Payslips ")
                        {
                            Image = NewBank;
                            RunObject = Report "New Payslipx";
                        }
                        action("Earnings Report")
                        {
                            Image = "Report";
                            RunObject = Report Earnings;
                        }
                        action("Deduction Report")
                        {
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = Report Deductions;
                        }
                        action("Net Pay Report")
                        {
                            Image = "Report";
                            RunObject = Report "Net Pay Bank Transfer";
                        }
                        action("Employee Below Pay")
                        {
                            Image = "Report";
                            RunObject = Report "Employee Below Pay";
                        }
                        action("Employee List ")
                        {
                            Image = "Report";
                            RunObject = Report "Employee - List";
                        }
                        action("SACCO  Reports")
                        {
                            Image = "Report";
                            RunObject = Report "Sacco Report";
                        }
                    }
                    group("Statutory Reports")
                    {
                        Caption = 'Statutory Reports';

                        action("Monthly Payee Report ")
                        {
                            Image = "Report";
                            RunObject = Report "Monthly PAYE Reportx";
                        }
                        action("NSSF Reporting ")
                        {
                            Image = "Report";
                            RunObject = Report "NSSF Reporting";
                        }
                        action("NHIF ")
                        {
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
                            Image = "Report";
                            RunObject = Report "Pension Report";
                        }
                    }
                    group("Annual Statutory Reports")
                    {
                        Caption = 'Annual Statutory Reports';

                        action("P9A Report ")
                        {
                            Image = ResourcePlanning;
                            RunObject = Report "P9A Report";
                        }
                        action(P10Report)
                        {
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = Report P10;
                        }
                    }
                    group("Reconciliation Reports")
                    {
                        Caption = 'Reconciliation Reports';

                        action("Monthly Difference Report")
                        {
                            RunObject = Report "Payroll Reconciliation";
                        }
                        action("Employees Removed ")
                        {
                            Image = ChangeCustomer;
                            RunObject = Report "Employees Removed";
                        }
                        action("Summary By Centre")
                        {
                            RunObject = Report "Summary By Center_1";
                        }
                        action("Payroll Reconciliation Summary")
                        {
                            Image = Reconcile;
                            RunObject = Report "Payroll Reconciliation Summary";
                        }
                        action("Master Roll Report")
                        {
                            RunObject = Report "Master Roll Report";
                        }
                    }
                    group("Leave Reports")
                    {
                        action("leave balance")
                        {
                            Caption = 'Leave Balances';
                            RunObject = Report "Leave Balance";
                        }
                        action("leave Statement")
                        {
                            Caption = 'Leave Statements';
                            RunObject = Report "HR Staff Leave Statement";
                        }
                    }
                    group("Imprest Deductions")
                    {
                        Caption = 'Imprest Deduction';

                        action("Imprest Deduction")
                        {
                            RunObject = page "Imprest Deduction";
                        }
                    }
                }
            }
            group(Trustees)
            {
                Caption = 'Board Members';
                Image = HumanResources;

                action("Trustee Employees")
                {
                    Caption = 'Board Members';
                    RunObject = page "Trustee Employees";
                }
                group("Setups")
                {
                    action("Pay Period Trustees")
                    {
                        Caption = 'Pay Period - Board Members';
                        RunObject = page "Pay Period Trustees";
                    }
                }
                group("Trustee Payment Reversal")
                {
                    Caption = 'Board Payment Reversal';

                    action("Trustee Payment Reversals")
                    {
                        Caption = 'Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals";
                    }
                    action("Posted Trustee Payment Reversals")
                    {
                        Caption = 'Posted Board Payment Reversals';
                        RunObject = page "Trustee Payment Reversals-Post";
                    }
                }
                group("Periodic Activities")
                {
                    action("Payroll Run-Trustees")
                    {
                        Caption = 'Payroll Run - Board Members';
                        RunObject = report "Payroll Run Trustees";
                    }
                    action("Transfer To Journal-Trustee")
                    {
                        Caption = 'Transfer To Journal - Board Members';
                        RunObject = report "Transfer to Journal - Trustee";
                    }
                    action("Open General Journal")
                    {
                        RunObject = page "General Journal";
                    }
                    action("Board Sitting Allowances")
                    {
                        RunObject = page "Board Attendance Register List";
                    }
                    action("Export To Bank")
                    {
                        RunObject = xmlport "Payroll Export To Bank";
                    }
                }
                group(Reports)
                {
                    group("Bank-Details")
                    {
                        action("Board Bank Details")
                        {
                            Image = "Report";
                            RunObject = Report "Trustee Bank Details";
                        }
                    }
                    group("Management-Reports ")
                    {
                        Caption = 'Management Reports';

                        action("Board Payslips ")
                        {
                            Image = NewBank;
                            RunObject = Report "Trustee Payslipx";
                        }
                        action("Earnings -Report")
                        {
                            Caption = 'Earnings Report';
                            Image = "Report";
                            RunObject = Report "Trustee Earnings";
                        }
                        action("Deduction-Report")
                        {
                            Caption = 'Deductions Report';
                            Image = "Report";
                            RunObject = Report TrusteeDeductions;
                        }
                        action("Net- Pay Report")
                        {
                            Caption = 'Net Pay report';
                            Image = "Report";
                            RunObject = Report "Trustee Net Pay Bank Transfer";
                        }
                        action("Board Below Pay")
                        {
                            Image = "Report";
                            RunObject = Report "Trustee Below Pay";
                        }
                        action("Board List ")
                        {
                            Image = "Report";
                            RunObject = Report "Trustee - List";
                        }
                        action("SACCO Reports")
                        {
                            Image = "Report";
                            RunObject = Report "Trustee Sacco Report";
                        }
                    }
                    group("Statutory-Reports")
                    {
                        Caption = 'Statutory Reports';

                        action("Monthly Payee - Report ")
                        {
                            Caption = 'Montly payee report';
                            Image = "Report";
                            RunObject = Report "Trustee Monthly PAYE Report";
                        }
                        action("NSSF-Reporting ")
                        {
                            Caption = 'NSSF reporting';
                            Image = "Report";
                            RunObject = Report "Trustee NSSF Reporting";
                        }
                        action(NHIF)
                        {
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
                            Caption = 'Pension Report';
                            Image = "Report";
                            RunObject = Report "Trustee Pension Report";
                        }
                    }
                    group("Annual-Statutory Reports")
                    {
                        Caption = 'Annual Statutory Reports';

                        action("P9A-Report ")
                        {
                            Caption = 'P9A Report';
                            Image = ResourcePlanning;
                            RunObject = Report "P9A Report-Trustees";
                        }
                        action("P10-Report")
                        {
                            Caption = 'P10 Report';
                            Image = "Report";
                            RunObject = Report TrusteeP10;
                        }
                    }
                    group("Reconciliation-Reports")
                    {
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
                    RunObject = Page "Employee Contracts";
                }
                action("Updated Contracts")
                {
                    RunObject = Page "Updated Employee Contracts";
                }
            }
            group("Loan ")
            {
                Image = Calculator;

                group("Loan Applications")
                {
                    action("Loan Applications - New")
                    {
                        RunObject = Page "Loan Application List-Payroll";
                    }
                    action("Loan Applciations - Issued")
                    {
                        RunObject = Page "Posted Loan List-Payroll";
                    }
                }
                group("Loan Interest Processing")
                {
                    action("Interest Processing")
                    {
                        RunObject = page "Loan Interest List-Payroll";
                    }
                    action("Posted Loan Interest")
                    {
                        RunObject = page "Posted Loan Interests-Payroll";
                    }
                    action("Reversed Loan Interest")
                    {
                        RunObject = page "Reversed Loan Interests-Payrol";
                    }
                }
                group("Loan Setups")
                {
                    action("Loan Product Types ")
                    {
                        RunObject = Page "Loan Product Types-Payroll";
                    }
                }
            }
            group("Periodic Activity")
            {
                Image = History;

                action("Import Earnings & Deductions")
                {
                    RunObject = Page "Import Earnings & Deductions";
                }
                action("Imported Earnings & Deductions")
                {
                    RunObject = Page "Imported Earnings & Deductions";
                }
                action("Email List ")
                {
                    RunObject = Page "Email List";
                }
            }
            group("Medical Ceiling")
            {
                action("Medical Ceiling Setup")
                {
                    RunObject = Page "Medical Ceiling Setup";
                }
            }
            group("Self Service")
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
                action("Budget Approval List")
                {
                    RunObject = Page "Budget Approval List";
                }
            }
            group("Leave Management")
            {
                Image = Statistics;

                action("Leave Application List ")
                {
                    RunObject = Page "Leave Application List";
                }
                action("Leave Adjustment List ")
                {
                    RunObject = Page "Leave Adjustment List";
                }
                action("Leave Recall List")
                {
                    RunObject = Page "Leave Recall List";
                }
                action("Approved Leaves")
                {
                    RunObject = Page "Approved Leaves";
                }
                action("Leave Types Setup ")
                {
                    RunObject = Page "Leave Types Setup";
                }
            }
            group(Disciplinary)
            {
                Image = Worksheets;

                action("Employee Disciplinary")
                {
                    RunObject = Page "Employee Disciplinary List";
                }
            }
        }
        area(processing)
        {
            action("Employee's List ")
            {
                Image = CustomerList;
                RunObject = Page "Employee List";
            }
            action("Payroll Requests")
            {
                Image = Reuse;
                RunObject = Page "Payroll Requests";
            }
            action("Human Resources Setup")
            {
                RunObject = Page "Human Resources Setup";
            }
        }
    }
}
