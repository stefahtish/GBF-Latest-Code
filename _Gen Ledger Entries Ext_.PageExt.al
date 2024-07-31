pageextension 50143 "Gen Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }
        modify("Reason Code")
        {
            Visible = true;
            Caption = 'General Expense Code';
        }
        addafter(Description)
        {
        }
    }
    var myInt: Integer;
}
