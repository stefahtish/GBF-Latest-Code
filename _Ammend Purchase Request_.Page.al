page 51317 "Ammend Purchase Request"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Reason/Description';
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Combine Order"; Rec."Combine Order")
                {
                    Caption = 'Combine Quote';
                    Visible = false;
                }
                group(Control22)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;
                    Visible = ShowDim;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                }
                field("Rejection Comment"; Rec."Rejection Comment")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = CommentVisible;
                }
                field("Ammend Requisition No."; Rec."Ammend Requisition No.")
                {
                }
            }
            part(PurchaseRequestSubform; "Purchase Request Subform")
            {
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = FIELD("No."), "Procurement Plan" = FIELD("Procurement Plan"), "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"), "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code");
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = ShowCommentFactbox;
            }
            systempart(Control12; Links)
            {
            }
            systempart(Control35; Notes)
            {
            }
            systempart(Control16; MyNotes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //BudgetControl.CheckBudgetPurchase(Rec);
                    Committment.CheckPurchReqCommittment(Rec);
                    Committment.PurchReqCommittment(Rec, ErrorMsg);
                    IF ErrorMsg <> '' THEN ERROR(ErrorMsg);
                    InternalRequestLine.reset;
                    InternalRequestLine.SetRange("Document No.", Rec."No.");
                    if InternalRequestLine.Find('-') then
                        repeat
                            InternalRequestLine.TestField(Quantity);
                        until InternalRequestLine.Next = 0;
                    if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendReqRequestforApproval(Rec);
                    /* //Check HOD approver
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."HOD User" then begin
                            ApprovalEntry.Reset;
                            ApprovalEntry.SetRange("Table ID", 50126);
                            ApprovalEntry.SetRange("Document No.", "No.");
                            ModifyHODApprovals.SetTableView(ApprovalEntry);
                            ModifyHODApprovals.RunModal;
                        end;
                    end; */
                    Commit;
                    CurrPage.Close;
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'View Approvals';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Print)
            {
                Caption = 'Print Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Purchase Request", true, true, PurchReq);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve For Request For Quotation';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Released";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm('Are you sure you want to approve PFR No. %1 and send it to Request For Quotation?', false, Rec."No.") = true then begin
                        Rec."Cleared For RFQ" := true;
                        Rec.Modify;
                        Commit;
                        Message('%1 Approved Successfully', Rec."No.");
                    end
                    else
                        exit;
                end;
            }
            action("Reject Approved PRF")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RFQVisible;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject PFR No. %1 ?', false, Rec."No.") = true then begin
                        IR.Reset;
                        IR.SetRange("No.", Rec."No.");
                        if IR.FindFirst then begin
                            RejectApprovedPRF.SetTableView(IR);
                            RejectApprovedPRF.RunModal;
                        end;
                    end
                    else
                        exit;
                end;
            }
            group(Action10)
            {
                Visible = false;

                action("Raise RFQ")
                {
                    Caption = 'Raise RFQ';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                            DocManager.CreateRFQRequest(Rec);
                            */
                    end;
                }
                action("Make Order")
                {
                    Caption = 'Create &LPO';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.Check(Rec) THEN
                        //DocManager.MakeOrder(Rec);
                        /*
                        OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(RECORDID);
                        IF OpenApprovalEntriesExist=TRUE THEN
                          ERROR(Text002)
                        ELSE
                          */
                        if Rec.Status <> Rec.Status::Released then Error('This requisition must be fully approved before ordering');
                        if Rec.Status = Rec.Status::Released then ProcurementMgt.MakeOrder(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Create RFQ")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create an RFQ for this requisition?', false) = true then begin
                            Rec.TestField(Status, Rec.Status::Released);
                            ProcurementMgt.CreateRFQ(Rec);
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Create LPO")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // IF CONFIRM('Are you sure you want to create an RFQ for this requisition?',FALSE)=TRUE THEN
                        //  BEGIN
                        //    TESTFIELD(Status,Status::Released);
                        //    ProcurementMgt.CreateRFQ(Rec);
                        //  END;
                        //
                        // COMMIT;
                        // CurrPage.CLOSE;
                    end;
                }
                action("Raise RFP")
                {
                    Caption = 'Raise RFP';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                            DocManager.CreateRFPRequest(Rec);
                            */
                    end;
                }
                action("Raise Tender")
                {
                    Caption = 'Raise Tender';
                    Image = DocInBrowser;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                            DocManager.CreateTenderRequest(Rec);
                            */
                    end;
                }
                action("Check Budget")
                {
                    Image = BreakRulesOff;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*BudgetControl.CheckBudgetPurchase(Rec);
                            MESSAGE(Text001);
                            */
                    end;
                }
                action("Request Over Expenditure")
                {
                    Image = BreakRulesOn;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('Complete');
                        //BudgetControl.CheckBudgetPurchase();
                    end;
                }
                action("Reverse Committment")
                {
                    trigger OnAction()
                    begin
                        Committment.ReversePurchReqCommittment(Rec);
                    end;
                }
                action("Commit Erroneous Entries")
                {
                    trigger OnAction()
                    begin
                        Committment.CheckPurchReqCommittment(Rec);
                        Committment.PurchReqCommittment(Rec, ErrorMsg);
                    end;
                }
                action(Archive)
                {
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive this document?', false) = true then begin
                            Rec.Status := Rec.Status::Archived;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        // ShowDimFields();
        // COMMIT;
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        //
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    trigger OnInit()
    begin
        ShowDim := true;
        RFQVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;
        Rec."Requisition Type" := Rec."Requisition Type"::Ammend;
    end;

    trigger OnOpenPage()
    begin
        //ShowDimFields();
        SetControlAppearance;
        Commit;
        /*Carol
            IF (Status=Status::Released) THEN Field supplier editable TRUE
            ELSE IF (Status=Status::Open); editable FALSE
            END
            */
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PurchReq: Record "Internal Request Header";
        Text001: Label 'Within Budget';
        [InDataSet]
        ShowDim: Boolean;
        ProcurementMgt: Codeunit "Procurement Management";
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        ApprovalEditable: Boolean;
        Text002: Label 'This document must be fully approved before making the order!!!';
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved",Released,Fulfilled;
        PaymentRec: Record Payments;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program","FA Disposal",Equity,Money_Market,Property,TPS,"Service Charge","Service Charge Claim";
        CombineVisible: Boolean;
        InternalRequestLine: Record "Internal Request Line";
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        RFQVisible: Boolean;
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
        CommentVisible: Boolean;
        RejectApprovedPRF: Report "Reject Approved PRF";
        IR: Record "Internal Request Header";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if Rec.Status <> Rec.Status::Released then
            RFQVisible := false
        else
            RFQVisible := true;
        if Rec."Rejection Comment" <> '' then
            CommentVisible := true
        else
            CommentVisible := false;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update;
    end;
}
