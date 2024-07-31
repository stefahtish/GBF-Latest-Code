page 50246 "Approved/Post Staff Claim Card"
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                group(Control49)
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
                group("EFT Details")
                {
                    Caption = 'EFT Details';
                    Editable = NOT DocPosted;
                    Visible = EFTpayment;

                    field("EFT Reference"; Rec."EFT Reference")
                    {
                        Editable = NOT DocPosted;
                    }
                    field("EFT File Generated"; Rec."EFT File Generated")
                    {
                        Editable = false;
                    }
                    field("EFT Date"; Rec."EFT Date")
                    {
                        Editable = NOT DocPosted;
                    }
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = OpenApprovalEntriesExist AND NOT DocPosted;
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
                    Caption = 'Purpose';
                    Editable = NOT OpenApprovalEntriesExist;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Payment Narration");
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Currency; Rec.Currency)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    Enabled = true;
                    Visible = true;
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Staff Claim Amount';
                    TableRelation = Payments."Petty Cash Net Amount";
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
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
            part(Control19; "Staff Claim Lines")
            {
                Editable = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
            }
            part(Control55; "Apportionment Allocation Lines")
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
                    var
                        Error001: Label 'Petty Cash Amount can not be less than or equal to 0';
                        Error002: Label 'Petty Cash amount can not be greater than %1.%2';
                    begin
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();
                        if Rec."Claim Type" = Rec."Claim Type"::" " then Error('Please define a claim type');
                        if Rec."Payment Narration" = '' then Error('Please define the Purpose for this claim');
                        ClaimLines.Reset;
                        ClaimLines.SetRange(ClaimLines.No, Rec."No.");
                        if ClaimLines.Find('-') then begin
                            repeat
                                ClaimLines.TestField("Expenditure Date");
                                //ClaimLines.TESTFIELD("Claim Receipt No.");
                                ClaimLines.TestField("Expenditure Description");
                            until ClaimLines.Next = 0;
                        end;
                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then Error(Error001);
                        Committment.CheckStaffClaimCommittment(Rec);
                        Committment.StaffClaimCommittment(Rec, ErrorMsg);
                        if ErrorMsg <> '' then Error(ErrorMsg);
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
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        // IF CONFIRM(UncommitTxt,FALSE,"No.")=TRUE THEN
                        //  BEGIN
                        //    Committment.UncommitImprest(Rec);
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        //  END ELSE
                        //    EXIT;
                    end;
                }
                separator(Action33)
                {
                }
                action(Confirm)
                {
                    Caption = 'Confirm Funds Receipt';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Confirm;

                    trigger OnAction()
                    begin
                        Rec.ConfirmFundsReceipt();
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        Rec.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Staff Claim Voucher", true, true, Rec)
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
                    Enabled = NOT Rec.Posted;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = PayingBankEditable;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostStaffClaim(Rec);
                        Commit;
                        CurrPage.Close();
                    end;
                }
                action(Commit)
                {
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Committment.StaffClaimCommittment(Rec, ErrorMsg);
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
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        //CurrPage. .PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //DocStatus:=FormatStatus(Status);
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Staff Claim";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage..PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //ShowDim := true;
        //DocStatus:=FormatStatus(Status);
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
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
        ClaimLines: Record "Payment Lines";
        CanCancelApprovalForPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        UserSetup: Record "User Setup";
        DocReleased: Boolean;
        EFTPayment: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := TRUE //ApprovalsMgmt.HasApprovalEntries(RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then
            DocReleased := true
        else
            DocReleased := false;
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if Rec.Status = Rec.Status::Released then
            PayingBankEditable := true
        else
            PayingBankEditable := false;
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
