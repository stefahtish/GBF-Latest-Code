page 50636 Deduction
{
    PageType = List;
    SourceTable = DeductionsX;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Tax deductible"; Rec."Tax deductible")
                {
                }
                field(Advance; Rec.Advance)
                {
                }
                field("Start date"; Rec."Start date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field(Loan; Rec.Loan)
                {
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                }
                field("Grace period"; Rec."Grace period")
                {
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    Visible = false;
                }
                field("Pension Scheme"; Rec."Pension Scheme")
                {
                }
                field("Deduction Table"; Rec."Deduction Table")
                {
                }
                field("Account Type Employer"; Rec."Account Type Employer")
                {
                }
                field("Account No. Employer"; Rec."Account No. Employer")
                {
                }
                field("Percentage Employer"; Rec."Percentage Employer")
                {
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                }
                field("Flat Amount Employer"; Rec."Flat Amount Employer")
                {
                }
                field("Total Amount Employer"; Rec."Total Amount Employer")
                {
                }
                field("Loan Type"; Rec."Loan Type")
                {
                }
                field("Show Balance"; Rec."Show Balance")
                {
                }
                field(CoinageRounding; Rec.CoinageRounding)
                {
                    Visible = false;
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    Visible = false;
                }
                field("Balance Mode"; Rec."Balance Mode")
                {
                }
                field("Main Loan Code"; Rec."Main Loan Code")
                {
                }
                field(Shares; Rec.Shares)
                {
                    Visible = false;
                }
                field("Show on report"; Rec."Show on report")
                {
                }
                field("Non-Interest Loan"; Rec."Non-Interest Loan")
                {
                }
                field("Exclude when on Leave"; Rec."Exclude when on Leave")
                {
                }
                field("Co-operative"; Rec."Co-operative")
                {
                    Visible = false;
                }
                field("Total Shares"; Rec."Total Shares")
                {
                    Visible = false;
                }
                field(Rate; Rec.Rate)
                {
                    Visible = false;
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                }
                field("Secondary PAYE"; Rec."Secondary PAYE")
                {
                }
                field("Total Days"; Rec."Total Days")
                {
                    Visible = false;
                }
                field("Housing Earned Limit"; Rec."Housing Earned Limit")
                {
                    Visible = false;
                }
                field("Pension Limit Percentage"; Rec."Pension Limit Percentage")
                {
                }
                field("Pension Limit Amount"; Rec."Pension Limit Amount")
                {
                }
                field("Applies to All"; Rec."Applies to All")
                {
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                }
                field("Pension Scheme Code"; Rec."Pension Scheme Code")
                {
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                    Visible = false;
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                }
                field(Block; Rec.Block)
                {
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    Visible = false;
                }
                field("Show on Payslip Information"; Rec."Show on Payslip Information")
                {
                }
                field("Voluntary Percentage"; Rec."Voluntary Percentage")
                {
                }
                field("Owner Occupied Interest"; Rec."Owner Occupied Interest")
                {
                    Visible = false;
                }
                field(Voluntary; Rec.Voluntary)
                {
                }
                field("Voluntary Amount"; Rec."Voluntary Amount")
                {
                }
                field("Voluntary Code"; Rec."Voluntary Code")
                {
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                }
                field("Share Top Up"; Rec."Share Top Up")
                {
                    Visible = false;
                }
                field("Customer Entry"; Rec."Customer Entry")
                {
                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                }
                field("Balance Type"; Rec."Balance Type")
                {
                }
                field("Exclude Employer Balance"; Rec."Exclude Employer Balance")
                {
                }
                field(Statutories; Rec.Statutories)
                {
                }
                field(Imprest; Rec.Imprest)
                {
                }
                field(NSSF; Rec.NSSF)
                {
                }
                field(HELB; Rec.HELB)
                {
                }
                field(NITA; Rec.NITA)
                {
                }
                field("Exempt from a third rule"; Rec."Exempt from a third rule")
                {
                }
                field("Share Contributions Code"; Rec."Share Contributions Code")
                {
                }
                field("Benevolent Contributions Code"; Rec."Benevolent Contributions Code")
                {
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Mass Update Earnings&Deductions")
            {
                Caption = 'Mass Update Earnings & Deductions';
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;

                trigger OnAction()
                var
                    PayrollRun: Report "Payroll Run";
                begin
                    // EarningsMassUpdate.GetEarnings(Rec);
                    // EarningsMassUpdate.Run;
                    PayrollRun.DefaultAssignmentDed(Rec.Code);
                end;
            }
            action("Other Earnings")
            {
                Caption = '% of Other Earnings';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Other Earnings";
                RunPageLink = "Main Earning" = FIELD(Code);
            }
        }
    }
    var
        Payment: Record EarningsX temporary;
        PaymentCode: Code[10];
        "Actions": Option Add,edit,Delete;
        Sources: Option Payment,Deduction,Saving;
        EarningsMassUpdate: Report "Earnings Mass Update";
}
