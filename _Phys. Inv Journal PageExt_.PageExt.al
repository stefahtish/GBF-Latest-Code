pageextension 50137 "Phys. Inv Journal PageExt" extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Entry Type")
        {
            field(Narration; Rec.Narration)
            {
                Caption = 'Comments';
                ApplicationArea = All;
            }
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field(Status; Rec.Status)
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
            part(WorkflowStatusBatch; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Batch Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnBatch;
            }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Line Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }
        }
    }
    actions
    {
        modify("P&ost")
        {
            trigger OnBeforeAction()
            var
                ItemJnlLine: Record "Item Journal Line";
            begin
                ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                ItemJnlLine.SetFilter("Posting Date", '<>%1', 0D);
                if ItemJnlLine.Find('-') then
                    repeat
                        ItemJnlLine.TestField(Status, Rec.Status::Released);
                    until ItemJnlLine.Next() = 0;
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                ItemJnlLine: Record "Item Journal Line";
            begin
                ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                ItemJnlLine.SetFilter("Posting Date", '<>%1', 0D);
                if ItemJnlLine.Find('-') then
                    repeat
                        ItemJnlLine.TestField(Status, Rec.Status::Released);
                    until ItemJnlLine.Next() = 0;
            end;
        }
        addbefore("F&unctions")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';

                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;

                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Journal Batch';
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                        begin
                            ApprovalsMgmt.TrySendItemBatchApprovalRequest(Rec);
                            SetControlAppearanceFromBatch;
                            SetControlAppearance;
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        //Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist AND CanRequestFlowApprovalForBatchAndCurrentLine;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction()
                        var
                            ItemJournalLine: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                        begin
                            GetCurrentlySelectedLines(ItemJournalLine);
                            ApprovalsMgmt.TrySendItemJournalLineApprovalRequests(ItemJournalLine);
                            SetControlAppearanceFromBatch;
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;

                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Journal Batch';
                        Enabled = CanCancelApprovalForJnlBatch OR CanCancelFlowApprovalForBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                        begin
                            ApprovalsMgmt.TryCancelItemJournalBatchApprovalRequest(Rec);
                            SetControlAppearance;
                            SetControlAppearanceFromBatch;
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        Enabled = CanCancelApprovalForJnlLine OR CanCancelFlowApprovalForLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction()
                        var
                            ItemJournalLine: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                        begin
                            GetCurrentlySelectedLines(ItemJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(ItemJournalLine);
                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        CurrentJnlBatchName: Code[50];
        AdjustmentVisible: Boolean;

    local procedure GetCurrentlySelectedLines(var ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(ItemJournalLine);
        exit(ItemJournalLine.FindSet());
    end;

    local procedure SetControlAppearanceFromBatch()
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForAllLines: Boolean;
    begin
        if not ItemJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then exit;
        ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(ItemJournalBatch.RecordId);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(ItemJournalBatch.RecordId);
        OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(ItemJournalBatch.RecordId);
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");
        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(ItemJournalBatch.RecordId);
        // WorkflowWebhookManagement.GetCanRequestAndCanCancelJournalBatch(
        //   GenJournalBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, CanRequestFlowApprovalForAllLines);
        // CanRequestFlowApprovalForBatchAndAllLines := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForAllLines;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanRequestFlowApprovalForLine: Boolean;
    begin
        OpenApprovalEntriesExistForCurrUser := OpenApprovalEntriesExistForCurrUser or ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;
        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestFlowApprovalForLine, CanCancelFlowApprovalForLine);
        CanRequestFlowApprovalForBatchAndCurrentLine := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForLine;
        if (Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt.") or (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") then
            AdjustmentVisible := true
        else
            AdjustmentVisible := false;
    end;
}
