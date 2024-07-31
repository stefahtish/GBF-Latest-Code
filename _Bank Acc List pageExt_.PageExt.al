pageextension 50151 "Bank Acc List pageExt" extends "Bank Account List"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
