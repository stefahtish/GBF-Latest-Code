report 50311 "Cancel Approved LPO"
{
    Permissions = TableData "Approval Entry" = rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //Uncheck commitments
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                if PurchaseLine.Find('-') then begin
                    repeat
                        PurchaseLine.Committment := false;
                        PurchaseLine.Modify;
                        Commit;
                    until PurchaseLine.Next = 0;
                end;
                //Clear commitments
                CommitmentEntries.Reset;
                CommitmentEntries.SetRange("Document No", PurchaseHeader."No.");
                CommitmentEntries.DeleteAll;
                //Clear Approvals
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
                ApprovalEntry.DeleteAll;
                Commit;
                //Prompt and Insert Rejection Comment
                if RejectionComments.RunModal = ACTION::OK then begin
                    RejectComment := RejectionComments.GetRejectComment;
                    if RejectComment = '' then Error('Please input rejection comment');
                    PurchaseHeader."Cancel Comments" := RejectComment;
                    PurchaseHeader.Status := PurchaseHeader.Status::Open;
                    PurchaseHeader."Cancelled By" := UserId;
                    PurchaseHeader.Modify;
                    Commit;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        PurchaseLine: Record "Purchase Line";
        CommitmentEntries: Record "Commitment Entries";
        ApprovalEntry: Record "Approval Entry";
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
}
