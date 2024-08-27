tableextension 50171 "DtldCvLedgerEntryExt" extends "Detailed CV Ledg. Entry Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50006; "Customer Transaction Type"; enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
    }
    var
        myInt: Integer;
}
