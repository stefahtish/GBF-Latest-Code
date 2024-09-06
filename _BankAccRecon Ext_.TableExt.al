tableextension 50170 "BankAccRecon Ext" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Debit Amount"; Decimal)
        {
        }
        field(50001; "Credit Amount"; Decimal)
        {
        }
    }
    var
        myInt: Integer;
}
