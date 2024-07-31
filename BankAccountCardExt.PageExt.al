pageextension 50140 BankAccountCardExt extends "Bank Account Card"
{
    layout
    {
        modify("No.")
        {
            Editable = true;
            Visible = true;
        }
        addlast(Posting)
        {
            field("Bank Type"; Rec."Bank Type")
            {
                ApplicationArea = All;
            }
            field(CashierID; Rec.CashierID)
            {
                ApplicationArea = All;
            }
            field("Sort Code"; Rec."Sort Code")
            {
                ApplicationArea = All;
            }
            field("Check Bank Limit"; Rec."Check Bank Limit")
            {
                ApplicationArea = All;
            }
            field("Bank Limit (LCY)"; Rec."Bank Limit (LCY)")
            {
                Editable = Rec."Check Bank Limit";
                ApplicationArea = All;
            }
        }
    }
}
