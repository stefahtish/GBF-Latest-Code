report 50135 "Modify HOD Approvals"
{
    Permissions = TableData "Approval Entry" = rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem(ApprovalEntry; "Approval Entry")
        {
            trigger OnAfterGetRecord()
            begin
                if UserSetup.Get(UserId) then begin
                    ApprovalEntry1.Reset;
                    ApprovalEntry1.Copy(ApprovalEntry);
                    ApprovalEntry1.SetRange("Sequence No.", 1);
                    ApprovalEntry1.SetFilter(Status, '%1|%2|%3', ApprovalEntry1.Status::Created, ApprovalEntry1.Status::Open, ApprovalEntry1.Status::Approved);
                    // ApprovalEntry1.SetRange("Approver ID", UserId);
                    if ApprovalEntry1.Find('-') then begin
                        ApprovalEntry1."Approver ID" := UserSetup."Approver ID";
                        if ApprovalEntry1.Status = ApprovalEntry1.Status::Approved then begin
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Open;
                        end;
                        ApprovalEntry1.Modify;
                    end;
                    //Created
                    ApprovalEntry2.Reset;
                    ApprovalEntry2.Copy(ApprovalEntry);
                    ApprovalEntry2.SetFilter("Sequence No.", '<>%1', 1);
                    if ApprovalEntry2.Find('-') then begin
                        repeat
                            ApprovalEntry2.Status := ApprovalEntry2.Status::Created;
                            ApprovalEntry2.Modify;
                        until ApprovalEntry2.Next = 0;
                    end;
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
        UserSetup: Record "User Setup";
        ApprovalEntry1: Record "Approval Entry";
        ApprovalEntry2: Record "Approval Entry";
}
