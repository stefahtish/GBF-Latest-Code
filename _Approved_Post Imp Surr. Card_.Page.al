page 50244 "Approved/Post Imp Surr. Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Payments;
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
                    ApplicationArea = basic, suite;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ApplicationArea = basic, suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ApplicationArea = basic, suite;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ImprestRec.Reset;
                        ImprestRec.SetRange("Payment Type", Rec."Payment Type"::Imprest);
                        ImprestRec.SetRange(Surrendered, false);
                        ImprestRec.SetRange("Account No.", Rec."Account No.");
                        if ACTION::LookupOK = PAGE.RunModal(Page::"Posted Imprests", ImprestRec) then begin
                            Rec."Imprest Issue Doc. No" := ImprestRec."No.";
                            Rec.Validate("Imprest Issue Doc. No");
                        end;
                    end;
                }
                group(Control52)
                {
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Editable = false;
                        ApplicationArea = basic, suite;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Editable = false;
                        ApplicationArea = basic, suite;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                        ApplicationArea = basic, suite;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = basic, suite;
                }
                field(Currency; Rec.Currency)
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                    ApplicationArea = basic, suite;
                }
                field(Narration; Rec."Payment Narration")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ApplicationArea = basic, suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                group(Control47)
                {
                    Editable = false;
                    ShowCaption = false;

                    field(Destination; Rec.Destination)
                    {
                        ApplicationArea = basic, suite;
                    }
                    field("No of Days"; Rec."No of Days")
                    {
                        ApplicationArea = basic, suite;
                    }
                    field("Date of Project"; Rec."Date of Project")
                    {
                        ApplicationArea = basic, suite;
                        Visible = false;
                    }
                    field("Date of Completion"; Rec."Date of Completion")
                    {
                        ApplicationArea = basic, suite;
                        Visible = false;
                    }
                    field("Due Date"; Rec."Due Date")
                    {
                        ApplicationArea = basic, suite;
                    }
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = basic, suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = basic, suite;
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    ApplicationArea = basic, suite;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
                group("Apportion?")
                {
                    Caption = 'Apportion?';

                    field("No Apportion"; Rec."No Apportion")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'No';
                        Visible = false;
                    }
                    field(Apportion; Rec.Apportion)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Yes';
                        Visible = false;
                    }
                }
            }
            part(Control19; "Imprest Surrender Lines")
            {
                ApplicationArea = basic, suite;
                // Visible = ActivityImp;
                SubPageLink = No = FIELD("No."), "Payment Type" = FIELD("Payment Type");
            }
            part(ExtImprestSurrender; "Ext Imprest Surrender Lines")
            {
                Caption = 'External Imprest Surrender Lines';
                ApplicationArea = basic, suite;
                // Visible = ActivityImp;
                Visible = false;
                SubPageLink = No = FIELD("No."), "Payment Type" = FIELD("Payment Type");
            }
            part(Control20; "Imprest Surrender Lines2")
            {
                ApplicationArea = basic, suite;
                UpdatePropagation = Both;
                caption = 'Lines';
                Visible = Facilitators or OfficeImp;
                SubPageLink = No = FIELD("No."), "Payment Type" = FIELD("Payment Type");
            }
            part(Control21; "Imprest Surrender Lines3")
            {
                ApplicationArea = basic, suite;
                UpdatePropagation = Both;
                caption = 'Lines';
                Visible = ItemImp;
                SubPageLink = No = FIELD("No."), "Payment Type" = FIELD("Payment Type");
            }
            part(Control61; "Apportionment Allocation Lines")
            {
                ApplicationArea = basic, suite;
                Editable = NOT Rec.Posted;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = Rec.Apportion;

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
            systempart(Control16; Notes)
            {
            }
            systempart(Control17; MyNotes)
            {
            }
            systempart(Control18; Links)
            {
            }
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                Image = "Order";

                action("Co&mments")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = basic, suite;
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
                        ApprovalEntry.SetRange("Table ID", Database::Payments);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.RunModal();
                    end;
                }
                action(Navigate)
                {
                    ApplicationArea = basic, suite;
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
                    Visible = DocPosted;

                    trigger OnAction()
                    begin
                        Rec.Navigate;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Surrender Date");
                        Rec.ValidateSurrender();
                        // Committment.CheckImprestSurrenderCommittment(Rec);
                        // Committment.ImprestSurrenderCommittment(Rec,ErrorMsg);
                        //
                        // IF ErrorMsg<>'' THEN
                        //  ERROR(ErrorMsg);
                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
                        Commit;
                        //Check HOD approver
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset;
                                ApprovalEntry.SetRange("Table ID", 50121);
                                ApprovalEntry.SetRange("Document No.", Rec."No.");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal;
                            end;
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForPayment;
                    Image = Cancel;
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                separator(Action33)
                {
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;

                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Imprest Surrender", true, true, Rec);
                    end;
                }
                action("Print Cash Receipt")
                {
                    Caption = 'Print Cash Receipt';
                    Ellipsis = true;
                    ApplicationArea = basic, suite;
                    Image = PrintVoucher;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.CalcFields("Cash Receipt No. Surr");
                        if Rec."Cash Receipt No. Surr" = '' then Error('There is no posted receipt associated with Imprest Surrender No.%1', Rec."No.");
                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."Cash Receipt No. Surr");
                        REPORT.Run(Report::Receipt, true, false, BankLedgerEntry);
                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ApplicationArea = basic, suite;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = basic, suite;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        //ReleasePurchDoc.ReopenPV(Rec);
                    end;
                }
                separator(Action27)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action("Post & Print")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    ApplicationArea = basic, suite;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = DocReleased AND NOT DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost."Post ImprestSurrender"(Rec);
                        Commit;
                        CurrPage.Close;
                        if Rec.Posted then begin
                            BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."No.");
                            Commit();
                            REPORT.Run(Report::Receipt, false, false, BankLedgerEntry);
                        end;
                    end;
                }
                action(Approve)
                {
                    Image = Approve;
                    Promoted = true;
                    ApplicationArea = basic, suite;
                    PromotedCategory = New;
                }
                action(Reject)
                {
                    Image = Reject;
                    ApplicationArea = basic, suite;
                }
                action(Delegate)
                {
                    Image = Delegate;
                    ApplicationArea = basic, suite;
                }
                action(Reopen)
                {
                    Caption = 'Reopen Document';
                    Image = ReOpen;
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = Rec."Status" = Rec."Status"::"Released";

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to reopen?', false) then PaymentsPost.ReopenDocument(Rec);
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
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2", "Actual Amount Spent 1", "Actual Amount Spent 2", "Cash Receipt Amount 1", "Cash Receipt Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec."Actual Amount Spent" := Rec."Actual Amount Spent 1" + Rec."Actual Amount Spent 2";
        Rec."Cash Receipt Amount" := Rec."Cash Receipt Amount 1" + Rec."Cash Receipt Amount 2";
        Rec.Modify(true);
        SetControlAppearance();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2", "Actual Amount Spent 1", "Actual Amount Spent 2", "Cash Receipt Amount 1", "Cash Receipt Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec."Actual Amount Spent" := Rec."Actual Amount Spent 1" + Rec."Actual Amount Spent 2";
        Rec."Cash Receipt Amount" := Rec."Cash Receipt Amount 1" + Rec."Cash Receipt Amount 2";
        Rec.Modify(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Imprest Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Imprest Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //SETRANGE("Created By",USERID);
        //DocStatus:=FormatStatus(Status);
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        PaymentsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        ImprestRec: Record Payments;
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        PaymentLines: Record "Payment Lines";
        CanCancelApprovalForPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        DocReleased: Boolean;
        ModifyHODApprovals: Report "Modify HOD Approvals";
        UserSetup: Record "User Setup";
        ActivityImp: Boolean;
        Facilitators: Boolean;
        Pmt: Record Payments;
        OfficeImp: Boolean;
        ItemImp: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := true
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then DocReleased := true;
        // Pmt.Reset();
        // Pmt.SetRange("No.", "Imprest Issue Doc. No");
        // if Pmt.FindFirst() then begin
        //     if (Pmt.Type = Pmt.Type::General) and (Pmt."General Imprest Type" = Pmt."General Imprest Type"::"Office Running") then
        //         OfficeImp := true
        //     else
        //         OfficeImp := false;
        //     if (Pmt.Type = Pmt.Type::General) and (Pmt."General Imprest Type" = Pmt."General Imprest Type"::Item) then
        //         ItemImp := true
        //     else
        //         ItemImp := false;
        //     if (Pmt.Type = Pmt.Type::Activity) then begin
        //         ActivityImp := true;
        //         PaymentLines.Reset();
        //         PaymentLines.SetRange(No, Rec."Imprest Issue Doc. No");
        //         PaymentLines.SetRange("Line Type", PaymentLines."Line Type"::Item);
        //         if PaymentLines.FindFirst() then
        //             ItemImp := true
        //         else
        //             ItemImp := false;
        //     end else
        //         ActivityImp := false;
        //     if (Pmt.FacilitatorsReq = true) then
        //         Facilitators := true
        //     else
        //         Facilitators := false;
        // end;
    end;
}
