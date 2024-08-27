tableextension 50148 CustLedgerEntryTableExtension extends "Cust. Ledger Entry"
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
        field(50009; "Entry Type"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(50010; "Loan Transaction Type"; Enum LoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     LoanProduct: Record "Loan Product Type";
            //     LoanRec: Record "Loans Register";
            //     LoanTransPriority: Record "Transaction Type Priority";
            // begin
            //     if LoanRec.Get("Loan No") then;
            //     if LoanProduct.get(LoanRec."Loan Product Type") then begin
            //         LoanTransPriority.Get(LoanProduct.Code, "Loan Transaction Type");
            //         "Transaction Priority" := LoanTransPriority.Priority;
            //     end;
            // end;
        }
        field(50011; "Loan No"; Code[50])
        {
            ObsoleteState = Removed;
            Caption = 'Loan No';
            DataClassification = ToBeClassified;
            //TableRelation = "Loans Register" where("PML No." = field("Customer No."));
        }
        field(50013; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = ToBeClassified;
        }
        field(50014; "Period Reference"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Transaction Priority"; Integer)
        {
        }
        field(50016; "Customer Transaction Type"; enum "Customer Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
    }
}
