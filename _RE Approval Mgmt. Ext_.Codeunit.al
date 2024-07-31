codeunit 50159 "RE Approval Mgmt. Ext"
{
    trigger OnRun()
    begin
    end;
    var WorkflowEventHandlingCut: Codeunit "RE Workflow Event Handling Ext";
    WorkflowManagement: Codeunit "Workflow Management";
    NoWorkFlowEnabledErr: TextConst ENU = 'No approval workflow for this record type is enabled.';
    procedure CheckGBFPaymentsApprovalsWorkflowEnable(var GBFPayments: Record "GBF Payments"): Boolean begin
        if not IsGBFPaymentsDocApprovalsWorkflowEnable(GBFPayments)then Error(NoWorkFlowEnabledErr);
        exit(true);
    end;
    procedure IsGBFPaymentsDocApprovalsWorkflowEnable(var GBFPayments: Record "GBF Payments"): Boolean begin
        if GBFPayments.Status <> GBFPayments.Status::Open then exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(GBFPayments, WorkflowEventHandlingCut.RunWorkflowOnSendGBFPaymentsForApprovalCode()));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GBFPayments: Record "GBF Payments";
    begin
        case RecRef.Number of Database::"GBF Payments": begin
            RecRef.SetTable(GBFPayments);
            ApprovalEntryArgument."Document No.":=GBFPayments."No";
            ApprovalEntryArgument.Amount:=GBFPayments."Total Amount";
        end;
        end;
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelGBFPaymentsForApproval(var GBFPayments: Record "GBF Payments")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendGBFPaymentsForApproval(var GBFPayments: Record "GBF Payments")
    begin
    end;
}
