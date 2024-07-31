tableextension 50170 "BankAccRecon Ext" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Debit Amount"; Decimal)
        {
        }
        field(5001; "Credit Amount"; Decimal)
        {
        }
    }
    var myInt: Integer;
}
