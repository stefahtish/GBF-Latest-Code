tableextension 50117 BankAccReconTableExt extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(50000; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
        }
        field(50001; "Document No."; Code[20])
        {
        }
    }
}
