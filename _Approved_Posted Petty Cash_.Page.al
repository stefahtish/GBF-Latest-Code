page 50257 "Approved/Posted Petty Cash"
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
                }
                field(Date; Rec.Date)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Editable = NOT OpenApprovalEntriesExist;
                    Visible = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = OpenApprovalEntriesExist AND NOT DocPosted;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                group("Cheque Details")
                {
                    Caption = 'Cheque Details';
                    Visible = NOT OpenApprovalEntriesExist AND ChequePayment;

                    field("Cheque No"; Rec."Cheque No")
                    {
                        Editable = NOT OpenApprovalEntriesExist AND ChequePayment;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Editable = NOT OpenApprovalEntriesExist AND ChequePayment;
                    }
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Enabled = OpenApprovalEntriesExist AND NOT DocPosted;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Enabled = OpenApprovalEntriesExist AND NOT DocPosted;
                    ShowMandatory = true;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Currency; Rec.Currency)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    Enabled = true;
                    Visible = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Editable = false;
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    TableRelation = Payments."Petty Cash Net Amount";
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    Editable = false;
                }
            }
            part(ImprestLines; "Petty Cash Lines")
            {
                Caption = 'Petty Cash Lines';
                Editable = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
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
                    var
                        Error001: Label 'Petty Cash Amount can not be less than or equal to 0';
                        Error002: Label 'Petty Cash amount can not be greater than %1.%2';
                    begin
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();
                        CashManagementSetup.TestField("Petty Cash Max");
                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then Error(Error001);
                        if Rec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then Error(Error002, GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");
                        Committment.CheckPettyCashCommittment(Rec);
                        Committment.PettyCashCommittment(Rec, ErrorMsg);
                        if ErrorMsg <> '' then Error(ErrorMsg);
                        Commit;
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
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForPayment;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitPettyCash(Rec);
                            Committment.CancelPaymentsCommitments(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        end
                        else
                            exit;
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        Payments.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Petty Cash Voucher", true, false, Payments)
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

                action(Post)
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
                        PaymentsPost.PostPettyCash(Rec);
                        Commit;
                        CurrPage.Close();
                    end;
                }
                // action(Confirm)
                // {
                //     Caption = 'Confirm Funds Receipt';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Image = Confirm;
                //     trigger OnAction()
                //     begin
                //         if Confirm('Are you sure?', false) then begin
                //             "Confirm Receipt" := true;
                //             Modify();
                //         end;
                //     end;
                // }
                action(Commit)
                {
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Committment.PettyCashCommittment(Rec, ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    trigger OnAction()
                    begin
                        Committment.ReversePettyCashCommittment(Rec);
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
                action("Issue Funds")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = PostSendTo;
                    Enabled = not Rec.Posted and DocReleased;

                    trigger OnAction()
                    begin
                        PaymentsPost.NotifyPaymentsFundsReceipt(Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.ImprestLines.PAGE.ShowFields(Rec."Multi-Donor");
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash";
        Rec."Account Type" := Rec."Account Type"::Customer;
        Rec."Pay Mode" := Rec.DefaultPettyCash(Rec."Paying Bank Account");
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //ShowDim:=TRUE;
        //DocStatus:=FormatStatus(Status);
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        PaymentsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        PaymentMethod: Record "Payment Method";
        [InDataSet]
        ChequePayment: Boolean;
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        [InDataSet]
        ShowDim: Boolean;
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        PayingBankEditable: Boolean;
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        CanCancelApprovalForPayment: Boolean;
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        Payments: Record Payments;
        DocReleased: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then
            DocReleased := true
        else
            DocReleased := false;
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if PaymentMethod.Get(Rec."Pay Mode") then begin
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
                ChequePayment := true
            else
                ChequePayment := false;
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
