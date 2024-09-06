page 50245 "Approved/Post Imprest Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    ApplicationArea = All;
                    Caption = 'Time';
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Editable = NOT OpenApprovalEntriesExist;
                    Visible = ShowDim;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = All;
                        Visible = ShowDim;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;
                        Visible = ShowDim;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
                group("Payment Details")
                {
                    Caption = 'Payment Details';
                    Visible = DocReleased;

                    field("Pay Mode"; Rec."Pay Mode")
                    {
                        Editable = OpenApprovalEntriesExist AND NOT DocPosted;
                        Visible = DocReleased;
                        ShowMandatory = true;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Paying Bank Account"; Rec."Paying Bank Account")
                    {
                        Enabled = OpenApprovalEntriesExist AND NOT DocPosted;
                        Visible = DocReleased;
                        ShowMandatory = true;
                        ApplicationArea = All;
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
                    group(Control69)
                    {
                        ShowCaption = false;
                        Visible = ChequePayment;

                        field("Cheque Type"; Rec."Cheque Type")
                        {
                            ApplicationArea = All;
                            Editable = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                        }
                        field("Cheque No"; Rec."Cheque No")
                        {
                            ApplicationArea = All;
                            Editable = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                            Visible = DocReleased;
                        }
                        field("Cheque Date"; Rec."Cheque Date")
                        {
                            ApplicationArea = All;
                            Editable = OpenApprovalEntriesExist AND ChequePayment AND NOT DocPosted;
                            Visible = DocReleased;
                        }
                    }
                }
                field("Travel Type"; Rec."Travel Type")
                {
                    Editable = NOT OpenApprovalEntriesExist;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                group(Control64)
                {
                    ShowCaption = false;
                    Visible = CurVisible;

                    field(Currency; Rec.Currency)
                    {
                        ApplicationArea = All;
                        Editable = NOT OpenApprovalEntriesExist AND NOT DocPosted;
                    }
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Imprest Payee';
                    ApplicationArea = All;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Payment Voucher Payee"; Rec."On behalf of")
                {
                    Editable = NOT DocPosted;
                    ApplicationArea = All;
                    Visible = DocReleased;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Purpose';
                    ApplicationArea = All;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Date of Project"; Rec."Date of Project")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = All;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = NOT OpenApprovalEntriesExist;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = DocPosted;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = DocPosted;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = DocPosted;
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Confirm Receipt User"; Rec."Confirm Receipt User")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Confirm Receipt Date-Time"; Rec."Confirm Receipt Date-Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
            part(ImprestLines; "Imprest Lines")
            {
                Caption = 'Imprest Lines';
                ApplicationArea = basic, suite;
                Editable = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
            }
            part(ExtImprestLines; "Ext Imprest Lines")
            {
                Caption = 'External Imprest Lines';
                ApplicationArea = basic, suite;
                // Editable = NOT OpenApprovalEntriesExist;
                SubPageLink = No = FIELD("No.");
                Visible = false;
            }
        }
        area(factboxes)
        {
            /*part(Control57; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST (50000),
                              "Document Type" = CONST ("Payment Voucher"),
                              "Document No." = FIELD ("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control56; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST (50000),
                              "Document Type" = CONST ("Payment Voucher"),
                              "Document No." = FIELD ("No.");
                Visible = false;
            }*/
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                Visible = ShowCommentFactbox;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
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
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                Image = "Order";

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = basic, suite;
                    RunObject = Page "Comment Sheet";
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = basic, suite;
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
                    ApplicationArea = basic, suite;
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
                        Commit();
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
                    ApplicationArea = basic, suite;
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
                    ApplicationArea = basic, suite;

                    trigger OnAction()
                    var
                        ImprestSlots: Integer;
                        Error001: Label 'Imprest Amount can not be less than or equal to 0';
                    begin
                        Rec.CalcFields("Imprest Amount");
                        if Rec."Imprest Amount" <= 0 then Error(Error001);
                        Rec.TestField("Payment Narration");
                        // ImpLines.RESET;
                        // ImpLines.SETRANGE(No,"No.");
                        // IF ImpLines.FIND('-') THEN
                        //   //BEGIN
                        //    RPTypes.RESET;
                        //    RPTypes.SETRANGE(Code,ImpLines."Expenditure Type");
                        //    IF RPTypes.FIND('-') THEN
                        //         IF RPTypes."Cost of Sale"=TRUE THEN
                        //          MESSAGE('%1,%2,%3',RPTypes.Code,ImpLines."Expenditure Type",RPTypes."Cost of Sale");
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
                    Enabled = NOT DocReleased;
                    Image = Cancel;
                    Promoted = true;
                    ApplicationArea = basic, suite;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitImprest(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Commit;
                            Committment.UncommitImprest(Rec);
                            Commit;
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
                    ApplicationArea = basic, suite;
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
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        Rec.SetRange("No.", Rec."No.");
                        REPORT.Run(50000, true, true, Rec)
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
                    ApplicationArea = basic, suite;

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

                action(Post)
                {
                    Caption = 'P&ost';
                    Enabled = DocReleased AND NOT DocPosted;
                    Image = PostOrder;
                    ApplicationArea = basic, suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostImprest(Rec);
                        Commit;
                        CurrPage.Close;
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
                    ApplicationArea = basic, suite;

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
                    ApplicationArea = basic, suite;

                    trigger OnAction()
                    begin
                        Committment.ReverseImprestCommittment(Rec);
                    end;
                }
                action(Approve)
                {
                    Image = Approve;
                    ApplicationArea = basic, suite;
                    Promoted = true;
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
                    Promoted = true;
                    ApplicationArea = basic, suite;
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
                    ApplicationArea = basic, suite;
                    PromotedCategory = Process;
                    Visible = false;
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
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec.Modify();
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        // DocStatus:=FormatStatus(Status);
        if Rec.Status <> Rec.Status::Released then
            CurrencyVisible := false
        else
            CurrencyVisible := true;
    end;

    trigger OnInit()
    begin
        PageEditable := true;
        CurVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
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
        //ShowDimFields();
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
        PageEditable: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        CurVisible: Boolean;
        ModifyHODApprovals: Report "Modify HOD Approvals";
        RPTypes: Record "Receipts and Payment Types";
        ImpLines: Record "Payment Lines";
        EFTPayment: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := true //ApprovalsMgmt.HasApprovalEntries(RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
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
        // IF "Travel Type"="Travel Type"::Foreign THEN
        //  CurVisible:=TRUE
        // ELSE
        CurVisible := true;
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
