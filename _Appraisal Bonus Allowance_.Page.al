page 50703 "Appraisal Bonus Allowance"
{
    DataCaptionFields = "Employee No", Type, "Code";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Assignment Matrix-X";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                        Commit;
                        //Validate Formula Amounts
                        Payroll.ValidateFormulaAmounts(Rec);
                    end;
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Ext Insurance Amount"; Rec."Ext Insurance Amount")
                {
                    Caption = 'External Insurance Amount';
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                }
                field(Tenure; Rec.Tenure)
                {
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                }
                field("Gratuity PAYE"; Rec."Gratuity PAYE")
                {
                }
                field("Reference No"; Rec."Reference No")
                {
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                }
                field("Period Repayment"; Rec."Period Repayment")
                {
                }
                field("Employee Voluntary"; Rec."Employee Voluntary")
                {
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    Editable = false;
                }
                field("Loan Repay"; Rec."Loan Repay")
                {
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field(Retirement; Rec.Retirement)
                {
                }
                field("Pay Period"; Rec."Pay Period")
                {
                }
                field("Tax Deductible"; Rec."Tax Deductible")
                {
                }
                field("Taxable amount"; Rec."Taxable amount")
                {
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                }
                field("House No."; Rec."House No.")
                {
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Payment;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Payment;
    end;

    var
        Payroll: Codeunit Payroll;
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Deductions: Record DeductionsX;
        Earnings: Record EarningsX;
        ValidateAmountTxt: Label 'You have earnings or deductions that depend on changing this amount.\Do you wish to update them?';
}
