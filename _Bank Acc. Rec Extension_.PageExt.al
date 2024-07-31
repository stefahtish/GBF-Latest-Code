pageextension 50139 "Bank Acc. Rec Extension" extends "Bank Acc. Reconciliation"
{
    layout
    {
        addafter(StatementNo)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
