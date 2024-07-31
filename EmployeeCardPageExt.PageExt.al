pageextension 50128 EmployeeCardPageExt extends "Employee Card"
{
    PromotedActionCategories = 'New,Process,Report,Change Request';

    layout
    {
        addlast(General)
        {
            field(Ext; Rec.Extension)
            {
                Caption = 'Extension';
                ApplicationArea = All;
            }
        }
        addafter("E-Mail")
        {
            field("Alternative Branch Code"; Rec."Alternative Branch Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Alt. Address Start Date")
        {
            Caption = 'Branch Start Date';
        }
        modify("Alt. Address End Date")
        {
            Caption = 'Branch End Date';
        }
        modify("Job Title")
        {
            Visible = false;
        }
        modify("Birth Date")
        {
            Visible = false;
        }
        modify("Social Security No.")
        {
            Visible = false;
        }
        modify("Alt. Address Code")
        {
            Visible = false;
        }
        modify(Extension)
        {
            Visible = false;
        }
        modify("Bank Branch No.")
        {
            Visible = false;
        }
        modify("Bank Account No.")
        {
            Visible = false;
        }
        modify("Employee Posting Group")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify(IBAN)
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        modify("Emplymt. Contract Code")
        {
            Visible = false;
        }
        modify(Pager)
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = true;
        }
        addafter("Employment Date")
        {
            group(Estatus)
            {
                ShowCaption = false;
                Editable = Statuseditable;

                field("Employment Status"; Rec."Employment Status")
                {
                    Caption = 'Employee Status';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        EmplRec: Record Employee;
                    begin
                        StatusView;
                        Rec.Status := Rec."Employment Status";
                        CurrPage.Update();
                        exit;
                    end;
                }
            }
        }
        addafter("Privacy Blocked")
        {
            field("User ID"; Rec."User ID")
            {
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the User ID field';
                ApplicationArea = All;
            }
            field("Imprest Customer Code"; Rec."Imprest Customer Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Imprest Customer Code field.', Comment = '%';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                ApplicationArea = All;
            }
        }
        addlast(Personal)
        {
            field(Disabled; Rec.Disabled)
            {
                ToolTip = 'Specifies the value of the Disabled field';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if Rec.Disabled = Rec.Disabled::No then begin
                        DisabilityView := false;
                    end
                    else
                        DisabilityView := true;
                end;
            }
            group(Control197)
            {
                ShowCaption = false;
                Visible = DisabilityView;

                field(Disability; Rec.Disability)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Disability field';
                    ApplicationArea = All;
                }
                field("Disability Certificate"; Rec."Disability Certificate")
                {
                    Caption = 'Disability Certificate No.';
                    ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    ApplicationArea = All;
                }
            }
            field("ID No."; Rec."ID No.")
            {
                ToolTip = 'Specifies the value of the ID No. field';
                ApplicationArea = All;
            }
            field("Passport Number"; Rec."Passport Number")
            {
                ApplicationArea = All;
            }
            field("Huduma Number"; Rec."Huduma Number")
            {
                ApplicationArea = All;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ToolTip = 'Specifies the value of the Marital Status field';
                ApplicationArea = All;
            }
            field(Religion; Rec.Religion)
            {
                ToolTip = 'Specifies the value of the Religion field';
                ApplicationArea = All;
            }
            field(Race; Rec.Race)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Ethnic Origin"; Rec."Ethnic Origin")
            {
                Caption = 'Race';
                ToolTip = 'Specifies the value of the Ethnic Origin field';
                ApplicationArea = All;
            }
            field("Ethnic Community"; Rec."Ethnic Community")
            {
                // Visible = false;
                Caption = 'Ethnic Group';
                ToolTip = 'Specifies the value of the Ethnic Code field';
                ApplicationArea = All;
            }
            field("Ethnic Name"; Rec."Ethnic Name")
            {
                ToolTip = 'Specifies the value of the Ethnic Community field';
                ApplicationArea = All;
            }
            field("Home District"; Rec."Home District")
            {
                ToolTip = 'Specifies the value of the Home District field';
                ApplicationArea = All;
            }
            field("First Language"; Rec."First Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the First Language field';
                ApplicationArea = All;
            }
            field("Second Language"; Rec."Second Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Second Language field';
                ApplicationArea = All;
            }
            field("Other Language"; Rec."Other Language")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Other Language field';
                ApplicationArea = All;
            }
            field("County Code"; Rec."County Code")
            {
                ApplicationArea = All;
            }
            field("County Name"; Rec."County Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address & Contact")
        {
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Job Position"; Rec."Job Position")
                {
                    Caption = 'Job ID';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Title2"; Rec."Job Title2")
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    Caption = 'Position';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field(Manager; Rec.Manager)
                {
                    ToolTip = 'Specifies the value of the Manager field.';
                    ApplicationArea = All;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';
                    ToolTip = 'Specifies the value of the Employment Type field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                field("Division/Section"; Rec."Division/Section")
                {
                    ToolTip = 'Specifies the value of the Division/Section field.';
                    ApplicationArea = All;
                }
                field(Directorate; Rec.Directorate)
                {
                    ToolTip = 'Specifies the value of the Directorate field.';
                    ApplicationArea = All;
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = true;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                        ToolTip = 'Specifies the value of the Contract Type field';
                        ApplicationArea = All;
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                        ToolTip = 'Specifies the value of the Contract Number field';
                        ApplicationArea = All;
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                        ToolTip = 'Specifies the value of the Contract Length field';
                        ApplicationArea = All;
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Start Date field';
                        ApplicationArea = All;
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the Contract End Date field';
                        ApplicationArea = All;
                    }
                }
            }
        }
        addafter("Employment Information")
        {
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Editable = false;

                field("Acting No"; Rec."Acting No")
                {
                    ToolTip = 'Specifies the value of the Acting No field';
                    ApplicationArea = All;
                }
                field(Control58; Rec."Acting Position")
                {
                    ToolTip = 'Specifies the value of the Acting Position field';
                    ApplicationArea = All;
                }
                field("Acting Description"; Rec."Acting Description")
                {
                    ToolTip = 'Specifies the value of the Acting Description field';
                    ApplicationArea = All;
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                    ApplicationArea = All;
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    ToolTip = 'Specifies the value of the Relieved Name field';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                    ApplicationArea = All;
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                    ToolTip = 'Specifies the value of the Reason for Acting field';
                    ApplicationArea = All;
                }
            }
        }
        addlast(Payments)
        {
            field("PIN Number"; Rec."PIN Number")
            {
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the PIN Number field';
                ApplicationArea = All;
            }
            field("NHIF No."; Rec."NHIF No")
            {
                Caption = 'NHIF No.';
                ToolTip = 'Specifies the value of the NHIF No. field';
                ApplicationArea = All;
            }
            field("NSSF No."; Rec."Social Security No.")
            {
                Caption = 'NSSF No.';
                ToolTip = 'Specifies the value of the Social Security No. field';
                ApplicationArea = All;
            }
            field("Pay Mode"; Rec."Pay Mode")
            {
                ToolTip = 'Specifies the value of the Pay Mode field';
                ApplicationArea = All;
            }
            field("Employee's Bank"; Rec."Employee's Bank")
            {
                Caption = 'Bank';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Bank field';
            }
            field("Employee Bank Name"; Rec."Employee Bank Name")
            {
                Caption = 'Bank Name';
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Specifies the value of the Bank Name field';
            }
            field("Bank Branch"; Rec."Bank Branch")
            {
                Caption = 'Branch';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Branch field';
            }
            field("Employee Branch Name"; Rec."Employee Branch Name")
            {
                Caption = 'Branch Name';
                Editable = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Branch Name field';
            }
            field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
            {
                Caption = 'Sort Code';
                Editable = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Sort Code field';
            }
            field("Bank Account Number"; Rec."Bank Account Number")
            {
                Caption = 'Bank Account Number';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Bank Account Number field';
            }
            field("Posting Group"; Rec."Posting Group")
            {
                Caption = 'HR Posting Group';
                ToolTip = 'Specifies the value of the HR Posting Group field';
                ApplicationArea = All;
            }
            field("Gratuity Vendor No."; Rec."Gratuity Vendor No.")
            {
                ToolTip = 'Specifies the value of the Gratuity Vendor No. field. This is used for Employees being paid Gratuity';
                ApplicationArea = All;
            }
            field("Debtor Code"; Rec."Debtor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debtor Code field for Payroll Loan purposes';
            }
            field("Salary Scale"; Rec."Salary Scale")
            {
                ToolTip = 'Specifies the value of the Salary Scale field';
                ApplicationArea = All;
            }
            field(Present; Rec.Present)
            {
                Caption = 'Present Pointer';
                ToolTip = 'Specifies the value of the Present Pointer field';
                ApplicationArea = All;
            }
            field(Previous; Rec.Previous)
            {
                Caption = 'Previous Pointer';
                Editable = false;
                ToolTip = 'Specifies the value of the Previous Pointer field';
                ApplicationArea = All;
            }
            field(Halt; Rec.Halt)
            {
                Caption = 'Halt Pointer';
                Editable = false;
                ToolTip = 'Specifies the value of the Halt Pointer field';
                ApplicationArea = All;
            }
            field("Incremental Month"; Rec."Incremental Month")
            {
                ToolTip = 'Specifies the value of the Incremental Month field';
                ApplicationArea = All;
            }
            field("Pays tax?"; Rec."Pays tax?")
            {
                ToolTip = 'Specifies the value of the Pays tax? field';
                ApplicationArea = All;
            }
            field("Secondary Employee"; Rec."Secondary Employee")
            {
                ToolTip = 'Specifies the value of the Secondary Employee field';
                ApplicationArea = All;
                // Visible = false;
            }
            field("Insurance Relief"; Rec."Insurance Relief")
            {
                ToolTip = 'Specifies the value of the Insurance Relief field';
                ApplicationArea = All;
            }
            field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Pro-Rata Calculated field';
                ApplicationArea = All;
            }
            field("Basic Pay"; Rec."Basic Pay")
            {
                ToolTip = 'Specifies the value of the Basic Pay field';
                ApplicationArea = All;
            }
            field("House Allowance"; Rec."House Allowance")
            {
                ToolTip = 'Specifies the value of the House Allowance field';
                ApplicationArea = All;
            }
            field("Insurance Premium"; Rec."Insurance Premium")
            {
                Editable = false;
                ToolTip = 'Specifies the value of the Insurance Premium field';
                ApplicationArea = All;
            }
            field("Total Allowances"; Rec."Total Allowances")
            {
                ToolTip = 'Specifies the value of the Total Allowances field';
                ApplicationArea = All;
            }
            field("Total Deductions"; Rec."Total Deductions")
            {
                ToolTip = 'Specifies the value of the Total Deductions field';
                ApplicationArea = All;
            }
            field("Taxable Allowance"; Rec."Taxable Allowance")
            {
                ToolTip = 'Specifies the value of the Taxable Allowance field';
                ApplicationArea = All;
            }
            field("Cumm. PAYE"; Rec."Cumm. PAYE")
            {
                ToolTip = 'Specifies the value of the Cumm. PAYE field';
                ApplicationArea = All;
            }
            field("Leave Category"; Rec."Leave Category")
            {
                ApplicationArea = All;
            }
        }
        addafter(Payments)
        {
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the ProbationPeriod field';
                    ApplicationArea = All;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Probation End Date field';
                    ApplicationArea = All;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Join field';
                    ApplicationArea = All;
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Medical Scheme Join field';
                    ApplicationArea = All;
                }
                field("Special Retirement Age"; Rec."Special Retirement Age")
                {
                    ToolTip = 'Specifies the value of the Special Retirement Age field where e.g. Researcher and policy makers including persons with disabilities retire at 65.';
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Birth Date")
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
                    ToolTip = 'Specifies the value of the  Age field';
                    ApplicationArea = All;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Retirement Date field';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Important Dates")
        {
            group("Leave Details")
            {
                Caption = 'Leave Details';
                Visible = false;

                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ToolTip = 'Specifies the value of the Annual Leave Days field';
                    ApplicationArea = All;
                }
                field("Compassionate Leave Days"; Rec."Compassionate Leave Days")
                {
                    ToolTip = 'Specifies the value of the Compassionate Leave Days field';
                    ApplicationArea = All;
                }
                field("Maternity Leave Days"; Rec."Maternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Maternity Leave Days field';
                    ApplicationArea = All;
                }
                field("Paternity Leave Days"; Rec."Paternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Paternity Leave Days field';
                    ApplicationArea = All;
                }
                field("Sick Leave Days"; Rec."Sick Leave Days")
                {
                    ToolTip = 'Specifies the value of the Sick Leave Days field';
                    ApplicationArea = All;
                }
                field("Study Leave Days"; Rec."Study Leave Days")
                {
                    ToolTip = 'Specifies the value of the Study Leave Days field';
                    ApplicationArea = All;
                }
                field("Other Leave Days (Total)"; Rec."Other Leave Days (Total)")
                {
                    ToolTip = 'Specifies the value of the Other Leave Days (Total) field';
                    ApplicationArea = All;
                }
                field("Total Leave Balance"; Rec."Total Leave Balance")
                {
                    ToolTip = 'Specifies the value of the Total Leave Balance field';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Important Dates")
        {
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field';
                    ApplicationArea = All;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ToolTip = 'Specifies the value of the Send Alert to field';
                    ApplicationArea = All;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ToolTip = 'Specifies the value of the Served Notice Period field';
                    ApplicationArea = All;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field';
                    ApplicationArea = All;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Termination Category field';
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Date field';
                    ApplicationArea = All;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ToolTip = 'Specifies the value of the Exit Interview Done by field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    ToolTip = 'Specifies the value of the Allow Re-Employment In Future field';
                    ApplicationArea = All;
                }
            }
            part("Interview Panelist"; "Interview Panelist")
            {
                UpdatePropagation = Both;
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
            group(Increament)
            {
                part("Employee Salary Increament"; "Employee Salary Increment")
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No.");
                }
            }
        }
        addbefore("Important Dates")
        {
            part(BankDetails; "Employee Bank Accounts List")
            {
                Caption = 'Employee Bank/FOSA Accounts List';
                SubPageLink = "Employee No." = field("No.");
                ApplicationArea = All;
            }
            part(InsuranceDetails; "Employee Insurance List")
            {
                Caption = 'Employee Insurance List';
                SubPageLink = "Employee No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("E&mployee")
        {
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
            action(Disciplinary)
            {
                Image = DeleteAllBreakpoints;
                RunObject = Page "Other Incidencts";
                RunPageLink = "Employee No" = FIELD("No.");
                ToolTip = 'Executes the Disciplinary action';
                ApplicationArea = All;
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
                ToolTip = 'Executes the Employment History action';
                ApplicationArea = All;
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
                ToolTip = 'Executes the Appointment Checklist action';
                ApplicationArea = All;
            }
            action("Professional Membership")
            {
                Image = Agreement;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Professional Membership";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Executes the Professional Membership action';
                ApplicationArea = All;
            }
            action(Union)
            {
                Image = Union;
                ToolTip = 'Executes the Union action';
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
            }
            action(House)
            {
                Image = Warehouse;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                // RunObject = Page "Houses List";
                // RunPageLink = "Allocated Employee" = FIELD("No.");
                ToolTip = 'Executes the House action';
                ApplicationArea = All;
            }
            action("Acting Positions")
            {
                Image = EditCustomer;
                RunObject = Page "Acting Duties List";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Executes the Acting Positions action';
                ApplicationArea = All;
            }
            action(Beneficiaries)
            {
                Image = Employee;
                RunObject = Page "Employee Beneficiaries";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Executes the Beneficiaries action';
                ApplicationArea = All;
            }
        }
        addafter("E&mployee")
        {
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Visible = false;

                group(Action192)
                {
                    Caption = 'Performance Management';
                    Image = Travel;

                    action(Appraisal)
                    {
                        ToolTip = 'Executes the Appraisal action';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Message('Coming Soon');
                        end;
                    }
                }
            }
        }
        addafter("Performance Management")
        {
            group(Payroll)
            {
                Caption = 'Payroll';

                group(Earnings)
                {
                    action("Assign Earnings")
                    {
                        Caption = 'Assign Earnings';
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(false);
                        ToolTip = 'Executes the Assign Earnings action';
                        ApplicationArea = All;
                    }
                    action(List)
                    {
                        RunObject = Page Earnings;
                        ToolTip = 'Executes the List action';
                        ApplicationArea = All;
                    }
                    action("Dispay Reccuring Earnings")
                    {
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST(Recurring), Closed = CONST(false);
                        ToolTip = 'Executes the Dispay Reccuring Earnings action';
                        ApplicationArea = All;
                    }
                    action("Display Non-reccuring Earnings")
                    {
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST("Non-recurring"), Closed = CONST(false);
                        ToolTip = 'Executes the Display Non-reccuring Earnings action';
                        ApplicationArea = All;
                    }
                }
                group(Deductions)
                {
                    action("Assign Deductions")
                    {
                        Caption = 'Assign Deductions';
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(false);
                        ToolTip = 'Executes the Assign Deductions action';
                        ApplicationArea = All;
                    }
                    action("Deductions List")
                    {
                        RunObject = Page Deductions;
                        ToolTip = 'Executes the Deductions List action';
                        ApplicationArea = All;
                    }
                    action("Display Reccuring Deductions")
                    {
                        Caption = 'Display Reccuring Deductions';
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST(Recurring), Closed = CONST(false);
                        ToolTip = 'Executes the Display Reccuring Deductions action';
                        ApplicationArea = All;
                    }
                    action("Display Non-reccuring Deductions")
                    {
                        Caption = 'Display Non-reccuring Deductions';
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST("Non-recurring"), Closed = CONST(false);
                        ToolTip = 'Executes the Display Non-reccuring Deductions action';
                        ApplicationArea = All;
                    }
                }
                group(OpeningBalances)
                {
                    Caption = 'Opening Balances';

                    action("Opening Balances")
                    {
                        RunObject = Page "Deductions Balances";
                        RunPageLink = "Employee No" = FIELD("No.");
                        ToolTip = 'Executes the Opening Balances action';
                        ApplicationArea = All;
                    }
                }
                group(Loans)
                {
                    action("Deduction Loan")
                    {
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Loan), Closed = CONST(false);
                        ToolTip = 'Executes the Deduction Loan action';
                        ApplicationArea = All;
                    }
                    action("Employee Loan(s) List")
                    {
                        Caption = 'Employee Loan(s) List';
                        ToolTip = 'Executes the Employee Loan(s) List action';
                        ApplicationArea = All;
                    }
                    action("Savings Withdrawals")
                    {
                        RunObject = Page "Payments & Deductions";
                        RunPageLink = "Employee No" = FIELD("No."), Closed = CONST(false), Type = CONST("Saving Scheme");
                        ToolTip = 'Executes the Savings Withdrawals action';
                        ApplicationArea = All;
                    }
                }
            }
        }
        addlast(Processing)
        {
            action("Assign Default Ded/Earnings")
            {
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Assign Default Ded/Earnings action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.DefaultAssignment();
                end;
            }
            action(Payslip)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the Payslip action';
                ApplicationArea = All;

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
                Caption = 'Payroll Run';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Payroll Run action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then begin
                        CurrentMonth := PayPeriod."Starting Date";
                        //Employee.SETRANGE("No.",Employee."No.");
                        Employee.SetRange("Pay Period Filter", CurrentMonth);
                        REPORT.Run(Report::"Payroll Run1", true, false, Employee);
                    end
                    else
                        Error('You cannot run payroll for a closed period')
                end;
            }
            action("Validate Payroll Data")
            {
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Validates Payroll Data Upon Manual Change';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    //PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then begin
                        CurrentMonth := PayPeriod."Starting Date";
                        Employee.SETRANGE("No.", Employee."No.");
                        Employee.SetRange("Pay Period Filter", CurrentMonth);
                        REPORT.Run(Report::"Validate Payroll Run", true, false, Employee);
                    end
                    else
                        Error('You cannot run payroll for a closed period')
                end;
            }
            action("Yearly Bonus")
            {
                Image = Holiday;
                ToolTip = 'Executes the Yearly Bonus action';
                ApplicationArea = All;

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
                ToolTip = 'Executes the Mail Payslip action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."No.");
                    Employee.SetRange(Status, Rec.Status::Active);
                    if Employee.FindFirst() then if Confirm(Text0001) then Report.Run(Report::"Mail Bulk Payslips", true, false, Employee);
                end;
            }
            action("Mail P9")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    MailBulkP9s: Report "Mail Bulk P9s";
                begin
                    if Confirm(Text0002, false) = true then begin
                        //Mail single
                        Employee.Reset;
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst then begin
                            MailBulkP9s.SetTableView(Employee);
                            MailBulkP9s.Run;
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
                ToolTip = 'Executes the Import Data action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Clear(EmployeeXML);
                    EmployeeXML.Run;
                end;
            }
            action("Change Request")
            {
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Change Request action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Numb := HRMgt.EmployeeChangeReq(Rec);
                    EmployeeChange.SetRange(Number, Numb);
                    HRMgt.EmployeeChangeReq(Rec);
                    PAGE.Run(Page::"Employee Change Card", EmployeeChange);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetNoFieldVisible;
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
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
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        StatusView;
    end;

    var
        ShowMapLbl: Label 'Show on Map';
        FormatAddress: Codeunit "Format Address";
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
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
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        HRMgt: Codeunit "HR Management";
        Numb: Code[20];
        EmployeeChange: Record "Employee Change Request";
        Text0001: Label 'Do you want to send the payslip?';
        Text0002: Label 'Do you want to send the p9?';
        Statuseditable: Boolean;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible;
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

    procedure StatusView()
    begin
        if Rec."Employment Status" <> Rec."Employment Status"::"Permanently Inactive" then
            Statuseditable := true
        else
            Statuseditable := false;
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
