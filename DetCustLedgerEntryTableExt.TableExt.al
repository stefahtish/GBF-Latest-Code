tableextension 50149 DetCustLedgerEntryTableExt extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; "Property Code"; Code[20])
        {
        }
        field(50001; "Property Floor"; code[40])
        {
        }
        field(50002; "Property Unit"; code[40])
        {
        }
        field(50003; "Lease No"; code[20])
        {
        }
        field(50004; charge; code[40])
        {
        }
        field(50005; Rate; Decimal)
        {
        }
        field(50006; Consumption; Decimal)
        {
        }
        field(50007; Rent; Boolean)
        {
        }
        field(50008; ServiceCharge; Boolean)
        {
        }
        field(50009; "EntryType"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ", Income, Expense;
        }
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
