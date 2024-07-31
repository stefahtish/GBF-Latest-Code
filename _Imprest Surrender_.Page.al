page 50138 "Imprest Surrender"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    RefreshOnActivate = true;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = Rec.Status = Rec.Status::Open;

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    // Enabled = false;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    ApplicationArea = all;
                    Enabled = NOT OpenApprovalEntriesExist;

                    trigger OnValidate()
                    var
                    begin
                        rec."Posting Date" := rec."Surrender Date";
                        //rec.Insert()
                    end;
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                    ApplicationArea = all;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                    Enabled = Rec."Apply on behalf";
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                {
                    ApplicationArea = all;
                    Enabled = NOT OpenApprovalEntriesExist;

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
                    Enabled = false;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Enabled = true;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Narration; Rec."Payment Narration")
                {
                    ApplicationArea = all;
                    enabled = NOT OpenApprovalEntriesExist;
                }
                group(Control47)
                {
                    Enabled = false;
                    ShowCaption = false;

                    // field(Destination; Destination)
                    // {
                    // }
                    // field("No of Days"; "No of Days")
                    // {
                    // }
                    // field("Date of Project"; "Date of Project")
                    // {
                    // }
                    // field("Date of Completion"; "Date of Completion")
                    // {
                    // }
                    field("Due Date"; Rec."Due Date")
                    {
                        ApplicationArea = all;
                    }
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = all;
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    ApplicationArea = all;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
                    editable = true;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part(ImprestLines; "Imprest Surrender Lines")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status = Rec.Status::Open;
                SubPageLink = No = field("No."), "Payment Type" = field("Payment Type");
                UpdatePropagation = both;
            }
            part(ExtImprestLines; "Ext Imprest Surrender Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'External Imprest Surrender Lines';
                Enabled = Rec.Status = Rec.Status::Open;
                SubPageLink = No = field("No."), "Payment Type" = field("Payment Type");
                UpdatePropagation = both;
                Visible = false;
            }
            part(MandatoryDocs; "Surrender Mandatory Docs")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mandatory Documents';
                Enabled = Rec.Status = Rec.Status::Open;
                SubPageLink = "Surrender No." = field("No.");
                UpdatePropagation = both;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Payments"),
                              "No." = field("No.");


            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = all;
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
        }
    }
    actions
    {
        area(navigation)
        {
            // action("Clear Lines")
            // {
            //     Image = DeleteRow;
            //     Promoted = true;
            //     ApplicationArea = all;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         PaymentLines.Reset;
            //         PaymentLines.SetRange(No, "No.");
            //         PaymentLines.DeleteAll();
            //         ExtPaymentLines.Reset();
            //         ExtPaymentLines.SetRange(No, "No.");
            //         ExtPaymentLines.DeleteAll();
            //     end;
            // }
            action("Update Lines")
            {
                Image = UpdateDescription;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PaymentLine: Record "Payment Lines";
                    PaymentRec: Record Payments;
                    ImpSurrLines: Record "Payment Lines";
                    ExtPaymentLine: Record "Ext Payment Lines";
                    ExtInsurrLines: Record "Ext Payment Lines";
                    Text001: Label 'The imprest %1 has been fully surrendered';
                begin
                    if PaymentRec.Get(Rec."Imprest Issue Doc. No") then begin
                        if Rec."Payment Type" = Rec."Payment Type"::"Imprest Surrender" then begin
                            if PaymentRec.Surrendered then Error(Text001, Rec."Imprest Issue Doc. No");
                            Rec."Account Type" := PaymentRec."Account Type";
                            Rec."Account No." := PaymentRec."Account No.";
                            Rec.Validate("Account No.");
                            Rec."Pay Mode" := PaymentRec."Pay Mode";
                            Rec."Cheque No" := PaymentRec."Cheque No";
                            Rec."Cheque Date" := PaymentRec."Cheque Date";
                            Rec."Paying Bank Account" := PaymentRec."Paying Bank Account";
                            Rec.Currency := PaymentRec.Currency;
                            Rec."Payment Narration" := PaymentRec."Payment Narration";
                            Rec."Multi-Donor" := PaymentRec."Multi-Donor";
                            Rec."Staff No." := PaymentRec."Staff No.";
                            Rec."Payment Narration" := PaymentRec."Payment Narration";
                            Rec.Destination := PaymentRec.Destination;
                            Rec."No of Days" := PaymentRec."No of Days";
                            Rec."Date of Project" := PaymentRec."Date of Project";
                            Rec."Date of Completion" := PaymentRec."Date of Completion";
                            Rec."Due Date" := PaymentRec."Due Date";
                            Rec."Posted Date" := PaymentRec."Posted Date";
                            Rec."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                            Rec.Validate("Shortcut Dimension 1 Code");
                            Rec."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                            Rec.Validate("Shortcut Dimension 2 Code");
                            Rec."Dimension Set ID" := PaymentRec."Dimension Set ID";
                            Rec."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                            Rec.Validate("Shortcut Dimension 3 Code");
                            Rec.Validate("Dimension Set ID");
                            PaymentLine.Reset;
                            PaymentLine.SetRange(No, PaymentRec."No.");
                            if PaymentLine.Find('-') then begin
                                PaymentLines.Reset;
                                PaymentLines.SetRange(No, Rec."No.");
                                PaymentLines.DeleteAll();
                                repeat
                                    ImpSurrLines.Init;
                                    ImpSurrLines.TransferFields(PaymentLine);
                                    ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender";
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                                    ImpSurrLines."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                                    ImpSurrLines."Shortcut Dimension 4 Code" := PaymentRec."Shortcut Dimension 4 Code";
                                    ImpSurrLines.No := Rec."No.";
                                    ImpSurrLines."Line No" := Rec.GetNextLineNo();
                                    ImpSurrLines."Actual Spent" := PaymentLine.Amount;
                                    ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                                    ImpSurrLines.Insert;
                                until PaymentLine.Next = 0;
                            end;
                            ExtPaymentLine.Reset();
                            ExtPaymentLine.SetRange(No, PaymentRec."No.");
                            if ExtPaymentLine.FindSet() then begin
                                ExtPaymentLines.Reset();
                                ExtPaymentLines.SetRange(No, Rec."No.");
                                ExtPaymentLines.DeleteAll();
                                repeat
                                    ExtInsurrLines.Init;
                                    ExtInsurrLines.TransferFields(ExtPaymentLine);
                                    ExtInsurrLines."Payment Type" := ExtInsurrLines."Payment Type"::"Imprest Surrender"; //Carol
                                    ExtInsurrLines.No := Rec."No.";
                                    ExtInsurrLines."Line No" := Rec.GetExtNextLineNo();
                                    ExtInsurrLines."Actual Spent" := ExtPaymentLine.Amount;
                                    ExtInsurrLines.Purpose := PaymentRec."Payment Narration";
                                    ExtInsurrLines.Insert;
                                until ExtPaymentLine.Next() = 0;
                            end;
                        end;
                    end;
                end;
            }
            // group("Payment Voucher")
            // {
            //     Caption = 'Payment Voucher';
            //     Image = "Order";
            //     action("Co&mments")
            //     {
            //         Caption = 'Co&mments';
            //         Image = ViewComments;
            //         RunObject = Page "Comment Sheet";
            //     }
            //     action(Dimensions)
            //     {
            //         Caption = 'Dimensions';
            //         Image = Dimensions;
            //         ShortCutKey = 'Shift+Ctrl+D';
            //         trigger OnAction()
            //         begin
            //             ShowDocDim;
            //             CurrPage.SaveRecord;
            //         end;
            //     }
            //     action(Approvals)
            //     {
            //         Caption = 'Approvals';
            //         Image = Approval;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         trigger OnAction()
            //         var
            //             ApprovalEntries: Page "Approval Entries";
            //             ApprovalEntry: Record "Approval Entry";
            //         begin
            //             ApprovalEntry.Reset();
            //             //ApprovalEntry.SetCurrentKey("Document No.");
            //             ApprovalEntry.SetRange("Table ID", Database::Payments);
            //             ApprovalEntry.SetRange("Document No.", "No.");
            //             ApprovalEntries.SetTableView(ApprovalEntry);
            //             ApprovalEntries.LookupMode(true);
            //             ApprovalEntries.RunModal();
            //         end;
            //     }
            //     action(Navigate)
            //     {
            //         Caption = '&Navigate';
            //         Image = Navigate;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         PromotedIsBig = true;
            //         ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
            //         Visible = DocPosted;
            //         trigger OnAction()
            //         begin
            //             Navigate;
            //         end;
            //     }
            // }
            action(Navigate)
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                ApplicationArea = all;
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
                    ApplicationArea = all;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SurrenderDocs: Record "Surrender Mandatory Docs";
                        ProcDocLinks: Record "Procurement Document Links";
                    begin
                        Rec.TestField("Surrender Date");
                        Rec.TestField("Imprest Issue Doc. No");
                        Rec.CalcFields("Remaining Amount");
                        SurrenderDocs.Reset();
                        SurrenderDocs.SetRange("Surrender No.", Rec."No.");
                        SurrenderDocs.SetRange(Mandatory, true);
                        if SurrenderDocs.FindFirst() then begin
                            ProcDocLinks.Reset();
                            ProcDocLinks.SetRange("No.", Rec."No.");
                            if ProcDocLinks.Count < SurrenderDocs.Count then Error('Kindly upload all mandatory documents before sending for approvals');
                        end;
                        // if "Remaining Amount" <> 0 then
                        //     Error('Please account for all imprest amount');
                        // PaymentLine.reset;
                        // PaymentLine.SetRange(No, "No.");
                        // if PaymentLine.Find('-') then
                        //     repeat
                        //         PaymentLine.CalcFields("Remaining Amount");
                        //     until PaymentLine.Next = 0;
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
                    Promoted = true;
                    ApplicationArea = all;
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
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", Database::Payments);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        Commit();
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        Commit();
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Payments.SetRange("No.", Rec."No.");
                        Commit();
                        REPORT.Run(Report::"Imprest Surrender", true, true, Payments);
                    end;
                }
                action("Print Cash Receipt")
                {
                    Caption = 'Print Cash Receipt';
                    Ellipsis = true;
                    Image = PrintVoucher;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.CalcFields("Cash Receipt No. Surr");
                        if Rec."Cash Receipt No. Surr" = '' then Error('There is no posted receipt associated with Imprest Surrender No.%1', Rec."No.");
                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."Cash Receipt No. Surr");
                        Commit();
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
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = DocReleased AND NOT DocPosted;

                    trigger OnAction()
                    begin
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
                action("Mass Commit")
                {
                    Caption = 'Mass Commit';
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Payments: Record Payments;
                        Commitment: record "Commitment Entries";
                        CodeCommit: Codeunit Committment;
                    begin
                        Payments.Reset();
                        Payments.SetRange("Payment Type", Rec."Payment Type"::"Imprest Surrender");
                        Payments.SetRange(Status, Rec.Status::"Pending Approval", Rec.Status::Released);
                        if Payments.FindSet() then begin
                            repeat
                                Commitment.Reset();
                                Commitment.SetRange("Commitment No", Payments."No.");
                                if not Commitment.FindFirst() then begin
                                    Committment.ImprestCommittment2(Rec, ErrorMsg);
                                end;
                            until Payments.Next() = 0;
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
        rec."Posting Date" := Today;
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
        ExtPaymentLines: Record "Ext Payment Lines";
        CanCancelApprovalForPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        DocReleased: Boolean;
        ModifyHODApprovals: Report "Modify HOD Approvals";
        UserSetup: Record "User Setup";
        Payments: Record Payments;
        PageEnabled: Boolean;
        //EDDIE [RunOnClient]
        //EDDIE DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        PaymentLine: Record "Payment Lines";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then DocReleased := true;
        PageEnabled := false;
    end;
}
