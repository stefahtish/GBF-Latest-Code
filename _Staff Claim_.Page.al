page 50152 "Staff Claim"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    ApplicationArea = All;



    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released);

                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Editable = PageEditable;
                }
                field(Date; Rec.Date)
                {
                    Enabled = false;
                    Editable = PageEditable;
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Editable = PageEditable;
                    //  Enabled = Rec."Apply on behalf";
                }
                field("Account No."; Rec."Account No.")
                {
                    Enabled = Rec."Apply on behalf";
                    Visible = false;
                    Editable = PageEditable;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Enabled = false;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    Editable = PageEditable;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Enabled = false;
                }
                group(Control49)
                {
                    // Enabled = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Editable = PageEditable;
                        // Enabled = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Editable = PageEditable;
                        //Enabled = false;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Editable = PageEditable;
                        // Visible = false;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    //  Enabled = false;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Enabled = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Enabled = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    //    Enabled = false;
                    Editable = Rec.Status = Rec.Status::Released;
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
                    Caption = 'Purpose';
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Payment Narration");
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = PageEditable;
                }
                field(Currency; Rec.Currency)
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Staff Claim Amount';
                    TableRelation = Payments."Petty Cash Net Amount";
                }
                field("Imprest Surrender Doc. No"; Rec."Imprest Surrender Doc. No")
                {
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Enabled = false;
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
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    Visible = false;
                }
                field("User Id"; Rec."User Id")
                {
                    Visible = false;
                }
            }
            part(ClaimLines; "Staff Claim Lines")
            {
                Enabled = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
            }
            part(ApportionmentLines; "Apportionment Allocation Lines")
            {
                Enabled = Rec.Status = Rec.Status::Open;
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
                        if Rec."Claim Type" = Rec."Claim Type"::" " then Error('Please define a claim type');
                        if Rec."Payment Narration" = '' then Error('Please define the Purpose for this claim');
                        ClaimLines.Reset;
                        ClaimLines.SetRange(ClaimLines.No, Rec."No.");
                        if ClaimLines.Find('-') then begin
                            repeat
                                ClaimLines.TestField("Expenditure Date");
                                //ClaimLines.TESTFIELD("Claim Receipt No.");
                                ClaimLines.TestField("Expenditure Description");
                                if ClaimLines.Amount <= 0 then Error('One of your lines has an amount less than or equal to 0');
                            until ClaimLines.Next = 0;
                        end;
                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then Error(Error001);
                        //Check medical Ceiling
                        PaymentsPost.CheckMedicalClaimCeiling(Rec);
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
                    Enabled = CanCancelApprovalForPayment;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitImprest(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Commit;
                            Committment.CancelPaymentsCommitments(Rec);
                        end
                        else
                            exit;
                        CurrPage.Close;
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
                        Payments.SetRange("Payment Type", Rec."Payment Type"::"Staff Claim");
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
                separator(Action33)
                {
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
                    var
                        PaymentRec: Record Payments;
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange("No.", Rec."No.");
                        //DocPrint.PrintPurchHeader(Rec);
                        // SetRange("No.", "No.");
                        // StaffClaim.SetTableView(Rec);
                        // StaffClaim.run;
                        REPORT.Run(Report::"Staff Claim Voucher", true, true, PaymentRec)
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
                    Visible = NOT OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        REC.Reset();
                        Rec.SetRange("No.", rec."No.");
                        if rec.FindSet() then begin
                            rec.Status := rec.Status::Open;
                            rec.Modify()
                        end;
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

                //  Visible = false;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    // Visible = false;
                    trigger OnAction()
                    begin
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
                    Visible = false;

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
                action(Archive)
                {
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive this document?', false) = true then begin
                            //Committment.rev
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
        rec."Posting Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage..PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        ShowDim := true;
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
        PayingBankEnabled: Boolean;
        PageEditable: Boolean;
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        CanCancelApprovalForPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        UserSetup: Record "User Setup";
        //EDDIE[RunOnClient]
        //EDDIE DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        StaffClaim: Report "Staff Claim Voucher";

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
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if Rec.Status = Rec.Status::Released then
            PayingBankEnabled := true
        else
            PayingBankEnabled := false;
        if Rec.Posted = true then
            PageEditable := false
        else
            PageEditable := true;
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
