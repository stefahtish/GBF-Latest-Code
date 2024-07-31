page 50645 Deductions
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
                field("Applies to All"; Rec."Applies to All")
                {
                }
                field("Show on Payslip Information"; Rec."Show on Payslip Information")
                {
                }
                field("Institution Code"; Rec."Institution Code")
                {
                }
                field(Block; Rec.Block)
                {
                }
                field(Voluntary; Rec.Voluntary)
                {
                }
                field("Voluntary Code"; Rec."Voluntary Code")
                {
                }
                field("Voluntary Amount"; Rec."Voluntary Amount")
                {
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Type Employer"; Rec."Account Type Employer")
                {
                }
                field("Account No. Employer"; Rec."Account No. Employer")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                }
                field("Start date"; Rec."Start date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Total Amount Employer"; Rec."Total Amount Employer")
                {
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                }
                field("Flat Amount Employer"; Rec."Flat Amount Employer")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Percentage Employer"; Rec."Percentage Employer")
                {
                }
                field("Deduction Table"; Rec."Deduction Table")
                {
                }
                field("Owner Occupied Interest"; Rec."Owner Occupied Interest")
                {
                    Visible = false;
                }
                field("Show on report"; Rec."Show on report")
                {
                }
                field("Show Balance"; Rec."Show Balance")
                {
                }
                field("Customer Entry"; Rec."Customer Entry")
                {
                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                }
                field(Statutories; Rec.Statutories)
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
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                }
                field("Auto Create PV"; Rec."Auto Create PV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Create PV field';
                }
                field("POP Code"; Rec."POP Code")
                {
                    ApplicationArea = All;
                }
                field("Exempt from a third rule"; Rec."Exempt from a third rule")
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
                    Message('Deductions updated successfully');
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
}
