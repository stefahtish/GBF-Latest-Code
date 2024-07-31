codeunit 50115 WorkFlowEventResponseCUExt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit WorkflowEventHandlingCUExt;
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        CASE ResponseFunctionName OF WorkFlowResponse.SetStatusToPendingApprovalCode: BEGIN
            //Payments
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode);
            //Leave Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode);
            //tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //proc method
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProcMethodForApprovalCode);
            //Sample Analysis
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendSampleforApprovalCode);
            //Payroll Approval
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPayrollApprovalForApprovalCode());
            //Recruitment
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //Prospective Suppliers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Asset Allocation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendAssetAllocationforApprovalCode);
            //Asset Transfer
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendAssetTransforApprovalCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //Training Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode);
            //Employee Appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode);
            //Leave Recall
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Employee Transfers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode);
            //Loan Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode);
            //Emp Acting and Promotion
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New Emp appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendInvestReqForApprovalCode);
            //Tender Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode);
            //Audit
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey Workplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLabScheduleforApprovalCode);
            //Licenseregistration
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLicenseregistrationforApprovalCode);
            //LicenseApplication
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendLicenseApplicationforApprovalCode);
            //ICTWorkplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendICTWorkplanforApprovalCode);
            //UserIncidences
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendUserIncidencesforApprovalCode);
            //RiskHeader
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendRiskHeaderforApprovalCode);
            //TransportIncident
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendTransportIncidentforApprovalCode);
            //DriverLogging
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendDriverLoggingforApprovalCode);
            //WorkProgramme
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunworkflowOnSendWorkProgrammeforApprovalCode);
            //ProjectManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnCancelProjectreqforApprovalCode);
            //ContractManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnCancelContractreqforApprovalCode);
        END;
        WorkFlowResponse.CreateApprovalRequestsCode: BEGIN
            //Payments
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode);
            //Payroll Approval
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendPayrollApprovalForApprovalCode());
            //Leave Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //Proc method
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendProcMethodForApprovalCode);
            //Sample Analysis
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendSampleforApprovalCode);
            //Recruitment
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //prospective Suppliers:
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Asset Allocation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendAssetAllocationforApprovalCode);
            //Asset Transfer
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendAssetTransforApprovalCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //Training Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode);
            //Employee Appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode);
            //Leave Recall
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Employee Transfers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode);
            //Loan Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode);
            //Employee Acting Promotion
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New emp appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendInvestReqForApprovalCode);
            //Tender Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode);
            //Audit
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey Workplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLabScheduleforApprovalCode);
            //AssetDisposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendAssetDisposalforApprovalCode);
            //LicenseRegistration
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLicenseRegistrationforApprovalCode);
            //LicenseApplication
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendLicenseApplicationforApprovalCode);
            //ICTWorkplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendICTWorkplanforApprovalCode);
            //UserIncidences
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendUserIncidencesforApprovalCode);
            //RiskHeader
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendRiskHeaderforApprovalCode);
            //TransportIncident
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendTransportIncidentforApprovalCode);
            //DriverLogging
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendDriverLoggingforApprovalCode);
            //WorkProgramme
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnSendWorkProgrammeforApprovalCode);
            //ProjectManager
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendprojectreqforApprovalCode);
            //ContractManager
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendContractreqforApprovalCode);
        END;
        WorkFlowResponse.SendApprovalRequestForApprovalCode: BEGIN
            //Payments
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode);
            //Payroll Approval
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPayrollApprovalForApprovalCode());
            //Leave Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //Proc method
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProcMethodForApprovalCode);
            //Sample Analysis
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendSampleforApprovalCode);
            //Recruitment
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //Prospective Suppliers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Asset Allocation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendAssetAllocationforApprovalCode);
            //Asset Transfer
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendAssetTransforApprovalCode);
            //Training Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode);
            //Employee Appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode);
            //Leave Recall
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Employee Transfers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode);
            //Loan Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode);
            //Emp Acting and Promotion
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New emp appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendInvestReqForApprovalCode);
            //Tender Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode);
            //Audit
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey Workplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLabScheduleforApprovalCode);
            //AssetDisposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendAssetDisposalforApprovalCode);
            //LicenseRegistration
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLicenseRegistrationforApprovalCode);
            //LicenseApplication
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendLicenseApplicationforApprovalCode);
            //ICTWorkplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendICTWorkplanforApprovalCode);
            //UserIncidences
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendUserIncidencesforApprovalCode);
            //RiskHeader
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendRiskHeaderforApprovalCode);
            //TransportIncident
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendTransportIncidentforApprovalCode);
            //DriverLogging
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendDriverLoggingforApprovalCode);
            //WorkProgramme
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendWorkProgrammeforApprovalCode);
            //ProjectManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendprojectreqforApprovalCode);
            //ContractManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendContractreqforApprovalCode);
        END;
        WorkFlowResponse.OpenDocumentCode: BEGIN
            //Payments
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnRejectPaymentsCode);
            //Payroll Approval
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelPayrollApprovalApprovalRequestCode());
            //Leave Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode);
            //Asset Allocation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelAssetAllocationApprovalRequestCode);
            //Asset Transfer
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnSendAssetTransforApprovalCode);
            //Sample Analysis
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelSampleApprovalRequestCode);
            //Tender committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelTenderCommitteeApprovalRequestCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelProcReqApprovalRequestCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelContChangeApprovalRequestCode);
            //Proc Method
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelPayrollChangeApprovalRequestCode);
            //Recruitment
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode);
            //Prospective Supplier:
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelprospectivesupplierRequestApprovalCode);
            //Training Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode);
            //Transport Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode);
            //Employee Appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode);
            //Leave Recall
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode);
            //Employee Transfers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode);
            //Loan Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode);
            //Employee Acting and Promotion
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnRejectEmpActingPromotionCode);
            //Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelProposedBudgetForApprovalCode);
            //Bank Rec
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelBankRecForApprovalCode);
            //Leave Adj
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode);
            //New emp appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode);
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelInvestReqApprovalRequestCode);
            //Tender Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelTenderEvalApprovalRequestCode);
            //Supplier Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelSupplierEvalApprovalRequestCode);
            //FA Disposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelFADisposalApprovalRequestCode);
            //Audit
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunworkflowOnCancelAuditApprovalRequestCode);
            //ResearchActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelResearchActivityApprovalRequestCode);
            //PartnershipActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelPartnershipActivityApprovalRequestCode);
            //ResearchSurvey Workplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelResearchSurveyApprovalRequestCode);
            //ItemJournal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelItemJournalApprovalRequestCode);
            //ItemJournalLinee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelItemJournalLineApprovalRequestCode);
            //LabSchedule
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLabScheduleApprovalRequestCode);
            //AssetDisposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelAssetDisposalApprovalRequestCode);
            //LicenseRegistration
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode);
            //LicenseApplication
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLicenseApplicationApprovalRequestCode);
            //ICTWorkplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelICTWorkplanApprovalRequestCode);
            //UserIncidences
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelUserIncidencesApprovalRequestCode);
            //RiskHeader
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRiskHeaderApprovalRequestCode);
            //TransportIncident
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelTransportIncidentApprovalRequestCode);
            //DriverLogging
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelDriverLoggingApprovalRequestCode);
            //WorkProgramme
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelWorkProgrammeApprovalRequestCode);
            //ProjectManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelProjectreqforApprovalCode);
            //ProjectManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelContractreqforApprovalCode);
        END;
        WorkFlowResponse.CancelAllApprovalRequestsCode: BEGIN
            //Payments
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelPaymentsApprovalRequestCode);
            //Payroll Approval
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelPayrollApprovalApprovalRequestCode());
            //Leave Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelTenderCommitteeApprovalRequestCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelProcReqApprovalRequestCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelContChangeApprovalRequestCode);
            //Proc Method
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelProcMethodApprovalRequestCode);
            //Sample Analysis
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelSampleApprovalRequestCode);
            //Recruitment
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode);
            //Prospective Supplier
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelprospectivesupplierRequestApprovalCode);
            //Asset Allocation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelAssetAllocationApprovalRequestCode);
            //Asset Transfer
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelAssetTransApprovalRequestCode);
            //Tender Committee
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode);
            //Training Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode);
            //Transport Request
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode);
            //Employee Appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode);
            //Leave Recall
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode);
            //Employee Transfers
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode);
            //Loan Application
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode);
            //Employee Acting and Promotion
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode);
            //Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelProposedBudgetForApprovalCode);
            //Bank Rec
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelBankRecForApprovalCode);
            //Leave Adj
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode);
            //New emp appraisal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode);
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelInvestReqApprovalRequestCode);
            //Tender Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelTenderEvalApprovalRequestCode);
            //Supplier Evaluation
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelSupplierEvalApprovalRequestCode);
            //FA Disposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelFADisposalApprovalRequestCode);
            //Audit
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelAuditApprovalRequestCode);
            //ResearchActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelResearchActivityApprovalRequestCode);
            //PartnershipActivity
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelPartnershipActivityApprovalRequestCode);
            //ResearchSurvey Workplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunworkflowOnCancelResearchSurveyApprovalRequestCode);
            //ItemJournal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelItemJournalApprovalRequestCode);
            //ItemJournalLine
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelItemJournalLineApprovalRequestCode);
            //LabSchedule
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLabScheduleApprovalRequestCode);
            //AssetDisposal
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelAssetDisposalApprovalRequestCode);
            //LicenseRegistration
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode);
            // //LicenseApplication
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLicenseApplicationApprovalRequestCode);
            //ICTWorkplan
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelICTWorkplanApprovalRequestCode);
            //UserIncidences
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelUserIncidencesApprovalRequestCode);
            //RiskHeader
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRiskHeaderApprovalRequestCode);
            //TransportIncident
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelTransportIncidentApprovalRequestCode);
            //DriverLogging
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelDriverLoggingApprovalRequestCode);
            //WorkProgramme
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelWorkProgrammeApprovalRequestCode);
            //ProjectManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelProjectreqforApprovalCode);
            //ContractManagement
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelContractreqforApprovalCode);
        END;
        WorkFlowResponse.ReleaseDocumentCode: begin
            WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.ReleaseDocumentCode, WorkflowEventHandling.RunWorkflowOnAfterReleaseInvestReqCode);
        end;
        END;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        ReleasePayments: Codeunit "Release Payments";
        WorkflowResponses: Codeunit "Workflow Responses";
        Payments: Record Payments;
        IR: Record "Internal Request Header";
        LeaveApp: Record "Leave Application";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        RNeeds: record "Recruitment Needs";
        TRequest: Record "Training Request";
        TravelRequest: Record "Travel Requests";
        EAppraisal: Record "Employee Appraisal";
        LRecall: Record "Employee Off/Holiday";
        LoanApplication: Record "Loan Application";
        EActingPosition: Record "Employee Acting Position";
        BApproval: Record "Budget Approval Header";
        PayrollApproval: Record "Payroll Approval";
        BName: Record "G/L Budget Name";
        BRecon: Record "Bank Acc. Reconciliation";
        LAdj: Record "Leave Bal Adjustment Header";
        ReleaseReq: Codeunit "Release Requisition";
        VarVariant: Variant;
        TenderEval: Record "Tender Evaluation Header";
        SupplierEval: Record "Supplier Evaluation Header";
        FADisposal: Record "FA Disposal";
        AssetTrans: Record "Asset Allocation and Transfer";
        EmployeeTransfer: Record "Employee Transfers";
        AssetAllocation: Record "Asset Allocation and Transfer";
        TenderCommittee: Record "Tender Committees";
        ProqChangeReq: Record "Procurement Change Request";
        ContChange: Record "Contract Change Header";
        ProcMethod: Record "Procurement Request";
        Audit: Record "Audit Header";
        ResearchActivity: Record "Research Activity Plan";
        Partnership: Record "Partnerships Activity Plan";
        ResearchSurvey: Record "Research and survey Workplan";
        ItemJnl: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        LabSchedule: Record "Lab Annual Testing Schedule";
        AssetDisposal: Record "AnnualDisposal Header";
        LicenseRegistration: Record "Licensing dairy Enterprise";
        LicenseApplication: Record "License Applications";
        ICTWorkplan: Record "ICT Workplan";
        UserIncidences: Record "User Support Incident";
        RiskHeader: Record "Risk Header";
        TransportIncident: Record "Transport Incident";
        DriverLogging: Record "Driver Logging";
        WorkProgramme: Record "Activity Work Programme";
        Projectman: Record Projectman;
        ContractMan: Record "Project Header";
        TargetSetup: Record "Target Setup Header";
        ReleaseDoc: Codeunit "Document Release";
        ProspectivesSuppliers: Record "Prospective Suppliers";
    begin
        VarVariant:=RecRef;
        CASE RecRef.NUMBER OF //Payments
        DATABASE::Payments: begin
            Payments.SetView(RecRef.GetView());
            Handled:=true;
            ReleasePayments.PerformManualRelease(VarVariant);
        end;
        //Employee Transfer
        DATABASE::"Employee Transfers": begin
            EmployeeTransfer.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseEmployeeTransfer(VarVariant);
        end;
        //TargetSetupHeader
        Database::"Target Setup Header": begin
            TargetSetup.SetView(RecRef.GetView());
            Handled:=true;
            ReleaseDoc.TargetSetupHeaderRelease(VarVariant);
        end;
        DATABASE::"Payroll Approval": begin
            PayrollApproval.SetView(RecRef.GetView());
            Handled:=true;
            ReleaseDoc.PayrollApprovalRelease(VarVariant);
        end;
        //Tender committe
        DATABASE::"Tender Committees": begin
            TenderCommittee.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseTenderCommittee(VarVariant);
        end;
        //procurement Change Request
        DATABASE::"Procurement Change Request": begin
            ProqChangeReq.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseProcChangeRequest(VarVariant);
        end;
        //Contract Change
        DATABASE::"Contract Change Header": begin
            ContChange.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseContChange(VarVariant);
        end;
        //procurement method
        DATABASE::"Procurement Request": begin
            ProcMethod.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseProcMethod(VarVariant);
        end;
        //Requisitions
        Database::"Internal Request Header": begin
            IR.SetView((RecRef.GetView()));
            Handled:=true;
            ReleaseReq.PerformManualRelease(VarVariant);
            if IR."Document Type" = IR."Document Type"::Stock then ReleaseReq.sendSupplyChainNotifications(VarVariant);
        end;
        //Leave Application
        DATABASE::"Leave Application": begin
            LeaveApp.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLeave(VarVariant);
        end;
        //Sample Analysis
        DATABASE::"Sample Analysis And Reporting": begin
            SampleAnalysis.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseSample(VarVariant);
        end;
        //asset Transfer
        DATABASE::"Asset Allocation and Transfer": begin
            AssetTrans.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseAssetTransfer(VarVariant);
        end;
        //Recruitment
        DATABASE::"Recruitment Needs": begin
            RNeeds.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseRecruitment(VarVariant);
        end;
        //Prospective Suppliers
        DATABASE::"Prospective Suppliers": begin
            ProspectivesSuppliers.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseProspectiveSuppliers(VarVariant);
        end;
        //Training Request
        DATABASE::"Training Request": begin
            TRequest.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseTrainingRequest(VarVariant);
        end;
        //Transport Request
        DATABASE::"Travel Requests": begin
            TravelRequest.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseTransportReq(VarVariant);
        end;
        //Employee Appraisal
        DATABASE::"Employee Appraisal": begin
            EAppraisal.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseEmployeeAppraisalRequest(VarVariant);
        end;
        // Leave Recall
        DATABASE::"Employee Off/Holiday": begin
            LRecall.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLeaveRecallRequest(VarVariant);
        end;
        // Loan Application
        DATABASE::"Loan Application": begin
            LoanApplication.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLoanApplication(VarVariant);
        end;
        //Emp acting and Promotion
        DATABASE::"Employee Acting Position": begin
            EActingPosition.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseEmpActingPromotion(VarVariant);
        end;
        //Budget
        DATABASE::"Budget Approval Header": begin
            BApproval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseBudget(VarVariant);
        end;
        //Proposed Budget
        DATABASE::"G/L Budget Name": begin
            BName.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseProposedBudget(VarVariant);
        end;
        //Bank Rec
        DATABASE::"Bank Acc. Reconciliation": begin
            BRecon.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseBankRec(VarVariant);
        end;
        //Leave Adj
        DATABASE::"Leave Bal Adjustment Header": begin
            LAdj.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLeaveAdj(VarVariant);
        end;
        //Tender Evaluation
        DATABASE::"Tender Evaluation Header": begin
            TenderEval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseTenderEval(VarVariant);
        end;
        //Supplier Evaluation
        Database::"Supplier Evaluation Header": begin
            SupplierEval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseSupplierEval(VarVariant);
        end;
        //FA Disposal
        Database::"FA Disposal": begin
            FADisposal.SetView((RecRef.GetView()));
            Handled:=true;
            WorkflowResponses.ReleaseFADisposal(VarVariant);
        end;
        //Audit
        DATABASE::"Audit Header": begin
            Audit.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseAudit(VarVariant);
        end;
        //ResearchActivity
        DATABASE::"Research Activity Plan": begin
            ResearchActivity.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseResearchActivity(VarVariant);
        end;
        //PartnershipActivity
        DATABASE::"Partnerships Activity Plan": begin
            Partnership.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleasePartnershipActivity(VarVariant);
        end;
        //ResearchSurvey Workplan
        DATABASE::"Research and survey Workplan": begin
            ResearchSurvey.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseResearchSurvey(VarVariant);
        end;
        //ItemJnl
        DATABASE::"Item Journal Batch": begin
            ItemJnl.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseItemJournal(VarVariant);
        end;
        //ItemJnlLine
        DATABASE::"Item Journal Line": begin
            ItemJnlLine.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseItemJournalLine(VarVariant);
        end;
        //LabSchedule
        DATABASE::"Lab Annual Testing Schedule": begin
            LabSchedule.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLabSchedule(VarVariant);
        end;
        //AssetDisposal
        DATABASE::"AnnualDisposal Header": begin
            AssetDisposal.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseAssetDisposal(VarVariant);
        end;
        //LicenseRegistration
        DATABASE::"Licensing dairy Enterprise": begin
            LicenseRegistration.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLicenseRegistration(VarVariant);
        end;
        //LicenseApplication
        DATABASE::"License Applications": begin
            LicenseApplication.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseLicenseApplication(VarVariant);
        end;
        //ICTWorkplan
        DATABASE::"ICT Workplan": begin
            ICTWorkplan.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseICTWorkplan(VarVariant);
        end;
        // UserIncidences
        DATABASE::"User Support Incident": begin
            UserIncidences.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseUserIncidences(VarVariant);
        end;
        //RiskHeader
        DATABASE::"Risk Header": begin
            RiskHeader.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseRiskHeader(VarVariant);
        end;
        //TransportIncident
        DATABASE::"Transport Incident": begin
            TransportIncident.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseTransportIncident(VarVariant);
        end;
        //DriverLogging
        DATABASE::"Driver Logging": begin
            DriverLogging.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseDriverLogging(VarVariant);
        end;
        //WorkProgramme
        DATABASE::"Activity Work Programme": begin
            WorkProgramme.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReleaseWorkProgramme(VarVariant);
        end;
        //ProjectManagement
        Database::Projectman: begin
            Projectman.Setview(recref.getview());
            handled:=true;
            WorkflowResponses.ReleaseProjectManagement(VarVariant);
        end;
        //ContractManagement
        Database::"Project Header": begin
            Projectman.Setview(recref.getview());
            handled:=true;
            WorkflowResponses.ReleaseContractManagement(VarVariant);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        ReleasePayments: Codeunit "Release Payments";
        WorkflowResponses: Codeunit "Workflow Responses";
        Payments: Record Payments;
        IR: Record "Internal Request Header";
        LeaveApp: Record "Leave Application";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        RNeeds: record "Recruitment Needs";
        TRequest: Record "Training Request";
        TravelRequest: Record "Travel Requests";
        EAppraisal: Record "Employee Appraisal";
        LRecall: Record "Employee Off/Holiday";
        LoanApplication: Record "Loan Application";
        EActingPosition: Record "Employee Acting Position";
        BApproval: Record "Budget Approval Header";
        BName: Record "G/L Budget Name";
        BRecon: Record "Bank Acc. Reconciliation";
        LAdj: Record "Leave Bal Adjustment Header";
        TenderEval: Record "Tender Evaluation Header";
        ReleaseReq: Codeunit "Release Requisition";
        SupplierEval: Record "Supplier Evaluation Header";
        FADisposal: Record "FA Disposal";
        VarVariant: Variant;
        AssetTran: Record "Asset Allocation and Transfer";
        EmployeeTransfers: Record "Employee Transfers";
        TenderCommittee: Record "Tender Committees";
        ProcChangeRec: Record "Procurement Change Request";
        ContChange: Record "Contract Change Header";
        ProcMethod: Record "Procurement Request";
        Audit: Record "Audit Header";
        ResearchActivity: Record "Research Activity Plan";
        Partnership: Record "Partnerships Activity Plan";
        ResearchSurvey: Record "Research and survey Workplan";
        ItemJnl: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        LabSchedule: Record "Lab Annual Testing Schedule";
        AssetDisposal: Record "AnnualDisposal Header";
        LicenseReg: Record "Licensing dairy Enterprise";
        LicenseApplication: Record "License Applications";
        ICTWorkplan: Record "ICT Workplan";
        UserIncidences: Record "User Support Incident";
        RiskHeader: Record "Risk Header";
        TransportIncident: Record "Transport Incident";
        DriverLogging: Record "Driver Logging";
        WorkProgramme: Record "Activity Work Programme";
        Projectman: Record projectman;
        ContractMan: Record "Project Header";
        TargetSetup: Record "Target Setup Header";
        ReleaseDoc: Codeunit "Document Release";
        PayrollApproval: Record "Payroll Approval";
        ContractChange: Record "Contract Change Header";
        ProspespectiveSup: Record "Prospective Suppliers";
    begin
        VarVariant:=RecRef;
        CASE RecRef.NUMBER OF //Payments
        DATABASE::Payments: begin
            Payments.SetView(RecRef.GetView());
            Handled:=true;
            ReleasePayments.Reopen(VarVariant);
        end;
        //Purchase Request
        //Requisitions
        Database::"Internal Request Header": begin
            IR.SetView((RecRef.GetView()));
            Handled:=true;
            ReleaseReq.PerformManualReopen(VarVariant);
            IR.Modify();
        end;
        DATABASE::"Payroll Approval": begin
            PayrollApproval.SetView(RecRef.GetView());
            Handled:=true;
            ReleaseDoc.PayrollApprovalReopen(PayrollApproval);
        end;
        //Leave Application
        DATABASE::"Leave Application": begin
            LeaveApp.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLeave(VarVariant);
        end;
        //TargetSetupHeader
        Database::"Target Setup Header": begin
            TargetSetup.SetView(RecRef.GetView());
            Handled:=true;
            ReleaseDoc.TargetSetupHeaderReopen(VarVariant);
        end;
        //Asset Transfer
        DATABASE::"Asset Allocation and Transfer": begin
            AssetTran.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenAssetTransfer(VarVariant);
        end;
        //Employee Transfer
        DATABASE::"Employee Transfers": begin
            EmployeeTransfers.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenEmployeeTransfer(VarVariant);
        end;
        //Sample
        DATABASE::"Sample Analysis And Reporting": begin
            SampleAnalysis.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenSample(VarVariant);
        end;
        //Tender committe
        DATABASE::"Tender Committees": begin
            TenderCommittee.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenTenderCommittee(VarVariant);
        end;
        //Procurement Change Request
        DATABASE::"Procurement Change Request": begin
            ProcChangeRec.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenProcChangeRequest(VarVariant);
        end;
        //Contract Change
        DATABASE::"Contract Change Header": begin
            ContractChange.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenContChange(VarVariant);
        end;
        //Proc method
        DATABASE::"Procurement Request": begin
            ProcMethod.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenProcMethod(VarVariant);
        end;
        //Recruitment
        DATABASE::"Recruitment Needs": begin
            RNeeds.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenRecruitment(VarVariant);
        end;
        //Prospective Suppliers:
        DATABASE::"Prospective Suppliers": begin
            ProspespectiveSup.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenProspectiveSupp(VarVariant);
        end;
        //Training Request
        DATABASE::"Training Request": begin
            TRequest.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenTrainingRequest(VarVariant);
        end;
        //Transport Request
        DATABASE::"Travel Requests": begin
            TravelRequest.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenTransportReq(VarVariant);
        end;
        //Employee Appraisal
        DATABASE::"Employee Appraisal": begin
            EAppraisal.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenEmployeeAppraisalRequest(VarVariant);
        end;
        //Leave Recall
        DATABASE::"Employee Off/Holiday": begin
            LRecall.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLeaveRecallRequest(VarVariant);
        end;
        //Loan Application
        DATABASE::"Loan Application": begin
            LoanApplication.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLoanApplication(VarVariant);
        end;
        //Emp acting and Promotion
        DATABASE::"Employee Acting Position": begin
            EActingPosition.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenEmpActingPromotion(VarVariant);
        end;
        //Budget
        DATABASE::"Budget Approval Header": begin
            BApproval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenBudget(VarVariant);
        end;
        //Proposed Budget
        DATABASE::"G/L Budget Name": begin
            BName.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenProposedBudget(VarVariant);
        end;
        //Bank Rec
        DATABASE::"Bank Acc. Reconciliation": begin
            BRecon.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenBankRec(VarVariant);
        end;
        //Leave Adj
        DATABASE::"Leave Bal Adjustment Header": begin
            LAdj.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLeaveAdj(VarVariant);
        end;
        //Tender Evauation
        DATABASE::"Tender Evaluation Header": begin
            TenderEval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenTenderEval(VarVariant);
        end;
        //Supplier Evaluation
        Database::"Supplier Evaluation Header": begin
            SupplierEval.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenSupplierEval(VarVariant);
        end;
        //FA Disposal
        Database::"FA Disposal": begin
            FADisposal.SetView((RecRef.GetView()));
            Handled:=true;
            WorkflowResponses.ReleaseFADisposal(VarVariant);
        end;
        //Audit
        DATABASE::"Audit Header": begin
            Audit.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenAudit(VarVariant);
        end;
        //ReseachActivity
        DATABASE::"Research Activity Plan": begin
            ResearchActivity.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenResearchActivity(VarVariant);
        end;
        //PartnershipsActivity
        DATABASE::"Partnerships Activity Plan": begin
            Partnership.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenPartnershipActivity(VarVariant);
        end;
        //Research and survey 
        DATABASE::"Research and survey Workplan": begin
            ResearchSurvey.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenResearchSurvey(VarVariant);
        end;
        //ItemJnl
        DATABASE::"Item Journal Batch": begin
            ItemJnl.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenItemJournal(VarVariant);
        end;
        //ItemJnlLine
        DATABASE::"Item Journal Line": begin
            ItemJnlLine.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenItemJournalLine(VarVariant);
        end;
        //LabSchedule
        DATABASE::"Lab Annual Testing Schedule": begin
            LabSchedule.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLabSchedule(VarVariant);
        end;
        //Asset Disposal
        DATABASE::"AnnualDisposal Header": begin
            AssetDisposal.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenAssetDisposal(VarVariant);
        end;
        //Licenseregistartion
        DATABASE::"Licensing dairy Enterprise": begin
            Licensereg.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLicenseRegistration(VarVariant);
        end;
        //LicenseApplication
        DATABASE::"License Applications": begin
            LicenseApplication.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenLicenseApplication(VarVariant);
        end;
        //ICTWorkplan
        DATABASE::"ICT Workplan": begin
            ICTWorkplan.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenICTWorkplan(VarVariant);
        end;
        //UserIncidences
        DATABASE::"User Support Incident": begin
            UserIncidences.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenUserIncidences(VarVariant);
        end;
        //RiskHeader
        DATABASE::"Risk Header": begin
            RiskHeader.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenRiskHeader(VarVariant);
        end;
        //TransportIncident
        DATABASE::"Transport Incident": begin
            TransportIncident.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenTransportIncident(VarVariant);
        end;
        //DriverLogging
        DATABASE::"Driver Logging": begin
            DriverLogging.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenDriverLogging(VarVariant);
        end;
        //WorkProgramme
        DATABASE::"Activity Work Programme": begin
            WorkProgramme.SetView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenWorkProgramme(VarVariant);
        end;
        //Projectman
        Database::ProjectMan: begin
            Projectman.setView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenProjectManagement(VarVariant);
        end;
        //Contractman
        Database::"Project Header": begin
            Contractman.setView(RecRef.GetView());
            Handled:=true;
            WorkflowResponses.ReopenContractManagement(VarVariant);
        end;
        end;
    end;
}
