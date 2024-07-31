pageextension 50129 HRSetupPageExt extends "Human Resources Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field("Base Calendar Code"; Rec."Base Calendar Code")
            {
                ApplicationArea = All;
            }
            field("Transport Request Nos."; Rec."Transport Request Nos.")
            {
                ApplicationArea = All;
            }
            field("Probation Period"; Rec."Probation Period")
            {
                Caption = 'Probation Period (Months)';
                ApplicationArea = All;
            }
            field("Incidences Nos"; Rec."Incidences Nos")
            {
                ApplicationArea = All;
            }
            field("Sick Off Nos"; Rec."Sick Of Nos")
            {
                ApplicationArea = All;
            }
            field("Appraisal Nos"; Rec."Appraisal Nos")
            {
                ApplicationArea = All;
            }
            field("Target Nos"; Rec."Target Nos")
            {
                ToolTip = 'Specifies the value of the Target Nos field.';
                ApplicationArea = All;
            }
            field("Keys Request Nos"; Rec."Keys Request Nos")
            {
                ApplicationArea = All;
            }
            field("Transport Request Nos"; Rec."Transport Request Nos")
            {
                ApplicationArea = All;
            }
            field("Appraisal Objective Nos"; Rec."Appraisal Objective Nos")
            {
                ApplicationArea = All;
            }
            field("Resource Request Nos"; Rec."Resource Request Nos")
            {
                ApplicationArea = All;
            }
            field("Vehicle Filling No"; Rec."Vehicle Filling No")
            {
                ApplicationArea = All;
            }
            field("Driver Log Nos"; Rec."Driver Log Nos")
            {
                ApplicationArea = All;
            }
            field("Asset Allocation Nos"; Rec."Asset Allocation Nos")
            {
                ApplicationArea = All;
            }
            field("Asset Transfer Nos"; Rec."Asset Transfer Nos")
            {
                ApplicationArea = All;
            }
            field("Contract No"; Rec."Contract No")
            {
                ApplicationArea = All;
            }
            field("Membership No."; Rec."Membership No.")
            {
                ApplicationArea = All;
            }
            field("Conveyance Nos"; Rec."Conveyance Nos")
            {
                ApplicationArea = All;
            }
            field("Training Evaluation Nos"; Rec."Training Evaluation Nos")
            {
                ApplicationArea = All;
            }
            field("Post Training Evaluation Nos."; Rec."Post Training Evaluation Nos.")
            {
                ToolTip = 'Specifies the value of the Post Training Evaluation Nos. field.';
                ApplicationArea = All;
            }
            field("Medical Claim Nos"; Rec."Medical Claim Nos")
            {
                ApplicationArea = All;
            }
            field("Training Request Nos"; Rec."Training Request Nos")
            {
                ApplicationArea = All;
            }
            field("Loan App No"; Rec."Loan App No")
            {
                ApplicationArea = All;
            }
            field("Loan Interest Nos"; Rec."Loan Interest Nos")
            {
                ApplicationArea = All;
            }
            field("Telephone Request Nos"; Rec."Telephone Request Nos")
            {
                ApplicationArea = All;
            }
            field("Cover Selection Nos"; Rec."Cover Selection Nos")
            {
                ApplicationArea = All;
            }
            field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
            {
                ApplicationArea = All;
            }
            field("Recruitment Needs Nos."; Rec."Recruitment Needs Nos.")
            {
                ApplicationArea = All;
            }
            field("Shortlisting Criteria"; Rec."Shortlisting Criteria")
            {
                Caption = 'Shortlisting Criteria Nos';
                ApplicationArea = All;
            }
            field("Applicants Nos."; Rec."Applicants Nos.")
            {
                ApplicationArea = All;
            }
            field("Job Application Nos."; Rec."Job Application Nos.")
            {
                ApplicationArea = All;
            }
            field("Payroll Req Nos"; Rec."Payroll Req Nos")
            {
                ApplicationArea = All;
            }
            field("Assignment Nos"; Rec."Assignment Nos")
            {
                ApplicationArea = All;
            }
            field("Savings Withdrawal No"; Rec."Savings Withdrawal No")
            {
                ApplicationArea = All;
            }
            field("Vehicle Maintenance Nos"; Rec."Vehicle Maintenance Nos")
            {
                ApplicationArea = All;
            }
            field("Employee Contract Nos"; Rec."Contract Nos")
            {
                ApplicationArea = All;
            }
            field("Employee Change Nos"; Rec."Employee Change Nos")
            {
                ApplicationArea = All;
            }
            field("Email Institution Nos"; Rec."Email Institution Nos")
            {
                ApplicationArea = All;
            }
            field("Training Needs Nos"; Rec."Training Needs Nos")
            {
                ApplicationArea = All;
            }
            field("Training Needs Request Nos."; Rec."Training Needs Request Nos.")
            {
                ApplicationArea = All;
            }
            field("Training Budget Item Nos"; Rec."Training Budget Item Nos")
            {
                ApplicationArea = All;
            }
            field("Trustee Nos"; Rec."Trustee Nos")
            {
                ApplicationArea = All;
            }
            field("Trustee Reversal Nos"; Rec."Trustee Reversal Nos")
            {
                ApplicationArea = All;
            }
            field("Imprest Deduction Nos"; Rec."Imprest Deduction Nos")
            {
                ApplicationArea = All;
            }
            field("Payroll Approval Nos"; Rec."Payroll Approval Nos")
            {
                ApplicationArea = All;
            }
            field("Committee Nos"; Rec."Committee Nos")
            {
                ApplicationArea = All;
            }
            field("Serial No"; Rec."Serial No")
            {
                ToolTip = 'Specifies the value of the Serial No field.';
                ApplicationArea = All;
            }
            field("Interview Committee No.s"; Rec."Interview Committee No.s")
            {
                ApplicationArea = all;
            }
        }
        addafter(Numbering)
        {
            group("Leave Setups")
            {
                Caption = 'Leave Setups';

                field("Base Calender Code"; Rec."Base Calender Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Leave Recall Nos"; Rec."Leave Recall Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Adjustment Nos"; Rec."Leave Adjustment Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Plan Nos"; Rec."Leave Plan Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance Code"; Rec."Leave Allowance Code")
                {
                    ApplicationArea = All;
                }
                field("Dependant Maximum Age"; Rec."Dependant Maximum Age")
                {
                    ApplicationArea = All;
                }
                field("Leave Days"; Rec."Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Leave Duration"; Rec."Leave Duration")
                {
                    ToolTip = 'Specifies the value of the Leave Duration field.';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Leave Setups")
        {
            group("Other Setups")
            {
                Caption = 'Other Setups';

                field("User Incident"; Rec."User Incident")
                {
                    ApplicationArea = All;
                }
                field("Conf/Sem Evaluation"; Rec."Conf/Sem Evaluation")
                {
                    ApplicationArea = All;
                }
                field("Conf/Sem/Request"; Rec."Conf/Sem/Request")
                {
                    ApplicationArea = All;
                }
                field("Employee Absentism"; Rec."Employee Absentism")
                {
                    ApplicationArea = All;
                }
                field("Corporation Tax"; Rec."Corporation Tax")
                {
                    ApplicationArea = All;
                }
                field("Company overtime hours"; Rec."Company overtime hours")
                {
                    ApplicationArea = All;
                }
                field("BFW Round Earning code"; Rec."BFW Round Earning code")
                {
                    ApplicationArea = All;
                }
                field("Working Hours"; Rec."Working Hours")
                {
                    ApplicationArea = All;
                }
                field("Round Down"; Rec."Round Down")
                {
                    ApplicationArea = All;
                }
                field("Housing Earned Limit"; Rec."Housing Earned Limit")
                {
                    ApplicationArea = All;
                }
                field("Tax Relief Amount"; Rec."Tax Relief Amount")
                {
                    ApplicationArea = All;
                }
                field("Off Days Code"; Rec."Off Days Code")
                {
                    ApplicationArea = All;
                }
                field("Account No (Training)"; Rec."Account No (Training)")
                {
                    ApplicationArea = All;
                }
                field("Qualification Days (Leave)"; Rec."Qualification Days (Leave)")
                {
                    ApplicationArea = All;
                }
                field("Board of Directors Tenure"; Rec."Board of Directors Tenure")
                {
                    ApplicationArea = All;
                }
                field("Imprest Due Days"; Rec."Imprest Due Days")
                {
                    ApplicationArea = All;
                }
                field("Imprest Notification Days"; Rec."Imprest Notification Days")
                {
                    ApplicationArea = All;
                }
                field("Contract Notification Days"; Rec."Contract Notification Days")
                {
                    ToolTip = 'Specifies the value of the Contract Notification Due Days field.';
                    ApplicationArea = All;
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    Caption = 'Employee Email Subject';
                    ToolTip = 'Specifies the value of the Email Subject field.';
                    ApplicationArea = All;
                }
                field("Employee Email Body"; Rec."Employee Email Body")
                {
                    ToolTip = 'Specifies the value of the Employee Email Body field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Net pay POP Code"; Rec."Net pay POP Code")
                {
                    ToolTip = 'Specifies the value of the Net pay POP Code field.';
                    ApplicationArea = All;
                    Caption = 'Adhoc Flag';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                    ApplicationArea = All;
                }
                field("Payment Description1"; Rec."Payment Description1")
                {
                    ToolTip = 'Specifies the value of the Payment Description1 field.';
                    ApplicationArea = All;
                }
                field("Payment Description2"; Rec."Payment Description2")
                {
                    ToolTip = 'Specifies the value of the Payment Description2 field.';
                    ApplicationArea = All;
                }
                field("Payment Description3"; Rec."Payment Description3")
                {
                    ToolTip = 'Specifies the value of the Payment Description3 field.';
                    ApplicationArea = All;
                }
                field("Payment Description4"; Rec."Payment Description4")
                {
                    ToolTip = 'Specifies the value of the Payment Description4 field.';
                    ApplicationArea = All;
                }
                field("Debit Narrative"; Rec."Debit Narrative")
                {
                    ToolTip = 'Specifies the value of the Debit Narrative field.';
                    ApplicationArea = All;
                }
                field("Credit Narrative"; Rec."Credit Narrative")
                {
                    ToolTip = 'Specifies the value of the Credit Narrative field.';
                    ApplicationArea = All;
                }
                field("Purpose Pay"; Rec."Purpose Pay")
                {
                    ToolTip = 'Specifies the value of the Purpose Pay field.';
                    ApplicationArea = All;
                }
            }
        }
        addafter("Other Setups")
        {
            group(Payroll)
            {
                Caption = 'Payroll';

                field("General Payslip Message"; Rec."General Payslip Message")
                {
                    ApplicationArea = All;
                }
                field("Human Resource Emails"; Rec."Human Resource Emails")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Type"; Rec."Payroll Rounding Type")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Precision"; Rec."Payroll Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("No. Of Days in Month"; Rec."No. Of Days in Month")
                {
                    ApplicationArea = All;
                }
                field("Pension Limit Amount"; Rec."Pension Limit Amount")
                {
                    ApplicationArea = All;
                }
                field("Owner Occupied Interest Limit"; Rec."Owner Occupied Interest Limit")
                {
                    ApplicationArea = All;
                }
                field("Company NHIF No"; Rec."Company NHIF No")
                {
                    ApplicationArea = All;
                }
                field("Company NSSF No"; Rec."Company NSSF No")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type Nos."; Rec."Loan Product Type Nos.")
                {
                    ApplicationArea = All;
                }
                field("Payroll Journal Template"; Rec."Payroll Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Disabililty Tax Exp. Amt"; Rec."Disabililty Tax Exp. Amt")
                {
                    ApplicationArea = All;
                }
                field("Payroll Journal No."; Rec."Payroll Journal No.")
                {
                    ApplicationArea = All;
                }
                field("Payroll Journal Batch"; Rec."Payroll Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Payroll Change Nos"; Rec."Payroll Change Nos")
                {
                    ApplicationArea = All;
                }
                field("Acting Nos"; Rec."Acting Nos")
                {
                    ApplicationArea = All;
                }
                field("Transfer Nos"; Rec."Transfer Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance"; Rec."Leave Allowance")
                {
                    Caption = 'Leave Allowance (%)';
                    ApplicationArea = All;
                }
                field("Payroll Import Nos"; Rec."Payroll Import Nos")
                {
                    ApplicationArea = All;
                }
                group("Salary Increment")
                {
                    field("Paid Months Before Increament"; Rec."Paid Months Before Increament")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Paid Months Before Increament field';
                    }
                    field("Increment Annually"; Rec."Increment Annually")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Increment Annually field';
                    }
                    field("Increment Semi-Annually"; Rec."Increment Semi-Annually")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Increment Semi-Annually field';
                    }
                    field("Increment Quarterly"; Rec."Increment Quarterly")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Increment Quarterly field';
                    }
                }
                field("Payslips Path"; Rec."Payslips Path")
                {
                    ApplicationArea = All;
                }
                field("Interbank EFT Path"; Rec."Interbank EFT Path")
                {
                    ToolTip = 'Specifies the value of the Interbank EFT Path field.';
                    ApplicationArea = All;
                }
                field("EFT Document Path"; Rec."EFT Document Path")
                {
                    ToolTip = 'Specifies the value of the EFT Document Path field.';
                    ApplicationArea = All;
                }
                field("Email Institutions Path"; Rec."Email Institutions Path")
                {
                    ApplicationArea = All;
                }
                field("Secondary PAYE %"; Rec."Secondary PAYE %")
                {
                    ApplicationArea = All;
                }
                field("Trustee Reversal Template"; Rec."Trustee Reversal Template")
                {
                    ApplicationArea = All;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    Caption = 'Normal Retirement Age';
                    ApplicationArea = All;
                }
                field("Other Retirement Age"; Rec."Other Retirement Age")
                {
                    Caption = 'Special Retirement Age';
                    ToolTip = 'Specifies the value of the Other Retirement Age field.';
                    ApplicationArea = All;
                }
                field("Loan Interest Template"; Rec."Loan Interest Template")
                {
                    ApplicationArea = All;
                }
                field("Net Pay Rounding Precision"; Rec."Net Pay Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Net Pay Rounding Type"; Rec."Net Pay Rounding Type")
                {
                    ApplicationArea = All;
                }
                field("Default Bank"; Rec."Default Bank")
                {
                    ApplicationArea = All;
                }
                field("Max Appraisal Score"; Rec."Max Appraisal Score")
                {
                    ToolTip = 'Specifies the value of the Max Appraisal Score field.';
                    ApplicationArea = All;
                }
                field("Target Max Score"; Rec."Target Max Score")
                {
                    ToolTip = 'Specifies the value of the Target Max Score field.';
                    ApplicationArea = All;
                }
            }
        }
        addafter(Payroll)
        {
            group(Notes)
            {
                Caption = 'Notes';

                field("Reference Notes"; RNotesText)
                {
                    MultiLine = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Reference Letter Text");
                        rec."Reference Letter Text".CreateInStream(Instr);
                        RNotes.Read(Instr);
                        if RNotesText <> Format(RNotes) then begin
                            Clear(Rec."Reference Letter Text");
                            Clear(RNotes);
                            RNotes.AddText(RNotesText);
                            rec."Reference Letter Text".CreateOutStream(OutStr);
                            RNotes.Write(OutStr);
                        end;
                    end;
                }
            }
            field("Enforce a third rule"; Rec."Enforce a third rule")
            {
                ApplicationArea = All;
            }
            field("Net pay ratio to Earnings"; Rec."Net pay ratio to Earnings")
            {
                ToolTip = 'Ratio for 1/3 rule';
                ApplicationArea = All;
            }
        }
    }
    var
        RNotes: BigText;
        Instr: InStream;
        RNotesText: Text;
        OutStr: OutStream;
}
