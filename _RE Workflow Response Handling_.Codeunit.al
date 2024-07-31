codeunit 50160 "RE Workflow Response Handling"
{
    trigger OnRun()
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandlingCust: Codeunit "RE Workflow Event Handling Ext";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of WorkflowResponseHandling.SetStatusToPendingApprovalCode(): WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkflowEventHandlingCust.RunWorkflowOnSendGBFPaymentsForApprovalCode());
        WorkflowResponseHandling.SendApprovalRequestForApprovalCode(): WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkflowEventHandlingCust.RunWorkflowOnSendGBFPaymentsForApprovalCode());
        WorkflowResponseHandling.CancelAllApprovalRequestsCode(): WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkflowEventHandlingCust.RunWorkflowOnCancelGBFPaymentsForApprovalCode());
        WorkflowResponseHandling.OpenDocumentCode(): WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkflowEventHandlingCust.RunWorkflowOnCancelGBFPaymentsForApprovalCode());
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        GBFPayments: Record "GBF Payments";
    begin
        case RecRef.Number of Database::"GBF Payments": begin
            RecRef.SetTable(GBFPayments);
            GBFPayments.Status:=GBFPayments.Status::Open;
            GBFPayments.Modify();
            Handled:=true;
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        GBFPayments: Record "GBF Payments";
    begin
        case RecRef.Number of Database::"GBF Payments": begin
            RecRef.SetTable(GBFPayments);
            GBFPayments.Status:=GBFPayments.Status::Released;
            GBFPayments.Modify();
            Handled:=true;
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var
        GBFPayments: Record "GBF Payments";
    begin
        case RecRef.Number of Database::"GBF Payments": begin
            RecRef.SetTable(GBFPayments);
            GBFPayments.Status:=GBFPayments.Status::"Pending Review";
            GBFPayments.Modify();
            IsHandled:=true;
        end;
        end;
    end;
}
