page 50637 "Loan Product Types-Payroll"
{
    CardPageID = "Loan Product Type Setup";
    PageType = List;
    SourceTable = "Loan Product Type";
    SourceTableView = WHERE(TPS = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("No Series"; Rec."No Series")
                {
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                }
                field(Rounding; Rec.Rounding)
                {
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                }
                field("Loan Category"; Rec."Loan Category")
                {
                }
                field("Calculate Interest"; Rec."Calculate Interest")
                {
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                }
                field(Internal; Rec.Internal)
                {
                }
                field("Pay Period Filter"; Rec."Pay Period Filter")
                {
                }
                field("Interest Receivable Account"; Rec."Interest Receivable Account")
                {
                }
            }
        }
    }
    actions
    {
    }
}
