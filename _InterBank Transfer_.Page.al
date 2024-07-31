page 50157 "InterBank Transfer"
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
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Editable = NOT OpenApprovalEntriesExist;
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
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                group(History)
                {
                    Caption = 'History';

                    field("Created By"; Rec."Created By")
                    {
                    }
                    field(Posted; Rec.Posted)
                    {
                        Editable = false;
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        Editable = false;
                    }
                    field("Posted Date"; Rec."Posted Date")
                    {
                        Editable = false;
                    }
                }
                group("Source Bank Details")
                {
                    Caption = 'Source Bank Details';
                    Editable = NOT OpenApprovalEntriesExist;

                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Source Bank"; Rec."Source Bank")
                    {
                        trigger OnValidate()
                        begin
                            GetSourceBankName;
                            CurrPage.Update;
                        end;
                    }
                    field(SourceBankName; SourceBankName)
                    {
                        Caption = 'Account Name';
                        Editable = false;
                    }
                    field("Source Currency"; Rec."Source Currency")
                    {
                        Caption = 'Source Bank Currency';
                    }
                    field("Source Bank Amount"; Rec."Source Bank Amount")
                    {
                    }
                    field("Source Amount LCY"; Rec."Source Amount LCY")
                    {
                        Editable = false;
                    }
                }
                group(Totals)
                {
                    Caption = 'Totals';

                    field("Petty Cash Amount"; Rec."Petty Cash Amount")
                    {
                        Caption = 'Total Receiving Bank Amount';
                    }
                    field("Petty Cash Amount (LCY)"; Rec."Petty Cash Amount (LCY)")
                    {
                        Caption = 'Total Receiving Bank Amount (KSH)';
                    }
                }
            }
            group("Payment Details")
            {
                Caption = 'Payment Details';
                Editable = NOT OpenApprovalEntriesExist;
                Visible = false;

                grid("Receiving Bank Details")
                {
                    Caption = 'Receiving Bank Details';
                    GridLayout = Rows;

                    group(Control44)
                    {
                        ShowCaption = false;

                        field("Account No."; Rec."Account No.")
                        {
                            Caption = 'Receiving Bank Account';
                            Editable = NOT OpenApprovalEntriesExist;
                        }
                        field("Account Name"; Rec."Account Name")
                        {
                            Editable = false;
                            ToolTip = 'z';
                        }
                        field("Receiving Bank Amount"; Rec."Receiving Bank Amount")
                        {
                        }
                        field(Currency; Rec.Currency)
                        {
                            Caption = 'Receiving Bank Currency';
                            Editable = NOT OpenApprovalEntriesExist;
                            Enabled = true;
                            Visible = true;
                        }
                        field("Receiving Amount LCY"; Rec."Receiving Amount LCY")
                        {
                        }
                    }
                }
            }
            part("Interbank Transfer Lines"; "Interbank Lines")
            {
                Caption = 'Interbank Transfer Lines';
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
            part("Document Attachment"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No."), "Table ID" = const(50121);
                Visible = false;
            }
            part("Document Attachment Factbox"; "Documents Links")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
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
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';
                    ApplicationArea = Basic, Suite;

                    //  Visible = false;
                    trigger OnAction()
                    var
                        DocumentManagement: Codeunit "Document Management";
                    begin
                        //    DocumentManagement.UploadInterbankTransferfiles(Rec."No.", CurrPage.Caption, Rec.RecordId);
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
                        NarrLength: Integer;
                    begin
                        GeneralLedgerSetup.Get;
                        CashManagementSetup.Get;
                        Rec.TestField("Source Bank Amount");
                        Rec.TestField("Source Bank");
                        Rec.TestField("Payment Narration");
                        Rec.TestField(Date);
                        NarrLength := Text.StrLen(Rec."Payment Narration");
                        if NarrLength > 100 then Error('Payment Narration should be less than 100 characters');
                        Rec.CalcFields("Petty Cash Amount (LCY)");
                        if Rec."Petty Cash Amount (LCY)" <> Rec."Source Amount LCY" then Error('Please make sure both Receiving and Source Amounts are the same');
                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendPaymentsForApproval(Rec);
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
                    begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
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
                        Rec.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"InterBank Transfer-Multiple", true, true, Rec)
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
                        //Remove Approval//
                        // IF NOT CONFIRM('The Document has not been approved. Would you like to proceed?', FALSE) THEN BEGIN
                        //  CurrPage.CLOSE()
                        //  END ELSE
                        //  //modifies the record//
                        //  MESSAGE('This record will be automatically approved.');
                        //  Status:=Status::Released;
                        //  MODIFY;
                        PaymentsPost.PostInterBankMultiple(Rec);
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
                        //Committment.StaffClaimCommittment(Rec,ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    trigger OnAction()
                    begin
                        //Committment.ReversePettyCashCommittment(Rec);
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
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        //CurrPage. .PAGE.ShowFields("Multi-Donor");
        ShowDimFields();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Bank Transfer";
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
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
        PayingBankEditable: Boolean;
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        Bank: Record "Bank Account";
        RecBankName: Text;
        SourceBankName: Text;
        CanCancelApprovalForPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Payments: Record Payments;
        FromFile: Text;
        DocumentManagement: Codeunit "Document Management";

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
            PayingBankEditable := true
        else
            PayingBankEditable := false;
        GetSourceBankName;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update;
    end;

    local procedure GetSourceBankName()
    begin
        if Rec."Source Bank" <> '' then begin
            if Bank.Get(Rec."Source Bank") then SourceBankName := Bank.Name;
        end;
    end;
}
