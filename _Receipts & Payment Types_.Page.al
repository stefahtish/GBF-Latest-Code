page 50117 "Receipts & Payment Types"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    UsageCategory = lists;
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
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Payroll Liabilities"; Rec."Payroll Liabilities")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                }
                field("Customer Payment On Account"; Rec."Customer Payment On Account")
                {
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                }
                field("Calculate Retention"; Rec."Calculate Retention")
                {
                }
                field("Retention Code"; Rec."Retention Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Based On Travel Rates Table"; Rec."Based On Travel Rates Table")
                {
                }
                field("Receipt Reference"; Rec."Receipt Reference")
                {
                }
                field("Based On a Table"; Rec."Based On a Table")
                {
                }
                field("Old Account No"; Rec."Old Account No")
                {
                }
                field("Do NOT Allow Apply Twice"; Rec."Do NOT Allow Apply Twice")
                {
                }
                field("Payment Option"; Rec."Payment Option")
                {
                }
                field("Imprest Payment"; Rec."Imprest Payment")
                {
                }
                field("Claim Payment"; Rec."Claim Payment")
                {
                }
                field("Cost of Sale"; Rec."Cost of Sale")
                {
                }
                field("Check Medical Ceiling"; Rec."Check Medical Ceiling")
                {
                }
                field("Property Receipt"; Rec."Property Receipt")
                {
                }
                field("Property Receipt Type"; Rec."Property Receipt Type")
                {
                }
                field("Manual Allocation"; Rec."Manual Allocation")
                {
                }
            }
        }
    }
    actions
    {
    }
}
