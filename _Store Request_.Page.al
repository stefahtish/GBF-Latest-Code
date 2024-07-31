page 50749 "Store Request"
{
    DeleteAllowed = false;
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
                    // Enabled = false;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Enabled = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Request Description';
                    Enabled = NOT OpenApprovalEntriesExist;
                    NotBlank = true;
                }
                group(Control17)
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        NotBlank = true;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        //  NotBlank = true;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                    }
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Desired Date';
                    Enabled = NOT OpenApprovalEntriesExist;
                    NotBlank = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Issuing Store';
                    Enabled = NOT OpenApprovalEntriesExist;
                    NotBlank = true;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                group(Control33)
                {
                    ShowCaption = false;

                    field("Collected By"; Rec."Collected By")
                    {
                        Caption = 'Received By';
                        Enabled = DocReleased AND NOT DocPosted;
                    }
                    field("Collected Name"; Rec."Collected Name")
                    {
                        Caption = 'Received Name';
                        Enabled = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Enabled = false;
                        Visible = NOT DocPosted;

                        trigger OnValidate()
                        begin
                            SetControlAppearance;
                        end;
                    }
                    field("SRN Type"; Rec."SRN Type")
                    {
                        Enabled = Rec."Status" = Rec."Status"::Open;
                    }
                    field("Requested By"; Rec."Requested By")
                    {
                        Enabled = false;
                    }
                    field(Posted; Rec.Posted)
                    {
                        Enabled = false;
                        Visible = DocPosted;
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        Caption = 'Issued By';
                        Enabled = false;
                        Visible = DocPosted;
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                        Caption = 'Issue Date';
                        Enabled = false;
                    }
                    field("Time Posted"; Rec."Time Posted")
                    {
                        Enabled = false;
                        Visible = DocPosted;
                    }
                    field("Total Amount"; Rec."Total Amount")
                    {
                    }
                    field("Rejection Comment"; Rec."Rejection Comment")
                    {
                        Enabled = false;
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
                SubPageLink = "Document No." = FIELD("No.");
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
            action("Upload Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Upload documents for the record.';
                ApplicationArea = Basic, Suite;
                Visible = NOT DocReleased;

                trigger OnAction()
                var
                begin
                    //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                end;
            }
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
                    Committment.UncommitStoreReq(Rec);
                    Rec.Status := Rec.Status::Archived;
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
                    // TestField("Shortcut Dimension 1 Code");
                    //  Rec.TestField("Shortcut Dimension 2 Code");
                    Rec.TestField("Location Code");
                    Rec.TestField("Expected Receipt Date");
                    Rec.TestField("Reason Description");
                    if Confirm('Send SRN for approval?', false) = true then begin
                        if Rec."SRN Type" = Rec."SRN Type"::Consumables then begin
                            Committment.CheckStoreReqCommittment(Rec);
                            Committment.StoreReqCommittment(Rec, ErrorMsg);
                            if ErrorMsg <> '' then Error(ErrorMsg);
                        end;
                        if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendReqRequestforApproval(Rec);
                        // Check HOD approver
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

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    //ApprovalsMgmt.OnCancelRequisitionsApprovalRequest(Rec);
                    if Confirm('Cancelling this approval request will uncommit the previously committed amount in the budget. Continue', false) = true then begin
                        //Committment.UncommitStoreReq(Rec);
                        ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                        Committment.CancelIRCommitments(Rec);
                    end;
                    Commit;
                    CurrPage.Close;
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                    //DocManager.CreatePurchaseRequest(Rec);
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
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = DocReleased AND NOT DocPosted;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject this document?', false) = true then begin
                        //Clear all approval entries
                        ApprovalEntry.Reset;
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntry.DeleteAll;
                        Commit;
                        //Prompt and Insert Rejection Comment
                        if RejectionComments.RunModal = ACTION::OK then begin
                            RejectComment := RejectionComments.GetRejectComment;
                            if RejectComment = '' then Error('Please input rejection comment');
                            Rec."Rejection Comment" := RejectComment;
                            Rec.Modify;
                        end;
                        Commit;
                        //Uncommit
                        Committment.UncommitStoreReq(Rec);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Commit;
                        Message('%1 rejected successfully', Rec."No.");
                    end;
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
                        Committment.UncommitStoreReq(Rec);
                        Rec.Status := Rec.Status::Archived;
                        Rec.Modify;
                    end;
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
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

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
    // local procedure testDimensions(DimId: Integer)
    // begin
    //     case DimId of
    //         1:
    //             begin
    //                 RequestLines.Reset;
    //                 RequestLines.SetRange("Document No.", "No.");
    //                 RequestLines.SetRange("Document Type", "Document Type");
    //                 if RequestLines.Find('-') then
    //                     repeat
    //                         RequestLines.TestField("Shortcut Dimension 1 Code");
    //                     until RequestLines.Next = 0;
    //             end;
    //         2:
    //             begin
    //                 RequestLines.Reset;
    //                 RequestLines.SetRange("Document No.", "No.");
    //                 RequestLines.SetRange("Document Type", "Document Type");
    //                 if RequestLines.Find('-') then
    //                     repeat
    //                         RequestLines.TestField("Shortcut Dimension 3 Code");
    //                     until RequestLines.Next = 0;
    //             end;
    //         3:
    //             begin
    //                 RequestLines.Reset;
    //                 RequestLines.SetRange("Document No.", "No.");
    //                 RequestLines.SetRange("Document Type", "Document Type");
    //                 if RequestLines.Find('-') then
    //                     repeat
    //                         RequestLines.TestField("Shortcut Dimension 3 Code");
    //                     until RequestLines.Next = 0;
    //             end;
    //     end;
    // end;
    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update;
    end;
}
