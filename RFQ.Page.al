page 50771 RFQ
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(RFQ));
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
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Reason/Description';
                    Editable = NOT OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Combine Order"; Rec."Combine Order")
                {
                    Caption = 'Combine Quote';
                }
                group(Control45)
                {
                    ShowCaption = false;
                    Visible = Rec.Reversed;

                    field(Reversed; Rec.Reversed)
                    {
                        Editable = false;
                    }
                    field("Reversed By"; Rec."Reversed By")
                    {
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                }
                group(Control22)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;
                    Visible = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                }
            }
            part(PurchaseRequestSubform; "RFQ Subform")
            {
                Caption = 'RFQ Subform';
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
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
                Visible = false;

                trigger OnAction()
                begin
                    //BudgetControl.CheckBudgetPurchase(Rec);
                    // Committment.CheckPurchReqCommittment(Rec);
                    // Committment.PurchReqCommittment(Rec,ErrorMsg);
                    // IF ErrorMsg<>'' THEN
                    //   ERROR(ErrorMsg);
                    if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendReqRequestforApproval(Rec);
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            action(Print)
            {
                Caption = 'Print Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Purchase Request", true, true, PurchReq);
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
                    Caption = 'Make &Quote';
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
                        if Rec.Status = Rec.Status::Released then ProcurementMgt.MakeQuote(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Create RFQ")
                {
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ProcurementMgt.CreateRFQ(Rec);
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
            }
            group(Action24)
            {
                action("Reverse GPR")
                {
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm(Text003, false) = true then begin
                            //MESSAGE(Rec."No.");
                            ProcMgt.ReverseGPRDocument(Rec);
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
        //ShowDimFields();
        // DocStatus:=PaymentRec.FormatStatus(Status);
        // DocStatus:=FormatStatus(Status);
        //
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;
    end;

    trigger OnOpenPage()
    begin
        //ShowDimFields();
        ShowDim := true;
        SetControlAppearance;
        /*Carol
            IF (Status=Status::Released) THEN Field supplier editable TRUE
            ELSE IF (Status=Status::Open); editable FALSE
            END
            */
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        //
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Travel";
        CombineVisible: Boolean;
        InternalRequestLine: Record "Internal Request Line";
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ProcMgt: Codeunit "Procurement Management";
        Text003: Label 'Are you sure you would like to Reverse this GPR?';
        ReversedVisible: Boolean;

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
