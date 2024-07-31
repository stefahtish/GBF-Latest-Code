tableextension 50118 BankAccLedgerEntryExt extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; PayeeName; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Cheque Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account Ledger Entry";
        }
        field(50002; "Bank Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Investment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "No. Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Payee; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Expected Receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Account Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50010; "Deposit No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "EFT Reference"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
