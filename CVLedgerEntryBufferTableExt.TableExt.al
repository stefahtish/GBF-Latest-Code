tableextension 50150 CVLedgerEntryBufferTableExt extends "CV Ledger Entry Buffer"
{
    fields
    {
        field(51520000; "Loan Transaction Type";Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(51520001; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(51520002; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(5152003; "Period Reference"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(51520006; "Customer Transaction Type";enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
    }
}
