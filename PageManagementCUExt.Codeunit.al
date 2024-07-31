codeunit 50116 PageManagementCUExt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; VAR PageID: Integer)
    begin
        CASE RecordRef.NUMBER OF //Payments
        DATABASE::Payments: PageID:=(GetPaymentsPageID(RecordRef));
        //Sample Analysis
        DATABASE::"Sample Analysis And Reporting": PageID:=(page::"Sample Analysis Card");
        //Requisitions
        Database::"Internal Request Header": PageID:=(GetRequisitionsPageID(RecordRef));
        //Transport Req
        DATABASE::"Travel Requests": PageID:=(GetTransportPageID(RecordRef));
        //Leave adj
        //New emp appraisal
        DATABASE::"Employee Appraisal": PageID:=(PAGE::"Appraisal Card-Review");
        //New emp appraisal Target Setup
        DATABASE::"Target Setup Header": PageID:=(PAGE::"Target Setup Header");
        //tender Evaluation
        Database::"Tender Evaluation Header": PageID:=(Page::"Tender Evaluation");
        //Supplier Evaluation
        Database::"Supplier Evaluation Header": PageID:=(page::"Supplier Evaluation Card");
        //Recruitment Request
        Database::"Recruitment Needs": PageID:=(page::"Recruitment Request");
        //Budget approval
        Database::"Budget Approval Header": PageID:=(page::"Budget Approval Card");
        //Proposed Budget approval
        Database::"Proposed Budget Header": PageID:=(page::"Proposed Budget Card");
        Database::"Employee Acting Position": PageID:=(page::"Acting Position Card");
        Database::"Loan Application": PageID:=(page::"Loan Application Form-Payroll");
        Database::"FA Disposal": PageID:=(page::"FA Disposal Card");
        Database::"Employee Transfers": PageID:=(page::"Employee Transfer Card");
        //Audit
        DATABASE::"Audit Header": PageID:=(GetAuditPageID(RecordRef));
        //Asset transfe and allocation
        Database::"Asset Allocation and Transfer": PageID:=(GetAssetPageID(RecordRef));
        //Research
        DATABASE::"Research Activity Plan": PageID:=(GetResearchPageID(RecordRef));
        DATABASE::"Partnerships Activity Plan": PageID:=(PAGE::"Partnership support");
        DATABASE::"Research and survey Workplan": PageID:=(PAGE::"Research and survey workplan");
        //Item Journal
        Database::"Item Journal Batch": PageID:=(PAGE::"Item Journal Batches");
        DATABASE::"Item Journal Line": PageID:=(PAGE::"Item Journal Lines");
        Database::"Licensing dairy Enterprise": PageID:=(Page::"Applicant Registration");
        Database::"License Applications": PageID:=(Page::"License and Permit App card");
        Database::"Activity Work Programme": PageID:=(Page::"Activity Work Program");
        //Project PageManagement
        Database::ProjectMan: PageID:=(page::ProjectDataCaptureCard);
        //Contract PageManagement
        Database::"Project Header": PageID:=(GetContractPageID(RecordRef));
        //Leave Application
        Database::"Leave Application": PageID:=(page::"Emp Leave Application Card");
        //leave adjustment
        Database::"Leave Bal Adjustment Header": PageID:=(page::"Leave Adjustment Header");
        // tender committee
        Database::"Tender Committees": PageID:=(Page::Committee);
        Database::"Procurement Request": PageID:=(GetProcurementRequestPageID(RecordRef));
        END;
    end;
    Local procedure GetProcurementRequestPageID(RecordRef: RecordRef): Integer var
        ProcRequest: Record "Procurement Request";
    begin
        RecordRef.SETTABLE(ProcRequest);
        CASE ProcRequest."Process Type" OF ProcRequest."Process Type"::RFQ: EXIT(PAGE::"Quotation Card");
        ProcRequest."Process Type"::RFP: EXIT(PAGE::"RFP Card");
        ProcRequest."Process Type"::Tender: EXIT(PAGE::"Tender Card");
        END;
    end;
    Local procedure GetPaymentsPageID(RecordRef: RecordRef): Integer var
        Payments: Record Payments;
    begin
        //Modified by Brian for Different Payments
        RecordRef.SETTABLE(Payments);
        CASE Payments."Payment Type" OF Payments."Payment Type"::Imprest: EXIT(PAGE::Imprest);
        Payments."Payment Type"::"Imprest Surrender": EXIT(PAGE::"Imprest Surrender");
        Payments."Payment Type"::"Petty Cash": EXIT(PAGE::"Petty Cash");
        Payments."Payment Type"::"Petty Cash Surrender": EXIT(PAGE::"Petty Cash Surrender");
        Payments."Payment Type"::"Payment Voucher": EXIT(PAGE::"Payment Voucher");
        Payments."Payment Type"::"Staff Claim": EXIT(PAGE::"Staff Claim");
        Payments."Payment Type"::"Bank Transfer": EXIT(PAGE::"InterBank Transfer");
        END;
    end;
    Local procedure GetResearchPageID(RecordRef: RecordRef): Integer var
        Research: Record "Research Activity Plan";
    begin
        //Modified by Faith for Different research workplans
        RecordRef.SETTABLE(Research);
        CASE Research."Research type" OF Research."Research type"::Dairystds: EXIT(PAGE::"Dairy Stds Activity Plan");
        Research."Research type"::Export: EXIT(PAGE::"Promotion Activity Plan");
        Research."Research type"::Support: EXIT(PAGE::"Stake. Support Activity Plan");
        END;
    end;
    Local procedure GetAuditPageID(RecordRef: RecordRef): Integer var
        Audit: Record "Audit Header";
    begin
        //Modified by Brian for Different Payments
        RecordRef.SETTABLE(Audit);
        CASE Audit.Type OF Audit."Type"::"Work Paper": EXIT(PAGE::"Audit Working Paper");
        Audit."Type"::"Audit Report": if Audit."Report Status" = Audit."Report Status"::Audit then EXIT(PAGE::"Audit Report Card")
            else if Audit."Report Status" = Audit."Report Status"::Audit then EXIT(PAGE::"Auditee Report Card");
        Audit."Type"::"Audit Program": EXIT(PAGE::"Audit Program");
        END;
    end;
    local procedure GetRequisitionsPageID(RecordRef: RecordRef): Integer var
        IR: Record "Internal Request Header";
    begin
        RecordRef.SetTable(IR);
        case IR."Document Type" of IR."Document Type"::Purchase: exit(Page::"Purchase Request");
        IR."Document Type"::Stock: exit(Page::"Store Request");
        end;
    end;
    Local procedure GetTransportPageID(RecordRef: RecordRef): Integer var
        TravelReq: Record "Travel Requests";
    begin
        RecordRef.SETTABLE(TravelReq);
        EXIT(PAGE::"Transport Request");
    end;
    Local procedure GetAssetPageID(RecordRef: RecordRef): Integer var
        Asset: Record "Asset Allocation and Transfer";
    begin
        RecordRef.SETTABLE(Asset);
        if Asset.Type = Asset.Type::"Initial Allocation" then EXIT(PAGE::"Asset Allocation Card");
        if Asset.Type = Asset.Type::Transfer then EXIT(PAGE::"Asset Transfer Card");
    end;
    // local procedure GetProjManPageId(RecordRef: RecordRef): Integer
    // var
    // ProjectMa:Record ProjectMan;
    // begin
    //     RecordRef.SETTABLE(ProjectMa);
    //     exit(page::"ProjectInitCard");
    // end;
    Local procedure GetContractPageID(RecordRef: RecordRef): Integer var
        Contract: Record "Project Header";
    begin
        RecordRef.SETTABLE(Contract);
        if Contract.Type = Contract.Type::"Extension" then EXIT(PAGE::"Open Contract Extension");
        if Contract.Type = Contract.Type::"Suspension" then EXIT(PAGE::"Open Contract Suspension Card");
        if Contract.Type = Contract.Type::"Running" then EXIT(page::"Project Header Card");
    end;
}
