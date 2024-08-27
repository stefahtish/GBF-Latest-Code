tableextension 50150 CVLedgerEntryBufferTableExt extends "CV Ledger Entry Buffer"
{
    fields
    {
        field(51500; "Loan Transaction Type"; Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(52001; "Loan No"; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
        }
        field(50002; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(50003; "Period Reference"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Customer Transaction Type"; enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
    }
}
