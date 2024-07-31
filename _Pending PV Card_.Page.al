page 50255 "Pending PV Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Documents';
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Payment Voucher")
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    Editable = false;
                }
                group(Control54)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Editable = true;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Editable = true;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = NOT DocPosted;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                group(Control66)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        Editable = ChequePayment AND NOT DocPosted AND NOT OpenApprovalEntriesExist;
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {
                        Editable = ChequePayment AND NOT DocPosted;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Editable = ChequePayment AND NOT DocPosted;
                    }
                }
                field(Payee; Rec.Payee)
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                group(Control64)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Check Printed"; Rec."Check Printed")
                    {
                        Editable = false;
                        Visible = ChequePayment;
                    }
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Payee PIN"; Rec."Payee PIN")
                {
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                    Editable = NOT DocPosted;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Levied Invoice"; Rec."Levied Invoice")
                {
                    Caption = 'Levied Payment Voucher';
                    ToolTip = 'Tick if this PV includes other levies e.g. service levy';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                }
                field("Total Witholding VAT Tax"; Rec."Total Witholding VAT Tax")
                {
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    Visible = false;
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                }
                field("Vendor Entry No"; Rec."Vendor Entry No")
                {
                    Visible = false;
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    Visible = false;
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
                group("RTGS Details")
                {
                    Caption = 'RTGS Details';
                    Editable = NOT DocPosted;
                    Visible = RTGSPayment;

                    field("RTGS Date"; Rec."RTGS Date")
                    {
                    }
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
                field(Apportion; Rec.Apportion)
                {
                    Visible = false;
                }
            }
            part(Control26; "PV Subform")
            {
                SubPageLink = No = FIELD("No.");
            }
            part(Control76; "Apportionment Allocation Lines")
            {
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
            systempart(Control21; Notes)
            {
            }
            systempart(Control20; MyNotes)
            {
            }
            systempart(Control19; Links)
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
            group(Action38)
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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Paying Bank Account");
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField(Payee);
                        Rec.TestField("Payment Narration");
                        /*
                        IF PayMethod.GET("Pay Mode") THEN
                          BEGIN
                            IF PayMethod."Bal. Account Type"=PayMethod."Bal. Account Type"::Cheque THEN
                              TESTFIELD("Cheque No");
                              TESTFIELD("Cheque Date");
                          END;
                          */
                        if Rec."Direct Expense" = true then begin
                            if Confirm('You have indicated that %1 is a direct expense hence will be committed. Continue?', false, Rec."No.") = true then begin
                                Committment.CheckPVCommittment(Rec);
                                Committment.PVCommittment(Rec, ErrorMsg);
                                if ErrorMsg <> '' then Error(ErrorMsg);
                            end
                            else
                                exit;
                        end;
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
                    Enabled = CanCancelApprovalForPayment AND NOT DocPosted;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request? Please note this will uncommit previous committments regarding %1', false, Rec."No.") = true then begin
                            //Committment.ReversePVCommittment(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Commit;
                            Committment.CancelPaymentsCommitments(Rec);
                        end;
                        CurrPage.Close;
                    end;
                }
                separator(Action30)
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
                        PaymentRec.Reset;
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst then begin
                            PLines.Reset;
                            PLines.SetRange(No, PaymentRec."No.");
                            if PLines.FindFirst then begin
                                if PLines."Account Type" <> PLines."Account Type"::Vendor then
                                    REPORT.Run(Report::"Payment Voucher", true, false, PaymentRec)
                                else
                                    REPORT.Run(Report::"Payment Voucher-Vendor", true, false, PaymentRec);
                            end;
                        end;
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
                        //Uncommented the code
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
                separator(Action23)
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Uncommented the code
                        PaymentsPost."Post Payment Voucher"(Rec);
                        Commit;
                        CurrPage.Close();
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
                action(GenerateEFT)
                {
                    Caption = 'Generate EFT File';
                    Enabled = EFTpayment;
                    Image = ExportToExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = NOT DocPosted;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to generate an EFT file for PV %1', false, Rec."No.") = true then begin
                            if PayMethod.Get(Rec."Pay Mode") then begin
                                if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::EFT then Error('Payment mode must be EFT');
                            end
                            else
                                Error('Pay mode %1 has not been set up', Rec."Pay Mode");
                            CashManagementSetup.Get;
                            CashManagementSetup.TestField("EFT Path");
                            PLines.Reset;
                            PLines.SetRange(No, Rec."No.");
                            if not PLines.FindFirst then Error('Payment Lines are empty');
                            Rec.TestField("EFT File Generated", false);
                            PaymentRec.Reset;
                            PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                            if PaymentRec.FindFirst then REPORT.RunModal(Report::"Generate EFT", false, false, PaymentRec);
                        end;
                    end;
                }
                action(PrintCheck)
                {
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Report;
                    Visible = NOT DocPosted;

                    trigger OnAction()
                    begin
                        if PayMethod.Get(Rec."Pay Mode") then begin
                            if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::Cheque then Error('Payment mode must be Cheque');
                        end;
                        Rec.TestField("Check Printed", false);
                        Rec.TestField("Cheque No");
                        Rec.TestField("Cheque Date");
                        PaymentRec.Reset;
                        PaymentRec.SetRange("No.", Rec."No.");
                        if PaymentRec.FindFirst then REPORT.Run(Report::"PV Check", true, false, PaymentRec);
                    end;
                }
                action(ImportPayments)
                {
                    Caption = 'Import Bulk Payments';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = NOT DocPosted;

                    trigger OnAction()
                    begin
                        Clear(ImportPVLines);
                        ImportPVLines.GetHeaderNo(Rec);
                        ImportPVLines.Run;
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
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        [InDataSet]
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        Committment: Codeunit Committment;
        PaymentsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        [InDataSet]
        ChequePayment: Boolean;
        [InDataSet]
        DocReleased: Boolean;
        EFTPayment: Boolean;
        PaymentRec: Record Payments;
        PLines: Record "Payment Lines";
        PayMethod: Record "Payment Method";
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        ImportPVLines: XMLport "Import PV Lines";
        CashManagementSetup: Record "Cash Management Setups";
        ErrorMsg: Text;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        RTGSPayment: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PaymentMethod: Record "Payment Method";
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
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        // MESSAGE('%1,%2',DocPosted,OpenApprovalEntriesExist);
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then
            RTGSPayment := true
        else
            RTGSPayment := false;
    end;
}
