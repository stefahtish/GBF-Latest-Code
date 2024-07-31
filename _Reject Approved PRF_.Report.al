report 50134 "Reject Approved PRF"
{
    Permissions = TableData "Approval Entry" = rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem(IR; "Internal Request Header")
        {
            trigger OnAfterGetRecord()
            begin
                //Clear all approval entries
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "No.");
                ApprovalEntry.DeleteAll;
                Commit;
                //Prompt and Insert Rejection Comment
                if RejectionComments.RunModal = ACTION::OK then begin
                    RejectComment := RejectionComments.GetRejectComment;
                    if RejectComment = '' then Error('Please input rejection comment');
                    "Rejection Comment" := RejectComment;
                    Modify;
                end;
                Commit;
                Status := Status::Open;
                Modify;
                Commit;
                Message('%1 rejected successfully', "No.");
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
        ApprovalEntry: Record "Approval Entry";
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
}
