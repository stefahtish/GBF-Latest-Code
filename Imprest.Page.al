page 50132 Imprest
{
    // DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    RefreshOnActivate = true;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approvals';
    DeleteAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = PageEnabled;

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    //Enabled = false;
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = Rec."Apply on behalf";
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    // Enabled = false;
                    Visible = false;
                }
                group(Control54)
                {
                    ShowCaption = false;
                    Enabled = NOT OpenApprovalEntriesExist;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        var

                        begin

                        end;
                        // Enabled = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = true;

                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                }
                group(Control65)
                {
                    ShowCaption = false;
                    Visible = false;

                    field("Pay Mode"; Rec."Pay Mode")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = OpenApprovalEntriesExist AND NOT DocPosted;
                        Visible = DocReleased;

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                        Visible = DocReleased;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                        Visible = DocReleased;
                    }
                }
                field("Travel Type"; Rec."Travel Type")
                {
                    Enabled = NOT OpenApprovalEntriesExist;
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                // field("Paying Bank Account2"; Rec."Paying Bank Account2")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Paying Bank Account2 field.';
                // }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    //Enabled = OpenApprovalEntriesExist AND NOT DocPosted;
                    //Visible = DocReleased;
                }
                group(Control64)
                {
                    ShowCaption = false;
                    Visible = CurVisible;

                    field(Currency; Rec.Currency)
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = NOT OpenApprovalEntriesExist;
                    }
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Payee';
                    Enabled = NOT OpenApprovalEntriesExist;
                }
                field("Payment Voucher Payee"; Rec."On behalf of")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT DocPosted;
                    Visible = DocReleased;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purpose';
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        PaymentLine: record "Payment Lines";
                    begin
                        PaymentLine.Reset;
                        // PaymentLine.SetRange("Payment Type", "Payment Type");
                        PaymentLine.SetRange(No, rec."No.");
                        if PaymentLine.FindSet() then begin
                            PaymentLine."Shortcut Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
                            PaymentLine."Shortcut Dimension 2 Code" := rec."Shortcut Dimension 2 Code";
                            PaymentLine.Modify()
                        end;

                    end;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Date of Project"; Rec."Date of Project")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Travel Date';
                    Enabled = NOT OpenApprovalEntriesExist;
                    ShowMandatory = true;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Return Date';
                    Enabled = NOT OpenApprovalEntriesExist;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = Basic, Suite;
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Enabled = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = DocPosted;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = DocPosted;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = DocPosted;
                }
                group(Control76)
                {
                    ShowCaption = false;

                    field("Staff No."; Rec."Staff No.")
                    {
                        ApplicationArea = Basic, Suite;
                        //  Enabled = false;
                    }
                    field("Account Type"; Rec."Account Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Salary Scale"; Rec."Salary Scale")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = true;
                        visible = false;
                    }
                    field(TrainingNo; Rec.TrainingNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                        visible = false;
                    }
                    field(Cashier; Rec.Cashier)
                    {
                        ApplicationArea = All;
                        Enabled = false;
                        visible = false;
                    }
                }
                group("EFT Details")
                {
                    Caption = 'EFT Details';
                    Enabled = NOT DocPosted;
                    Visible = EFTpayment;

                    field("EFT Reference"; Rec."EFT Reference")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("EFT File Generated"; Rec."EFT File Generated")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("EFT Date"; Rec."EFT Date")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
            part(ImprestLines; "Imprest Lines")
            {
                Caption = 'Imprest Lines';
                ApplicationArea = basic, suite;
                Enabled = NOT OpenApprovalEntriesExist and PageEnabled;
                SubPageLink = No = FIELD("No.");
                UpdatePropagation = both;
            }
            part(ExtImprestLines; "Ext Imprest Lines")
            {
                Caption = 'External Imprest Lines';
                ApplicationArea = basic, suite;
                Enabled = NOT OpenApprovalEntriesExist and PageEnabled;
                SubPageLink = No = FIELD("No.");
                UpdatePropagation = both;
                Visible = false;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50124), "No." = FIELD("No.");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = ShowCommentFactbox;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control53; Links)
            {
            }
            systempart(Control52; Notes)
            {
            }
        }
    }
    actions
    {
        area(navigation)
        {
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
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = Basic, Suite;

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
                    Commit();
                    ApprovalEntries.RunModal();
                end;
            }
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
                    Visible = false;

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = Rec.Status = Rec.Status::Open;
                    Image = SendApprovalRequest;
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Lines: Record "Payment Lines";
                        ImprestSlots: Integer;
                        Error001: Label 'Imprest Amount can not be less than or equal to 0';
                    begin
                        // ImprestRecord.CheckingStatus(Rec);
                        // ImprestRecord.CheckPendingSurrenderImp(Rec);
                        //CalcFields("Imprest Amount");
                        if Rec."Imprest Amount" <= 0 then Error(Error001);
                        Rec.TestField("Payment Narration");

                        rec.TestField("Account No.");
                        rec.TestField("Staff No.");
                        Committment.CheckImprestCommittment(Rec);
                        Committment.ImprestCommittment(Rec, ErrorMsg);
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
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Image = Cancel;
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitImprest(Rec);
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
                    ApplicationArea = Basic, Suite;
                    PromotedCategory = Process;
                    Image = Confirm;
                    Visible = Rec.Status = Rec.Status::Released;

                    trigger OnAction()
                    begin
                        Rec.ConfirmFundsReceipt();
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
                        Payments.SetRange("Payment Type", Rec."Payment Type"::Imprest);
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
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.Reset();
                        Rec.SetFilter("No.", '%1', Rec."No.");
                        if Rec.FindFirst() then begin
                            Commit();
                            REPORT.Run(Report::Imprest, true, false, Rec);
                        end;
                    end;
                }
                action("&Print Payment Voucher")
                {
                    Caption = '&Print Payment Voucher';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    ApplicationArea = Basic, Suite;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        Payments.Reset;
                        Payments.SetRange("No.", Rec."No.");
                        REPORT.Run(50000, true, true, Payments);
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
                    ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;

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
                    Visible = Rec.Status = Rec.Status::Released;
                    // Enabled = DocReleased;
                    ApplicationArea = all;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PaymentsPost.PostImprest(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action(Commit)
                {
                    Image = Confirm;

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Committment.ImprestCommittment(Rec, ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    trigger OnAction()
                    begin
                        Committment.ReverseImprestCommittment(Rec);
                    end;
                }
                action("Imprest Job")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PlanningWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    RunObject = report "Imprest Reminder Queue";
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
                            Committment.UncommitImprest(Rec);
                            Rec.Status := Rec.Status::Archived;
                            Rec.Modify;
                        end;
                    end;

                }
                action(Dimensions)
                {
                    //AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Commit();
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
            }
            //     action(GenerateEFT)
            //     {
            //         Caption = 'Generate EFT File';
            //         Enabled = DocReleased AND NOT DocPosted;
            //         Image = ExportToExcel;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         Visible = EFTpayment;
            //         trigger OnAction()
            //         begin
            //             if Confirm('Are you sure you want to generate an EFT file for PV %1', false, "No.") = true then begin
            //                 if PayMethod.Get("Pay Mode") then begin
            //                     if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::EFT then
            //                         Error('Payment mode must be EFT');
            //                 end else
            //                     Error('Pay mode %1 has not been set up', "Pay Mode");
            //                 CashManagementSetup.Get;
            //                 CashManagementSetup.TestField("EFT Path");
            //                 PLines.Reset;
            //                 PLines.SetRange(No, "No.");
            //                 if not PLines.FindFirst then
            //                     Error('Payment Lines are empty');
            //                 TestField("EFT File Generated", false);
            //                 PaymentRec.Reset;
            //                 PaymentRec.SetRange(PaymentRec."No.", "No.");
            //                 if PaymentRec.FindFirst then
            //                     REPORT.RunModal(51519010, false, false, PaymentRec);
            //             end;
            //         end;
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
    var
        PaymentLine: record "Payment Lines";
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec.Modify(true);
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        // DocStatus:=FormatStatus(Status);
        if Rec.Status <> Rec.Status::Released then
            CurrencyVisible := false
        else
            CurrencyVisible := true;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec.Modify(true);
    end;

    trigger OnInit()
    begin
        PageEnabled := true;
        CurVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Imprest: Record Payments;
    begin
        //Inserting Payment Type and Account Type:
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ;
        //Inserting Payment Type and Account Type:
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        ShowDimFields();
        ShowDim := true;
        //DocStatus:=FormatStatus(Status);
        if Rec.Status <> Rec.Status::Released then
            CurrencyVisible := false
        else
            CurrencyVisible := true;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        PaymentsPost: Codeunit "Payments Management";
        PaymentMethod: Record "Payment Method";
        [InDataSet]
        ChequePayment: Boolean;
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        [InDataSet]
        ShowDim: Boolean;
        ImpLinesPage: Page Imprest;
        [InDataSet]

        DocReleased: Boolean;
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        JobQueuesUsed: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        CreateIncomingDocumentVisible: Boolean;
        CreateIncomingDocFromEmailAttachment: Boolean;
        IncomingDocEmailAttachmentEnabled: Boolean;
        DocPosted: Boolean;
        User: Record User;
        CurrencyVisible: Boolean;
        Payments: Record Payments;
        UserSetup: Record "User Setup";
        PageEnabled: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        CurVisible: Boolean;
        ModifyHODApprovals: Report "Modify HOD Approvals";
        RPTypes: Record "Receipts and Payment Types";
        ImpLines: Record "Payment Lines";
        EmpRec: Record Employee;
        EFTPayment: Boolean;
        PaymentRec: Record Payments;
        PLines: Record "Payment Lines";
        PayMethod: Record "Payment Method";
        CashManagementSetup: Record "Cash Management Setups";
        //EDDIE [RunOnClient]
        //DocManagement: DotNet BCDocumentManagement;
        // DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        ImprestRecord: Record Payments;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if (Rec.Status = Rec.Status::Released) then begin
            DocReleased := true;
            // EDDIE PageEnabled := false
        end
        else if (Rec.Status = Rec.Status::"Pending Approval") then
            PageEnabled := false
        else
            DocReleased := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if Rec."Travel Type" = Rec."Travel Type"::Foreign then
            CurVisible := true
        else
            CurVisible := false;
    end;

    Local procedure CheckIfPendingSurrender()
    var
        Imprest: Record Payments;
        Txt0002: Label 'You still have unsurrended Imprest for date %1 with Imprest Amount %2. You cannot apply for another one until You Surrender the Previous Imprest';
    begin
        Imprest.Reset();
        Imprest.SetRange("User Id", UserId);
        Imprest.SetRange(Surrendered, false);
        Imprest.SetRange("Payment Type", Rec."Payment Type"::Imprest);
        if Imprest.FindFirst() then begin
            Error(Txt0002, Imprest."Date of Project", Imprest."Imprest Amount");
        end;
        //  "Payment Type" := "Payment Type"::Imprest;
        //   "Account Type" := "Account Type"::Customer;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update;
    end;

    procedure GetCustMaxImprest(EmpNo: Code[20]) Slot: Integer
    var
        Customer: Record Customer;
    begin
        // IF Customer.GET(EmpNo) THEN
        //  BEGIN
        //    Customer.TESTFIELD("Max Imprest Available");
        //    Slot:=Customer."Max Imprest Available";
        //  END;
        // EXIT(Slot);
    end;
}
