page 50787 "Store Request Customized"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Reject';
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Stock));
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
                group(Control17)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ShowMandatory = true;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ShowMandatory = true;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                    }
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Request Description';
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Required Date';
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Issuing Store';
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                group(Control33)
                {
                    ShowCaption = false;

                    field("Collected By"; Rec."Collected By")
                    {
                        Caption = 'Received By';
                        Editable = DocReleased AND NOT DocPosted;
                    }
                    field("Collected Name"; Rec."Collected Name")
                    {
                        Caption = 'Received Name';
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        Visible = NOT DocPosted;

                        trigger OnValidate()
                        begin
                            SetControlAppearance;
                        end;
                    }
                    field("SRN Type"; Rec."SRN Type")
                    {
                        Editable = Rec."Status" = Rec."Status"::Open;
                    }
                    field("Requested By"; Rec."Requested By")
                    {
                        Editable = false;
                    }
                    field(Posted; Rec.Posted)
                    {
                        Editable = false;
                        Visible = DocPosted;
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        Caption = 'Issued By';
                        Editable = false;
                        Visible = DocPosted;
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                        Caption = 'Issue Date';
                        Editable = false;
                    }
                    field("Time Posted"; Rec."Time Posted")
                    {
                        Editable = false;
                        Visible = DocPosted;
                    }
                    field("Total Amount"; Rec."Total Amount")
                    {
                    }
                    field("Rejection Comment"; Rec."Rejection Comment")
                    {
                        Editable = false;
                        Style = Attention;
                        StyleExpr = TRUE;
                        Visible = CommentVisible;
                    }
                }
            }
            part(StoreRequestSubform; "Store Request Subform")
            {
                Caption = 'Store Request Subform';
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
            systempart(Control23; Links)
            {
            }
            part("FactBox"; "Requests FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control20; Notes)
            {
            }
            systempart(Control9; MyNotes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = DocReleased AND NOT DocPosted;

                trigger OnAction()
                begin
                    //IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                    if Rec.Posted then Error(Text001);
                    Rec.TestField("Expected Receipt Date");
                    //TESTFIELD("Posting Date");
                    Rec.TestField("Reason Description");
                    Rec.TestField("Location Code");
                    Rec.TestField("Collected By");
                    ProcurementManager.PostInternalRequest(Rec);
                    Commit;
                    CurrPage.Close;
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    // IF ApprovalsMgmt.CheckRequisitionsApprovalsWorkflowEnabled(Rec) THEN
                    //  ApprovalsMgmt.OnSendRequisitionsForApproval(Rec);
                    Rec.TestField("Shortcut Dimension 1 Code");
                    Rec.TestField("Shortcut Dimension 2 Code");
                    Rec.TestField("Location Code");
                    if Confirm('Send SRN for approval?', false) = true then begin
                        if Rec."SRN Type" = Rec."SRN Type"::Consumables then begin
                            Committment.CheckStoreReqCommittment(Rec);
                            Committment.StoreReqCommittment(Rec, ErrorMsg);
                            if ErrorMsg <> '' then Error(ErrorMsg);
                        end;
                        Commit;
                        if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendReqRequestforApproval(Rec);
                        Commit;
                        //Check HOD approver
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset;
                                ApprovalEntry.SetRange("Table ID", 50126);
                                ApprovalEntry.SetRange("Document No.", Rec."No.");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal;
                            end;
                        end;
                    end;
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
                    //ApprovalsMgmt.OnCancelRequisitionsApprovalRequest(Rec);
                    if Confirm('Cancelling this approval request will uncommit the previously committed amount in the budget. Continue', false) = true then begin
                        //Committment.UncommitStoreReq(Rec);
                        ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                    end;
                end;
            }
            action("Create Purchase Request")
            {
                Caption = 'Create Purchase Request';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    //IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                    //DocManager.CreatePurchaseRequest(Rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance";
                begin
                    ApprovalEntries.Setrecordfilters(DATABASE::"Internal Request Header", DocType::"Store Requisitions", Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Print Issue Note")
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    IR.Reset;
                    IR.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Store Request", true, true, IR);
                end;
            }
            action("Reject Approved SRN")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = DocReleased AND NOT DocPosted;

                trigger OnAction()
                var
                    RejectApprovedPRF: Report "Reject Approved PRF";
                begin
                    if Confirm('Are you sure you want to reject SRN No. %1 ?', false, Rec."No.") = true then begin
                        //Uncommit first
                        Committment.UncommitStoreReq(Rec);
                        Commit;
                        IR.Reset;
                        IR.SetRange("No.", Rec."No.");
                        if IR.FindFirst then begin
                            RejectApprovedPRF.SetTableView(IR);
                            RejectApprovedPRF.RunModal;
                            Commit;
                        end;
                    end
                    else
                        exit;
                end;
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
    end;

    trigger OnInit()
    begin
        CommentVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
        //ShowDimFields();
    end;

    var
        ProcurementManager: Codeunit "Procurement Management";
        Text001: Label 'IR has already been posted';
        IR: Record "Internal Request Header";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Committment: Codeunit Committment;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RequestLines: Record "Internal Request Line";
        [InDataSet]
        ShowDim: Boolean;
        ShowCommentFactbox: Boolean;
        DocPosted: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ErrorMsg: Text;
        DocReleased: Boolean;
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
        CommentVisible: Boolean;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then DocReleased := true;
        if Rec."Rejection Comment" <> '' then
            CommentVisible := true
        else
            CommentVisible := false;
    end;

    local procedure testDimensions(DimId: Integer)
    begin
        case DimId of
            1:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 1 Code");
                        until RequestLines.Next = 0;
                end;
            2:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next = 0;
                end;
            3:
                begin
                    RequestLines.Reset;
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next = 0;
                end;
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
}
