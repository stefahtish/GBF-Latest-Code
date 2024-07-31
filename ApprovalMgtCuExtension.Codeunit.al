codeunit 50113 ApprovalMgtCuExtension
{
    var ApproverIDInserted: Boolean;
    WorkFlowManagement: Codeunit "Workflow Management";
    PendingApprovalMsg: Label 'An approval request has been sent.';
    NoApprovalsSentMsg: Label 'No approval requests have been sent, either because they are already sent or because related workflows do not support the journal line.';
    NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
    PendingApprovalForSelectedLinesMsg: Label 'Approval requests have been sent.';
    PendingApprovalForSomeSelectedLinesMsg: Label 'Approval requests have been sent.\\Requests for some journal lines were not sent, either because they are already sent or because related workflows do not support the journal line.';
    ApprovalReqCanceledForSelectedLinesMsg: Label 'The approval request for the selected record has been canceled.';
    PendingJournalBatchApprovalExistsErr: Label 'An approval request already exists.', Comment = '%1 is the Document No. of the journal line';
    WorkflowEventHandling: Codeunit WorkflowEventHandlingCUExt;
    //Mine
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequest(VAR ApprovalEntry: Record "Approval Entry")
    var
        NextApprovalEntry: Record "Approval Entry";
    begin
        IF ApprovalEntry."Approval Stage" <> '' THEN BEGIN
            IF MinimumApprovalsReached(ApprovalEntry)THEN BEGIN
                NextApprovalEntry.Reset();
                NextApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
                NextApprovalEntry.SETRANGE("Table ID", ApprovalEntry."Table ID");
                NextApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type");
                NextApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
                NextApprovalEntry.SETFILTER(Status, '%1|%2', NextApprovalEntry.Status::Created, NextApprovalEntry.Status::Open);
                //    NextApprovalEntry.SETRANGE("Approval Stage", ApprovalEntry."Approval Stage");
                NextApprovalEntry.SETRANGE("Sequence No.", ApprovalEntry."Sequence No.");
                NextApprovalEntry.SETFILTER("Entry No.", '<>%1', ApprovalEntry."Entry No.");
                IF NextApprovalEntry.FIND('-')THEN REPEAT NextApprovalEntry.VALIDATE(Status, NextApprovalEntry.Status::Approved);
                        NextApprovalEntry.MODIFY(TRUE);
                    UNTIL NextApprovalEntry.NEXT = 0;
            END;
        END;
    end;
    local procedure MinimumApprovalsReached(ApprovalEntry: Record "Approval Entry"): Boolean var
        LastApprovalEntry: Record "Approval Entry";
        NoOfApprovals: Integer;
        ApprovalStages: Record "Approval Stages1";
        MinimumApprovers: Integer;
    begin
        LastApprovalEntry.RESET;
        LastApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
        LastApprovalEntry.SETRANGE("Table ID", ApprovalEntry."Table ID");
        LastApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type");
        LastApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
        LastApprovalEntry.SETRANGE("Approval Stage", ApprovalEntry."Approval Stage");
        LastApprovalEntry.SETFILTER(Status, '=%1', LastApprovalEntry.Status::Approved);
        NoOfApprovals:=LastApprovalEntry.COUNT;
        //Get Current Approval Stage
        IF ApprovalStages.GET(ApprovalEntry."Workflow User Group Code", ApprovalEntry."Approval Stage")THEN MinimumApprovers:=ApprovalStages."Minimum Approvers";
        IF NoOfApprovals >= MinimumApprovers THEN EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
    //OnBeforeApprovalEntryInsert
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure OnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry") //; ApproverId: Code[50]; var IsHandled: Boolean)
    var
        WkFlow: Record Workflow;
        WkFlowUserGrp: Record "Workflow User Group Member";
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        ApprovalEntry.Description:=ApprovalEntryArgument.Description;
        ApprovalEntry."Workflow User Group Code":=ApprovalEntryArgument."Workflow User Group Code";
        WkFlowUserGrp.Reset();
        WkFlowUserGrp.SetRange("Workflow User Group Code", ApprovalEntryArgument."Workflow User Group Code");
        WkFlowUserGrp.SetRange("User Name", ApprovalEntry."Approver ID");
        if WkFlowUserGrp.FindFirst()then begin
            ApprovalEntry."Approval Stage":=WkFlowUserGrp."Approval Stages";
            if WkFlowUserGrp.Subtitute <> '' then begin
                ApprovalEntry."Approver ID":=WkFlowUserGrp.Subtitute;
            end;
        end;
    //Modifcation
    // IF WkFlow.GET(ApprovalEntryArgument."Approval Code") THEN;
    // IF NOT ApproverIDInserted AND WkFlow."Insert Approver ID" THEN
    //     MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument,
    //                        WkFlowUserGrp."Approval Stages", WorkflowStepArgument."Workflow User Group Code");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprReqForApprTypeSalespersPurchaser', '', false, false)]
    local procedure OnAfterCreateApprReqForApprTypeSalespersPurchaser(WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    var
        WkFlow: Record Workflow;
    begin
        //Modifcation
        IF WkFlow.GET(ApprovalEntryArgument."Approval Code")THEN;
        IF NOT ApproverIDInserted AND WkFlow."Insert Approver ID" THEN MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument, ApprovalEntryArgument."Approval Stage", ApprovalEntryArgument."Workflow User Group Code");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprReqForApprTypeApprover', '', false, false)]
    local procedure OnAfterCreateApprReqForApprTypeApprover(WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    var
        WkFlow: Record Workflow;
    begin
        //Modifcation
        IF WkFlow.GET(ApprovalEntryArgument."Approval Code")THEN;
        IF NOT ApproverIDInserted AND WkFlow."Insert Approver ID" THEN MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument, ApprovalEntryArgument."Approval Stage", ApprovalEntryArgument."Workflow User Group Code");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(VAR ApprovalEntry: Record "Approval Entry")
    var
        RejectionComments: Page "Rejection Comments";
        Comment: Text;
        Text001: Label 'Please input rejection comment.';
        Text002: Label 'Please confirm rejection comment.';
    begin
        Commit();
        IF RejectionComments.RUNMODAL = ACTION::OK THEN BEGIN
            Comment:=RejectionComments.GetRejectComment;
            IF Comment = '' THEN ERROR(Text001);
            InsertRejectionComment(Comment, ApprovalEntry);
        END;
    end;
    local procedure InsertRejectionComment(Comment: Text; ApprovalEntry: Record "Approval Entry")
    var
        CommentLine: Record "Approval Comment Line";
        LineNo: Integer;
    begin
        IF CommentLine.FINDLAST THEN LineNo:=CommentLine."Entry No." + 1
        ELSE
            LineNo:=1;
        CommentLine.INIT;
        CommentLine."Entry No.":=LineNo;
        CommentLine."Table ID":=ApprovalEntry."Table ID";
        case ApprovalEntry."Document Type" of ApprovalEntry."Document Type"::" ": CommentLine."Document Type":=CommentLine."Document Type"::" ";
        ApprovalEntry."Document Type"::"Blanket Order": CommentLine."Document Type":=CommentLine."Document Type"::"Blanket Order";
        ApprovalEntry."Document Type"::"Credit Memo": CommentLine."Document Type":=CommentLine."Document Type"::"Credit Memo";
        ApprovalEntry."Document Type"::Invoice: CommentLine."Document Type":=CommentLine."Document Type"::Invoice;
        ApprovalEntry."Document Type"::Order: CommentLine."Document Type":=CommentLine."Document Type"::Order;
        ApprovalEntry."Document Type"::Quote: CommentLine."Document Type":=CommentLine."Document Type"::Quote;
        ApprovalEntry."Document Type"::"Return Order": CommentLine."Document Type":=CommentLine."Document Type"::"Return Order";
        ApprovalEntry."Document Type"::"Employee Appraisal": CommentLine."Document Type":=CommentLine."Document Type"::"Employee Appraisal";
        ApprovalEntry."Document Type"::"Store Requisitions": CommentLine."Document Type":=CommentLine."Document Type"::"Store Requisitions";
        ApprovalEntry."Document Type"::"Supplier Evaluation": CommentLine."Document Type":=CommentLine."Document Type"::"Supplier Evaluation";
        ApprovalEntry."Document Type"::Imprest: CommentLine."Document Type":=CommentLine."Document Type"::Imprest;
        ApprovalEntry."Document Type"::"Imprest Surrender": CommentLine."Document Type":=CommentLine."Document Type"::"Imprest Surrender";
        ApprovalEntry."Document Type"::"Audit Program": CommentLine."Document Type":=CommentLine."Document Type"::"Audit Program";
        end;
        CommentLine."Document No.":=ApprovalEntry."Document No.";
        CommentLine."Document Type":=ApprovalEntry."Document Type";
        CommentLine."Date and Time":=CREATEDATETIME(TODAY, TIME);
        CommentLine.Comment:=Comment;
        CommentLine."Record ID to Approve":=ApprovalEntry."Record ID to Approve";
        CommentLine."Workflow Step Instance ID":=ApprovalEntry."Workflow Step Instance ID";
        CommentLine."User ID":=USERID;
        CommentLine.INSERT;
    end;
    local procedure MakeApprovalEntry2(ApprovalEntryArgument: Record "Approval Entry"; SequenceNo: Integer; ApproverId: Code[50]; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalStage: Code[20]; WorkFlowUserGroup: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        OnlinePortal: Codeunit "Online Portal Services";
    begin
        ApprovalEntry."Table ID":=ApprovalEntryArgument."Table ID";
        ApprovalEntry."Document Type":=ApprovalEntryArgument."Document Type";
        ApprovalEntry."Document No.":=ApprovalEntryArgument."Document No.";
        ApprovalEntry."Salespers./Purch. Code":=ApprovalEntryArgument."Salespers./Purch. Code";
        ApprovalEntry."Sequence No.":=SequenceNo - 1;
        ApprovalEntry."Sender ID":=USERID;
        ApprovalEntry.Amount:=ApprovalEntryArgument.Amount;
        ApprovalEntry."Amount (LCY)":=ApprovalEntryArgument."Amount (LCY)";
        ApprovalEntry."Currency Code":=ApprovalEntryArgument."Currency Code";
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Approver ID");
        ApprovalEntry."Approver ID":=UserSetup."Approver ID";
        ApprovalEntry."Workflow Step Instance ID":=ApprovalEntryArgument."Workflow Step Instance ID";
        IF ApproverId = USERID THEN ApprovalEntry.Status:=ApprovalEntry.Status::Approved
        ELSE
            ApprovalEntry.Status:=ApprovalEntry.Status::Created;
        ApprovalEntry."Date-Time Sent for Approval":=CREATEDATETIME(TODAY, TIME);
        ApprovalEntry."Last Date-Time Modified":=CREATEDATETIME(TODAY, TIME);
        ApprovalEntry."Last Modified By User ID":=USERID;
        ApprovalEntry."Due Date":=CALCDATE(WorkflowStepArgument."Due Date Formula", TODAY);
        CASE WorkflowStepArgument."Delegate After" OF WorkflowStepArgument."Delegate After"::Never: EVALUATE(ApprovalEntry."Delegation Date Formula", '');
        WorkflowStepArgument."Delegate After"::"1 day": EVALUATE(ApprovalEntry."Delegation Date Formula", '<1D>');
        WorkflowStepArgument."Delegate After"::"2 days": EVALUATE(ApprovalEntry."Delegation Date Formula", '<2D>');
        WorkflowStepArgument."Delegate After"::"5 days": EVALUATE(ApprovalEntry."Delegation Date Formula", '<5D>');
        ELSE
            EVALUATE(ApprovalEntry."Delegation Date Formula", '');
        END;
        ApprovalEntry."Available Credit Limit (LCY)":=ApprovalEntryArgument."Available Credit Limit (LCY)";
        SetApproverType(WorkflowStepArgument, ApprovalEntry);
        SetLimitType(WorkflowStepArgument, ApprovalEntry);
        ApprovalEntry."Record ID to Approve":=ApprovalEntryArgument."Record ID to Approve";
        ApprovalEntry."Approval Code":=ApprovalEntryArgument."Approval Code";
        //Eddie BPIT Modifications
        ApprovalEntry."Approval Stage":=ApprovalStage;
        ApprovalEntry."Workflow User Group Code":=WorkFlowUserGroup;
        ApprovalEntry."Staff No.":=OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Sender ID");
        ApprovalEntry."Approver Staff No.":=OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Approver ID");
        ApprovalEntry.INSERT(TRUE);
        ApproverIDInserted:=TRUE;
    end;
    local procedure SetApproverType(WorkflowStepArgument: Record "Workflow Step Argument"; VAR ApprovalEntry: Record "Approval Entry")
    begin
        CASE WorkflowStepArgument."Approver Type" OF WorkflowStepArgument."Approver Type"::"Salesperson/Purchaser": ApprovalEntry."Approval Type":=ApprovalEntry."Approval Type"::"Sales Pers./Purchaser";
        WorkflowStepArgument."Approver Type"::Approver: ApprovalEntry."Approval Type":=ApprovalEntry."Approval Type"::Approver;
        WorkflowStepArgument."Approver Type"::"Workflow User Group": ApprovalEntry."Approval Type":=ApprovalEntry."Approval Type"::"Workflow User Group";
        END;
    end;
    local procedure SetLimitType(WorkflowStepArgument: Record "Workflow Step Argument"; VAR ApprovalEntry: Record "Approval Entry")
    begin
        CASE WorkflowStepArgument."Approver Limit Type" OF WorkflowStepArgument."Approver Limit Type"::"Approver Chain", WorkflowStepArgument."Approver Limit Type"::"First Qualified Approver": ApprovalEntry."Limit Type":=ApprovalEntry."Limit Type"::"Approval Limits";
        WorkflowStepArgument."Approver Limit Type"::"Direct Approver": ApprovalEntry."Limit Type":=ApprovalEntry."Limit Type"::"No Limits";
        WorkflowStepArgument."Approver Limit Type"::"Specific Approver": ApprovalEntry."Limit Type":=ApprovalEntry."Limit Type"::"No Limits";
        END;
        IF ApprovalEntry."Approval Type" = ApprovalEntry."Approval Type"::"Workflow User Group" THEN ApprovalEntry."Limit Type":=ApprovalEntry."Limit Type"::"No Limits";
    end;
    procedure CheckPaymentsApprovalsWorkflowEnabled(VAR Payments: Record Payments): Boolean begin
        IF NOT IsPaymentsApprovalsWorkflowEnabled(Payments)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsPaymentsApprovalsWorkflowEnabled(VAR Payments: Record Payments): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Payments, WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPaymentsForApproval(VAR Payments: Record Payments)
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPaymentsApprovalRequest(VAR Payments: Record Payments)
    begin
    end;
    //internal request header
    procedure CheckReqWorkflowEnabled(VAR Req: Record "Internal Request Header"): Boolean begin
        if not IsReqWorkflowEnabled(Req)then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    procedure IsReqWorkflowEnabled(VAR Req: Record "Internal Request Header"): Boolean begin
        exit(WorkFlowManagement.CanExecuteWorkflow(Req, WorkflowEventHandling.RunWorkflowOnSendReqForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendReqRequestforApproval(var Req: Record "Internal Request Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelReqApprovalRequest(var Req: Record "Internal Request Header")
    begin
    end;
    //Transport request
    [IntegrationEvent(false, false)]
    procedure OnSendTransportApprovalRequest(VAR TransportReq: Record "Travel Requests")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTransportApprovalRequest(VAR TransportReq: Record "Travel Requests")
    begin
    end;
    procedure CheckTransportWorkflowEnabled(VAR TransportReq: Record "Travel Requests"): Boolean begin
        IF NOT IsTransportWorkflowEnabled(TransportReq)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTransportWorkflowEnabled(VAR TransportReq: Record "Travel Requests"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(TransportReq, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRequestApproval(VAR LeaveRequest: Record "Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRequestApproval(VAR LeaveRequest: Record "Leave Application")
    begin
    end;
    procedure CheckLeaveRequestWorkflowEnabled(VAR LeaveRequest: Record "Leave Application"): Boolean begin
        IF NOT IsLeaveRequestWorkflowEnabled(LeaveRequest)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLeaveRequestWorkflowEnabled(VAR LeaveRequest: Record "Leave Application"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LeaveRequest, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode));
    end;
    //tender Committee
    [IntegrationEvent(false, false)]
    procedure OnSendTenderCommitteeRequestApproval(VAR TenderCommittee: Record "Tender Committees")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTenderCommitteeApproval(VAR TenderCommittee: Record "Tender Committees")
    begin
    end;
    procedure CheckTenderCommitteeRequestWorkflowEnabled(VAR TenderCommittee: Record "Tender Committees"): Boolean begin
        IF NOT IsTenderCommitteeRequestWorkflowEnabled(TenderCommittee)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTenderCommitteeRequestWorkflowEnabled(VAR TenderCommittee: Record "Tender Committees"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(TenderCommittee, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode));
    end;
    //Procurement Change Request
    [IntegrationEvent(false, false)]
    procedure OnSendProcReqRequestApproval(VAR ProcReq: Record "Procurement Change Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelProcReqApproval(VAR ProcReq: Record "Procurement Change Request")
    begin
    end;
    procedure CheckProcReqRequestWorkflowEnabled(VAR ProcReq: Record "Procurement Change Request"): Boolean begin
        IF NOT IsProcReqRequestWorkflowEnabled(ProcReq)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsProcReqRequestWorkflowEnabled(VAR ProcReq: Record "Procurement Change Request"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ProcReq, WorkflowEventHandling.RunworkflowOnSendProcReqforApprovalCode));
    end;
    //Contract Change START
    [IntegrationEvent(false, false)]
    procedure OnSendContChangeRequestApproval(VAR ContChange: Record "Contract Change Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelContChangeApproval(VAR ContChange: Record "Contract Change Header")
    begin
    end;
    procedure CheckContChangeRequestWorkflowEnabled(VAR ContChange: Record "Contract Change Header"): Boolean begin
        IF NOT IsContChangeRequestWorkflowEnabled(ContChange)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsContChangeRequestWorkflowEnabled(VAR ContChange: Record "Contract Change Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ContChange, WorkflowEventHandling.RunworkflowOnSendContChangeforApprovalCode));
    end;
    //Contract Change END
    //asset transfer
    [IntegrationEvent(false, false)]
    procedure OnSendAssetTransApproval(VAR AssetTrans: Record "Asset Allocation and Transfer")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAssetTransApproval(VAR AssetTrans: Record "Asset Allocation and Transfer")
    begin
    end;
    procedure CheckAssetTransWorkflowEnabled(VAR AssetTrans: Record "Asset Allocation and Transfer"): Boolean begin
        IF NOT IsAssetTransWorkflowEnabled(AssetTrans)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsAssetTransWorkflowEnabled(VAR AssetTrans: Record "Asset Allocation and Transfer"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(AssetTrans, WorkflowEventHandling.RunworkflowOnSendAssetTransforApprovalCode));
    end;
    //asset allocation
    [IntegrationEvent(false, false)]
    procedure OnSendAssetAllocationApproval(VAR AssetAllocation: Record "Asset Allocation and Transfer")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAssetAllocationApproval(VAR AssetAllocation: Record "Asset Allocation and Transfer")
    begin
    end;
    procedure CheckAssetAllocationWorkflowEnabled(VAR AssetAllocation: Record "Asset Allocation and Transfer"): Boolean begin
        IF NOT IsAssetAllocationWorkflowEnabled(AssetAllocation)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsAssetAllocationWorkflowEnabled(VAR AssetAllocation: Record "Asset Allocation and Transfer"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(AssetAllocation, WorkflowEventHandling.RunworkflowOnSendAssetAllocationforApprovalCode));
    end;
    //Quotation Card
    procedure CheckProcMethodWorkflowEnabled(VAR ProcMethod: Record "Procurement Request"): Boolean begin
        if not IsProcMethodWorkflowEnabled(ProcMethod)then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    procedure IsProcMethodWorkflowEnabled(VAR ProcMethod: Record "Procurement Request"): Boolean begin
        exit(WorkFlowManagement.CanExecuteWorkflow(ProcMethod, WorkflowEventHandling.RunWorkflowOnSendProcMethodForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendProcMethodApprovalRequest(VAR ProcMethod: Record "Procurement Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelProcMethodApprovalRequest(VAR ProcMethod: Record "Procurement Request")
    begin
    end;
    //Recruitment
    [IntegrationEvent(false, false)]
    Procedure OnSendRecruitmentApprovalRequest(VAR RecruitmentRequest: Record "Recruitment Needs")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentApprovalRequest(VAR RecruitmentRequest: Record "Recruitment Needs")
    begin
    end;
    procedure CheckRecruitmentRequestWorkflowEnabled(VAR RecruitmentRequest: Record "Recruitment Needs"): Boolean begin
        IF NOT IsRecruitmentRequestWorkflowEnabled(RecruitmentRequest)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsRecruitmentRequestWorkflowEnabled(VAR RecruitmentRequest: Record "Recruitment Needs"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(RecruitmentRequest, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTrainingRequestforApproval(VAR TrainingReq: Record "Training Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTrainingRequestApproval(VAR TrainingReq: Record "Training Request")
    begin
    end;
    procedure CheckTrainingRequestWorkflowEnabled(VAR TrainingReq: Record "Training Request"): Boolean begin
        IF NOT IsTrainingRequestWorkflowEnabled(TrainingReq)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTrainingRequestWorkflowEnabled(VAR TrainingReq: Record "Training Request"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(TrainingReq, WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeAppraisalRequestforApproval(VAR EmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeAppraisalApprovalRequest(VAR EmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;
    procedure CheckEmployeeAppraisalWorkflowEnabled(VAR EmployeeAppraisal: Record "Employee Appraisal"): Boolean begin
        IF NOT IsEmployeeAppraisalWorkflowEnabled(EmployeeAppraisal)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsEmployeeAppraisalWorkflowEnabled(VAR EmployeeAppraisal: Record "Employee Appraisal"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(EmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRecallRequestforApproval(VAR LeaveRecall: Record "Employee Off/Holiday")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRecallApprovalRequest(VAR LeaveRecall: Record "Employee Off/Holiday")
    begin
    end;
    procedure CheckLeaveRecallWorkflowEnabled(VAR LeaveRecall: Record "Employee Off/Holiday"): Boolean begin
        IF NOT IsLeaveRecallWorkflowEnabled(LeaveRecall)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLeaveRecallWorkflowEnabled(VAR LeaveRecall: Record "Employee Off/Holiday"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LeaveRecall, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode));
    end;
    //Employee Transfers
    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeTransferRequestforApproval(VAR EmployeeTransfer: Record "Employee Transfers")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeTransferApprovalRequest(VAR EmployeeTransfer: Record "Employee Transfers")
    begin
    end;
    procedure CheckEmployeeTransferWorkflowEnabled(VAR EmployeeTransfer: Record "Employee Transfers"): Boolean begin
        IF NOT IsEmployeeTransferWorkflowEnabled(EmployeeTransfer)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsEmployeeTransferWorkflowEnabled(VAR EmployeeTransfer: Record "Employee Transfers"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(EmployeeTransfer, WorkflowEventHandling.RunWorkflowOnSendEmployeeTransferRequestForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPayrollChangeforApproval(VAR "Payroll Change": Record "Payroll Change Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollChangeApproval(VAR "Payroll Change": Record "Payroll Change Header")
    begin
    end;
    procedure CheckPayrollChangeWorkflowEnabled(VAR "Payroll Change": Record "Payroll Change Header"): Boolean begin
        IF NOT IsPayrollChangeWorkflowEnabled("Payroll Change")THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsPayrollChangeWorkflowEnabled(VAR "Payroll Change": Record "Payroll Change Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow("Payroll Change", WorkflowEventHandling.RunworkflowOnSendPayrollChangeRequestforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLoanApplicationRequestforApproval(VAR LoanApplication: Record "Loan Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLoanApplicationRequestApproval(VAR LoanApplication: Record "Loan Application")
    begin
    end;
    procedure CheckLoanApplicationWorkflowEnabled(VAR LoanApplication: Record "Loan Application"): Boolean begin
        IF NOT IsLoanApplicationWorkflowEnabled(LoanApplication)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLoanApplicationWorkflowEnabled(VAR LoanApplication: Record "Loan Application"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LoanApplication, WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendEmpActingAndPromotionRequestForApproval(VAR EmpActing: Record "Employee Acting Position")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelEmpActingAndPromotionRequestApproval(VAR EmpActing: Record "Employee Acting Position")
    begin
    end;
    procedure CheckEmpActingAndPromotionWorkflowEnabled(VAR EmpActing: Record "Employee Acting Position"): Boolean begin
        IF NOT IsEmpActingAndPromotionWorkflowEnabled(EmpActing)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsEmpActingAndPromotionWorkflowEnabled(VAR EmpActing: Record "Employee Acting Position"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(EmpActing, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendBudgetApproval(VAR Budget: Record "Budget Approval Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelBudgetApproval(VAR Budget: Record "Budget Approval Header")
    begin
    end;
    procedure CheckBudgetWorkflowEnabled(VAR Budget: Record "Budget Approval Header"): Boolean begin
        IF NOT IsBudgetWorkflowEnabled(Budget)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsBudgetWorkflowEnabled(VAR Budget: Record "Budget Approval Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Budget, WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendProposedBudgetApproval(VAR ProposedBudget: Record "G/L Budget Name")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelProposedBudgetApproval(VAR ProposedBudget: Record "G/L Budget Name")
    begin
    end;
    procedure CheckProposedBudgetWorkflowEnabled(VAR ProposedBudget: Record "G/L Budget Name"): Boolean begin
        IF NOT IsProposedBudgetWorkflowEnabled(ProposedBudget)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsProposedBudgetWorkflowEnabled(VAR ProposedBudget: Record "G/L Budget Name"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ProposedBudget, WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendBankRecApproval(VAR BankAccRec: Record "Bank Acc. Reconciliation")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelBankRecApproval(VAR BankAccRec: Record "Bank Acc. Reconciliation")
    begin
    end;
    procedure CheckBankRecWorkflowEnabled(VAR BankAccRec: Record "Bank Acc. Reconciliation"): Boolean begin
        IF NOT IsBankRecWorkflowEnabled(BankAccRec)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsBankRecWorkflowEnabled(VAR BankAccRec: Record "Bank Acc. Reconciliation"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(BankAccRec, WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveAdjApproval(VAR LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAdjApproval(VAR LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
    end;
    procedure CheckLeaveAdjWorkflowEnabled(VAR LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean begin
        IF NOT IsLeaveAdjWorkflowEnabled(LeaveAdj)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLeaveAdjWorkflowEnabled(VAR LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LeaveAdj, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendNewEmpAppraisalRequestforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmpAppraisalRequestApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;
    procedure CheckNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean begin
        if not IsNewEmpAppraisalWorkflowEnabled(NewEmployeeAppraisal)then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    procedure IsNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean begin
        exit(WorkflowManagement.CanExecuteWorkflow(NewEmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode));
    end;
    //Tender evaluation
    procedure CheckTenderEvalWorkflowEnabled(VAR Tender: Record "Tender Evaluation Header"): Boolean begin
        IF NOT IsTenderEvalWorkflowEnabled(Tender)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTenderEvalWorkflowEnabled(VAR TenderEval: Record "Tender Evaluation Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(TenderEval, WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTenderEvalForApproval(VAR TenderEval: Record "Tender Evaluation Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTenderEvalApprovalRequest(VAR TenderEval: Record "Tender Evaluation Header")
    begin
    end;
    //Payroll Approval
    procedure CheckPayrollApprovalApprovalsWorkflowEnabled(VAR PayrollApproval: Record "Payroll Approval"): Boolean begin
        IF NOT IsPayrollApprovalApprovalsWorkflowEnabled(PayrollApproval)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsPayrollApprovalApprovalsWorkflowEnabled(VAR PayrollApproval: Record "Payroll Approval"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(PayrollApproval, WorkflowEventHandling.RunWorkflowOnSendPayrollApprovalForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPayrollApprovalForApproval(VAR PayrollApproval: Record "Payroll Approval")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollApprovalApprovalRequest(VAR PayrollApproval: Record "Payroll Approval")
    begin
    end;
    //Supplier evaluation
    procedure CheckSupplierEvalWorkflowEnabled(VAR Evaluation: Record "Supplier Evaluation Header"): Boolean begin
        IF NOT IsSupplierEvalWorkflowEnabled(Evaluation)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsSupplierEvalWorkflowEnabled(VAR Evaluation: Record "Supplier Evaluation Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Evaluation, WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendSupplierEvalForApproval(VAR Evaluation: Record "Supplier Evaluation Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelSupplierEvalApprovalRequest(VAR Evaluation: Record "Supplier Evaluation Header")
    begin
    end;
    //Prospective Suppliers
    [IntegrationEvent(false, false)]
    Procedure OnSendProspectiveSuppliersApprovalRequest(VAR ProspectiveSupplier: Record "Prospective Suppliers")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelProspectiveSuppliersApprovalRequest(VAR ProspectiveSupplier: Record "Prospective Suppliers")
    begin
    end;
    procedure CheckProspectiveSupplierRequestWorkflowEnabled(VAR ProspectiveSupplier: Record "Prospective Suppliers"): Boolean begin
        IF NOT IsProspectiveSupplierRequestWorkflowEnabled(ProspectiveSupplier)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsProspectiveSupplierRequestWorkflowEnabled(VAR ProspectiveSupplier: Record "Prospective Suppliers"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ProspectiveSupplier, WorkflowEventHandling.RunworkflowOnSendProspectiveSupplierRequestforApprovalCode));
    end;
    //Sample analysis
    procedure CheckSampleWorkflowEnabled(VAR Sample: Record "Sample Analysis And Reporting"): Boolean begin
        if not IsSampleWorkflowEnabled(Sample)then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    procedure IsSampleWorkflowEnabled(VAR Sample: Record "Sample Analysis And Reporting"): Boolean begin
        exit(WorkFlowManagement.CanExecuteWorkflow(Sample, WorkflowEventHandling.RunworkflowOnSendSampleforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendSampleRequestforApproval(VAR Sample: Record "Sample Analysis And Reporting")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelSampleApprovalRequest(VAR Sample: Record "Sample Analysis And Reporting")
    begin
    end;
    //FA Disposal
    procedure CheckFADisposalWorkflowEnabled(VAR FADisposal: Record "FA Disposal"): Boolean begin
        IF NOT IsFADisposalWorkflowEnabled(FADisposal)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsFADisposalWorkflowEnabled(VAR FADisposal: Record "FA Disposal"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(FADisposal, WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendFADisposalForApproval(VAR FADisposal: Record "FA Disposal")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelFADisposalApprovalRequest(VAR FADisposal: Record "FA Disposal")
    begin
    end;
    //Audit header
    procedure CheckAuditWorkflowEnabled(VAR AuditHeader: Record "Audit Header"): Boolean begin
        IF NOT IsAuditWorkflowEnabled(AuditHeader)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsAuditWorkflowEnabled(VAR AuditHeader: Record "Audit Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(AuditHeader, WorkflowEventHandling.RunworkflowOnSendAuditforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendAuditForApproval(VAR AuditHeader: Record "Audit Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAuditApprovalRequest(VAR AuditHeader: Record "Audit Header")
    begin
    end;
    //Research Activity
    procedure CheckResearchActivityWorkflowEnabled(VAR Activity: Record "Research Activity Plan"): Boolean begin
        IF NOT IsResearchActivityWorkflowEnabled(Activity)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsResearchActivityWorkflowEnabled(VAR Activity: Record "Research Activity Plan"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Activity, WorkflowEventHandling.RunworkflowOnSendResearchActivityforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendResearchActivityForApproval(VAR Activity: Record "Research Activity Plan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelResearchActivityApprovalRequest(VAR Activity: Record "Research Activity Plan")
    begin
    end;
    //PartnershipActivity
    procedure CheckPartnershipActivityWorkflowEnabled(VAR PActivity: Record "Partnerships Activity Plan"): Boolean begin
        IF NOT IsPartnershipActivityWorkflowEnabled(PActivity)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsPartnershipActivityWorkflowEnabled(VAR PActivity: Record "Partnerships Activity Plan"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(PActivity, WorkflowEventHandling.RunworkflowOnSendPartnershipActivityforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPartnershipActivityForApproval(VAR PActivity: Record "Partnerships Activity Plan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPartnershipActivityApprovalRequest(VAR PActivity: Record "Partnerships Activity Plan")
    begin
    end;
    //ResearchSurvey Workplan
    procedure CheckResearchSurveyWorkflowEnabled(VAR SActivity: Record "Research and survey Workplan"): Boolean begin
        IF NOT IsResearchSurveyWorkflowEnabled(SActivity)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsResearchSurveyWorkflowEnabled(VAR SActivity: Record "Research and survey Workplan"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(SActivity, WorkflowEventHandling.RunWorkflowOnSendResearchSurveyForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendResearchSurveyForApproval(VAR SActivity: Record "Research and survey Workplan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelResearchSurveyApprovalRequest(VAR SActivity: Record "Research and survey Workplan")
    begin
    end;
    //ItemJournal
    procedure TrySendItemBatchApprovalRequest(var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
        PendingJournalBatchApprovalExistsErr: Label 'An approval request already exists.', Comment = '%1 is the Document No. of the journal line';
    begin
        GetItemJournalBatch(ItemJournalBatch, ItemJournalLine);
        CheckItemJournalWorkflowEnabled(ItemJournalBatch);
        if HasOpenApprovalEntries(ItemJournalBatch.RecordId)then Error(PendingJournalBatchApprovalExistsErr);
        OnSendItemJournalForApproval(ItemJournalBatch);
    end;
    procedure TrySendItemJournalLineApprovalRequests(var ItemJournalLine: Record "Item Journal Line")
    var
        LinesSent: Integer;
    begin
        if ItemJournalLine.Count = 1 then CheckItemJournalLineApprovalsWorkflowEnabled(ItemJournalLine);
        repeat if WorkflowManagement.CanExecuteWorkflow(ItemJournalLine, WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalCode) and not HasOpenApprovalEntries(ItemJournalLine.RecordId)then begin
                OnSendItemLineForApproval(ItemJournalLine);
                LinesSent+=1;
            end;
        until ItemJournalLine.Next = 0;
        case LinesSent of 0: Message(NoApprovalsSentMsg);
        ItemJournalLine.Count: Message(PendingApprovalForSelectedLinesMsg);
        else
            Message(PendingApprovalForSomeSelectedLinesMsg);
        end;
    end;
    procedure TryCancelItemJournalBatchApprovalRequest(var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        GetItemJournalBatch(ItemJournalBatch, ItemJournalLine);
        OnCancelItemJournalApprovalRequest(ItemJournalBatch);
        WorkflowWebhookManagement.FindAndCancel(ItemJournalBatch.RecordId);
    end;
    procedure TryCancelJournalLineApprovalRequests(var ItemJournalLine: Record "Item Journal Line")
    var
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        repeat if HasOpenApprovalEntries(ItemJournalLine.RecordId)then OnCancelItemLineApprovalRequest(ItemJournalLine);
            WorkflowWebhookManagement.FindAndCancel(ItemJournalLine.RecordId);
        until ItemJournalLine.Next = 0;
        Message(ApprovalReqCanceledForSelectedLinesMsg);
    end;
    procedure ShowJournalApprovalEntries(var ItemJournalLine: Record "Item Journal Line")
    var
        ApprovalEntry: Record "Approval Entry";
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        GetItemJournalBatch(ItemJournalBatch, ItemJournalLine);
        ApprovalEntry.SetFilter("Table ID", '%1|%2', DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line");
        ApprovalEntry.SetFilter("Record ID to Approve", '%1|%2', ItemJournalBatch.RecordId, ItemJournalLine.RecordId);
        ApprovalEntry.SetRange("Related to Change", false);
        PAGE.Run(PAGE::"Approval Entries", ApprovalEntry);
    end;
    local procedure GetItemJournalBatch(var ItemJournalBatch: Record "Item Journal Batch"; var ItemJournalLine: Record "Item Journal Line")
    begin
        if not ItemJournalBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name")then ItemJournalBatch.Get(ItemJournalLine.GetFilter("Journal Template Name"), ItemJournalLine.GetFilter("Journal Batch Name"));
    end;
    procedure CheckItemJournalWorkflowEnabled(VAR ItemJnl: Record "Item Journal Batch"): Boolean begin
        IF NOT IsItemJournalWorkflowEnabled(ItemJnl)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure CheckItemJournalLineApprovalsWorkflowEnabled(var ItemJournalLine: Record "Item Journal Line"): Boolean begin
        if not WorkflowManagement.CanExecuteWorkflow(ItemJournalLine, WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalCode)then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    procedure IsItemJournalWorkflowEnabled(VAR ItemJnl: Record "Item Journal Batch"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ItemJnl, WorkflowEventHandling.RunWorkflowOnSendItemJournalForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendItemJournalForApproval(VAR ItemJnl: Record "Item Journal Batch")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelItemJournalApprovalRequest(VAR ItemJnl: Record "Item Journal Batch")
    begin
    end;
    //Item Journal Line
    procedure CheckItemLineWorkflowEnabled(VAR ItemJnlLine: Record "Item Journal Line"): Boolean begin
        IF NOT IsItemLineWorkflowEnabled(ItemJnlLine)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsItemLineWorkflowEnabled(VAR ItemJnlLine: Record "Item Journal Line"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ItemJnlLine, WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendItemLineForApproval(VAR ItemJnlLine: Record "Item Journal Line")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelItemLineApprovalRequest(VAR ItemJnline: Record "Item Journal Line")
    begin
    end;
    //Lab Annual Schedule
    procedure CheckLabScheduleWorkflowEnabled(VAR LabSchedule: Record "Lab Annual Testing Schedule"): Boolean begin
        IF NOT IsLabScheduleWorkflowEnabled(LabSchedule)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLabScheduleWorkflowEnabled(VAR LabSchedule: Record "Lab Annual Testing Schedule"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LabSchedule, WorkflowEventHandling.RunWorkflowOnSendLabScheduleForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLabScheduleForApproval(VAR LabSchedule: Record "Lab Annual Testing Schedule")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLabScheduleApprovalRequest(VAR LabSchedule: Record "Lab Annual Testing Schedule")
    begin
    end;
    //Asset Annual Workplan
    procedure CheckAssetDisposalWorkflowEnabled(VAR ADisposal: Record "AnnualDisposal Header"): Boolean begin
        IF NOT IsAssetDisposalWorkflowEnabled(ADisposal)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsAssetDisposalWorkflowEnabled(VAR ADisposal: Record "AnnualDisposal Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ADisposal, WorkflowEventHandling.RunWorkflowOnSendAssetDisposalForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendAssetDisposalForApproval(VAR ADisposal: Record "AnnualDisposal Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAssetDisposalApprovalRequest(VAR ADisposal: Record "AnnualDisposal Header")
    begin
    end;
    //License Registrations
    procedure CheckLicenseRegistrationWorkflowEnabled(VAR LicenseRegistration: Record "Licensing dairy Enterprise"): Boolean begin
        IF NOT IsLicenseRegistrationWorkflowEnabled(LicenseRegistration)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLicenseRegistrationWorkflowEnabled(VAR LicenseRegistration: Record "Licensing dairy Enterprise"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LicenseRegistration, WorkflowEventHandling.RunWorkflowOnSendLicenseRegistrationForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLicenseRegistrationForApproval(VAR LicenseRegistration: Record "Licensing dairy Enterprise")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLicenseRegistrationApprovalRequest(VAR LicenseRegistration: Record "Licensing dairy Enterprise")
    begin
    end;
    //LicenseApplication
    procedure CheckLicenseApplicationWorkflowEnabled(VAR LicenseApplication: Record "License Applications"): Boolean begin
        IF NOT IsLicenseApplicationWorkflowEnabled(LicenseApplication)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsLicenseApplicationWorkflowEnabled(VAR LicenseApplication: Record "License Applications"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(LicenseApplication, WorkflowEventHandling.RunWorkflowOnSendLicenseApplicationForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLicenseApplicationForApproval(VAR LicenseApplication: Record "License Applications")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLicenseApplicationApprovalRequest(VAR LicenseApplication: Record "License Applications")
    begin
    end;
    //ICTWorkplan
    procedure CheckICTWorkplanWorkflowEnabled(VAR ICTWorkplan: Record "ICT Workplan"): Boolean begin
        IF NOT IsICTWorkplanWorkflowEnabled(ICTWorkplan)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsICTWorkplanWorkflowEnabled(VAR ICTWorkplan: Record "ICT Workplan"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ICTWorkplan, WorkflowEventHandling.RunworkflowOnSendICTWorkplanforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendICTWorkplanForApproval(VAR ICTWorkplan: Record "ICT Workplan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelICTWorkplanApprovalRequest(VAR ICTWorkplan: Record "ICT Workplan")
    begin
    end;
    //UserIncidences
    procedure CheckUserIncidencesWorkflowEnabled(VAR UserIncidences: Record "User Support Incident"): Boolean begin
        IF NOT IsUserIncidencesWorkflowEnabled(UserIncidences)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsUserIncidencesWorkflowEnabled(VAR UserIncidences: Record "User Support Incident"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(UserIncidences, WorkflowEventHandling.RunworkflowOnSendUserIncidencesforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendUserIncidencesForApproval(VAR UserIncidences: Record "User Support Incident")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelUserIncidencesApprovalRequest(VAR UserIncidences: Record "User Support Incident")
    begin
    end;
    //RiskHeader
    procedure CheckRiskHeaderWorkflowEnabled(VAR RiskHeader: Record "Risk Header"): Boolean begin
        IF NOT IsRiskHeaderWorkflowEnabled(RiskHeader)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsRiskHeaderWorkflowEnabled(VAR RiskHeader: Record "Risk Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(RiskHeader, WorkflowEventHandling.RunworkflowOnSendRiskHeaderforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRiskHeaderForApproval(VAR RiskHeader: Record "Risk Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRiskHeaderApprovalRequest(VAR RiskHeader: Record "Risk Header")
    begin
    end;
    //TransportIncident
    procedure CheckTransportIncidentWorkflowEnabled(VAR TransportIncident: Record "Transport Incident"): Boolean begin
        IF NOT IsTransportIncidentWorkflowEnabled(TransportIncident)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTransportIncidentWorkflowEnabled(VAR TransportIncident: Record "Transport Incident"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(TransportIncident, WorkflowEventHandling.RunworkflowOnSendTransportIncidentforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTransportIncidentForApproval(VAR TransportIncident: Record "Transport Incident")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTransportIncidentApprovalRequest(VAR TransportIncident: Record "Transport Incident")
    begin
    end;
    //DriverLogging
    procedure CheckDriverLoggingWorkflowEnabled(VAR DriverLogging: Record "Driver Logging"): Boolean begin
        IF NOT IsDriverLoggingWorkflowEnabled(DriverLogging)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsDriverLoggingWorkflowEnabled(VAR DriverLogging: Record "Driver Logging"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(DriverLogging, WorkflowEventHandling.RunworkflowOnSendDriverLoggingforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendDriverLoggingForApproval(VAR DriverLogging: Record "Driver Logging")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelDriverLoggingApprovalRequest(VAR DriverLogging: Record "Driver Logging")
    begin
    end;
    //ProjectManagement
    procedure CheckProjectmanagementWorkflowEnabled(VAR projectman: Record projectman): Boolean begin
        IF NOT IsprojectmanagementWorkflowEnabled(projectman)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsprojectmanagementWorkflowEnabled(VAR projectman: Record projectman): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(projectman, WorkflowEventHandling.RunWorkflowOnSendprojectreqforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendprojectreqForApproval(VAR projectman: Record projectman)
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelprojectreqforapproval(VAR projectman: Record projectman)
    begin
    end;
    //Contract Management
    procedure CheckContractApprovalRequestWorkflowEnabled(VAR ContractApproval: Record "Project Header"): Boolean begin
        IF NOT IsContractWorkflowEnabled(ContractApproval)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsContractWorkflowEnabled(VAR ContractApproval: Record "Project Header"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(ContractApproval, WorkflowEventHandling.RunworkflowOnSendContractreqforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendContractReqforApproval(VAR ContractApproval: Record "Project Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelContractreqforApproval(VAR ContractApproval: Record "Project Header")
    begin
    end;
    //Workprogramme
    procedure CheckWorkprogrammeWorkflowEnabled(VAR Workprogramme: Record "Activity Work Programme"): Boolean begin
        IF NOT IsWorkprogrammeWorkflowEnabled(Workprogramme)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsWorkprogrammeWorkflowEnabled(VAR Workprogramme: Record "Activity Work Programme"): Boolean begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(Workprogramme, WorkflowEventHandling.RunworkflowOnSendWorkprogrammeforApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendWorkprogrammeForApproval(VAR Workprogramme: Record "Activity Work Programme")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelWorkprogrammeApprovalRequest(VAR Workprogramme: Record "Activity Work Programme")
    begin
    end;
    //TargetSetupHeader
    procedure CheckTargetSetupHeaderApprovalsWorkflowEnabled(VAR TargetSetup: Record "Target Setup Header"): Boolean begin
        IF NOT IsTargetSetupHeaderApprovalsWorkflowEnabled(TargetSetup)THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure IsTargetSetupHeaderApprovalsWorkflowEnabled(VAR TargetSetupHeader: Record "Target Setup Header"): Boolean begin
        IF TargetSetupHeader."Target Status" <> TargetSetupHeader."Target Status"::Setting then EXIT(false);
        EXIT(WorkflowManagement.CanExecuteWorkflow(TargetSetupHeader, WorkflowEventHandling.RunWorkflowOnSendTargetSetupHeaderForApprovalCode));
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTargetSetupHeaderForApproval(VAR TargetSetupHeader: Record "Target Setup Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTargetSetupHeaderApprovalRequest(VAR TargetSetupHeader: Record "Target Setup Header")
    begin
    end;
    procedure FindOpenApprovalEntryForCurrUser(var ApprovalEntry: Record "Approval Entry"; RecordID: RecordID): Boolean begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        ApprovalEntry.SetRange("Related to Change", false);
        exit(ApprovalEntry.FindFirst);
    end;
    procedure HasOpenApprovalEntriesForCurrentUser(RecordID: RecordID): Boolean var
        ApprovalEntry: Record "Approval Entry";
    begin
        exit(FindOpenApprovalEntryForCurrUser(ApprovalEntry, RecordID));
    end;
    procedure HasOpenApprovalEntries(RecordID: RecordID): Boolean var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);
        exit(not ApprovalEntry.IsEmpty);
    end;
    procedure HasOpenOrPendingApprovalEntries(RecordID: RecordID): Boolean var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
        ApprovalEntry.SetRange("Related to Change", false);
        exit(not ApprovalEntry.IsEmpty);
    end;
    local procedure HasPendingApprovalEntriesForWorkflow(RecId: RecordID; WorkflowInstanceId: Guid): Boolean var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Record ID to Approve", RecId);
        ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
        ApprovalEntry.SetFilter("Workflow Step Instance ID", WorkflowInstanceId);
        exit(not ApprovalEntry.IsEmpty);
    end;
    procedure HasAnyOpenJournalLineApprovalEntries(JournalTemplateName: Code[20]; JournalBatchName: Code[20]): Boolean var
        ItemJournalLine: Record "Item Journal Line";
        ApprovalEntry: Record "Approval Entry";
        ItemJournalLineRecRef: RecordRef;
        ItemJournalLineRecordID: RecordID;
    begin
        ApprovalEntry.SetRange("Table ID", DATABASE::"Item Journal Line");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);
        if ApprovalEntry.IsEmpty then exit(false);
        ItemJournalLine.SetRange("Journal Template Name", JournalTemplateName);
        ItemJournalLine.SetRange("Journal Batch Name", JournalBatchName);
        if ItemJournalLine.IsEmpty then exit(false);
        if ItemJournalLine.Count < ApprovalEntry.Count then begin
            ItemJournalLine.FindSet;
            repeat if HasOpenApprovalEntries(ItemJournalLine.RecordId)then exit(true);
            until ItemJournalLine.Next = 0;
        end
        else
        begin
            ApprovalEntry.FindSet;
            repeat ItemJournalLineRecordID:=ApprovalEntry."Record ID to Approve";
                ItemJournalLineRecRef:=ItemJournalLineRecordID.GetRecord;
                ItemJournalLineRecRef.SetTable(ItemJournalLine);
                if(ItemJournalLine."Journal Template Name" = JournalTemplateName) and (ItemJournalLine."Journal Batch Name" = JournalBatchName)then exit(true);
            until ApprovalEntry.Next = 0;
        end;
        exit(false)end;
    procedure CanCancelApprovalForRecord(RecID: RecordID): Boolean var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId)then exit(false);
        ApprovalEntry.SetRange("Table ID", RecID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecID);
        ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);
        if not UserSetup."Approval Administrator" then ApprovalEntry.SetRange("Sender ID", UserId);
        exit(ApprovalEntry.FindFirst);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(VAR RecRef: RecordRef; VAR ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
        Payments: Record Payments;
        Req: Record "Internal Request Header";
        TransportRequests: Record "Travel Requests";
        LeaveRequest: Record "Leave Application";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        RecruitmentRequest: Record "Recruitment Needs";
        TrainingReq: Record "Training Request";
        EmployeeTransfer: Record "Employee Transfers";
        EmployeeAppraisal: Record "Employee Appraisal";
        LeaveRecall: Record "Employee Off/Holiday";
        PayrollChange: Record "Payroll Change Header";
        PayrollRequest: Record "Payroll Requests";
        LoanApplication: Record "Loan Application";
        EmpActing: Record "Employee Acting Position";
        Budget: Record "Budget Approval Header";
        ProposedBudget: Record "G/L Budget Name";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        LeaveAdj: Record "Leave Bal Adjustment Header";
        CashManagementSetups: Record "Cash Management Setups";
        NoSeries: Codeunit NoSeriesManagement;
        NewEmployeeAppraisal: Record "Employee Appraisal";
        TenderEval: Record "Tender Evaluation Header";
        SupEval: Record "Supplier Evaluation Header";
        FADisposal: Record "FA Disposal";
        AssetTransfer: Record "Asset Allocation and Transfer";
        TenderCommittee: Record "Tender Committees";
        ProcChangeRequest: Record "Procurement Change Request";
        ContChange: Record "Contract Change Header";
        ProcRequest: Record "Procurement Request";
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
        PayrollApproval: Record "Payroll Approval";
        PurchHeader: Record "Purchase Header";
        UserIncidences: Record "User Support Incident";
        RiskHeader: Record "Risk Header";
        TransportIncident: Record "Transport Incident";
        DriverLogging: Record "Driver Logging";
        Workprogramme: Record "Activity Work Programme";
        ProjectMAN: Record "ProjectmAN";
        ContractMan: Record "Project Header";
        TargetSetup: Record "Target Setup Header";
        ProspectiveSupplier: Record "Prospective Suppliers";
    begin
        CASE RecRef.NUMBER OF //Pen Admin Modification
        //Payments
        DATABASE::Payments: BEGIN
            RecRef.SETTABLE(Payments);
            Payments.CalcFields("Impress Amount 1", "Impress Amount 2");
            ApprovalAmount:=Payments."Impress Amount 1" + Payments."Impress Amount 2";
            ApprovalAmountLCY:=Payments."Impress Amount 1" + Payments."Impress Amount 2";
            CASE Payments."Payment Type" OF Payments."Payment Type"::"Payment Voucher": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Payment Voucher";
            Payments."Payment Type"::Imprest: ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Imprest;
            Payments."Payment Type"::"Imprest Surrender": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Imprest Surrender";
            Payments."Payment Type"::"Petty Cash": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Petty Cash";
            Payments."Payment Type"::"Petty Cash Surrender": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Petty Cash Surrender";
            Payments."Payment Type"::"Bank Transfer": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Bank Transfer";
            Payments."Payment Type"::"Staff Claim": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Staff Claim";
            END;
            ApprovalEntryArgument."Document No.":=Payments."No.";
            ApprovalEntryArgument.Amount:=ApprovalAmount;
            ApprovalEntryArgument."Amount (LCY)":=ApprovalAmountLCY;
            ApprovalEntryArgument."Currency Code":=Payments.Currency;
        END;
        //sample analysis
        DATABASE::"Sample Analysis And Reporting": BEGIN
            RecRef.SETTABLE(SampleAnalysis);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=SampleAnalysis."Analysis No.";
        END;
        //Procurement Request
        DATABASE::"Procurement Request": BEGIN
            RecRef.SETTABLE(ProcRequest);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ProcRequest."No.";
        END;
        //PurchHeader
        DATABASE::"Purchase Header": BEGIN
            RecRef.SETTABLE(PurchHeader);
            ApprovalEntryArgument.Amount:=PurchHeader."Amount Including VAT";
        END;
        //Asset Transfer
        DATABASE::"Asset Allocation and Transfer": BEGIN
            RecRef.SETTABLE(AssetTransfer);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=AssetTransfer."No.";
        END;
        //Tender commitee
        DATABASE::"Tender Committees": BEGIN
            RecRef.SETTABLE(TenderCommittee);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=TenderCommittee."Appointment No";
        END;
        //Procurement Change Request
        DATABASE::"Procurement Change Request": BEGIN
            RecRef.SETTABLE(ProcChangeRequest);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ProcChangeRequest.Number;
        END;
        //Contract Change
        Database::"Contract Change Header": begin
            RecRef.SETTABLE(ContChange);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ContChange."No.";
        end;
        //Requisitions
        Database::"Internal Request Header": begin
            RecRef.SetTable(Req);
            case req."Document Type" of req."Document Type"::Purchase: ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Purchase Requisitions";
            req."Document Type"::Stock: ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Store Requisitions";
            end;
            Req.CalcFields("Total Amount");
            ApprovalAmount:=Req."Total Amount";
            ApprovalEntryArgument."Document No.":=Req."No.";
            ApprovalEntryArgument.Amount:=ApprovalAmount;
        end;
        //TargetSetupHeader
        DATABASE::"Target Setup Header": BEGIN
            RecRef.SetTable(TargetSetup);
            TargetSetup.CalcFields("Total score");
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Appraisal";
            ApprovalEntryArgument."Document No.":=TargetSetup."Target No";
            ApprovalEntryArgument.Amount:=TargetSetup."Total Score";
            ApprovalEntryArgument."Amount (LCY)":=TargetSetup."Total Score";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=StrSubstNo('Staff Appraisal-%1 for the Period between %2 - %3', TargetSetup."Appraisee Name", TargetSetup."Period Start", TargetSetup."Period End");
        end;
        //Travel Requests
        DATABASE::"Travel Requests": BEGIN
            RecRef.SETTABLE(TransportRequests);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Travel Requests";
            ApprovalEntryArgument."Document No.":=TransportRequests."Request No.";
            ApprovalEntryArgument.Amount:=TransportRequests."No. of Personnel";
            ApprovalEntryArgument."Amount (LCY)":=TransportRequests."No. of Personnel";
            ApprovalEntryArgument.Description:=format(TransportRequests."Travel Details", 100);
        END;
        //Leave Application
        DATABASE::"Leave Application": BEGIN
            RecRef.SETTABLE(LeaveRequest);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::LeaveApplication;
            ApprovalEntryArgument."Document No.":=LeaveRequest."Application No";
            ApprovalEntryArgument.Amount:=LeaveRequest."Days Applied";
            ApprovalEntryArgument."Amount (LCY)":=LeaveRequest."Days Applied";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=LeaveRequest.Name + ' Leave Application';
        END;
        //Recruitment
        DATABASE::"Recruitment Needs": BEGIN
            RecRef.SETTABLE(RecruitmentRequest);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Recruitment;
            ApprovalEntryArgument."Document No.":=RecruitmentRequest."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=RecruitmentRequest.Description;
        END;
        //Prospective Suppliers:
        DATABASE::"Prospective Suppliers": BEGIN
            RecRef.SETTABLE(ProspectiveSupplier);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Prospective Suppliers";
            ApprovalEntryArgument."Document No.":=ProspectiveSupplier."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=ProspectiveSupplier.Name;
        END;
        //TrainingRequest
        DATABASE::"Training Request": BEGIN
            RecRef.SETTABLE(TrainingReq);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::TrainingRequest;
            ApprovalEntryArgument."Document No.":=TrainingReq."Request No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=TrainingReq.Description;
        END;
        //Employee Transfer
        DATABASE::"Employee Transfers": BEGIN
            RecRef.SETTABLE(EmployeeTransfer);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Transfer";
            ApprovalEntryArgument."Document No.":=EmployeeTransfer."Transfer No";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=EmployeeTransfer."Employee Name" + ' transfer ' + EmployeeTransfer."Reason of Transfer";
        END;
        // Leave Recall
        DATABASE::"Employee Off/Holiday": BEGIN
            RecRef.SETTABLE(LeaveRecall);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Leave Recall";
            ApprovalEntryArgument."Document No.":=LeaveRecall."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        Database::"Payroll Approval": begin
            RecRef.SETTABLE(PayrollApproval);
            case PayrollApproval."Payroll Type" of PayrollApproval."Payroll Type"::Employee: begin
                PayrollApproval.CALCFIELDS("Total Allowances", "Total Employer Amount");
                ApprovalAmount:=PayrollApproval."Total Allowances" + PayrollApproval."Total Employer Amount";
                ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Payroll";
            end;
            end;
            ApprovalEntryArgument."Document No.":=PayrollApproval."No.";
            ApprovalEntryArgument.Amount:=ApprovalAmount;
            ApprovalEntryArgument."Amount (LCY)":=ApprovalAmountLCY;
            ApprovalEntryArgument."Currency Code":=PayrollApproval."Currency Code";
            ApprovalEntryArgument.Description:=PayrollApproval.Description;
        end;
        //Payroll Change
        DATABASE::"Payroll Change Header": BEGIN
            RecRef.SETTABLE(PayrollChange);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Payroll Change";
            ApprovalEntryArgument."Document No.":=PayrollChange.No;
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Payroll Request
        DATABASE::"Payroll Requests": BEGIN
            RecRef.SETTABLE(PayrollRequest);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Payroll Request";
            ApprovalEntryArgument."Document No.":=PayrollRequest."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
            ApprovalEntryArgument.Description:=PayrollRequest."Code Descripton";
        END;
        //Loan Application
        DATABASE::"Loan Application": BEGIN
            RecRef.SETTABLE(LoanApplication);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Payroll Loan Application";
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Loan Application";
            ApprovalEntryArgument.Description:=LoanApplication.Description + ' Employee ' + LoanApplication."Employee Name";
            ApprovalEntryArgument."Document No.":=LoanApplication."Loan No";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Acting and  Promotion
        DATABASE::"Employee Acting Position": BEGIN
            RecRef.SETTABLE(EmpActing);
            CASE EmpActing."Promotion Type" OF EmpActing."Promotion Type"::"Acting Position": ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Acting";
            EmpActing."Promotion Type"::Promotion: ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Promotion";
            END;
            ApprovalEntryArgument.Description:=Format(EmpActing."Promotion Type") + ' for ' + EmpActing."Employee No." + ' Postion: ' + EmpActing."Desired Position";
            ApprovalEntryArgument."Document No.":=EmpActing.No;
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Budget
        DATABASE::"Budget Approval Header": BEGIN
            RecRef.SETTABLE(Budget);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Budget;
            ApprovalEntryArgument."Document No.":=Budget."Document No.";
            ApprovalEntryArgument.Description:='Budget Entries for ' + Budget."Budget Name" + ' from ' + Budget."User ID";
        END;
        //Budget App
        DATABASE::"G/L Budget Name": BEGIN
            CashManagementSetups.GET;
            CashManagementSetups.TESTFIELD("Proposed Budget Approval Nos");
            RecRef.SETTABLE(ProposedBudget);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Proposed Budget";
            ProposedBudget."Document No.":=NoSeries.GetNextNo(CashManagementSetups."Proposed Budget Approval Nos", 0D, TRUE);
            ProposedBudget.MODIFY(TRUE);
            ApprovalEntryArgument."Document No.":=ProposedBudget."Document No.";
            ApprovalEntryArgument.Description:=ProposedBudget.Name + ' Final Budget Approval';
        END;
        //Bank Rec
        DATABASE::"Bank Acc. Reconciliation": BEGIN
            CashManagementSetups.GET;
            CashManagementSetups.TESTFIELD("Bank Reconciliation Nos");
            RecRef.SETTABLE(BankAccReconciliation);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Bank Reconciliation";
            BankAccReconciliation."Document No.":=NoSeries.GetNextNo(CashManagementSetups."Bank Reconciliation Nos", 0D, TRUE);
            BankAccReconciliation.MODIFY(TRUE);
            ApprovalEntryArgument."Document No.":=BankAccReconciliation."Document No.";
            ApprovalEntryArgument.Description:=BankAccReconciliation."Bank Account No." + 'Reconciliation as at ' + FORMAT(BankAccReconciliation."Statement Date");
        END;
        //Leave Adj
        DATABASE::"Leave Bal Adjustment Header": BEGIN
            RecRef.SETTABLE(LeaveAdj);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::LeaveAdjustment;
            ApprovalEntryArgument."Document No.":=LeaveAdj.Code;
            ApprovalEntryArgument.Description:='Leave Adjustment';
        END;
        //New Emp Appraisal
        DATABASE::"Employee Appraisal": begin
            RecRef.SetTable(NewEmployeeAppraisal);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Employee Appraisal";
            ApprovalEntryArgument."Document No.":=NewEmployeeAppraisal."Appraisal No";
            ApprovalEntryArgument.Description:=StrSubstNo('Staff Appraisal-%1 for the Period between %2 - %3', NewEmployeeAppraisal."Appraisee Name", NewEmployeeAppraisal."Period Start", NewEmployeeAppraisal."Period End");
        end;
        //Tender Evaluation
        DATABASE::"Tender Evaluation Header": BEGIN
            RecRef.SETTABLE(TenderEval);
            ApprovalEntryArgument."Document No.":=TenderEval."Quote No";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Supplier Evaluation
        Database::"Supplier Evaluation Header": begin
            RecRef.SetTable(SupEval);
            ApprovalEntryArgument."Document No.":=SupEval."No.";
            ApprovalEntryArgument.Description:=SupEval.Description;
        end;
        //FA Disposal
        Database::"FA Disposal": begin
            RecRef.SetTable(FADisposal);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"FA Disposal";
            ApprovalEntryArgument."Document No.":=FADisposal."No.";
            ApprovalEntryArgument.Description:=FADisposal.Comments;
        end;
        //Audit
        DATABASE::"Audit Header": BEGIN
            RecRef.SETTABLE(Audit);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=Audit."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Research Activity
        Database::"Research Activity Plan": begin
            RecRef.SetTable(ResearchActivity);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ResearchActivity.Code;
            ApprovalEntryArgument.Description:=ResearchActivity."Description of activity";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        end;
        //Partnerships
        Database::"Partnerships Activity Plan": begin
            RecRef.SetTable(Partnership);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=Partnership.Code;
            ApprovalEntryArgument.Description:=Partnership."Name of partnership";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        end;
        //Research survey
        DATABASE::"Research and survey Workplan": BEGIN
            RecRef.SETTABLE(ResearchSurvey);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ResearchSurvey.Code;
            ApprovalEntryArgument.Description:=ResearchSurvey."Name of research";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Item Jnl batch
        DATABASE::"Item Journal Batch": BEGIN
            RecRef.SETTABLE(ItemJnl);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ItemJnl."Document No.";
            ApprovalEntryArgument.Description:=ItemJnl."Journal Template Name";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Item Jnl Line
        DATABASE::"Item Journal Line": BEGIN
            RecRef.SETTABLE(ItemJnlLine);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=ItemJnlLine."Document No.";
            ApprovalEntryArgument.Description:=ItemJnlLine."Journal Template Name";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Annual Schedule
        DATABASE::"Lab Annual Testing Schedule": BEGIN
            RecRef.SETTABLE(LabSchedule);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=LabSchedule.Code;
            ApprovalEntryArgument.Description:=LabSchedule."Nature of Testing";
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        //Annual Schedule
        DATABASE::"AnnualDisposal Header": BEGIN
            RecRef.SETTABLE(AssetDisposal);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=AssetDisposal."No.";
            ApprovalEntryArgument.Description:=AssetDisposal.Description;
            ApprovalEntryArgument."Salespers./Purch. Code":='';
        END;
        DATABASE::"Licensing dairy Enterprise": BEGIN
            RecRef.SETTABLE(LicenseRegistration);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Licensing;
            ApprovalEntryArgument."Document No.":=LicenseRegistration."Application no";
            ApprovalEntryArgument.Description:=format(LicenseRegistration."Customer Type");
        END;
        DATABASE::"License Applications": BEGIN
            RecRef.SETTABLE(LicenseApplication);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Licensing;
            ApprovalEntryArgument."Document No.":=LicenseApplication."No.";
            ApprovalEntryArgument.Description:=format(LicenseApplication."Application Type");
        END;
        Database::"ICT Workplan": begin
            RecRef.SetTable(ICTWorkplan);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Workplan;
            ApprovalEntryArgument."Document No.":=ICTWorkplan."No.";
            ApprovalEntryArgument.Description:=ICTWorkplan.Description;
        end;
        Database::"User Support Incident": begin
            RecRef.SetTable(UserIncidences);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Incident;
            ApprovalEntryArgument."Document No.":=UserIncidences."Incident Reference";
            ApprovalEntryArgument.Description:=UserIncidences."Incident Description";
        end;
        Database::"Risk Header": begin
            RecRef.SetTable(RiskHeader);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::Risk;
            ApprovalEntryArgument."Document No.":=RiskHeader."No.";
            ApprovalEntryArgument.Description:=RiskHeader."Risk Category Description";
        end;
        //TransportIncident
        Database::"Transport Incident": begin
            RecRef.SetTable(TransportIncident);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Transport Incident";
            ApprovalEntryArgument."Document No.":=TransportIncident."Incident Reference";
            ApprovalEntryArgument.Description:=TransportIncident."Incident Description";
        end;
        //Driverlogging
        Database::"Driver Logging": begin
            RecRef.SetTable(DriverLogging);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Driver Logging";
            ApprovalEntryArgument."Document No.":=DriverLogging."Log No.";
            ApprovalEntryArgument.Description:=DriverLogging.Driver;
        end;
        //ActivityWorkProgramme
        Database::"Activity Work Programme": begin
            RecRef.SetTable(Workprogramme);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::"Activity WorkProgramme";
            ApprovalEntryArgument."Document No.":=Workprogramme."No.";
            ApprovalEntryArgument.Description:=Workprogramme.Description;
        end;
        //Project Management
        Database::projectman: begin
            Recref.settable(ProjectMan);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=projectman."Project No.";
            ApprovalEntryArgument.Description:=projectman."project Name";
        end;
        //Contract Management
        Database::"Project Header": begin
            Recref.settable(ContractMan);
            ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
            ApprovalEntryArgument."Document No.":=Contractman."No.";
            ApprovalEntryArgument.Description:=Contractman."Project Name";
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; VAR Variant: Variant; VAR IsHandled: Boolean)
    var
        Payments: Record Payments;
        Req: Record "Internal Request Header";
        TransportRequest: Record "Travel Requests";
        LeaveRequest: Record "Leave Application";
        SampleAnalysis: Record "Sample Analysis And Reporting";
        RecruitmentRequest: Record "Recruitment Needs";
        TrainingReq: Record "Training Request";
        EmployeeTransfer: Record "Employee Transfers";
        EmployeeAppraisal: Record "Employee Appraisal";
        LeaveRecall: Record "Employee Off/Holiday";
        PayrollChange: Record "Payroll Change Header";
        PayrollRequest: Record "Payroll Requests";
        LoanApplication: Record "Loan Application";
        EmpActing: Record "Employee Acting Position";
        Budget: Record "Budget Approval Header";
        ProposedBudget: Record "G/L Budget Name";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        LeaveAdj: Record "Leave Bal Adjustment Header";
        NewEmployeeAppraisal: Record "Employee Appraisal";
        TenderEval: Record "Tender Evaluation Header";
        SupEval: Record "Supplier Evaluation Header";
        FADisposal: Record "FA Disposal";
        AssetTransfer: Record "Asset Allocation and Transfer";
        TenderCommittee: Record "Tender Committees";
        ProqChange: Record "Procurement Change Request";
        ContChange: Record "Contract Change Header";
        ProcRequest: Record "Procurement Request";
        Audit: Record "Audit Header";
        ResearchActivity: Record "Research Activity Plan";
        Partnership: Record "Partnerships Activity Plan";
        ResearchSurvey: Record "Research and survey Workplan";
        ItemJnl: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        LabSchedule: Record "Lab Annual Testing Schedule";
        AssetDisposal: Record "AnnualDisposal Header";
        LicenseReg: Record "Licensing dairy Enterprise";
        LicenseApp: Record "License Applications";
        ICTWorkplan: Record "ICT Workplan";
        UserIncidences: Record "User Support Incident";
        RiskHeader: Record "Risk Header";
        TransportIncident: Record "Transport Incident";
        DriverLogging: Record "Driver Logging";
        Workprogramme: Record "Activity Work Programme";
        ProjectManagement: Record ProjectMan;
        ContractManagement: Record "Project Header";
        TargetSetup: Record "Target Setup Header";
        PayrollApproval: Record "Payroll Approval";
        ProspectiveSuppliers: Record "Prospective Suppliers";
    begin
        //Modifications by Eddie BPIT Ltd
        CASE RecRef.NUMBER OF //Payments
        DATABASE::Payments: BEGIN
            RecRef.SETTABLE(Payments);
            Payments.VALIDATE(Status, Payments.Status::"Pending Approval");
            Payments.MODIFY(TRUE);
            Variant:=Payments;
            IsHandled:=true;
        END;
        //Asset transfer
        DATABASE::"Asset Allocation and Transfer": BEGIN
            RecRef.SETTABLE(AssetTransfer);
            AssetTransfer.VALIDATE(Status, AssetTransfer.Status::"Pending Approval");
            AssetTransfer.MODIFY(TRUE);
            Variant:=AssetTransfer;
            IsHandled:=true;
        END;
        //Tender Committee
        DATABASE::"Tender Committees": BEGIN
            RecRef.SETTABLE(TenderCommittee);
            TenderCommittee.VALIDATE(Status, TenderCommittee.Status::"Pending Approval");
            TenderCommittee.MODIFY(TRUE);
            Variant:=TenderCommittee;
            IsHandled:=true;
        END;
        //Procurement Change Request
        DATABASE::"Procurement Change Request": BEGIN
            RecRef.SETTABLE(ProqChange);
            ProqChange.VALIDATE(Status, ProqChange.Status::"Pending Approval");
            ProqChange.MODIFY(TRUE);
            Variant:=ProqChange;
            IsHandled:=true;
        END;
        Database::"Contract Change Header": begin
            RecRef.SETTABLE(ContChange);
            ContChange.VALIDATE(Status, ContChange.Status::"Pending Approval");
            ContChange.MODIFY(TRUE);
            Variant:=ContChange;
            IsHandled:=true;
        end;
        //Requisitions
        Database::"Internal Request Header": begin
            RecRef.SetTable(Req);
            Req.Validate(Status, Req.Status::"Pending Approval");
            Req.Modify(true);
            Variant:=Req;
            IsHandled:=true;
        end;
        //Proc Requests
        Database::"Procurement Request": begin
            RecRef.SetTable(ProcRequest);
            ProcRequest.Validate(Status, ProcRequest.Status::"Pending Approval");
            ProcRequest.Modify(true);
            Variant:=ProcRequest;
            IsHandled:=true;
        end;
        //Sample Anlaysis
        Database::"Sample Analysis And Reporting": begin
            RecRef.SetTable(SampleAnalysis);
            SampleAnalysis.Validate(Status, SampleAnalysis.Status::"Pending Approval");
            SampleAnalysis.Modify(true);
            Variant:=SampleAnalysis;
            IsHandled:=true;
        end;
        Database::"Payroll Approval": begin
            RecRef.SetTable(PayrollApproval);
            PayrollApproval.Validate(Status, PayrollApproval.Status::"Pending Approval");
            PayrollApproval.Modify(true);
            Variant:=PayrollApproval;
            IsHandled:=true;
        end;
        //Employee Transfer
        Database::"Employee Transfers": begin
            RecRef.SetTable(EmployeeTransfer);
            EmployeeTransfer.Validate(Status, EmployeeTransfer.Status::"Pending Approval");
            EmployeeTransfer.Modify(true);
            Variant:=EmployeeTransfer;
            IsHandled:=true;
        end;
        //Travel Requests
        DATABASE::"Travel Requests": BEGIN
            RecRef.SETTABLE(TransportRequest);
            TransportRequest.VALIDATE(Status, TransportRequest.Status::"Pending Approval");
            TransportRequest.MODIFY(TRUE);
            Variant:=TransportRequest;
            IsHandled:=true;
        END;
        //Leave Application
        DATABASE::"Leave Application": BEGIN
            RecRef.SETTABLE(LeaveRequest);
            LeaveRequest.VALIDATE(Status, LeaveRequest.Status::"Pending Approval");
            LeaveRequest.MODIFY(TRUE);
            Variant:=LeaveRequest;
            IsHandled:=true;
        END;
        //Recruitment Needs
        DATABASE::"Recruitment Needs": BEGIN
            RecRef.SETTABLE(RecruitmentRequest);
            RecruitmentRequest.VALIDATE(Status, RecruitmentRequest.Status::"Pending Approval");
            RecruitmentRequest.MODIFY(TRUE);
            Variant:=RecruitmentRequest;
            IsHandled:=true;
        END;
        //Prospective Suppliers:
        DATABASE::"Prospective Suppliers": BEGIN
            RecRef.SETTABLE(ProspectiveSuppliers);
            ProspectiveSuppliers.VALIDATE(Status, ProspectiveSuppliers.Status::"Pending Approval");
            ProspectiveSuppliers.MODIFY(TRUE);
            Variant:=ProspectiveSuppliers;
            IsHandled:=true;
        END;
        //TrainingRequest
        DATABASE::"Training Request": BEGIN
            RecRef.SETTABLE(TrainingReq);
            TrainingReq.VALIDATE(Status, TrainingReq.Status::"Pending Approval");
            TrainingReq.MODIFY(TRUE);
            Variant:=TrainingReq;
            IsHandled:=true;
        END;
        //Leave Recall
        DATABASE::"Employee Off/Holiday": BEGIN
            RecRef.SETTABLE(LeaveRecall);
            LeaveRecall.VALIDATE(Status, LeaveRecall.Status::"Pending Approval");
            LeaveRecall.MODIFY(TRUE);
            Variant:=LeaveRecall;
            IsHandled:=true;
        END;
        //Target Setup Header
        DATABASE::"Target Setup Header": BEGIN
            RecRef.SETTABLE(TargetSetup);
            TargetSetup.VALIDATE("Target Status", TargetSetup."Target Status"::"Under Review");
            TargetSetup.Modify(true);
            Variant:=TargetSetup;
            IsHandled:=true;
        END;
        //Loan Application
        DATABASE::"Loan Application": BEGIN
            RecRef.SETTABLE(LoanApplication);
            LoanApplication.VALIDATE("Loan Status", LoanApplication."Loan Status"::"Being Processed");
            LoanApplication.MODIFY(TRUE);
            Variant:=LoanApplication;
            IsHandled:=true;
        END;
        //EmpActing
        DATABASE::"Employee Acting Position": BEGIN
            RecRef.SETTABLE(EmpActing);
            EmpActing.VALIDATE(Status, EmpActing.Status::"Pending Approval");
            EmpActing.MODIFY(TRUE);
            Variant:=EmpActing;
            IsHandled:=true;
        END;
        //Budget
        DATABASE::"Budget Approval Header": BEGIN
            RecRef.SETTABLE(Budget);
            Budget.VALIDATE(Status, Budget.Status::"Pending Approval");
            Budget.MODIFY(TRUE);
            Variant:=Budget;
            IsHandled:=true;
        END;
        //Proposed Budget
        DATABASE::"G/L Budget Name": BEGIN
            RecRef.SETTABLE(ProposedBudget);
            ProposedBudget.VALIDATE("Budget Status", ProposedBudget."Budget Status"::"Pending Approval");
            ProposedBudget.MODIFY(TRUE);
            Variant:=ProposedBudget;
            IsHandled:=true;
        END;
        //Bank Rec
        DATABASE::"Bank Acc. Reconciliation": BEGIN
            RecRef.SETTABLE(BankAccReconciliation);
            BankAccReconciliation.VALIDATE("Approval Status", BankAccReconciliation."Approval Status"::"Pending Approval");
            BankAccReconciliation.MODIFY(TRUE);
            Variant:=BankAccReconciliation;
            IsHandled:=true;
        END;
        //Leave Adj
        DATABASE::"Leave Bal Adjustment Header": BEGIN
            RecRef.SETTABLE(LeaveAdj);
            LeaveAdj.VALIDATE(Status, LeaveAdj.Status::"Pending Approval");
            LeaveAdj.MODIFY(TRUE);
            Variant:=LeaveAdj;
            IsHandled:=true;
        END;
        //New Employee Appraisal
        DATABASE::"Employee Appraisal": begin
            RecRef.SetTable(NewEmployeeAppraisal);
            if NewEmployeeAppraisal.Status = NewEmployeeAppraisal.Status::Open then NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Pending Approval")
            else
                NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Mid-Year Approved");
            NewEmployeeAppraisal.Validate("Appraisal Status", NewEmployeeAppraisal."Appraisal Status"::Set);
            NewEmployeeAppraisal.Modify(true);
            Variant:=NewEmployeeAppraisal;
            IsHandled:=true;
        end;
        DATABASE::"Tender Evaluation Header": BEGIN
            RecRef.SETTABLE(TenderEval);
            TenderEval.VALIDATE(Status, TenderEval.Status::"Pending Approval");
            TenderEval.MODIFY(TRUE);
            Variant:=TenderEval;
            IsHandled:=true;
        END;
        Database::"Supplier Evaluation Header": begin
            RecRef.SetTable(SupEval);
            SupEval.Validate(Status, SupEval.Status::"Pending Approval");
            SupEval.Modify(true);
            Variant:=SupEval;
            IsHandled:=true;
        end;
        //FA Disposal
        Database::"FA Disposal": begin
            RecRef.SetTable(FADisposal);
            FADisposal.Validate(Status, FADisposal.Status::"Pending Approval");
            FADisposal.Modify(true);
            Variant:=FADisposal;
            IsHandled:=true;
        end;
        //Audit
        DATABASE::"Audit Header": BEGIN
            RecRef.SETTABLE(Audit);
            Audit.VALIDATE(Status, Audit.Status::"Pending Approval");
            Audit.MODIFY(TRUE);
            Variant:=Audit;
            IsHandled:=true;
        END;
        //research activity plan
        Database::"Research Activity Plan": begin
            RecRef.SetTable(ResearchActivity);
            ResearchActivity.Validate(Status, ResearchActivity.Status::"Pending Approval");
            ResearchActivity.Modify(true);
            Variant:=ResearchActivity;
            IsHandled:=true;
        end;
        //Partnerships activity plan
        Database::"Partnerships Activity Plan": begin
            RecRef.SetTable(Partnership);
            Partnership.Validate(Status, Partnership.Status::"Pending Approval");
            Partnership.Modify(true);
            Variant:=Partnership;
            IsHandled:=true;
        end;
        //Research survey activity plan
        Database::"Research and survey Workplan": begin
            RecRef.SetTable(ResearchSurvey);
            ResearchSurvey.Validate(Status, ResearchSurvey.Status::"Pending Approval");
            ResearchSurvey.Modify(true);
            Variant:=ResearchSurvey;
            IsHandled:=true;
        end;
        //Item Jnl batch
        DATABASE::"Item Journal Batch": BEGIN
            RecRef.SETTABLE(ItemJnl);
            ItemJnl.Validate(Status, ItemJnl.Status::Pending);
            ItemJnl.Modify(true);
            Variant:=ItemJnl;
            IsHandled:=true;
        END;
        //Item Jnl Line
        DATABASE::"Item Journal Line": BEGIN
            RecRef.SETTABLE(ItemJnlLine);
            ItemJnlLine.Validate(Status, ItemJnlLine.Status::Pending);
            ItemJnlLine.Modify(true);
            Variant:=ItemJnlLine;
            IsHandled:=true;
        END;
        //Lab schedule
        DATABASE::"Lab Annual Testing Schedule": BEGIN
            RecRef.SETTABLE(LabSchedule);
            LabSchedule.Validate(Status, LabSchedule.Status::"Pending Approval");
            LabSchedule.Modify(true);
            Variant:=LabSchedule;
            IsHandled:=true;
        END;
        //Annual schedule
        DATABASE::"AnnualDisposal Header": BEGIN
            RecRef.SETTABLE(AssetDisposal);
            AssetDisposal.Validate(Status, AssetDisposal.Status::"Pending Approval");
            AssetDisposal.Modify(true);
            Variant:=AssetDisposal;
            IsHandled:=true;
        END;
        //LicenseRegistration
        DATABASE::"Licensing dairy Enterprise": BEGIN
            RecRef.SETTABLE(LicenseReg);
            LicenseReg.Validate("Approval Status", LicenseReg."Approval Status"::"Pending Approval");
            LicenseReg.Modify(true);
            Variant:=LicenseReg;
            IsHandled:=true;
        END;
        //LicenseApplication
        DATABASE::"License Applications": BEGIN
            RecRef.SETTABLE(LicenseApp);
            LicenseApp.Validate("Approval Status", LicenseApp."Approval Status"::"Pending Approval");
            LicenseApp.Submitted:=true;
            LicenseApp.Modify(true);
            Variant:=LicenseApp;
            IsHandled:=true;
        END;
        //ICTWorkplan
        DATABASE::"ICT Workplan": BEGIN
            RecRef.SETTABLE(ICTWorkplan);
            ICTWorkplan.Validate("Status", ICTWorkplan."Status"::"Pending Approval");
            ICTWorkplan.Modify(true);
            Variant:=ICTWorkplan;
            IsHandled:=true;
        END;
        //UserIncident
        DATABASE::"User Support Incident": BEGIN
            RecRef.SETTABLE(UserIncidences);
            UserIncidences.Validate("Status", UserIncidences."Approval Status"::"Pending Approval");
            UserIncidences.Modify(true);
            Variant:=UserIncidences;
            IsHandled:=true;
        END;
        //  RiskHeader: Record "Risk Header";
        DATABASE::"Risk Header": BEGIN
            RecRef.SETTABLE(RiskHeader);
            RiskHeader.Validate("Status", RiskHeader."Status"::"Pending Approval");
            RiskHeader.Modify(true);
            Variant:=RiskHeader;
            IsHandled:=true;
        END;
        //TransportIncident
        DATABASE::"Transport Incident": BEGIN
            RecRef.SETTABLE(TransportIncident);
            TransportIncident.Validate("Status", TransportIncident."Status"::"Pending Approval");
            TransportIncident.Modify(true);
            Variant:=TransportIncident;
            IsHandled:=true;
        END;
        //DriverLogging
        DATABASE::"Driver Logging": BEGIN
            RecRef.SETTABLE(DriverLogging);
            DriverLogging.Validate("Status", DriverLogging."Status"::"Pending Approval");
            DriverLogging.Modify(true);
            Variant:=DriverLogging;
            IsHandled:=true;
        END;
        //Workprogramme
        DATABASE::"Activity Work Programme": BEGIN
            RecRef.SETTABLE(Workprogramme);
            Workprogramme.Validate("Status", Workprogramme."Status"::"Pending Approval");
            Workprogramme.Modify(true);
            Variant:=Workprogramme;
            IsHandled:=true;
        END;
        //ProjectManagement  
        Database::"Projectman": Begin
            Recref.SetTable(ProjectManagement);
            ProjectManagement.Validate("Project Approval Status", ProjectManagement."Project Approval Status"::"Pending Approval");
            projectManagement.Modify(true);
            variant:=ProjectManagement;
            Ishandled:=true;
        End;
        //Contract Management  
        Database::"Project Header": Begin
            Recref.SetTable(ContractManagement);
            ContractManagement.Validate("Status", ContractManagement."Status"::"Pending Approval");
            ContractManagement.Modify(true);
            variant:=ContractManagement;
            Ishandled:=true;
        End;
        end;
    end;
    procedure ChooseApprover(): Boolean var
        UserSetup: Record "User Setup";
        UserDetails: Record User;
        Text111: Label 'Are you sure you want to setup %1 %2 as the approver?';
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if ACTION::LookupOK = PAGE.RunModal(Page::"Approval User Setup", UserSetup, UserSetup."Approver ID")then begin
            UserSetup.TestField("Approver ID");
            UserDetails.Reset;
            UserDetails.SetRange("User Name", UserSetup."Approver ID");
            if UserDetails.Find('-')then;
            if Confirm(Text111, false, UserDetails."User Name", UserDetails."Full Name")then exit(true)
            else
                exit(false);
        end;
    end;
}
