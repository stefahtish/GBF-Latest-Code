tableextension 50151 DetVendLedgerEntryExt extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50001; "Funding Transaction Type";enum "Funding Transaction Type")
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashing field numbers';
        }
        field(50002; "Fund No."; Code[20])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashing field numbers';
        }
        field(50003; "Bond Application No."; Code[20])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashing field numbers';
        }
        field(50004; "Issue No."; Code[20])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashing field numbers';
        }
        field(50100; "Funding TransactionType";enum "Funding Transaction Type")
        {
            Caption = 'Funding Transaction Type';
        }
        field(50102; "FundNo."; Code[20])
        {
            Caption = 'Fund No.';
        }
        field(50103; "Bond ApplicationNo."; Code[20])
        {
            Caption = 'Bond Application No.';
        }
        field(50104; "IssueNo."; Code[20])
        {
        }
    }
}
