pageextension 50119 "Request To Approve Page Ext" extends "Requests to Approve"
{
    layout
    {
        addlast(Control1)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("Approver ID"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
        }
    }
}
