page 50124 "Petty Cash"
{
    //  DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
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
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    //Enabled = NOT OpenApprovalEntriesExist;
                }
                field("Account No."; Rec."Account No.")
                {
                    Enabled = Rec."Apply on behalf";
                }
                field("Account Name"; Rec."Account Name")
                {
                    Enabled = false;
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Visible = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Enabled = false;
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
                    Enabled = OpenApprovalEntriesExist AND NOT DocPosted;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Enabled = false;
                }
                group("Cheque Details")
                {
                    Caption = 'Cheque Details';
                    Visible = NOT OpenApprovalEntriesExist AND ChequePayment;

                    field("Cheque No"; Rec."Cheque No")
                    {
                        Enabled = NOT OpenApprovalEntriesExist AND ChequePayment;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Enabled = NOT OpenApprovalEntriesExist AND ChequePayment;
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
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("User Id"; Rec."User Id")
                {
                    Enabled = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    Visible = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Enabled = false;
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    Enabled = false;
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    TableRelation = Payments."Petty Cash Net Amount";
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Enabled = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part(ImprestLines; "Petty Cash Lines")
            {
                Caption = 'Petty Cash Lines';
                Enabled = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
            }
        }
        area(factboxes)
        {
            // part("Document Attachment Factbox"; "Document Attachment Custom")
            // {
            //     ApplicationArea = Suite;
            //     SubPageLink = "No." = FIELD("No.");
            // }
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
        }
    }
    actions
    {
        // area(navigation)
        // {
        //     group("Payment Voucher")
        //     {
        //         Caption = 'Payment Voucher';
        //         Image = "Order";
        //         action("Co&mments")
        //         {
        //             Caption = 'Co&mments';
        //             Image = ViewComments;
        //             RunObject = Page "Comment Sheet";
        //         }
        //         action(Dimensions)
        //         {
        //             Caption = 'Dimensions';
        //             Image = Dimensions;
        //             ShortCutKey = 'Shift+Ctrl+D';
        //             trigger OnAction()
        //             begin
        //                 ShowDocDim;
        //                 CurrPage.SaveRecord;
        //             end;
        //         }
        //         action(Approvals)
        //         {
        //             Caption = 'Approvals';
        //             Image = Approval;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             trigger OnAction()
        //             var
        //                 ApprovalEntries: Page "Approval Entries";
        //                 ApprovalEntry: Record "Approval Entry";
        //             begin
        //                 ApprovalEntry.Reset();
        //                 ApprovalEntry.SetCurrentKey("Document No.");
        //                 ApprovalEntry.SetRange("Table ID", Database::Payments);
        //                 ApprovalEntry.SetRange("Document No.", "No.");
        //                 ApprovalEntries.SetTableView(ApprovalEntry);
        //                 ApprovalEntries.LookupMode(true);
        //                 ApprovalEntries.RunModal();
        //             end;
        //         }
        //         action(Navigate)
        //         {
        //             Caption = '&Navigate';
        //             Image = Navigate;
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;
        //             ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
        //             Visible = DocPosted;
        //             trigger OnAction()
        //             begin
        //                 Navigate;
        //             end;
        //         }
        //     }
        // }
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
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
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
                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
                        Commit;
                        // Check HOD approver
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset;
                                ApprovalEntry.SetRange("Table ID", 50121);
                                ApprovalEntry.SetRange("Document No.", Rec."No.");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal;
                            end;
                        end;
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
                action(Confirm)
                {
                    Caption = 'Confirm Funds Receipt';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Confirm;
                    Visible = Rec.Status = Rec.Status::Released;

                    trigger OnAction()
                    begin
                        Rec.ConfirmFundsReceipt();
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
            // group("P&osting")
            // {
            //     Caption = 'P&osting';
            //     Image = Post;
            //     action(Post)
            //     {
            //         Caption = 'P&ost';
            //         Image = PostOrder;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         ShortCutKey = 'F9';
            //         Visible = NOT DocPosted;
            //         trigger OnAction()
            //         begin
            //             PaymentsPost.PostPettyCash(Rec);
            //             Commit;
            //             CurrPage.Close();
            //         end;
            //     }
            //     action(Commit)
            //     {
            //         Image = Confirm;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         Visible = false;
            //         trigger OnAction()
            //         begin
            //             Committment.PettyCashCommittment(Rec, ErrorMsg);
            //         end;
            //     }
            //     action("Reverse Commitment")
            //     {
            //         trigger OnAction()
            //         begin
            //             Committment.ReversePettyCashCommittment(Rec);
            //         end;
            //     }
            //     action(Approve)
            //     {
            //         Image = Approve;
            //         Promoted = true;
            //         PromotedCategory = New;
            //     }
            //     action(Reject)
            //     {
            //         Image = Reject;
            //     }
            //     action(Delegate)
            //     {
            //         Image = Delegate;
            //     }
            // }
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
        PayingBankEnabled: Boolean;
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        CanCancelApprovalForPayment: Boolean;
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        CompanyInfo: Record "Company Information";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        Payments: Record Payments;
        //[RunOnClient]
        //eddie  DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
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
