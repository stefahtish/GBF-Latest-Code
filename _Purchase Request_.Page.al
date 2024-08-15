page 50752 "Purchase Request"
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
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Date';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    //Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Apply On Behalf Of Committee"; Rec."Apply On Behalf Of Committee")
                {
                    ToolTip = 'Specifies the value of the Apply On Behalf Of Committee field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Committee; Rec.Committee)
                {
                    ToolTip = 'Specifies the value of the Committee field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = Rec."Apply On Behalf Of Committee";
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reason/Description';
                    //Visible = false;
                    Enabled = NOT OpenApprovalEntriesExist;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                group("Supplier Details")
                {
                    ShowCaption = false;
                    Visible = IsVisible;

                    field("Supplier category"; Rec."Supplier category")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Supply code';
                        Visible = false;
                    }
                    field("Supplier category Description"; Rec."Supplier category Description")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Supply code description';
                        Enabled = false;
                        Visible = false;
                    }
                    field("Supplier Subcategory"; Rec."Supplier Subcategory")
                    {
                        Caption = 'Supply subcode';
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field("Supplier Subcategory Desc"; Rec."Supplier Subcategory Desc")
                    {
                        Caption = 'Supply subcode description';
                        Enabled = false;
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    ApplicationArea = Basic, Suite;
                    visible = false;
                }
                field("Combine Order"; Rec."Combine Order")
                {
                    Caption = 'Combine Quote';
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                group(Control22)
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;
                    Visible = ShowDim;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field(completed; Rec.Completed)
                    {
                        ApplicationArea = all;
                    }
                    field("Insert Other Items"; Rec."Insert Other Items")
                    {
                        ToolTip = 'Specifies the value of the Insert Other Items field.';
                        ApplicationArea = All;
                        Visible = false;

                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                }
                field("Rejection Comment"; Rec."Rejection Comment")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = CommentVisible;
                }
            }
            part(PurchaseRequestSub; "Purchase Request Sub")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = Rec."Insert Other Items" = true;
            }
            part(PurchaseRequestSubform; "Purchase Request Subform")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = FIELD("No."), "Procurement Plan" = FIELD("Procurement Plan");
                UpdatePropagation = Both;
                Visible = Rec."Insert Other Items" = false;
            }
            field("Total Amount"; Rec."Total Amount")
            {
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("No.");
            }
            // part("Document Links Part"; "Document Links Part")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Record ID" = 
            // }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = ShowCommentFactbox;
            }
            systempart(Control12; Links)
            {
            }
            part("FactBox"; "Requests FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
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
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Upload documents for the record.';
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                    begin
                        //   FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
                action("Create Purchase Order")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Order;
                    visible = Rec.status = Rec.status::Released;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLine: Record "Purchase Line";
                        LpurchasePayable: Record "Purchases & Payables Setup";
                        Noseries: Codeunit NoSeriesManagement;
                        IntRequestLine: Record "Internal Request Line";
                        docNo: Code[20];
                        LineNo: integer;
                        UserResponse: Boolean;
                    begin
                        UserResponse := CONFIRM('Please confirm you want to create a Purchase order', false);
                        if UserResponse then begin
                            LineNo := 10000;
                            IntRequestLine.SetRange("Document No.", Rec."No.");
                            IntRequestLine.SetRange(LPO, true);
                            IntRequestLine.SetRange(Completed, false);
                            if IntRequestLine.FindFirst() then begin
                                PurchaseHeader.Init();
                                PurchaseHeader."Document Type" := DocumentType::Order;
                                LpurchasePayable.Get();
                                docNo := Noseries.GetNextNo(LpurchasePayable."Order Nos.", today, true);
                                PurchaseHeader."No." := docNo;
                                PurchaseHeader."Order Date" := Today;
                                PurchaseHeader."Buy-from Vendor No." := IntRequestLine.Supplier;
                                PurchaseHeader.Validate("Buy-from Vendor No.");
                                PurchaseHeader.Insert();
                                repeat
                                    if (IntRequestLine.Type2 = IntRequestLine.Type2::" ") or (IntRequestLine."Charge to No." = '') or (IntRequestLine.Supplier = '') then Error('Supplier charge to and Type must all have a value');
                                    LineNo := LineNo + 10000;
                                    PurchaseLine."Document No." := docNo;
                                    PurchaseLine."Line No." := LineNo;
                                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::order;
                                    PurchaseLine.type := IntRequestLine.Type2;
                                    PurchaseLine."No." := IntRequestLine."Charge to No.";
                                    PurchaseLine.Validate("No.");
                                    PurchaseLine.Description := IntRequestLine.Description;
                                    PurchaseLine.Quantity := IntRequestLine.Quantity;
                                    PurchaseLine."Unit of Measure" := IntRequestLine."Unit of Measure";
                                    PurchaseLine."Buy-from Vendor No." := IntRequestLine.Supplier;
                                    IntRequestLine.Completed := true;
                                    IntRequestLine."PO No." := docNo;
                                    IntRequestLine.Modify();
                                    PurchaseLine.Insert() until IntRequestLine.Next() = 0;
                                message('Converted successfully')
                            end;
                        end;
                    end;
                }
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                ApplicationArea = basic, Suite;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //BudgetControl.CheckBudgetPurchase(Rec);
                    Rec.TestField("Reason Description");
                    Committment.CheckPurchReqCommittment(Rec);
                    Committment.PurchReqCommittment(Rec, ErrorMsg);
                    IF ErrorMsg <> '' THEN ERROR(ErrorMsg);
                    // InternalRequestLine.reset;
                    // InternalRequestLine.SetRange("Document No.", "No.");
                    // InternalRequestLine.SetFilter(Type, '<>%1', InternalRequestLine.Type::"G/L Account");
                    // if InternalRequestLine.Find('-') then
                    //     repeat
                    //         InternalRequestLine.TestField(Quantity);
                    //     until InternalRequestLine.Next = 0;
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
                ApplicationArea = basic, Suite;
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
                ApplicationArea = basic, Suite;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Print)
            {
                Caption = 'Print Requisition';
                Image = Print;
                Promoted = true;
                ApplicationArea = basic, Suite;
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
                ApplicationArea = basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                //Visible = Rec."Status" = Rec."Status"::"Released";
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
                // Visible = RFQVisible;
                ApplicationArea = basic, Suite;
                Visible = false;

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
                    ApplicationArea = basic, Suite;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    end;
                }
                action("Create RFQ")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = basic, Suite;
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
                    ApplicationArea = basic, Suite;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to create an RFQ for this requisition?', FALSE) = TRUE THEN BEGIN
                            rec.TESTFIELD(Status, rec.Status::Released);
                            ProcurementMgt.CreateRFQ(Rec);
                        END;

                        COMMIT;
                        CurrPage.CLOSE;
                    end;
                }
                action("Raise RFP")
                {
                    Caption = 'Raise RFP';
                    Image = Documents;
                    ApplicationArea = basic, Suite;
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
                    ApplicationArea = basic, Suite;
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
                    ApplicationArea = basic, Suite;
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
                    ApplicationArea = basic, Suite;

                    trigger OnAction()
                    begin
                        Committment.ReversePurchReqCommittment(Rec);
                    end;
                }
                action("Commit Erroneous Entries")
                {
                    ApplicationArea = basic, Suite;

                    trigger OnAction()
                    begin
                        Committment.CheckPurchReqCommittment(Rec);
                        Committment.PurchReqCommittment(Rec, ErrorMsg);
                    end;
                }
                action(Archive)
                {
                    Image = Archive;
                    ApplicationArea = basic, Suite;
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
    end;

    trigger OnOpenPage()
    begin
        //ShowDimFields();
        SetControlAppearance;
        Commit;
        /*Carol
            IF (Status=Status::Released) THEN Field supplier Enabled TRUE
            ELSE IF (Status=Status::Open); Enabled FALSE
            END
            */
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;
    // procedure GetRecordID(): RecordId
    // begin
    //     InternalRequestLine.Reset();
    //     InternalRequestLine.SetRange("Document No.", Rec."No.");
    //     InternalRequestLine.SetRange("Procurement Plan", Rec."Procurement Plan");
    //     if InternalRequestLine.Find('-') then
    //         exit(InternalRequestLine.RecordId);
    // end;
    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PurchReq: Record "Internal Request Header";
        Text001: Label 'Within Budget';
        [InDataSet]
        ShowDim: Boolean;
        //"Insert Other Items": Boolean;
        IsVisible: Boolean;
        ProcurementMgt: Codeunit "Procurement Management";
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        ApprovalEnabled: Boolean;
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
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        Rec.GetDueDate();
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
        case Rec.Status of
            Rec.Status::Released:
                IsVisible := true;
        end;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update;
    end;
    // procedure SetPageControl()
    // var
    //     myInt: Integer;
    // begin
    //     if "Insert Other Items" then
    //         //Charges := true
    // end;
}
