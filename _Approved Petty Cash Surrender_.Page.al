page 50256 "Approved Petty Cash Surrender"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Misc';
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
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Petty Cash Issue Doc.No"; Rec."Petty Cash Issue Doc.No")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    LookupPageID = "Posted Petty cash";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PettyCash.Reset;
                        PettyCash.SetRange("Payment Type", Rec."Payment Type"::"Petty Cash");
                        PettyCash.SetRange(Surrendered, false);
                        PettyCash.SetRange("Account No.", Rec."Account No.");
                        if ACTION::LookupOK = PAGE.RunModal(80323, PettyCash) then begin
                            Rec."Petty Cash Issue Doc.No" := PettyCash."No.";
                            Rec.Validate("Petty Cash Issue Doc.No");
                        end;
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = false;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = false;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = Rec."Status" = Rec."Status"::"Released";
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Currency; Rec.Currency)
                {
                    Editable = false;
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                }
                field("Actual Petty Cash Amount Spent"; Rec."Actual Petty Cash Amount Spent")
                {
                }
                field("Receipted Petty Cash Amount"; Rec."Receipted Petty Cash Amount")
                {
                    Editable = false;
                }
                group("Apportion?")
                {
                    Caption = 'Apportion?';
                    Visible = false;

                    field("No Apportion"; Rec."No Apportion")
                    {
                        Caption = 'No';
                    }
                    field(Apportion; Rec.Apportion)
                    {
                        Caption = 'Yes';
                    }
                }
            }
            part("Petty Cash Surrender Lines"; "Imprest Surrender Lines")
            {
                Caption = 'Petty Cash Surrender Lines';
                Editable = NOT Rec.Posted;
                SubPageLink = No = FIELD("No.");
            }
            part(Control54; "Apportionment Allocation Lines")
            {
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
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
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
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        // Committment.CheckPettyCashSurrenderCommittment(Rec);
                        // Committment.PettyCashSurrenderCommittment(Rec,ErrorMsg);
                        // IF ErrorMsg<>'' THEN
                        //   ERROR(ErrorMsg);
                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                    end;
                }
                action(ArchiveDoc)
                {
                    Caption = 'Archive Document';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive?', false) then begin
                            PaymentsPost.ArchiveDocument(Rec);
                            CurrPage.Close;
                        end;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen Document';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = Rec."Status" = Rec."Status"::"Released";

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to reopen?', false) then PaymentsPost.ReopenDocument(Rec);
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        Rec.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Petty Cash Surrender", true, true, Rec)
                    end;
                }
                action("Print Receipt")
                {
                    Enabled = DocPosted;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec.Posted = false then Error(Text000, Rec."No.");
                        Rec.Reset;
                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."No.");
                        REPORT.Run(Report::Receipt, true, true, BankLedgerEntry);
                        Rec.Reset;
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = NOT DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostPettyCashSurrender(Rec);
                        Commit;
                        // IF Posted THEN BEGIN
                        //
                        // BankLedgerEntry.SETRANGE(BankLedgerEntry."Document No.","No.");
                        // REPORT.RUN(51519009,FALSE,FALSE,BankLedgerEntry);
                        //
                        // END;
                        CurrPage.Close;
                    end;
                }
                action(Approve)
                {
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = New;
                }
                action(Reject)
                {
                    Image = Reject;
                }
                action(Delegate)
                {
                    Image = Delegate;
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
        SetControlAppearance();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //DocStatus:=FormatStatus(Status);
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        PaymentsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        PCLines: Record "Payment Lines";
        Text000: Label 'Receipt No %1 has not been posted';
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        PettyCash: Record Payments;
        AccountNo: Code[20];
        ErrorMsg: Text;
        Committment: Codeunit Committment;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
    end;
}
