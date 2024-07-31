page 50421 "Leave Recall"
{
    PageType = Card;
    SourceTable = "Employee Off/Holiday";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = not Rec.Approved;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    Editable = false;
                }
                field("Leave Application"; Rec."Leave Application")
                {
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Recalled From"; Rec."Recalled From")
                {
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    Editable = true;
                }
                field("No. of Off Days"; Rec."No. of Off Days")
                {
                    Caption = 'No. of Days Recalled';
                    Editable = false;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Complete)
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Completed then Error('You have completed this recall');
                    if Recall.Get(Rec."No.") then begin
                        HRMgnt.LeaveRecall(Rec."No.");
                        Rec."No. of Off Days" := EmpLeave."Recalled Days";
                        Recall.Completed := TRUE;
                        Recall.MODIFY;
                        Message(Text0001, Rec."No.");
                    end;
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                Enabled = Rec.Status = Rec.Status::Open;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Leave Application");
                    Rec.TestField("Recalled From");
                    Rec.TestField("Recalled To");
                    Rec.TestField("Recalled By");
                    Rec.TestField("Reason for Recall");
                    if ApprovalsMgmt.CheckLeaveRecallWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendLeaveRecallRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Enabled = Pending;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelLeaveRecallApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                Enabled = Pending or Rec.Approved;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Transport Request","Leave Application","Leave Recall";
                begin
                    DocumentType := DocumentType::"Leave Recall";
                    ApprovalEntries.Setrecordfilters(DATABASE::"Employee Off/Holiday", DocumentType, Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        Recall: Record "Employee Off/Holiday";
        Text0001: Label 'The recall %1 has been completed';
        EmpLeave: Record "Employee Leave";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        HRMgnt: Codeunit "HR Management";
        Approved: Boolean;
        Pending: Boolean;

    procedure SetControlAppearance()
    begin
        if Rec.Status = Rec.Status::Released then
            Rec.Approved := true
        else
            Rec.Approved := false;
        if Rec.Status = Rec.Status::"Pending Approval" then
            Pending := true
        else
            Pending := false;
    end;
}
