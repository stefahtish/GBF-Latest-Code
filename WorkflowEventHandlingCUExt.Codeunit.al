codeunit 50114 WorkflowEventHandlingCUExt
{
    var WorkflowEvent: Codeunit "Workflow Event Handling";
    WorkflowManagement: Codeunit "Workflow Management";
    PaymentsSendForApprovalEventDescTxt: Label 'Approval of Payment is requested';
    PaymentsApprovalRequestCancelledEventDescTxt: Label 'Approval Request for a payment has been cancelled';
    PaymentsReleasedEventDescTxt: Label 'A payment has been released';
    PayrollApprovalSendApprovalTxt: Label 'An approval request for Payroll Approval is requested';
    PayrollApprovalCancelApprovalTxt: Label 'An approval request for Payroll Approval is cancelled';
    PayrollApprovalReleasedEventDescTxt: Label 'A Payroll Approval has been released';
    //Requisition___Purchase
    ReqSendforApprovalDescTxt: Label 'An approval request for a Requisition is requested';
    ReqCancelApprovalRequestDescTxt: Label 'An approval request for a Requisition is cancelled ';
    TransportRequestSendforApprovalDescTxt: Label 'An approval for Transport Request is requested';
    TransportRequestCancelApprovalRequestDescTxt: Label 'An approval request for Transport Request is cancelled ';
    LeaveRequestSendforApprovalDescTxt: Label 'An approval for Leave Application is requested';
    LeaveRequestCancelApprovalRequestDescTxt: Label 'An approval for Leave Application is cancelled ';
    TendercommitteeSendforApprovalDescTxt: Label 'An approval for tender committee is requested';
    TendercommitteeCancelApprovalRequestDescTxt: Label 'An approval for tender committee is cancelled ';
    ProcReqSendforApprovalDescTxt: Label 'An approval for procurement change request is requested';
    ProcReqCancelApprovalRequestDescTxt: Label 'An approval for procurement change request is cancelled ';
    ContractChangeSendforApprovalDescTxt: Label 'An approval for Contract Change is requested';
    ContractChangeCancelApprovalRequestDescTxt: Label 'An approval for Contract Change is cancelled ';
    ProcMethodSendforApprovalDescTxt: Label 'An approval for Procurement method is requested';
    ProcMethodRequestCancelApprovalRequestDescTxt: Label 'An approval for Procurement method is cancelled ';
    SampleAnalysisSendforApprovalDescTxt: Label 'An approval for Sample Analysis is requested';
    SampleAnalysisCancelApprovalRequestDescTxt: Label 'An approval for Sample Analysis is cancelled ';
    AssetTransSendforApprovalDescTxt: Label 'An approval for Asset Transfer  is requested';
    AssetTransCancelApprovalRequestDescTxt: Label 'An approval for Asset Transfer is cancelled ';
    AssetAllocationSendforApprovalDescTxt: Label 'An approval for Asset Allocation  is requested';
    AssetAllocationCancelApprovalRequestDescTxt: Label 'An approval for Asset Allocation is cancelled ';
    RecruitmentRequestSendforApprovalDescTxt: Label 'An approval for Recruitment is requested';
    RecruitmentRequestCancelApprovalRequestDescTxt: Label 'An approval request for Recruitment is cancelled';
    TrainingRequestSendforApprovalDescTxt: Label 'An approval request for Training is requested';
    TrainingRequestCancelApprovalRequestDescTxt: Label 'An approval request for Training Request is cancelled ';
    EmployeeAppraisalRequestSendforApprovalDescTxt: Label 'An approval request for Employee Appraisal is requested';
    EmployeeAppraisalCancelApprovalRequestDescTxt: Label 'An approval request for Employee Appraisal is cancelled';
    TargetSetupRequestSendforApprovalDescTxt: Label 'An approval request for Target Setup Review Appraisal is requested';
    TargetSetupCancelApprovalRequestDescTxt: Label 'An approval request for Target Setup Review Appraisal is cancelled';
    LeaveRecallApprovalRequestDescTxt: Label 'An approval for Leave Recall is requested';
    LeaveRecallCancelApprovalRequestDescTxt: Label 'An approval request for Leave Recall is cancelled';
    EmployeeTransferRequestforApprovalDescTxt: Label 'An approval for Employee Transfer is requested ';
    EmployeeTransferCancelApprovalRequestDescTxt: Label 'An approval request for Employee Transfer is cancelled';
    PayrollChangeRequestforApprovalDescTxt: Label 'An approval for Payroll Change is requested ';
    PayrollChangeCancelApprovalRequestDescTxt: Label 'An approval for Payroll Change is cancelled ';
    PayrollRequestApprovalDescTxt: Label 'An approval for Payroll Request is requested';
    PayrollRequestCancelApprovalDescTxt: Label 'An approval for Payroll Request is cancelled';
    PayrollLoanApplicationApprovalDescTxt: Label 'An approval for Payroll Loan Application is requested ';
    PayrollLoanApplicationCancelApprovalDescTxt: Label 'An approval for Payroll Loan application is cancelled';
    EmpActingPromotionSendForApprovalTxt: Label 'An Approval for Employee acting and promotion is requested';
    EmpActingPromotionCancelApprovalTxt: Label 'An Approval for Employee acting and promotion is cancelled';
    BudgetSendApprovalTxt: Label 'An approval request for Budget Lines is requested';
    BudgetCancelApprovalTxt: Label 'An approval request for Budget Lines is cancelled';
    ProposedBudgetSendApprovalTxt: Label 'An approval request for Proposed Budget is requested';
    ProposedBudgetCancelApprovalTxt: Label 'An approval request for Proposed Budget Lines is cancelled';
    BankRecSendApprovalTxt: Label 'An approval request for a Bank Reconciliation is requested';
    BankRecCancelApprovalTxt: Label 'An approval request for Bank Reconciliation is cancelled';
    AuditSendApprovalTxt: Label 'An approval request for Internal Audit is requested';
    AuditCancelApprovalTxt: Label 'An approval request for Internal Audit Lines is cancelled';
    FADisposalSendApprovalTxt: Label 'An approval request for FA Disposal is requested';
    FADisposalCancelApprovalTxt: Label 'An approval request for FA Disposal is cancelled';
    LeaveAdjSendApprovalTxt: Label 'An approval request for Leave Adjustment is requested';
    LeaveAdjCancelApprovalTxt: Label 'An approval request for Leave Adjustment is cancelled';
    InvSendApprovalTxt: Label 'An approval request for Investment is requested';
    InvCancelApprovalTxt: Label 'An approval request for Investment is cancelled';
    TPSApplicationApprovalDescTxt: Label 'An approval for TPS Application is requested ';
    TPSApplicationCancelApprovalDescTxt: Label 'An approval for TPS application is cancelled ';
    NewEmpAppraisalApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is requested ';
    NewEmpAppraisalCancelApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is cancelled';
    InvestReqSendForApprovalEventDescTxt: Label 'Approval of a Investment Requisition is requested.';
    InvestReqApprReqCancelledEventDescTxt: Label 'An approval request for a Investment Requisition has been canceled.';
    InvestReqReleasedEventDescTxt: Label 'A Investment Request has been released.';
    PayInvestSendForApprovalEventDescTxt: Label 'Approval of a investment payment is requested.';
    PayInvestApprReqCancelledEventDescTxt: Label 'An approval request for a Investment Payment has been canceled.';
    PayInvestReleasedEventDescTxt: Label 'A Investment Payment has been released.';
    InvestDisposalSendForApprovalEventDescTxt: Label 'Approval of a Investment Disposal is requested.';
    InvestDisposalApprReqCancelledEventDescTxt: Label 'An approval request for a Investment Disposal has been canceled.';
    InvestDisposalReleasedEventDescTxt: Label 'A Investment Disposal has been released.';
    LoanAppSendForApprovalEventDescTxt: Label 'Approval of a Loan Application is requested.';
    LoanAppApprReqCancelledEventDescTxt: Label 'An approval request for a Loan Application has been canceled.';
    LoanDisbSendForApprovalEventDescTxt: Label 'Approval of a Loan Disbursement is requested.';
    LoanDisbApprReqCancelledEventDescTxt: Label 'An approval request for a Loan Disbursement has been canceled.';
    LoanReceiptSendForApprovalEventDescTxt: Label 'Approval of a Loan Receipt is requested.';
    LoanReceiptApprReqCancelledEventDescTxt: Label 'An approval request for a Loan Receipt has been canceled.';
    LoanIntSendForApprovalEventDescTxt: Label 'Approval of a Loan Interest is requested.';
    LoanIntApprReqCancelledEventDescTxt: Label 'An approval request for a Loan Interest has been canceled.';
    TenderEvalSendForApprovalEventDescTxt: Label 'Approval of a Tender Evaluation is requested.';
    TenderEvalApprReqCancelledEventDescTxt: Label 'An approval request for a Tender Evaluation has been canceled.';
    FundReqSendForApprovalEventDescTxt: Label 'Approval of a Fund Requisition is requested.';
    FundReqCancelledEventDescTxt: Label 'An approval request for a fund requisition has been canceled.';
    FundReqReleasedEventDescTxt: Label 'A fund requisition has been released.';
    BondApplicationSendForApprovalEventDescTxt: Label 'Approval of a Bond Application is requested.';
    BondApplicationApprReqCancelledEventDescTxt: Label 'An approval request for a Bond Application has been canceled.';
    BondApplicationReleasedEventDescTxt: Label 'A Bond Application has been released.';
    InvestReceiptSendForApprovalEventDescTxt: Label 'Approval of a Receipt is requested.';
    InvestReceiptApprReqCancelledEventDescTxt: Label 'An approval request for a Receipt has been canceled.';
    InvestReceiptReleasedEventDescTxt: Label 'A Receipt has been released.';
    SupplierEvalSendForApprovalEventDescTxt: Label 'Approval of a Supplier Evaluation is requested.';
    SupplierEvalApprReqCancelledEventDescTxt: Label 'An approval request for a Supplier Evaluation has been canceled.';
    InvestQuoteSendForApprovalEventDescTxt: Label 'Approval of a Secuities Requisition is requested.';
    InvestQuoteApprReqCancelledEventDescTxt: Label 'An approval request for a Secuities Requisition has been canceled.';
    FADisposalSendForApprovalEventDescTxt: Label 'Approval of a FA Disposal is requested.';
    FADisposalApprReqCancelledEventDescTxt: Label 'An approval request for a FA Disposal has been canceled.';
    AuditSendForApprovalEventDescTxt: Label 'Approval of a audit header is requested.';
    AuditApprReqCancelledEventDescTxt: Label 'An approval request for audit header has been canceled.';
    //ResearchActivity
    ResearchActivitySendForApprovalEventDescTxt: Label 'Approval of a Research Activity is requested.';
    ResearchActivityApprReqCancelledEventDescTxt: Label 'An approval request for Research Activity has been canceled.';
    //PartnershipActivity
    PartnershipActivitySendForApprovalEventDescTxt: Label 'Approval of a Partnership Activity is requested.';
    PartnershipActivityApprReqCancelledEventDescTxt: Label 'An approval request for Partnership Activity has been canceled.';
    //SurveyActivity
    SurveyctivitySendForApprovalEventDescTxt: Label 'Approval of a Survey Activity is requested.';
    SurveychActivityApprReqCancelledEventDescTxt: Label 'An approval request for Survey Activity has been canceled.';
    //ItemJournal
    ItemJournalSendForApprovalEventDescTxt: Label 'Approval of a physical inventory journal is requested.';
    ItemJournalCancelledEventDescTxt: Label 'An approval request for physical inventory journal has been canceled.';
    //ItemJournalLine
    ItemJournalLineSendForApprovalEventDescTxt: Label 'Approval of a physical inventory journal Line is requested.';
    ItemJournalLineCancelledEventDescTxt: Label 'An approval request for physical inventory journal Line has been canceled.';
    //LabSchedule
    LabScheduleSendForApprovalEventDescTxt: Label 'Approval of a Lab Workplan is requested.';
    LabScheduleCancelledEventDescTxt: Label 'An approval request for Lab Workplan has been canceled.';
    //AssetDisposal
    AssetDisposalSendForApprovalEventDescTxt: Label 'Approval of a annual asset disposal plan is requested.';
    AssetDisposalCancelledEventDescTxt: Label 'An approval request for annual asset disposal plan has been canceled.';
    //LicenseRegistration
    LicenseRegistrationSendForApprovalEventDescTxt: Label 'Approval of a applicant registration is requested.';
    LicenseRegistrationCancelledApprovalEventDescTxt: Label 'Approval of a applicant registration has been canceled.';
    //LicenseApplication
    LicenseApplicationSendForApprovalEventDescTxt: Label 'Approval of a license Application/Renewal is requested.';
    LicenseApplicationCancelledApprovalEventDescTxt: Label 'Approval of a license Application/Renewal has been canceled.';
    ICTWorkplanSendForApprovalEventDescTxt: Label 'Approval of   ICT Workplan is requested.';
    ICTWorkplanCancelledApprovalEventDescTxt: Label 'Approval of   ICT Workplan has been canceled.';
    //UserIncidences
    UserIncidencesSendForApprovalEventDescTxt: Label 'Approval of Incidences is requested.';
    UserIncidencesCancelledApprovalEventDescTxt: Label 'Approval of Incidences has been canceled.';
    //RiskHeader
    RiskHeaderSendForApprovalEventDescTxt: Label 'Approval of Risk is requested.';
    RiskHeaderCancelledApprovalEventDescTxt: Label 'Approval of Riskr has been canceled.';
    //DriverLogging
    DriverLoggingSendForApprovalEventDescTxt: Label 'Approval of Driver Logging is requested.';
    DriverLoggingCancelledApprovalEventDescTxt: Label 'Approval of Driver Logging has been canceled.';
    //TransportIncident
    TransportIncidentSendForApprovalEventDescTxt: Label 'Approval of Transport Incident is requested.';
    TransportIncidentCancelledApprovalEventDescTxt: Label 'Approval of Transport Incident has been canceled.';
    //Workprogramme
    WorkprogrammeSendForApprovalEventDescTxt: Label 'Approval of Activity Work Programme is requested.';
    WorkprogrammeCancelledApprovalEventDescTxt: Label 'Approval of Activity Work Programme has been canceled.';
    //Project Management
    ProjectManagementSendForApprovalEventDescTxt: Label 'An Approval request for a project is requested';
    ProjectManagementCancelledApprovalEventDescTxt: Label 'An Approval request for a project is cancelled';
    //ContractProjectManagement
    ContractProjectManagementSendForApprovalEventDescTxt: Label 'An Approval request for a contract is requested';
    ContractProjectManagementCancelledApprovalEventDescTxt: Label 'An Approval request for a contract is Cancelled';
    //Prospective Suppliers:
    ProspectiveSupplierRequestSendforApprovalDescTxt: Label 'An approval for Prospective Supplier is requested';
    ProspectiveSupplierRequestCancelApprovalRequestDescTxt: Label 'An approval request for Prospective Supplier is cancelled';
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //
        //Payments
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendPaymentsForApprovalCode, DATABASE::Payments, PaymentsSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelPaymentsApprovalRequestCode, DATABASE::Payments, PaymentsApprovalRequestCancelledEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleasePaymentsCode, DATABASE::Payments, PaymentsReleasedEventDescTxt, 0, FALSE);
        //Payroll Approval
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendPayrollApprovalForApprovalCode, DATABASE::"Payroll Approval", PayrollApprovalSendApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelPayrollApprovalApprovalRequestCode, DATABASE::"Payroll Approval", PayrollApprovalCancelApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnAfterReleasePayrollApprovalCode, DATABASE::"Payroll Approval", PayrollApprovalReleasedEventDescTxt, 0, FALSE);
        //Requisitions
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendReqforApprovalCode, DATABASE::"Internal Request Header", ReqSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelReqForApprovalCode, DATABASE::"Internal Request Header", ReqCancelApprovalRequestDescTxt, 0, FALSE);
        //Leave Application
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveApplicationforApprovalCode, DATABASE::"Leave Application", LeaveRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveApplicationApprovalRequestCode, DATABASE::"Leave Application", LeaveRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Tender Committee
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendTenderCommitteeforApprovalCode, DATABASE::"Tender Committees", TendercommitteeSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelTenderCommitteeApprovalRequestCode, DATABASE::"Tender Committees", TendercommitteeCancelApprovalRequestDescTxt, 0, FALSE);
        //Procurement Request
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendProcReqforApprovalCode, DATABASE::"Procurement Change Request", ProcReqSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelProcReqApprovalRequestCode, DATABASE::"Procurement Change Request", ProcReqCancelApprovalRequestDescTxt, 0, FALSE);
        //Contract Change
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendContChangeforApprovalCode, DATABASE::"Contract Change Header", ContractChangeSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelContChangeApprovalRequestCode, DATABASE::"Contract Change Header", ContractChangeCancelApprovalRequestDescTxt, 0, FALSE);
        //Procurement method
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendProcMethodforApprovalCode, DATABASE::"Procurement Request", ProcMethodSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelProcMethodApprovalRequestCode, DATABASE::"Procurement Request", ProcMethodRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Sample Analysis
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendSampleforApprovalCode(), DATABASE::"Sample Analysis And Reporting", SampleAnalysisSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelSampleApprovalRequestCode, DATABASE::"Sample Analysis And Reporting", SampleAnalysisCancelApprovalRequestDescTxt, 0, FALSE);
        //AssetTransfer
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendAssetTransforApprovalCode(), DATABASE::"Asset Allocation and Transfer", AssetTransSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelAssetTransApprovalRequestCode, DATABASE::"Asset Allocation and Transfer", AssetTransCancelApprovalRequestDescTxt, 0, FALSE);
        //AssetAllocation
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendAssetAllocationforApprovalCode(), DATABASE::"Asset Allocation and Transfer", AssetAllocationSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelAssetAllocationApprovalRequestCode, DATABASE::"Asset Allocation and Transfer", AssetAllocationCancelApprovalRequestDescTxt, 0, FALSE);
        //Recruitment
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendRecruitmentRequestforApprovalCode, DATABASE::"Recruitment Needs", RecruitmentRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelRecruitmentRequestApprovalCode, DATABASE::"Recruitment Needs", RecruitmentRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Prospective Suppliers
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendProspectiveSupplierRequestforApprovalCode, DATABASE::"Prospective Suppliers", ProspectiveSupplierRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelprospectivesupplierRequestApprovalCode, DATABASE::"Prospective Suppliers", ProspectiveSupplierRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Training Request
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendTrainingRequestforApprovalCode, DATABASE::"Training Request", TrainingRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelTrainingRequestApprovalRequestCode, DATABASE::"Training Request", TrainingRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Transport Request
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTransportForApprovalCode, DATABASE::"Travel Requests", TransportRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTransportApprovalRequestCode, DATABASE::"Travel Requests", TransportRequestCancelApprovalRequestDescTxt, 0, FALSE);
        //Employee Appraisal
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode, DATABASE::"Employee Appraisal", EmployeeAppraisalRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode, DATABASE::"Employee Appraisal", EmployeeAppraisalCancelApprovalRequestDescTxt, 0, FALSE);
        //TargetSetupHeader
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTargetSetupHeaderForApprovalCode, DATABASE::"Target Setup Header", TargetSetupRequestSendforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTargetSetupHeaderApprovalRequestCode, DATABASE::"Target Setup Header", TargetSetupCancelApprovalRequestDescTxt, 0, FALSE);
        //New Emp Appraisal
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendNewEmpAppraisalforApprovalCode(), DATABASE::"Employee Appraisal", NewEmpAppraisalApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(), DATABASE::"Employee Appraisal", NewEmpAppraisalCancelApprovalDescTxt, 0, FALSE);
        //Leave Recall
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveRecallRequestforApprovalCode, DATABASE::"Employee Off/Holiday", LeaveRecallApprovalRequestDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveRecallApprovalRequestCode, DATABASE::"Employee Off/Holiday", LeaveRecallCancelApprovalRequestDescTxt, 0, FALSE);
        //Employee Transfer      
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendEmployeeTransferRequestforApprovalCode, DATABASE::"Employee Transfers", EmployeeTransferRequestforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelEmployeeTransferApprovalRequestCode, DATABASE::"Employee Transfers", EmployeeTransferCancelApprovalRequestDescTxt, 0, FALSE);
        //Payroll Change
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendPayrollChangeRequestforApprovalCode, DATABASE::"Payroll Change Header", PayrollChangeRequestforApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelPayrollChangeApprovalRequestCode, DATABASE::"Payroll Change Header", PayrollChangeCancelApprovalRequestDescTxt, 0, FALSE);
        //Loan Application
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLoanApplicationApprovalRequestCode, DATABASE::"Loan Application", PayrollLoanApplicationCancelApprovalDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLoanApplicationforApprovalCode, DATABASE::"Loan Application", PayrollLoanApplicationApprovalDescTxt, 0, FALSE);
        //EmpActing and Promotion
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode, DATABASE::"Employee Acting Position", EmpActingPromotionCancelApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendEmpActingPromotionForApprovalCode, DATABASE::"Employee Acting Position", EmpActingPromotionSendForApprovalTxt, 0, FALSE);
        //Budget
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendBudgetRequestForApprovalCode, DATABASE::"Budget Approval Header", BudgetSendApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelBudgetRequestForApprovalCode, DATABASE::"Budget Approval Header", BudgetCancelApprovalTxt, 0, FALSE);
        //Proposed Budget
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendProposedBudgetForApprovalCode, DATABASE::"G/L Budget Name", ProposedBudgetSendApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelProposedBudgetForApprovalCode, DATABASE::"G/L Budget Name", ProposedBudgetCancelApprovalTxt, 0, FALSE);
        //Bank Rec
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendBankRecForApprovalCode, DATABASE::"Bank Acc. Reconciliation", BankRecSendApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelBankRecForApprovalCode, DATABASE::"Bank Acc. Reconciliation", BankRecCancelApprovalTxt, 0, FALSE);
        //Leave Adj
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLeaveAdjForApprovalCode, DATABASE::"Leave Bal Adjustment Header", LeaveAdjSendApprovalTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLeaveAdjForApprovalCode, DATABASE::"Leave Bal Adjustment Header", LeaveAdjCancelApprovalTxt, 0, FALSE);
        //Tender Evaluation
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTenderEvalForApprovalCode, DATABASE::"Tender Evaluation Header", TenderEvalSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTenderEvalApprovalRequestCode, DATABASE::"Tender Evaluation Header", TenderEvalApprReqCancelledEventDescTxt, 0, FALSE);
        //Supplier Evaluation
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendSupplierEvalForApprovalCode, DATABASE::"Supplier Evaluation Header", SupplierEvalSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelSupplierEvalApprovalRequestCode, DATABASE::"Supplier Evaluation Header", SupplierEvalApprReqCancelledEventDescTxt, 0, FALSE);
        //FA Disposal
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendFADisposalForApprovalCode, DATABASE::"FA Disposal", FADisposalSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelFADisposalApprovalRequestCode, DATABASE::"FA Disposal", FADisposalApprReqCancelledEventDescTxt, 0, FALSE);
        //Audit
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendAuditForApprovalCode, DATABASE::"Audit Header", AuditSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelAuditApprovalRequestCode, DATABASE::"Audit Header", AuditApprReqCancelledEventDescTxt, 0, FALSE);
        //ResearchActivity
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendResearchActivityForApprovalCode, DATABASE::"Research Activity Plan", ResearchActivitySendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelResearchActivityApprovalRequestCode, DATABASE::"Research Activity Plan", ResearchActivityApprReqCancelledEventDescTxt, 0, FALSE);
        //PartnershipActivity
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendPartnershipActivityForApprovalCode, DATABASE::"Partnerships Activity Plan", PartnershipActivitySendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelPartnershipActivityApprovalRequestCode, DATABASE::"Partnerships Activity Plan", PartnershipActivityApprReqCancelledEventDescTxt, 0, FALSE);
        //ResearchSurvey Workplan
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendResearchSurveyForApprovalCode, DATABASE::"Research and survey Workplan", SurveyctivitySendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelResearchSurveyApprovalRequestCode, DATABASE::"Research and survey Workplan", SurveychActivityApprReqCancelledEventDescTxt, 0, FALSE);
        //ItemJnl
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendItemJournalForApprovalCode, DATABASE::"Item Journal Batch", ItemJournalSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelItemJournalApprovalRequestCode, DATABASE::"Item Journal Batch", ItemJournalCancelledEventDescTxt, 0, FALSE);
        //ItemJnlLine
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendItemJournalLineForApprovalCode, DATABASE::"Item Journal Line", ItemJournalLineSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelItemJournalLineApprovalRequestCode, DATABASE::"Item Journal Line", ItemJournalLineCancelledEventDescTxt, 0, FALSE);
        //LabSchedule
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLabScheduleForApprovalCode, DATABASE::"Lab Annual Testing Schedule", LabScheduleSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLabScheduleApprovalRequestCode, DATABASE::"Lab Annual Testing Schedule", LabScheduleCancelledEventDescTxt, 0, FALSE);
        //AssetDisposal
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendAssetDisposalForApprovalCode, DATABASE::"AnnualDisposal Header", AssetDisposalSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelAssetDisposalApprovalRequestCode, DATABASE::"AnnualDisposal Header", AssetDisposalCancelledEventDescTxt, 0, FALSE);
        //LicenseRegistration
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLicenseRegistrationForApprovalCode, DATABASE::"Licensing dairy Enterprise", LicenseRegistrationSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode, DATABASE::"Licensing dairy Enterprise", LicenseRegistrationCancelledApprovalEventDescTxt, 0, FALSE);
        // LicenseApplication
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLicenseApplicationForApprovalCode, DATABASE::"License Applications", LicenseApplicationSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLicenseApplicationApprovalRequestCode, DATABASE::"License Applications", LicenseApplicationCancelledApprovalEventDescTxt, 0, FALSE);
        //ICTWorkplan
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendICTWorkplanForApprovalCode, DATABASE::"ICT Workplan", ICTWorkplanSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelICTWorkplanApprovalRequestCode, DATABASE::"ICT Workplan", ICTWorkplanCancelledApprovalEventDescTxt, 0, FALSE);
        //UserIncidences
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendUserIncidencesForApprovalCode, DATABASE::"User Support Incident", UserIncidencesSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelUserIncidencesApprovalRequestCode, DATABASE::"User Support Incident", UserIncidencesCancelledApprovalEventDescTxt, 0, FALSE);
        //TransportIncident
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTransportIncidentForApprovalCode, DATABASE::"Transport Incident", TransportIncidentSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTransportIncidentApprovalRequestCode, DATABASE::"Transport Incident", TransportIncidentCancelledApprovalEventDescTxt, 0, FALSE);
        //RiskHeader
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendRiskHeaderForApprovalCode, DATABASE::"Risk Header", RiskHeaderSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelRiskHeaderApprovalRequestCode, DATABASE::"Risk Header", RiskHeaderCancelledApprovalEventDescTxt, 0, FALSE);
        //DriverLogging
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendDriverLoggingForApprovalCode, DATABASE::"Driver Logging", DriverLoggingSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelDriverLoggingApprovalRequestCode, DATABASE::"Driver Logging", DriverLoggingCancelledApprovalEventDescTxt, 0, FALSE);
        //WorkProgramme
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendWorkProgrammeForApprovalCode, DATABASE::"Activity Work Programme", WorkProgrammeSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelWorkProgrammeApprovalRequestCode, DATABASE::"Activity Work Programme", WorkProgrammeCancelledApprovalEventDescTxt, 0, FALSE);
        //ProjectManagement
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnsendprojectReqForApprovalcode, DATABASE::projectman, ProjectManagementSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelProjectReqForApprovalCode, DATABASE::projectman, ProjectManagementCancelledApprovalEventDescTxt, 0, FALSE);
        //Contract Management
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnsendContractReqForApprovalcode, DATABASE::"Project Header", ContractProjectManagementSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelContractReqForApprovalCode, DATABASE::"Project Header", ContractProjectManagementCancelledApprovalEventDescTxt, 0, FALSE);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of //Payments
        RunWorkflowOnCancelPaymentsApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelPaymentsApprovalRequestCode, RunWorkflowOnSendPaymentsForApprovalCode);
        //Requisitions
        RunWorkflowOnCancelReqForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelReqForApprovalCode, RunWorkflowOnSendReqForApprovalCode);
        //Leave Application
        RunworkflowOnCancelLeaveApplicationApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveApplicationApprovalRequestCode, RunworkflowOnSendLeaveApplicationforApprovalCode);
        //Tender Committee
        RunworkflowOnCancelTenderCommitteeApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTenderCommitteeApprovalRequestCode, RunworkflowOnSendTenderCommitteeforApprovalCode);
        //Procurement Request
        RunworkflowOnCancelProcReqApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelProcReqApprovalRequestCode, RunworkflowOnSendProcReqforApprovalCode);
        //Contract Change
        RunworkflowOnCancelContChangeApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelContChangeApprovalRequestCode, RunworkflowOnSendContChangeforApprovalCode);
        //Procurement Method
        RunWorkflowOnCancelProcMethodApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelProcMethodApprovalRequestCode, RunWorkflowOnSendProcMethodForApprovalCode);
        //Sample analysis 
        RunworkflowOnCancelSampleApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelSampleApprovalRequestCode, RunworkflowOnSendSampleforApprovalCode);
        //AssetTrans
        RunworkflowOnCancelAssetTransApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAssetTransApprovalRequestCode, RunworkflowOnSendAssetTransforApprovalCode);
        //AssetAllocation
        RunworkflowOnCancelAssetAllocationApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAssetAllocationApprovalRequestCode, RunworkflowOnSendAssetAllocationforApprovalCode);
        //Recruitment
        RunworkflowOnCancelRecruitmentRequestApprovalCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelRecruitmentRequestApprovalCode, RunworkflowOnSendRecruitmentRequestforApprovalCode);
        //Prospective Suppliers:
        RunworkflowOnCancelprospectivesupplierRequestApprovalCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelprospectivesupplierRequestApprovalCode, RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
        //Training Request
        RunworkflowOnCancelTrainingRequestApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTrainingRequestApprovalRequestCode, RunworkflowOnSendTrainingRequestforApprovalCode);
        //Transport Requests
        RunWorkflowOnCancelTransportApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelTransportApprovalRequestCode, RunWorkflowOnSendTransportForApprovalCode);
        //  //Employee Appraisal
        //  RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode:
        //    WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode,RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode);
        //Leave Recall
        RunworkflowOnCancelLeaveRecallApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveRecallApprovalRequestCode, RunworkflowOnSendLeaveRecallRequestforApprovalCode);
        //Payroll Change
        RunworkflowOnCancelPayrollChangeApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollChangeApprovalRequestCode, RunworkflowOnSendPayrollChangeRequestforApprovalCode);
        //Loan Application
        RunworkflowOnCancelLoanApplicationApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLoanApplicationApprovalRequestCode, RunworkflowOnSendLoanApplicationforApprovalCode);
        //Emp acting and Promotion
        RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode, RunWorkflowOnSendEmpActingPromotionForApprovalCode);
        //Budget
        RunWorkflowOnSendBudgetRequestForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelBudgetRequestForApprovalCode, RunWorkflowOnSendBudgetRequestForApprovalCode);
        //Proposed Budget
        RunWorkflowOnSendProposedBudgetForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelProposedBudgetForApprovalCode, RunWorkflowOnSendProposedBudgetForApprovalCode);
        //Bank Rec
        RunWorkflowOnSendBankRecForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelBankRecForApprovalCode, RunWorkflowOnSendBankRecForApprovalCode);
        //Leave Adj
        RunWorkflowOnSendLeaveAdjForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelLeaveAdjForApprovalCode, RunWorkflowOnSendLeaveAdjForApprovalCode);
        //New Emp Appraisal
        RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode, RunworkflowOnSendNewEmpAppraisalforApprovalCode);
        //Tender Evaluation
        RunworkflowOnCancelTenderEvalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTenderEvalApprovalRequestCode, RunworkflowOnSendTenderEvalforApprovalCode);
        //Supplier Evaluation
        RunworkflowOnCancelSupplierEvalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelSupplierEvalApprovalRequestCode, RunworkflowOnSendSupplierEvalforApprovalCode);
        //FA disposal
        RunworkflowOnCancelFADisposalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelFADisposalApprovalRequestCode, RunworkflowOnSendFADisposalforApprovalCode);
        //Employee Transfer
        RunworkflowOnCancelEmployeeTransferApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelEmployeeTransferApprovalRequestCode, RunWorkflowOnSendEmployeeTransferRequestForApprovalCode());
        //Audit
        RunworkflowOnCancelAuditApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAuditApprovalRequestCode, RunworkflowOnSendAuditforApprovalCode);
        //Research Activity
        RunworkflowOnCancelResearchActivityApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelResearchActivityApprovalRequestCode, RunworkflowOnSendResearchActivityforApprovalCode);
        //PartnershipActivity
        RunworkflowOnCancelPartnershipActivityApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPartnershipActivityApprovalRequestCode, RunworkflowOnSendPartnershipActivityforApprovalCode);
        //ResearchSurvey Workplan
        RunworkflowOnCancelResearchSurveyApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelResearchSurveyApprovalRequestCode, RunworkflowOnSendResearchSurveyforApprovalCode);
        //ItemJournal
        RunWorkflowOnCancelItemJournalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelItemJournalApprovalRequestCode, RunworkflowOnSendItemJournalforApprovalCode);
        //ItemJournalLine
        RunWorkflowOnCancelItemJournalLineApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelItemJournalLineApprovalRequestCode, RunworkflowOnSendItemJournalLineforApprovalCode);
        //LabSchedule
        RunWorkflowOnCancelLabScheduleApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLabScheduleApprovalRequestCode, RunworkflowOnSendLabScheduleforApprovalCode);
        //AssetDisposal
        RunWorkflowOnCancelAssetDisposalApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAssetDisposalApprovalRequestCode, RunworkflowOnSendAssetDisposalforApprovalCode);
        //LicenseRegistration
        RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLicenseRegistrationApprovalRequestCode, RunworkflowOnSendLicenseRegistrationforApprovalCode);
        //LicenseApplication
        RunWorkflowOnCancelLicenseApplicationApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLicenseApplicationApprovalRequestCode, RunworkflowOnSendLicenseApplicationforApprovalCode);
        //ICTWorkplan
        RunWorkflowOnCancelICTWorkplanApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelICTWorkplanApprovalRequestCode, RunworkflowOnSendICTWorkplanforApprovalCode);
        //UserIncidences
        RunWorkflowOnCancelUserIncidencesApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelUserIncidencesApprovalRequestCode, RunworkflowOnSendUserIncidencesforApprovalCode);
        //TransportIncident
        RunWorkflowOnCancelTransportIncidentApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTransportIncidentApprovalRequestCode, RunworkflowOnSendTransportIncidentforApprovalCode);
        //RiskHeader
        RunWorkflowOnCancelRiskHeaderApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelRiskHeaderApprovalRequestCode, RunworkflowOnSendRiskHeaderforApprovalCode);
        //DriverLogging
        RunWorkflowOnCancelDriverLoggingApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelDriverLoggingApprovalRequestCode, RunworkflowOnSendDriverLoggingforApprovalCode);
        //WorkProgramme
        RunWorkflowOnCancelWorkProgrammeApprovalRequestCode: WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelWorkProgrammeApprovalRequestCode, RunworkflowOnSendWorkProgrammeforApprovalCode);
        //ProjectMan
        RunWorkflowOnCancelProjectReqForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelProjectReqForApprovalCode, RunWorkflowOnsendprojectReqForApprovalcode);
        //Contract Management
        RunWorkflowOnCancelContractReqForApprovalCode: WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelContractReqForApprovalCode, RunWorkflowOnsendContractReqForApprovalcode);
        WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode: begin
            //Payments
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentsForApprovalCode);
            //Requisitions
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendReqforApprovalCode);
            //Leave Application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLeaveApplicationforApprovalCode);
            //Tender committee
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendContChangeforApprovalCode);
            //Procurement method
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendProcMethodForApprovalCode);
            //Asset transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendAssetTransforApprovalCode);
            //Asset Allocation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendAssetAllocationforApprovalCode);
            //Sample
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendSampleforApprovalCode);
            //Recruitment
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //Prospective Suppliers
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Training Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTransportForApprovalCode);
            //Leave Recall
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Payroll Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendPayrollChangeRequestforApprovalCode);
            //Loan application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLoanApplicationforApprovalCode);
            //Emp acting and Promotion
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New Emp Appraisal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            //Tender Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendFADisposalforApprovalCode);
            //Employee Transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEmployeeTransferRequestForApprovalCode());
            //Audit
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLabScheduleforApprovalCode);
            //AssetDisposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendAssetDisposalforApprovalCode);
            //LicenseRegistration
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLicenseRegistrationforApprovalCode);
            //LicenseApplication
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendLicenseApplicationforApprovalCode);
            //ICTWorkplan
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendICTWorkplanforApprovalCode);
            //UserIncidences
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendUserIncidencesforApprovalCode);
            //TransportIncident
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendTransportIncidentforApprovalCode);
            //RiskHeader
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendRiskHeaderforApprovalCode);
            //DriverLogging
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendDriverLoggingforApprovalCode);
            //WorkProgramme
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendWorkProgrammeforApprovalCode);
            //ProjectManagement
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendProjectreqforApprovalCode);
            //Contract Management
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendcontractreqforApprovalCode);
        end;
        WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode: begin
            //Payments
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentsForApprovalCode);
            //Requisitions
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendReqforApprovalCode);
            //Leave Application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLeaveApplicationforApprovalCode);
            //Tender committee
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendContChangeforApprovalCode);
            //Proc method
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendProcMethodForApprovalCode);
            //Sample
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendSampleforApprovalCode);
            //Asset Transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendAssetTransforApprovalCode);
            //Asset Allocation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendAssetAllocationforApprovalCode);
            //Recruitment
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //Prospective Supplier
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Training Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTransportForApprovalCode);
            //Leave Recall
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Payroll Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendPayrollChangeRequestforApprovalCode);
            //Loan Application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLoanApplicationforApprovalCode);
            //Emp acting and Promotion
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New Emp Appraisal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            //Tender Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendSupplierEvalforApprovalCode);
            //Employee Transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendEmployeeTransferRequestForApprovalCode());
            //Audit
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLabScheduleforApprovalCode);
            //AssetDisposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendAssetDisposalforApprovalCode);
            //LicenseRegistration
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLicenseRegistrationforApprovalCode);
            //LicenseApplication
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendLicenseApplicationforApprovalCode);
            //ICTWorkplan
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendICTWorkplanforApprovalCode);
            //UserIncidences
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendUserIncidencesforApprovalCode);
            //TransportIncident
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendTransportIncidentforApprovalCode);
            //RiskHeader
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendRiskHeaderforApprovalCode);
            //DriverLogging
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendDriverLoggingforApprovalCode);
            //WorkProgramme
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode, RunworkflowOnSendWorkProgrammeforApprovalCode);
            //ProjectManagement
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendProjectreqforApprovalCode);
            //ContractManagement
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendContractreqforApprovalCode);
        end;
        WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode: begin
            //Payments
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentsForApprovalCode);
            //Requisitions
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendReqforApprovalCode);
            //Leave Application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendLeaveApplicationforApprovalCode);
            //Tender committee
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendTenderCommitteeforApprovalCode);
            //Procurement Change Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendProcReqforApprovalCode);
            //Contract Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendContChangeforApprovalCode);
            //Proc method
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendProcMethodForApprovalCode);
            //Sample
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendSampleforApprovalCode);
            //Asset 
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendAssetAllocationforApprovalCode);
            //Asset transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendAssetTransforApprovalCode);
            //Recruitment
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendRecruitmentRequestforApprovalCode);
            //Prospective Suppliers:
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendProspectiveSupplierRequestforApprovalCode);
            //Training Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendTrainingRequestforApprovalCode);
            //Transport Request
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTransportForApprovalCode);
            //Leave Recall
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendLeaveRecallRequestforApprovalCode);
            //Payroll Change
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendPayrollChangeRequestforApprovalCode);
            //Loan Application
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendLoanApplicationforApprovalCode);
            //Emp acting and Promotion
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendEmpActingPromotionForApprovalCode);
            //Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBudgetRequestForApprovalCode);
            //Proposed Budget
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendProposedBudgetForApprovalCode);
            //Bank Rec
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBankRecForApprovalCode);
            //Leave Adj
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveAdjForApprovalCode);
            //New Emp Appraisal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendNewEmpAppraisalforApprovalCode);
            //Tender Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendTenderEvalforApprovalCode);
            //Supplier Evaluation
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendSupplierEvalforApprovalCode);
            //FA Disposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendFADisposalforApprovalCode);
            //Employee Transfer
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendEmployeeTransferRequestForApprovalCode());
            //Audit
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendAuditforApprovalCode);
            //ResearchActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendResearchActivityforApprovalCode);
            //PartnershipActivity
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendPartnershipActivityforApprovalCode);
            //ResearchSurvey
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendResearchSurveyforApprovalCode);
            //ItemJournal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendItemJournalforApprovalCode);
            //ItemJournalLine
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendItemJournalLineforApprovalCode);
            //LabSchedule
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunworkflowOnSendLabScheduleforApprovalCode);
            //AssetDisposal
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendAssetDisposalForApprovalCode);
            //LicenseRegistration
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLicenseRegistrationForApprovalCode);
            //LicenseApplication
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLicenseApplicationForApprovalCode);
            //ICTWorkplan
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendICTWorkplanForApprovalCode);
            //UserIncidences
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendUserIncidencesForApprovalCode);
            //TransportIncident
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTransportIncidentForApprovalCode);
            //RiskHeader
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendRiskHeaderForApprovalCode);
            //DriverLogging
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendDriverLoggingForApprovalCode);
            //WorkProgramme
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendWorkProgrammeForApprovalCode);
            //ProjectManagement
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendProjectreqforApprovalCode);
            //ProjectManagement
            WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode, RunworkflowOnSendContractreqforApprovalCode);
        end;
        end;
    end;
    procedure RunWorkflowOnSendPaymentsForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendPaymentsForApproval'));
    end;
    procedure RunWorkflowOnCancelPaymentsApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelPaymentsApprovalRequest'));
    end;
    procedure RunWorkflowOnAfterReleasePaymentsCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleasePayments'));
    end;
    procedure RunWorkflowOnRejectPaymentsCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterRejectPayments'));
    end;
    procedure RunWorkflowOnSendInvestReqForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendInvestReqForApproval'));
    end;
    procedure RunWorkflowOnCancelInvestReqApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelInvestReqApprovalRequest'));
    end;
    procedure RunWorkflowOnAfterReleaseInvestReqCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseInvestReq'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendPaymentsForApproval', '', false, false)]
    procedure RunWorkflowOnSendPaymentsForApproval(VAR Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentsForApprovalCode, Payments);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelPaymentsApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPaymentsApprovalRequest(VAR Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentsApprovalRequestCode, Payments);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Payments", 'OnAfterReleasePayments', '', false, false)]
    procedure RunWorkflowOnAfterReleasePaymentsDoc(VAR Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleasePaymentsCode, Payments);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPayments(VAR ApprovalEntry: Record "Approval Entry")
    var
        PaymentsRec: Record Payments;
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPaymentsCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        PaymentsRec.RESET;
        PaymentsRec.SETRANGE("No.", ApprovalEntry."Document No.");
        IF PaymentsRec.FINDFIRST THEN BEGIN
            PaymentsRec.Status:=PaymentsRec.Status::Open;
            PaymentsRec.MODIFY(TRUE);
        END;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTransportApprovalRequest', '', false, false)]
    procedure RunWorkflowOnSendTransportForApproval(VAR TransportReq: Record "Travel Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportForApprovalCode, TransportReq);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTransportApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTransportApprovalRequest(VAR TransportReq: Record "Travel Requests")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportApprovalRequestCode, TransportReq);
    end;
    procedure RunWorkflowOnSendTransportForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendTransportForApproval'));
    end;
    procedure RunWorkflowOnCancelTransportApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelTransportApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLeaveRequestApproval', '', false, false)]
    procedure RunworkflowOnSendLeaveApplicationforApproval(VAR LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveApplicationforApprovalCode, LeaveRequest);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLeaveRequestApproval', '', false, false)]
    procedure RunworkflowOnCancelLeaveApplicationApprovalRequest(VAR LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveApplicationApprovalRequestCode, LeaveRequest);
    end;
    procedure RunworkflowOnSendLeaveApplicationforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendLeaveApplicationforApproval'));
    end;
    procedure RunworkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelLeaveApplicationApprovalRequest'));
    end;
    //Tender Committee
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTenderCommitteeRequestApproval', '', false, false)]
    procedure RunworkflowOnSendTenderCommitteeforApproval(VAR TenderCommittee: Record "Tender Committees")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendTenderCommitteeforApprovalCode, TenderCommittee);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTenderCommitteeApproval', '', false, false)]
    procedure RunworkflowOnCancelTenderCommitteeApprovalRequest(VAR TenderCommittee: Record "Tender Committees")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelTenderCommitteeApprovalRequestCode, TenderCommittee);
    end;
    procedure RunworkflowOnSendTenderCommitteeforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendTenderCommitteeforApproval'));
    end;
    procedure RunworkflowOnCancelTenderCommitteeApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelTenderCommitteeApprovalRequest'));
    end;
    //Procurement Change Request
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendProcReqRequestApproval', '', false, false)]
    procedure RunworkflowOnSendProcReqforApproval(VAR ProcReq: Record "Procurement Change Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendProcReqforApprovalCode, ProcReq);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelProcReqApproval', '', false, false)]
    procedure RunworkflowOnCancelProcReqApprovalRequest(VAR ProcReq: Record "Procurement Change Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelProcReqApprovalRequestCode, ProcReq);
    end;
    procedure RunworkflowOnSendProcReqforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendProcReqforApproval'));
    end;
    procedure RunworkflowOnCancelProcReqApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelProcReqApprovalRequest'));
    end;
    //Contract Change START
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendContChangeRequestApproval', '', false, false)]
    procedure RunworkflowOnSendContChangeforApproval(VAR ContChange: Record "Contract Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendContChangeforApprovalCode, ContChange);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelContChangeApproval', '', false, false)]
    procedure RunworkflowOnCancelContChangeApprovalRequest(VAR ContChange: Record "Contract Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelContChangeApprovalRequestCode, ContChange);
    end;
    procedure RunworkflowOnSendContChangeforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendContChangeforApproval'));
    end;
    procedure RunworkflowOnCancelContChangeApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelContChangeApprovalRequest'));
    end;
    //Contract Change END
    //Sample
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendSampleRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendSampleforApproval(VAR Sample: Record "Sample Analysis And Reporting")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendSampleforApprovalCode, Sample);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelSampleApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelSampleApprovalRequest(VAR Sample: Record "Sample Analysis And Reporting")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelSampleApprovalRequestCode, Sample);
    end;
    procedure RunworkflowOnSendSampleforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendSampleforApproval'));
    end;
    procedure RunworkflowOnCancelSampleApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelSampleApprovalRequest'));
    end;
    //Asset Transfer
    procedure RunworkflowOnSendAssetTransforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendAssetTransforApproval'));
    end;
    procedure RunworkflowOnCancelAssetTransApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelAssetTransApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendAssetTransApproval', '', false, false)]
    procedure RunworkflowOnSendAssetTransforApproval(VAR AssetTrans: Record "Asset Allocation and Transfer")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendAssetTransforApprovalCode, AssetTrans);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelAssetTransApproval', '', false, false)]
    procedure RunworkflowOnCancelAssetTransApprovalRequest(VAR AssetTrans: Record "Asset Allocation and Transfer")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelAssetTransApprovalRequestCode, AssetTrans);
    end;
    //Asset allocation
    procedure RunworkflowOnSendAssetAllocationforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendAssetAllocationforApproval'));
    end;
    procedure RunworkflowOnCancelAssetAllocationApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelAssetAllocationApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendAssetAllocationApproval', '', false, false)]
    procedure RunworkflowOnSendAssetAllocationforApproval(VAR AssetAllocation: Record "Asset Allocation and Transfer")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendAssetAllocationforApprovalCode, AssetAllocation);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelAssetAllocationApproval', '', false, false)]
    procedure RunworkflowOnCancelAssetAllocationApprovalRequest(VAR AssetAllocation: Record "Asset Allocation and Transfer")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelAssetAllocationApprovalRequestCode, AssetAllocation);
    end;
    //Procurement Request
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendProcMethodApprovalRequest', '', false, false)]
    procedure RunWorkflowOnSendProcMethodForApproval(VAR ProcMethod: Record "Procurement Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProcMethodForApprovalCode, ProcMethod);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelProcMethodApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelProcMethodApprovalRequest(VAR ProcMethod: Record "Procurement Request")
    var
        ProRequest: Record "Procurement Request";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcMethodApprovalRequestCode, ProcMethod);
    end;
    procedure RunWorkflowOnSendProcMethodForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendProcMethodForApproval'));
    end;
    procedure RunWorkflowOnCancelProcMethodApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelProcMethodApprovalRequest'));
    end;
    //Recruitment request
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendRecruitmentApprovalRequest', '', false, false)]
    procedure RunworkflowOnSendRecruitmentRequestforApproval(VAR RecruitmentRequest: Record "Recruitment Needs")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendRecruitmentRequestforApprovalCode, RecruitmentRequest);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelRecruitmentApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelRecruitmentRequestApproval(VAR RecruitmentRequest: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelRecruitmentRequestApprovalCode, RecruitmentRequest);
        Recruitment.RESET;
        Recruitment.SETRANGE("No.", RecruitmentRequest."No.");
        IF Recruitment.FINDFIRST THEN BEGIN
            Recruitment.Status:=Recruitment.Status::Open;
            Recruitment.MODIFY(TRUE);
        END;
    end;
    procedure RunworkflowOnSendRecruitmentRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendRecruitmentRequestforApprovalCode'));
    end;
    procedure RunworkflowOnCancelRecruitmentRequestApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelRecruitmentRequestApprovalCode'));
    end;
    //Prospective Supplier
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendProspectiveSuppliersApprovalRequest', '', false, false)]
    procedure RunworkflowOnSendProspectiveSupplierRequestforApproval(VAR ProspectiveSupplier: Record "Prospective Suppliers")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendProspectiveSupplierRequestforApprovalCode, ProspectiveSupplier);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelProspectiveSuppliersApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelprospectivesupplierRequestApproval(VAR ProspectiveSupplier: Record "Prospective Suppliers")
    var
        ProspectiveSupp: Record "Prospective Suppliers";
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelprospectivesupplierRequestApprovalCode, ProspectiveSupplier);
        ProspectiveSupp.RESET;
        ProspectiveSupp.SETRANGE("No.", ProspectiveSupplier."No.");
        IF ProspectiveSupp.FINDFIRST THEN BEGIN
            ProspectiveSupp.Status:=ProspectiveSupp.Status::Open;
            ProspectiveSupp.MODIFY(TRUE);
        END;
    end;
    procedure RunworkflowOnSendProspectiveSupplierRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendProspectiveSupplierRequestforApprovalCode'));
    end;
    procedure RunworkflowOnCancelprospectivesupplierRequestApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelprospectivesupplierRequestApprovalCode'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTrainingRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendTrainingRequestforApproval(VAR TrainingReq: Record "Training Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendTrainingRequestforApprovalCode, TrainingReq);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTrainingRequestApproval', '', false, false)]
    procedure RunworkflowOnCancelTrainingRequestApprovalRequest(VAR TrainingReq: Record "Training Request")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelTrainingRequestApprovalRequestCode, TrainingReq);
    end;
    procedure RunworkflowOnSendTrainingRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendTrainingRequestforApproval'));
    end;
    procedure RunworkflowOnCancelTrainingRequestApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelTrainingRequestApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendEmployeeAppraisalRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendEmployeeAppraisalRequestforApproval(VAR EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode, EmployeeAppraisal);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelEmployeeAppraisalApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelEmployeeAppraisalApprovalRequest(VAR EmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode, EmployeeAppraisal);
    end;
    procedure RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendEmployeeAppraisalRequestforApproval'));
    end;
    procedure RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelEmployeeAppraisalApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLeaveRecallRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendLeaveRecallRequestforApproval(VAR LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveRecallRequestforApprovalCode, LeaveRecall);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLeaveRecallApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelLeaveRecallApprovalRequest(VAR LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveRecallApprovalRequestCode, LeaveRecall);
    end;
    procedure RunworkflowOnSendLeaveRecallRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendLeaveRecallRequestforApproval'));
    end;
    procedure RunworkflowOnCancelLeaveRecallApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelLeaveRecallApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendPayrollChangeforApproval', '', false, false)]
    procedure RunworkflowOnSendPayrollChangeRequestforApproval(VAR "Payroll Change": Record "Payroll Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendPayrollChangeRequestforApprovalCode, "Payroll Change");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelPayrollChangeApproval', '', false, false)]
    procedure RunworkflowOnCancelPayrollChangeApprovalRequest(VAR "Payroll Change": Record "Payroll Change Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelPayrollChangeApprovalRequestCode, "Payroll Change");
    end;
    procedure RunworkflowOnSendPayrollChangeRequestforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendPayrollChangeRequestforApproval'));
    end;
    procedure RunworkflowOnCancelPayrollChangeApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelPayrollChangeApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLoanApplicationRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendLoanApplicationforApproval(VAR LoanApplication: Record "Loan Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLoanApplicationforApprovalCode, LoanApplication);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLoanApplicationRequestApproval', '', false, false)]
    procedure RunworkflowOnCancelLoanApplicationApprovalRequest(VAR LoanApplication: Record "Loan Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLoanApplicationApprovalRequestCode, LoanApplication);
    end;
    procedure RunworkflowOnSendLoanApplicationforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnSendLoanApplicationforApproval'));
    end;
    procedure RunworkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunworkflowOnCancelLoanApplicationApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendEmpActingAndPromotionRequestForApproval', '', false, false)]
    procedure RunWorkflowOnSendEmpActingPromotionForApproval(VAR EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpActingPromotionForApprovalCode, EmpActing);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelEmpActingAndPromotionRequestApproval', '', false, false)]
    procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequest(VAR EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode, EmpActing);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectEmpActingPromotionApprovalRequest(VAR ApprovalEntry: Record "Approval Entry")
    var
        EmpActing: Record "Employee Acting Position";
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectEmpActingPromotionCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        EmpActing.RESET;
        EmpActing.SETRANGE(No, ApprovalEntry."Document No.");
        IF EmpActing.FIND('-')THEN BEGIN
            EmpActing.Status:=EmpActing.Status::Rejected;
            EmpActing.MODIFY;
        END;
    end;
    //Payroll Approval 
    procedure RunWorkflowOnSendPayrollApprovalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendPayrollApprovalForApproval'));
    end;
    procedure RunWorkflowOnCancelPayrollApprovalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelPayrollApprovalApprovalRequest'));
    end;
    procedure RunWorkflowOnAfterReleasePayrollApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleasePayrollApproval'));
    end;
    procedure RunWorkflowOnRejectPayrollApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterRejectPayrollApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendPayrollApprovalForApproval', '', false, false)]
    procedure RunWorkflowOnSendPayrollApprovalForApproval(VAR PayrollApproval: Record "Payroll Approval")
    var
        PayrollRec: Record "Payroll Approval";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollApprovalForApprovalCode, PayrollApproval);
        //Mark Period as Closed
        PayrollApproval.TestField("Payroll Period");
        if PayrollApproval."Payroll Type" = PayrollApproval."Payroll Type"::Pension then begin
            PayrollRec.Get(PayrollApproval."Payroll Period");
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelPayrollApprovalApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPayrollApprovalApprovalRequest(VAR PayrollApproval: Record "Payroll Approval")
    var
        PayrollRec: Record "Payroll Approval";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollApprovalApprovalRequestCode(), PayrollApproval);
        PayrollRec.Reset();
        PayrollRec.SetRange("No.", PayrollApproval."No.");
        if PayrollRec.FindFirst()then begin
            PayrollRec.Status:=PayrollRec.Status::Open;
            PayrollRec.Modify();
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPayrollApproval(VAR ApprovalEntry: Record "Approval Entry")
    var
        PayrollApproval: Record "Payroll Approval";
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPayrollApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        PayrollApproval.RESET;
        PayrollApproval.SETRANGE("No.", ApprovalEntry."Document No.");
        IF PayrollApproval.FINDFIRST THEN BEGIN
            PayrollApproval.Status:=PayrollApproval.Status::Open;
            PayrollApproval.MODIFY(TRUE);
        END;
    end;
    procedure RunWorkflowOnSendEmpActingPromotionForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendEmpActingPromotionForApproval'));
    end;
    procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelEmpActingPromotionApprovalRequest'));
    end;
    procedure RunWorkflowOnRejectEmpActingPromotionCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnRejectEmpActingPromotionApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendBudgetApproval', '', false, false)]
    procedure RunWorkflowOnSendBudgetRequestForApproval(VAR Budget: Record "Budget Approval Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBudgetRequestForApprovalCode, Budget);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelBudgetApproval', '', false, false)]
    procedure RunWorkflowOnCancelBudgetRequestForApproval(VAR Budget: Record "Budget Approval Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBudgetRequestForApprovalCode, Budget);
    end;
    procedure RunWorkflowOnSendBudgetRequestForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendBudgetRequestForApproval'));
    end;
    procedure RunWorkflowOnCancelBudgetRequestForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelBudgetRequestForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendProposedBudgetApproval', '', false, false)]
    procedure RunWorkflowOnSendProposedBudgetForApproval(VAR ProposedBudget: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProposedBudgetForApprovalCode, ProposedBudget);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelProposedBudgetApproval', '', false, false)]
    procedure RunWorkflowOnCancelProposedBudgetForApproval(VAR ProposedBudget: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProposedBudgetForApprovalCode, ProposedBudget);
    end;
    procedure RunWorkflowOnSendProposedBudgetForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendProposedBudgetForApproval'));
    end;
    procedure RunWorkflowOnCancelProposedBudgetForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelProposedBudgetForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendBankRecApproval', '', false, false)]
    procedure RunWorkflowOnSendBankRecForApproval(VAR BankAccRec: Record "Bank Acc. Reconciliation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBankRecForApprovalCode, BankAccRec);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelBankRecApproval', '', false, false)]
    procedure RunWorkflowOnCanceBankRecForApproval(VAR BankAccRec: Record "Bank Acc. Reconciliation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankRecForApprovalCode, BankAccRec);
    end;
    procedure RunWorkflowOnSendBankRecForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendBankRecForApproval'));
    end;
    procedure RunWorkflowOnCancelBankRecForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCanceBankRecForApproval'));
    end;
    //Leave Adjustment Approvals
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLeaveAdjApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveAdjForApproval(VAR LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveAdjForApprovalCode, LeaveAdj);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLeaveAdjApproval', '', false, false)]
    procedure RunWorkflowOnCancelLeaveAdjForApproval(VAR LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveAdjForApprovalCode, LeaveAdj);
    end;
    procedure RunWorkflowOnSendLeaveAdjForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendLeaveAdjForApproval'));
    end;
    procedure RunWorkflowOnCancelLeaveAdjForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelLeaveAdjForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendNewEmpAppraisalRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendNewEmpAppraisalforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendNewEmpAppraisalforApprovalCode, NewEmployeeAppraisal);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelNewEmpAppraisalRequestApproval', '', false, false)]
    procedure RunworkflowOnCancelNewEmpAppraisalApprovalRequest(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode, NewEmployeeAppraisal);
    end;
    procedure RunworkflowOnSendNewEmpAppraisalforApprovalCode(): Code[128]begin
        exit(UpperCase('RunworkflowOnSendNewEmpAppraisalforApproval'));
    end;
    procedure RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunworkflowOnCancelNewEmpAppraisalApprovalRequest'));
    end;
    //Requisitions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendReqRequestforApproval', '', false, false)]
    procedure RunWorkflowOnSendReqForApproval(VAR Req: Record "Internal Request Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendReqForApprovalCode, Req);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelReqApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelReqForApproval(VAR Req: Record "Internal Request Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelReqForApprovalCode, Req);
    end;
    procedure RunWorkflowOnSendReqForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendReqForApproval'));
    end;
    procedure RunWorkflowOnCancelReqForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelReqForApproval'));
    end;
    //Tender Evaluation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTenderEvalForApproval', '', false, false)]
    procedure RunWorkflowOnSendTenderEvalForApproval(VAR TenderEval: Record "Tender Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderEvalForApprovalCode, TenderEval);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTenderEvalApprovalRequest', '', false, false)]
    procedure unWorkflowOnCancelTenderEvalApprovalRequest(VAR TenderEval: Record "Tender Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderEvalApprovalRequestCode, TenderEval);
    end;
    procedure RunWorkflowOnSendTenderEvalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendTenderEvalForApproval'));
    end;
    procedure RunWorkflowOnCancelTenderEvalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelTenderEvalApprovalRequest'));
    end;
    //TargetSetupHeader
    procedure RunWorkflowOnSendTargetSetupHeaderForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendTargetSetupHeaderForApproval'));
    end;
    procedure RunWorkflowOnCancelTargetSetupHeaderApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelTargetSetupHeaderApprovalRequest'));
    end;
    procedure RunWorkflowOnAfterReleaseTargetSetupHeaderCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseTargetSetupHeader'));
    end;
    procedure RunWorkflowOnRejectTargetSetupHeaderCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterRejectTargetSetupHeader'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTargetSetupHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendTargetSetupHeaderForApproval(VAR TargetSetupHeader: Record "Target Setup Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTargetSetupHeaderForApprovalCode, TargetSetupHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTargetSetupHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTargetSetupHeaderApprovalRequest(VAR TargetSetupHeader: Record "Target Setup Header")
    var
        TargetSetup: Record "Target Setup Header";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTargetSetupHeaderApprovalRequestCode, TargetSetupHeader);
        TargetSetup.Reset();
        TargetSetup.SetRange("Target No", TargetSetupHeader."Target No");
        if TargetSetup.FindFirst()then begin
            TargetSetup."Target Status":=TargetSetup."Target Status"::Setting;
            TargetSetup.Modify(true);
        end;
    end;
    //Supplier Evaluation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendSupplierEvalForApproval', '', false, false)]
    procedure RunWorkflowOnSendSupplierEvalForApproval(VAR Evaluation: Record "Supplier Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSupplierEvalForApprovalCode, Evaluation);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelSupplierEvalApprovalRequest', '', false, false)]
    procedure unWorkflowOnCancelSupplierEvalApprovalRequest(VAR Evaluation: Record "Supplier Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSupplierEvalApprovalRequestCode, Evaluation);
    end;
    procedure RunWorkflowOnSendSupplierEvalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendSupplierEvalForApproval'));
    end;
    procedure RunWorkflowOnCancelSupplierEvalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelSupplierEvalApprovalRequest'));
    end;
    //FA Disposal
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendFADisposalForApproval', '', false, false)]
    procedure RunWorkflowOnSendFADisposalForApproval(VAR FADisposal: Record "FA Disposal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFADisposalForApprovalCode, FADisposal);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelFADisposalApprovalRequest', '', false, false)]
    procedure unWorkflowOnCancelFADisposalApprovalRequest(VAR FADisposal: Record "FA Disposal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFADisposalApprovalRequestCode, FADisposal);
    end;
    procedure RunWorkflowOnSendFADisposalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendFADisposalForApproval'));
    end;
    procedure RunWorkflowOnCancelFADisposalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelFADisposalApprovalRequest'));
    end;
    // EMPLOYEE TRANSFER
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendEmployeeTransferRequestforApproval', '', false, false)]
    procedure RunworkflowOnSendEmployeeTransferRequestforApproval(VAR EmployeeTransfer: Record "Employee Transfers")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendEmployeeTransferRequestforApprovalCode, EmployeeTransfer);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelEmployeeTransferApprovalRequest', '', false, false)]
    procedure RunworkflowOnCancelEmployeeTransferApprovalRequest(VAR EmployeeTransfer: Record "Employee Transfers")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelEmployeeTransferApprovalRequestCode, EmployeeTransfer);
    end;
    procedure RunWorkflowOnSendEmployeeTransferRequestForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendEmployeeTransferForApprovalRequest'));
    end;
    procedure RunWorkflowOnCancelEmployeeTransferApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelEmployeeTransferApprovalRequest'));
    end;
    procedure RunWorkflowOnAfterReleaseEmployeeTransferCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseEmployeeTransfer'));
    end;
    procedure RunWorkflowOnRejectEmployeeTransferCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnAfterRejectEmployeeTransfer'));
    end;
    //Audit header
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendAuditForApproval', '', false, false)]
    procedure RunWorkflowOnSendAuditForApproval(var AuditHeader: Record "Audit Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAuditForApprovalCode, AuditHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelAuditApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelAuditApprovalRequest(var AuditHeader: Record "Audit Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAuditApprovalRequestCode, AuditHeader);
    end;
    procedure RunWorkflowOnSendAuditForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendAuditForApproval'));
    end;
    procedure RunWorkflowOnCancelAuditApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelAuditApprovalRequest'));
    end;
    //ResearchActivity
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendResearchActivityForApproval', '', false, false)]
    procedure RunWorkflowOnSendResearchActivityForApproval(VAR Activity: Record "Research Activity Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendResearchActivityForApprovalCode, Activity);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelResearchActivityApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelResearchActivityApprovalRequest(VAR Activity: Record "Research Activity Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelResearchActivityApprovalRequestCode, Activity);
    end;
    procedure RunWorkflowOnSendResearchActivityForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendResearchActivityForApproval'));
    end;
    procedure RunWorkflowOnCancelResearchActivityApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelResearchActivityApprovalRequest'));
    end;
    //PartnershipActivity
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendPartnershipActivityForApproval', '', false, false)]
    procedure RunWorkflowOnSendPartnershipActivityForApproval(VAR PActivity: Record "Partnerships Activity Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPartnershipActivityForApprovalCode, PActivity);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelPartnershipActivityApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelPartnershipActivityApprovalRequest(VAR PActivity: Record "Partnerships Activity Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPartnershipActivityApprovalRequestCode, PActivity);
    end;
    procedure RunWorkflowOnSendPartnershipActivityForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendPartnershipActivityForApproval'));
    end;
    procedure RunWorkflowOnCancelPartnershipActivityApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelPartnershipActivityApprovalRequest'));
    end;
    //ResearchSurvey Workplan
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendResearchSurveyForApproval', '', false, false)]
    procedure RunWorkflowOnSendResearchSurveyForApproval(VAR SActivity: Record "Research and survey Workplan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendResearchSurveyForApprovalCode, SActivity);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelResearchSurveyApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelResearchSurveyApprovalRequest(VAR SActivity: Record "Research and survey Workplan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelResearchSurveyApprovalRequestCode, SActivity);
    end;
    procedure RunWorkflowOnSendResearchSurveyForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendResearchSurveyForApproval'));
    end;
    procedure RunWorkflowOnCancelResearchSurveyApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelResearchSurveyApprovalRequest'));
    end;
    //ItemJournal
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendItemJournalForApproval', '', false, false)]
    procedure RunWorkflowOnSendItemJournalForApproval(VAR ItemJnl: Record "Item Journal Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendItemJournalForApprovalCode, ItemJnl);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelItemJournalApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelItemJournalApprovalRequest(VAR ItemJnl: Record "Item Journal Batch")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelItemJournalApprovalRequestCode, ItemJnl);
    end;
    procedure RunWorkflowOnSendItemJournalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendItemJournalForApproval'));
    end;
    procedure RunWorkflowOnCancelItemJournalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelItemJournalApprovalRequest'));
    end;
    //ItemJournalLine
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendItemLineForApproval', '', false, false)]
    procedure RunWorkflowOnSendItemJournalLineForApproval(VAR ItemJnlLine: Record "Item Journal Line")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendItemJournalLineForApprovalCode, ItemJnlLine);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelItemLineApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelItemJournalLineApprovalRequest(VAR ItemJnline: Record "Item Journal Line")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelItemJournalLineApprovalRequestCode, ItemJnline);
    end;
    procedure RunWorkflowOnSendItemJournalLineForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendItemJournalLineForApproval'));
    end;
    procedure RunWorkflowOnCancelItemJournalLineApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelItemJournalLineApprovalRequest'));
    end;
    //LabSchedule
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLabScheduleForApproval', '', false, false)]
    procedure RunWorkflowOnSendLabScheduleForApproval(VAR LabSchedule: Record "Lab Annual Testing Schedule")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLabScheduleForApprovalCode, LabSchedule);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLabScheduleApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelLabScheduleApprovalRequest(VAR LabSchedule: Record "Lab Annual Testing Schedule")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLabScheduleApprovalRequestCode, LabSchedule);
    end;
    procedure RunWorkflowOnSendLabScheduleForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendLabScheduleForApproval'));
    end;
    procedure RunWorkflowOnCancelLabScheduleApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelLabScheduleApprovalRequest'));
    end;
    //AssetDisposal
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendAssetDisposalForApproval', '', false, false)]
    procedure RunWorkflowOnSendAssetDisposalForApproval(VAR ADisposal: Record "AnnualDisposal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAssetDisposalForApprovalCode, ADisposal);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelAssetDisposalApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelAssetDisposalApprovalRequest(VAR ADisposal: Record "AnnualDisposal Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAssetDisposalApprovalRequestCode, ADisposal);
    end;
    procedure RunWorkflowOnSendAssetDisposalForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendAssetDisposalForApproval'));
    end;
    procedure RunWorkflowOnCancelAssetDisposalApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelAssetDisposalApprovalRequest'));
    end;
    //ApplicantRegistration
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLicenseRegistrationForApproval', '', false, false)]
    procedure RunWorkflowOnSendLicenseRegistrationForApproval(VAR LicenseRegistration: Record "Licensing dairy Enterprise")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLicenseRegistrationForApprovalCode, LicenseRegistration);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLicenseRegistrationApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelLicenseRegistrationApprovalRequest(VAR LicenseRegistration: Record "Licensing dairy Enterprise")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode, LicenseRegistration);
    end;
    procedure RunWorkflowOnSendLicenseRegistrationForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendLicenseRegistrationForApproval'));
    end;
    procedure RunWorkflowOnCancelLicenseRegistrationApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelLicenseRegistrationApprovalRequest'));
    end;
    //LicenseApplication
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendLicenseApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendLicenseApplicationForApproval(VAR LicenseApplication: Record "License Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLicenseApplicationForApprovalCode, LicenseApplication);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelLicenseApplicationApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelLicenseApplicationApprovalRequest(VAR LicenseApplication: Record "License Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLicenseApplicationApprovalRequestCode, LicenseApplication);
    end;
    procedure RunWorkflowOnSendLicenseApplicationForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendLicenseApplicationForApproval'));
    end;
    procedure RunWorkflowOnCancelLicenseApplicationApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelLicenseApplicationApprovalRequest'));
    end;
    //ICTWorkplan
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendICTWorkplanForApproval', '', false, false)]
    procedure RunWorkflowOnSendICTWorkplanForApproval(VAR ICTWorkplan: Record "ICT Workplan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendICTWorkplanForApprovalCode, ICTWorkplan);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelICTWorkplanApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelICTWorkplanApprovalRequest(VAR ICTWorkplan: Record "ICT Workplan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelICTWorkplanApprovalRequestCode, ICTWorkplan);
    end;
    procedure RunWorkflowOnSendICTWorkplanForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendICTWorkplanForApproval'));
    end;
    procedure RunWorkflowOnCancelICTWorkplanApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelICTWorkplanApprovalRequest'));
    end;
    //UserIncidences
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendUserIncidencesForApproval', '', false, false)]
    procedure RunWorkflowOnSendUserIncidencesForApproval(VAR UserIncidences: Record "User Support Incident")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendUserIncidencesForApprovalCode, UserIncidences);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelUserIncidencesApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelUserIncidencesApprovalRequest(VAR UserIncidences: Record "User Support Incident")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUserIncidencesApprovalRequestCode, UserIncidences);
    end;
    procedure RunWorkflowOnSendUserIncidencesForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendUserIncidencesForApproval'));
    end;
    procedure RunWorkflowOnCancelUserIncidencesApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelUserIncidencesApprovalRequest'));
    end;
    //RiskHeader
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendRiskHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnRiskHeaderForApproval(VAR RiskHeader: Record "Risk Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRiskHeaderForApprovalCode, RiskHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelRiskHeaderApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelRiskHeaderApprovalRequest(VAR RiskHeader: Record "Risk Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRiskHeaderApprovalRequestCode, RiskHeader);
    end;
    procedure RunWorkflowOnSendRiskHeaderForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendRiskHeaderForApproval'));
    end;
    procedure RunWorkflowOnCancelRiskHeaderApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelRiskHeaderApprovalRequest'));
    end;
    //TransportIncident
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendTransportIncidentForApproval', '', false, false)]
    procedure RunWorkflowOnTransportIncidentForApproval(VAR TransportIncident: Record "Transport Incident")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportIncidentForApprovalCode, TransportIncident);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelTransportIncidentApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelTransportIncidentApprovalRequest(VAR TransportIncident: Record "Transport Incident")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportIncidentApprovalRequestCode, TransportIncident);
    end;
    procedure RunWorkflowOnSendTransportIncidentForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendTransportIncidentForApproval'));
    end;
    procedure RunWorkflowOnCancelTransportIncidentApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelTransportIncidentApprovalRequest'));
    end;
    //DriverLogging
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendDriverLoggingForApproval', '', false, false)]
    procedure RunWorkflowOnDriverLoggingForApproval(VAR DriverLogging: Record "Driver Logging")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendDriverLoggingForApprovalCode, DriverLogging);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelDriverLoggingApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelDriverLoggingApprovalRequest(VAR DriverLogging: Record "Driver Logging")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelDriverLoggingApprovalRequestCode, DriverLogging);
    end;
    procedure RunWorkflowOnSendDriverLoggingForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendDriverLoggingForApproval'));
    end;
    procedure RunWorkflowOnCancelDriverLoggingApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelDriverLoggingApprovalRequest'));
    end;
    // Workprogramme
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnSendWorkprogrammeForApproval', '', false, false)]
    procedure RunWorkflowOnWorkprogrammeForApproval(VAR Workprogramme: Record "Activity Work Programme")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendWorkprogrammeForApprovalCode, Workprogramme);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelWorkprogrammeApprovalRequest', '', false, false)]
    procedure RunWorksflowOnCancelWorkprogrammeApprovalRequest(VAR Workprogramme: Record "Activity Work Programme")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelWorkprogrammeApprovalRequestCode, Workprogramme);
    end;
    procedure RunWorkflowOnSendWorkprogrammeForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendWorkprogrammeForApproval'));
    end;
    procedure RunWorkflowOnCancelWorkprogrammeApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorksflowOnCancelWorkprogrammeApprovalRequest'));
    end;
    //ProjectManagement
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnsendprojectReqForApproval', '', false, false)]
    procedure RunWorkflowOnsendprojectReqForApproval(VAR ProjectMan: Record "Projectman")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnsendprojectReqForApprovalcode, ProjectMan);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelProjectReqForApproval', '', false, false)]
    procedure RunWorkflowOnCancelprojectReqForApproval(VAR ProjectMan: Record ProjectMan)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelprojectReqForApprovalcode, Projectman);
    end;
    procedure RunWorkflowOnSendprojectreqforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendprojectReqForApproval'));
    end;
    procedure RunWorkflowOnCancelProjectreqforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelprojectReqForApproval'));
    end;
    //ContractManagement
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnsendContractReqForApproval', '', false, false)]
    procedure RunWorkflowOnsendContractReqForApproval(VAR ContractApproval: Record "Project Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnsendContractReqForApprovalcode, ContractApproval);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtCuExtension, 'OnCancelContractReqForApproval', '', false, false)]
    procedure RunWorkflowOnCancelContractReqForApproval(VAR ContractApproval: Record "Project Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelContractReqForApprovalcode, ContractApproval);
    end;
    procedure RunWorkflowOnSendContractreqforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendContractReqForApproval'));
    end;
    procedure RunWorkflowOnCancelContractreqforApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelContractReqForApproval'));
    end;
}
