codeunit 50158 "RE Workflow Setup Ext"
{
    trigger OnRun()
    begin
    end;
    var WorkflowSetup: Codeunit "Workflow Setup";
    GBFPaymentsTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="GBF Payments">%1</DataItem></DataItems></ReportParameters>';
    GBFPaymentsApprovalWorkflowCodeTxt: TextConst ENU = 'CRAPW';
    GBFPaymentsWorkflowCategoryTxt: TextConst ENU = 'CRW';
    GBFPaymentsApprovalWorkfowDescTxt: TextConst ENU = 'Payment Voucher Approval Workflow';
    GBFPaymentsWorkflowCategoryDescTxt: TextConst ENU = 'Payment Voucher Document';
    local procedure BuildGBFPaymentsTypeConditions(Status: Integer): Text var
        GBFPayments: Record "GBF Payments";
    begin
        GBFPayments.SetRange(Status, Status);
        exit(StrSubstNo(GBFPaymentsTypeCondTxt, WorkflowSetup.Encode(GBFPayments.GetView(false))));
    end;
    local procedure InsertGBFPaymentsApprovalWorkflowDetails(Workflow: Record Workflow)
    var
        GBFPayments: Record "GBF Payments";
        WorkflowStepArgument: Record "Workflow Step Argument";
        WorkflowEventHandlingCust: Codeunit "RE Workflow Event Handling Ext";
        BlankDateFormula: DateFormula;
    begin
        // Error
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildGBFPaymentsTypeConditions(GBFPayments.Status::Open), WorkflowEventHandlingCust.RunWorkflowOnSendGBFPaymentsForApprovalCode(), BuildGBFPaymentsTypeConditions(GBFPayments.Status::"Pending Review"), WorkflowEventHandlingCust.RunWorkflowOnCancelGBFPaymentsForApprovalCode(), WorkflowStepArgument, true);
    end;
    local procedure InsertGBFPaymentsApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, GBFPaymentsApprovalWorkflowCodeTxt, GBFPaymentsApprovalWorkfowDescTxt, GBFPaymentsWorkflowCategoryTxt);
        InsertGBFPaymentsApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        WorkflowSetup.InsertWorkflowCategory(GBFPaymentsWorkflowCategoryTxt, GBFPaymentsWorkflowCategoryDescTxt);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(Database::"GBF Payments", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplates()
    begin
        InsertGBFPaymentsApprovalWorkflowTemplate();
    end;
}
