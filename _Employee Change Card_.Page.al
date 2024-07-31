page 50519 "Employee Change Card"
{
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = "Employee Change Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        //AssistEdit;
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field(Initials; Rec.Initials)
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Passport No."; Rec."Passport No.")
                {
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field(Gender; Rec.Gender)
                {
                }
                field(Disabled; Rec.Disabled)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled::No then begin
                            DisabilityView := false;
                        end
                        else
                            DisabilityView := true;
                    end;
                }
                group(Control129)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                    }
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Date of Birth - Age"; Rec."Date of Birth - Age")
                {
                    Caption = ' Age';
                    Importance = Standard;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field(Religion; Rec.Religion)
                {
                    Visible = false;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Visible = false;
                }
                field("Ethnic Community"; Rec."Ethnic Community")
                {
                    Caption = 'Ethnic Code';
                    Visible = false;
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    Caption = 'Ethnic Community';
                }
                field("Home District"; Rec."Home District")
                {
                }
                field(County; Rec.County)
                {
                    Caption = 'Home County';
                }
                field("First Language"; Rec."First Language")
                {
                    Visible = false;
                }
                field("Second Language"; Rec."Second Language")
                {
                    Visible = false;
                }
                field("Other Language"; Rec."Other Language")
                {
                    Visible = false;
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Job Position"; Rec."Job Position")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Area"; Rec.Area)
                {
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                field("Clearance Department"; Rec."Clearance Department")
                {
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = false;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                    }
                }
            }
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Editable = false;

                field("Acting No"; Rec."Acting No")
                {
                }
                field(Control159; Rec."Acting Position")
                {
                }
                field("Acting Description"; Rec."Acting Description")
                {
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                }
            }
            group(Administration)
            {
                field("Employment Date"; Rec."Employment Date")
                {
                }
                group(Estatus)
                {
                    ShowCaption = false;
                    Editable = Statuseditable;

                    field("Employment Status"; Rec."Employment Status")
                    {
                        Caption = 'Status';

                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            StatusView;
                            CurrPage.Update();
                            exit;
                        end;
                    }
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                }
                field("Termination Date"; Rec."Termination Date")
                {
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                }
                field("Resource No."; Rec."Resource No.")
                {
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                }
            }
            group("Lecturer Info")
            {
                Visible = false;
                Caption = 'Lecturer Info';

                field("Is Lecturer"; Rec."Is Lecturer")
                {
                }
                field("Lecturer Type"; Rec."Lecturer Type")
                {
                }
                field("Lecturer Password"; Rec."Lecturer Password")
                {
                }
                field("Portal Registered"; Rec."Portal Registered")
                {
                }
                field("Activation Code"; Rec."Activation Code")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Editable = true;
                Visible = false;

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    Visible = false;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ShowMandatory = true;
                }
                field("NHIF No."; Rec."NHIF No")
                {
                    Caption = 'NHIF No.';
                }
                field("NSSF No."; Rec."Social Security No.")
                {
                }
                field("HELB No"; Rec."HELB No")
                {
                }
                field("Co-Operative No"; Rec."Co-Operative No")
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field("Employee's Bank"; Rec."Employee's Bank")
                {
                    Caption = 'Bank';

                    trigger OnValidate()
                    begin
                        if Banks.Get(Rec."Bank Code") then BankName := Banks.Name;
                    end;
                }
                field("Employee Bank Name"; Rec."Employee Bank Name")
                {
                    Caption = 'Bank Name';
                    Editable = false;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    Caption = 'Branch';
                }
                field("Employee Branch Name"; Rec."Employee Branch Name")
                {
                    Caption = 'Branch Name';
                    Editable = false;
                }
                field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
                {
                    Caption = 'Sort Code';
                    Editable = false;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                }
                field(Present; Rec.Present)
                {
                    Caption = 'Present Pointer';
                }
                field(Previous; Rec.Previous)
                {
                    Caption = 'Previous Pointer';
                    Editable = false;
                }
                field(Halt; Rec.Halt)
                {
                    Caption = 'Halt Pointer';
                    Editable = false;
                }
                field("Incremental Month"; Rec."Incremental Month")
                {
                }
                field("Pays tax?"; Rec."Pays tax?")
                {
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    Editable = false;
                }
                field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
                {
                    Visible = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("House Allowance"; Rec."House Allowance")
                {
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    Editable = false;
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                }
                field("Cumm. PAYE"; Rec."Cumm. PAYE")
                {
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Join"; Rec."Date Of Join")
                {
                    trigger OnValidate()
                    begin
                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                Visible = false;

                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                }
                field("Compassionate Leave Days"; Rec."Compassionate Leave Days")
                {
                }
                field("Maternity Leave Days"; Rec."Maternity Leave Days")
                {
                    Visible = Visibility;
                }
                field("Paternity Leave Days"; Rec."Paternity Leave Days")
                {
                    Visible = Visibility;
                }
                field("Sick Leave Days"; Rec."Sick Leave Days")
                {
                }
                field("Study Leave Days"; Rec."Study Leave Days")
                {
                }
                field("Other Leave Days (Total)"; Rec."Other Leave Days (Total)")
                {
                }
            }
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Visible = false;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Picture)
            {
                Caption = 'Picture';
                Image = Picture;

                action("Co&mments")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                    Visible = true;
                }
                action(Dimensions)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    Visible = true;
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                    Visible = true;
                }
            }
            group(Employee)
            {
                Caption = 'Employee';

                action(AlternativeAddresses)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("Next of Kin")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageMode = View;
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                action(Disciplinary)
                {
                    Image = DeleteAllBreakpoints;
                    RunObject = Page "Closed Disciplinary Cases";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.") ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Employment History")
                {
                    Image = History;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Employment History ";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Employee Appointment Checklist")
                {
                    Caption = 'Appointment Checklist';
                    Image = CheckList;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Appointment Checklist ListPart";
                }
                action("Leave Aplications")
                {
                    Image = JobResponsibility;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedOnly = true;
                    RunObject = Page "Leave Application List";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
                action("Professional Membership")
                {
                    Image = Agreement;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Professional Membership";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Union)
                {
                    Image = Union;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                }
                action(House)
                {
                    Image = Warehouse;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Houses List";
                    RunPageLink = "Allocated Employee" = FIELD("No.");
                }
                action("Acting Positions")
                {
                    Image = EditCustomer;
                    RunObject = Page "Acting Duties List";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Beneficiaries)
                {
                    Image = Employee;
                    RunObject = Page "Employee Beneficiaries";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Visible = false;

                group(Action72)
                {
                    Caption = 'Performance Management';
                    Image = Travel;

                    action(Appraisal)
                    {
                        trigger OnAction()
                        begin
                            Message('Coming Soon');
                        end;
                    }
                }
            }
        }
        area(creation)
        {
            group(Earnings)
            {
                Visible = false;
            }
            action("Assign Earnings")
            {
                Caption = 'Assign Earnings';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(false);
            }
            action(List)
            {
                RunObject = Page Earnings;
            }
            action("Dispay Reccuring Earnings")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST(Recurring), Closed = CONST(false);
            }
            action("Display Non-reccuring Earnings")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST("Non-recurring"), Closed = CONST(false);
            }
            group(Deductions)
            {
                Visible = false;
            }
            action("Assign Deductions")
            {
                Caption = 'Assign Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(false);
            }
            action("Deductions List")
            {
                RunObject = Page Deductions;
            }
            action("Display Reccuring Deductions")
            {
                Caption = 'Display Reccuring Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST(Recurring), Closed = CONST(false);
            }
            action("Display Non-reccuring Deductions")
            {
                Caption = 'Display Non-reccuring Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST("Non-recurring"), Closed = CONST(false);
            }
            group(Loans)
            {
            }
            action("Deduction Loan")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Loan), Closed = CONST(false);
            }
            action("Employee Loan(s) List")
            {
                Caption = 'Employee Loan(s) List';
            }
            action("Savings Withdrawals")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Closed = CONST(false), Type = CONST("Saving Scheme");
            }
            group("Pay Manager")
            {
            }
            action("Pay Information")
            {
            }
            separator(Action147)
            {
            }
            action("Account Mapping")
            {
            }
        }
        area(processing)
        {
            action("Assign Default Ded/Earnings")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //DefaultAssignment();
                end;
            }
            action(Payslip)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then CurrentMonth := PayPeriod."Starting Date";
                    Employee.SetRange("No.", Rec."No.");
                    Employee.SetRange("Pay Period Filter", CurrentMonth);
                    REPORT.Run(Report::"New Payslipx", true, false, Employee);
                end;
            }
            action("Payroll Run")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then CurrentMonth := PayPeriod."Starting Date";
                    Employee.SetRange("No.", Employee."No.");
                    Employee.SetRange("Pay Period Filter", CurrentMonth);
                    REPORT.Run(Report::"Payroll Run", true, false, Employee);
                end;
            }
            action("Yearly Bonus")
            {
                Image = Holiday;

                trigger OnAction()
                begin
                    Payroll.GetYearlyBonus(Rec."No.");
                end;
            }
            action("Mail Payslip")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MailBulkPayslips: Report "Mail Bulk Payslips";
                begin
                    if Confirm(Text0001, false) = true then begin
                        //Mail single
                        Employee.Reset;
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst then begin
                            MailBulkPayslips.SetTableView(Employee);
                            MailBulkPayslips.Run;
                        end;
                    end
                    else
                        exit;
                end;
            }
            action("Import Data")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Clear(EmployeeXML);
                    EmployeeXML.Run;
                end;
            }
            action(SendApproval)
            {
                visible = Statuseditable;
                Caption = 'Change';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Employment Status" = Rec."Employment Status"::Inactive then Rec.TestField("Inactive Date");
                    Employee.Reset;
                    Employee.SetRange("No.", Rec."No.");
                    if Employee.Find('-') then Employee.TransferFields(Rec);
                    Employee.Modify;
                    Message('Change Made Successfully');
                    CurrPage.Close;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible;
        SetLecturerVisible;
        StatusView();
        SetContractView();
        DisabilityView := false;
        //ProbationPeriod:=HRSetup."Probation Duration";
        if LeaveType.Get('ANNUAL') then Rec."Annual Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('PATERNITY') then begin
            if Rec.Gender = LeaveType.Gender then Visibility := true;
            Rec."Paternity Leave Days" := LeaveType.Days;
        end
        else
            Visibility := false;
        //MODIFY;
        if LeaveType.Get('COMPASSION') then Rec."Compassionate Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('SICK') then Rec."Sick Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('UNPAID') then Rec."Other Leave Days (Total)" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('MATERNITY') then begin
            if Rec.Gender = LeaveType.Gender then
                Visibility := true
            else
                Visibility := false;
            Rec."Maternity Leave Days" := LeaveType.Days;
        end
        else
            Visibility := false;
        //MODIFY;
        if LeaveType.Get('STUDY') then Rec."Study Leave Days" := LeaveType.Days;
        //MODIFY;
        // "Compassionate Leave Days":=
        // "Paternity Leave Days":=
        // "Maternity Leave Days":=
        // "Sick Leave Days":=
        // "Study Leave Days":=
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        StatusView();
    end;

    var
        ShowMapLbl: Label 'Show on Map';
        NoFieldVisible: Boolean;
        IsLecturerVisible: Boolean;
        ContractView: Boolean;
        BankName: Text;
        Banks: Record Banks;
        ProbationPeriod: DateFormula;
        HRSetup: Record "Human Resources Setup";
        LeaveType: Record "Leave Type";
        Visibility: Boolean;
        DisabilityView: Boolean;
        PayPeriod: Record "Payroll PeriodX";
        CurrentMonth: Date;
        Employee: Record Employee;
        Statuseditable: Boolean;
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        Text0001: Label 'Do you want to send the payslip?';

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible;
    end;

    procedure StatusView()
    begin
        if Rec."Employment Status" <> Rec."Employment Status"::"Permanently Inactive" then
            Statuseditable := true
        else
            Statuseditable := false;
    end;

    local procedure SetLecturerVisible()
    begin
        if Rec."Is Lecturer" = true then begin
            IsLecturerVisible := true;
        end
        else
            IsLecturerVisible := false;
    end;

    local procedure SetContractView()
    begin
        if Rec."No." <> '' then begin
            if Rec."Nature of Employment" <> 'CONTRACT' then begin
                ContractView := false;
            end
            else
                ContractView := true;
        end;
    end;

    local procedure ContractFields()
    begin
        /*//"Contract Type":='';
            "Contract Number":=0;
            "Contract Start Date":=0D;
            "Contract End Date":=0D;
            "Send Alert to":='';
            MODIFY;
            */
    end;

    local procedure Disability()
    begin
        if Rec."No." <> '' then begin
            if Rec.Disabled = Rec.Disabled::No then begin
                DisabilityView := false;
            end
            else
                DisabilityView := true;
        end;
    end;

    local procedure DisabilityField()
    begin
        Rec.Disability := '';
    end;

    local procedure GetCurrentPayPeriod(): Date
    var
        PayrollPeriod: Record "Payroll PeriodX";
    begin
        PayPeriod.Reset;
        PayPeriod.SetRange(Closed, false);
        if PayPeriod.FindFirst then exit(PayPeriod."Starting Date");
    end;
}
