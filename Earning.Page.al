page 50635 Earning
{
    PageType = List;
    SourceTable = EarningsX;
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
                field("Pay Type"; Rec."Pay Type")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Acting Not Qualify(%)"; Rec."Acting Not Qualify(%)")
                {
                    ToolTip = 'Specifies the value of the Acting Not Qualify(%) field.';
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field(Formula; Rec.Formula)
                {
                }
                field(Quarters; Rec.Quarters)
                {
                    Visible = false;
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                }
                field("Minimum Limit"; Rec."Minimum Limit")
                {
                }
                field("Maximum Limit"; Rec."Maximum Limit")
                {
                }
                field("Reduces Tax"; Rec."Reduces Tax")
                {
                }
                field("Overtime Factor"; Rec."Overtime Factor")
                {
                }
                field(Counter; Rec.Counter)
                {
                }
                field(NoOfUnits; Rec.NoOfUnits)
                {
                }
                field("Low Interest Benefit"; Rec."Low Interest Benefit")
                {
                    Visible = false;
                }
                field("Show Balance"; Rec."Show Balance")
                {
                }
                field(CoinageRounding; Rec.CoinageRounding)
                {
                    Visible = false;
                }
                field(OverDrawn; Rec.OverDrawn)
                {
                    Visible = false;
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    Visible = false;
                }
                field(OverTime; Rec.OverTime)
                {
                }
                field(Months; Rec.Months)
                {
                }
                field("Show on Report"; Rec."Show on Report")
                {
                }
                field("Time Sheet"; Rec."Time Sheet")
                {
                    Visible = false;
                }
                field("Total Days"; Rec."Total Days")
                {
                    Visible = false;
                }
                field("Total Hrs"; Rec."Total Hrs")
                {
                    Visible = false;
                }
                field(Weekend; Rec.Weekend)
                {
                    Visible = false;
                }
                field(Weekday; Rec.Weekday)
                {
                    Visible = false;
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                }
                field("Default Enterprise"; Rec."Default Enterprise")
                {
                    Visible = false;
                }
                field("Default Activity"; Rec."Default Activity")
                {
                    Visible = false;
                }
                field(Prorate; Rec.Prorate)
                {
                    //  Visible = false;
                }
                field("Earning Type"; Rec."Earning Type")
                {
                }
                field("Applies to All"; Rec."Applies to All")
                {
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                }
                field("House Allowance Code"; Rec."House Allowance Code")
                {
                }
                field("Responsibility Allowance Code"; Rec."Responsibility Allowance Code")
                {
                }
                field("Commuter Allowance Code"; Rec."Commuter Allowance Code")
                {
                }
                field(Block; Rec.Block)
                {
                }
                field("Basic Pay Arrears"; Rec."Basic Pay Arrears")
                {
                }
                field("Pensionable Pay"; Rec."Pensionable Pay")
                {
                }
                field("Per Diem"; Rec."Per Diem")
                {
                }
                field("Yearly Bonus"; Rec."Yearly Bonus")
                {
                }
                field("Leave Allwance"; Rec."Leave Allwance")
                {
                }
                field("Supension Earnings Percentage"; Rec."Supension Earnings Percentage")
                {
                }
                field("Requires Employee Request"; Rec."Requires Employee Request")
                {
                }
                field("Casual Code"; Rec."Casual Code")
                {
                    Visible = false;
                }
                field(Gratuity; Rec.Gratuity)
                {
                }
                field("Special Duty"; Rec."Special Duty")
                {
                }
                field("Acting Allowance"; Rec."Acting Allowance")
                {
                }
                field("Salary Arrears Code"; Rec."Salary Arrears Code")
                {
                }
                field(BoardSittingAllowance; Rec.BoardSittingAllowance)
                {
                }
                field("Transfer Allowance"; Rec."Transfer Allowance")
                {
                }
                field("Transport Allowance"; Rec."Transport Allowance")
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
                    PayrollRun.DefaultAssignment(Rec.Code);
                    Message('Earnings updated successfully');
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
