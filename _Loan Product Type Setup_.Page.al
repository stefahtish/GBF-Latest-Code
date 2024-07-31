page 50646 "Loan Product Type Setup"
{
    PageType = Card;
    SourceTable = "Loan Product Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    Caption = 'Maximum no. of installments';
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
                field("Interest Receivable Account"; Rec."Interest Receivable Account")
                {
                }
                field("Interest Posting Group"; Rec."Interest Posting Group")
                {
                }
                field("Principal Receivable PG"; Rec."Principal Receivable PG")
                {
                    Caption = 'Customer posting group';
                }
            }
        }
    }
    actions
    {
    }
}
