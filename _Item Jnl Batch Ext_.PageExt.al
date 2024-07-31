pageextension 50136 "Item Jnl Batch Ext" extends "Item Journal Batches"
{
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        addafter(Name)
        {
            field("Document No."; Rec."Document No.")
            {
                enabled = false;
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore("P&ost")
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        if ApprovalsMgmt.CheckItemJournalWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendItemJournalForApproval(Rec);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = Rec.Status = Rec.Status::Pending;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        ApprovalsMgmt.OnCancelItemJournalApprovalRequest(Rec);
                        CurrPage.Close;
                    end;
                }
            }
        }
        modify("P&ost")
        {
            Enabled = Rec.Status = Rec.Status::Released;
        }
        modify("Post and &Print")
        {
            Enabled = Rec.Status = Rec.Status::Released;
        }
        modify("P&osting")
        {
            Enabled = Rec.Status = Rec.Status::Released;
        }
    }
    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
}
