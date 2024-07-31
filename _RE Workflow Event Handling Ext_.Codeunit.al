codeunit 50157 "RE Workflow Event Handling Ext"
{
    trigger OnRun()
    begin
    end;
    var WorkflowEventHandling: Codeunit "Workflow Event Handling";
    WorkflowManagement: Codeunit "Workflow Management";
    GBFPaymentsApprovalPaymentVoucherCancelEventDescTxt: TextConst ENU = 'Approval of a Payment Voucher document is canceled';
    GBFPaymentsSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Payment Voucher document is Requested';
    procedure RunWorkflowOnCancelGBFPaymentsForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelGBFPaymentsForApproval'));
    end;
    procedure RunWorkflowOnSendGBFPaymentsForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendGBFPaymentsForApproval'))end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of RunWorkflowOnCancelGBFPaymentsForApprovalCode(): WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelGBFPaymentsForApprovalCode(), RunWorkflowOnSendGBFPaymentsForApprovalCode());
        WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(): WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendGBFPaymentsForApprovalCode());
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendGBFPaymentsForApprovalCode(), Database::"GBF Payments", GBFPaymentsSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelGBFPaymentsForApprovalCode(), Database::"GBF Payments", GBFPaymentsApprovalPaymentVoucherCancelEventDescTxt, 0, false);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RE Approval Mgmt. Ext", 'OnCancelGBFPaymentsForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelGBFPaymentsForApproval(var GBFPayments: Record "GBF Payments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGBFPaymentsForApprovalCode(), GBFPayments);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RE Approval Mgmt. Ext", 'OnSendGBFPaymentsForApproval', '', true, true)]
    local procedure RunWorkflowOnSendGBFPaymentsForApproval(var GBFPayments: Record "GBF Payments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGBFPaymentsForApprovalCode(), GBFPayments);
    end;
}
