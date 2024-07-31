tableextension 50171 "DtldCvLedgerEntryExt" extends "Detailed CV Ledg. Entry Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(51520006; "Customer Transaction Type";enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
        field(51520001; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
    }
    var myInt: Integer;
}
