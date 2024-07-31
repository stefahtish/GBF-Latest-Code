page 51506 "GBF Payment Voucher"
{
    PageType = Card;
    SourceTable = "GBF Payments";
    SourceTableView = WHERE("Payment Type"=CONST(Normal), Posted=CONST(false));
    PromotedActionCategories = 'New,Print,Reporting,Post,Send for Approval,Cancel';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    /*IF Status<>Status::Open THEN
                        ERROR('You cannot change this document at this stage');*/
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    NotBlank = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN ERROR('You cannot change this document at this stage');
                    end;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                }
                field("Exchange Factor"; Rec."Exchange Factor")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Trip No"; Rec."Trip No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    NotBlank = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN ERROR('You cannot change this document at this stage');
                    end;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Details';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    Caption = 'Payee Bank Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    Caption = 'Payee Bank account No';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bank Name and Branch"; Rec."Bank Name and Branch")
                {
                    Caption = 'Branch';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    /*
                    IF Status=Status::Released THEN
                      BEGIN
                        CompanyInfo.GET();
                        Subject:='Payment Processing Notification';
                        SenderAddress:='erp@krb.go.ke';
                        SenderName:=CompanyInfo.Name;
                        Body:=STRSUBSTNO('This is to inform you that payment number %1 for %2 of net amount: %3 is currently being processed.',Rec.No,Rec.Payee,Rec."Net Amount");
                        Recipients:='rkamis@krb.go.ke; jruwa@krb.go.ke';
                        //Recipients:='gjuma@krb.go.ke';
                        SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                        SMTPSetup.Send;
                        MESSAGE('%1 have been notified of payment being processing',Recipients);
                        END;
                          */
                    end;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Gross Payment Amount';
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("W/H Income Tax"; Rec."W/H Income Tax")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Advance Payment Amount"; Rec."Advance Payment Amount")
                {
                    Editable = false;
                    Visible = AdvancePaymentVisible;
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Caption = 'Net Payment Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Eft Generated"; Rec."Eft Generated")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. Of Instalments"; Rec."No. Of Instalments")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cancellation Reason"; Rec."Cancellation Reason")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            part(lines; "PV Lines")
            {
                SubPageLink = "PV No"=FIELD(No);
                ApplicationArea = All;
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Payments)
            {
                Caption = 'Payments';

                action("Print Cheque")
                {
                    Caption = 'Print Cheque';
                    Image = Print;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Pay Mode");
                        Rec.TESTFIELD("Paying Bank Account");
                        Rec.TESTFIELD(Payee);
                        Rec.TESTFIELD(Status, Rec.Status::"Pending Review");
                        Rec.RESET;
                        Rec.SETFILTER(No, Rec.No);
                        // REPORT.RUN(Report::"Cheque UFAA", TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                action("VAT Certificate")
                {
                    Caption = 'VAT Certificate';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Pay Mode");
                        Rec.TESTFIELD("Paying Bank Account");
                        Rec.TESTFIELD(Payee);
                        /*IF Status<>Status::Released THEN
                        ERROR('This document is not yet fully approved'); */
                        PVRec.RESET;
                        PVRec.SETRANGE(PVRec.No, Rec.No);
                    //REPORT.RUNMODAL(Report::"VAT Withholding Certificate", TRUE, TRUE, PVRec);
                    end;
                }
                action("Generate  EFT")
                {
                    Caption = 'Generate  EFT';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                    /*
                        TESTFIELD("Pay Mode");
                        TESTFIELD("Paying Bank Account");
                        TESTFIELD(Payee);
                        
                        
                        KCBEFT.GetPV(Rec);
                        KCBEFT.RUN;
                         */
                    end;
                }
                action("Print Cheque - dot marix")
                {
                    Caption = 'Print Cheque - dot marix';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Pay Mode");
                        Rec.TESTFIELD("Paying Bank Account");
                        Rec.TESTFIELD(Payee);
                        Rec.TESTFIELD(Status, Rec.Status::"Pending Review");
                        Rec.RESET;
                        Rec.SETFILTER(No, Rec.No);
                        //  REPORT.RUN(Report::"Cheque ERC dot matrix", TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                action("Transaction History")
                {
                    Image = Allocations;
                    Promoted = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETFILTER(No, Rec.No);
                        IF Rec.FINDFIRST THEN //   REPORT.RUN(Report::"Payment History Trail", TRUE, TRUE, Rec);
                            Rec.RESET;
                    end;
                }
            }
            group(Functions)
            {
                Caption = 'Functions';

                action("View Approvals")
                {
                    Caption = 'View Approvals';
                    Image = Approvals;
                    RunObject = Page "Approval Request Entries";
                    RunPageLink = "Document No."=FIELD(No);
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                    /*TESTFIELD("Pay Mode");
                        TESTFIELD("Paying Bank Account");
                        TESTFIELD(Payee);
                        //IF ApprovalMgt.SendPaymentsApprovalRequest(Rec) THEN;
                        Status:=Status::Released;
                        MODIFY;*/
                    end;
                }
            }
            action("Cancel PV")
            {
                Image = CancelLine;
                Promoted = true;
                PromotedCategory = Category6;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    // PaymentRelease.CancelPV(Rec);
                    IF CONFIRM('do you want to cancel this PV', FALSE, TRUE) = TRUE THEN BEGIN
                        Rec.Status:=Rec.Status::Open;
                        Rec.MODIFY;
                        MESSAGE('Payment Voucher %1 has been Cancelled', Rec.No);
                    END
                    ELSE
                        EXIT;
                end;
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Visible = ApprovalsVisible;

                action(Approve)
                {
                    Caption = 'Review';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = ApprovalsVisible;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = ApprovalsVisible;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = ApprovalsVisible;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Send For Approval")
            {
                Caption = 'Send For Approval';
                Enabled = false;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Open THEN ERROR('The document has already been processed.');
                    IF Rec.Amount < 0 THEN ERROR('Amount cannot be less than zero.');
                    IF Rec.Amount = 0 THEN ERROR('Please enter amount.');
                    IF Rec."Pay Mode" = 'CHEQUE' THEN BEGIN
                        Rec.TESTFIELD("Paying Bank Account");
                    //TESTFIELD("Cheque No");
                    //TESTFIELD("Cheque Date");
                    //TESTFIELD("Cheque Type");
                    //TESTFIELD("Bank Code");
                    END;
                    Rec.TESTFIELD("Paying Bank Account");
                    Rec.TESTFIELD("Transaction Name");
                    Rec.TESTFIELD("Pay Mode");
                    Rec.TESTFIELD(Payee);
                    Rec.TESTFIELD(Amount);
                    Rec.TESTFIELD("VAT Code");
                    Rec.TESTFIELD("Withholding Tax Code");
                    Rec.TESTFIELD("Global Dimension 1 Code");
                    Rec.TESTFIELD("Account No.");
                    Rec.TESTFIELD("Branch Code");
                    Rec.TESTFIELD("Net Amount");
                    Rec.TESTFIELD("Paying Bank Account");
                /*IF CONFIRM('Are you sure you would like to approve the payment?',FALSE)=TRUE THEN BEGIN
                    Status:=Status::Released;
                    MODIFY;
                    MESSAGE('Document approved successfully.');
                    END;*/
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Enabled = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = PostVisible;
                ApplicationArea = all;

                trigger OnAction()
                var
                //  PVPost: Codeunit 51511014;
                begin
                    //Charles
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    // //
                    // UserSetup.RESET;
                    // UserSetup.SETRANGE(UserSetup."User ID", USERID);
                    // UserSetup.SETRANGE(UserSetup."Restrict Post Transactions", TRUE);
                    // IF UserSetup.FIND('-') THEN
                    //     ERROR('You are not allowed to perform this Action');
                    //IF Cashier=USERID THEN // Requested be Director F & S
                    // ERROR('Maker checker control, You do not have permissions to post Payment Voucher');
                    // IF "Trip No" <> '' THEN BEGIN
                    //     /*
                    //      // Requested by Kirui and Mariam on 12th Jan 2021.
                    //      IF CONFIRM('Payment voucher is for a trip\\Do you want to update PV from the trip\incase of staff who accepted later?',FALSE,TRUE)=TRUE THEN BEGIN
                    //         ImprestTrip.RESET;
                    //         ImprestTrip.SETFILTER(ImprestTrip."Trip No","Trip No");
                    //         IF ImprestTrip.FIND('-') THEN BEGIN
                    //          PAGE.RUNMODAL(51513521,ImprestTrip);
                    //         END;
                    //       END;
                    //      */
                    //     // Check If Exchange Rate has been specified for foreign Trips
                    //     IF ImprestTrip.GET("Trip No") THEN BEGIN
                    //         IF ImprestTrip."Destination Type" = ImprestTrip."Destination Type"::Foreign THEN BEGIN
                    //             IF Currency = '' THEN
                    //                 ERROR('Kindly Specify Currency for this trip');
                    //             IF "Exchange Rate" = 0 THEN
                    //                 ERROR('Kindly specify Exchange rate for %1', Currency);
                    //             // Update the Imprest with Payment Currency
                    //             RequestHeader.RESET;
                    //             RequestHeader.SETRANGE(RequestHeader."Trip No", "Trip No");
                    //             IF RequestHeader.FIND('-') THEN BEGIN
                    //                 REPEAT
                    //                     RequestHeader."Currency Code" := Currency;
                    //                     RequestHeader."Posted In finance" := TRUE;
                    //                     RequestHeader.MODIFY;
                    //                 UNTIL RequestHeader.NEXT = 0;
                    //             END;
                    //         END ELSE BEGIN
                    //             // Update the Imprest as posted
                    //             RequestHeader.RESET;
                    //             RequestHeader.SETRANGE(RequestHeader."Trip No", "Trip No");
                    //             IF RequestHeader.FIND('-') THEN BEGIN
                    //                 REPEAT
                    //                     RequestHeader."Posted In finance" := TRUE;
                    //                     RequestHeader.MODIFY;
                    //                 UNTIL RequestHeader.NEXT = 0;
                    //             END;
                    //         END;
                    //     END;
                    // END;
                    // // If posted mark as posted
                    // BankLedger.RESET;
                    // BankLedger.SETRANGE("Document No.", No);
                    // BankLedger.SETRANGE(Reversed, FALSE);
                    // IF BankLedger.FIND('-') THEN BEGIN
                    //     Posted := TRUE;
                    //     "Posted By" := BankLedger."User ID";
                    //     "Date Posted" := BankLedger."Posting Date";
                    //     MODIFY;
                    // END;
                    // COMMIT;
                    PVPosting.PostBatch(Rec);
                    Rec.Posted:=true;
                    Rec.modify;
                // Close Director Payroll Meetings
                // IF Source = Source::"Director Payroll" THEN BEGIN
                //     BoardOfDirectorsMeetings.RESET;
                //     BoardOfDirectorsMeetings.SETRANGE(BoardOfDirectorsMeetings."Payroll Month", "Director Payroll Month");
                //     IF BoardOfDirectorsMeetings.FIND('-') THEN BEGIN
                //         REPEAT
                //             BoardOfDirectorsMeetings."PV No" := No;
                //             BoardOfDirectorsMeetings.Posted := TRUE;
                //             BoardOfDirectorsMeetings.MODIFY;
                //         UNTIL BoardOfDirectorsMeetings.NEXT = 0;
                //     END;
                // END;
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //charles
                    //TESTFIELD(Status,Status::Open);
                    Rec.RESET;
                    Rec.SETFILTER(No, Rec.No);
                // REPORT.RUN(Report::"Duplicate Payment Vouchers", TRUE, TRUE, Rec);
                // CASE Source OF
                //     Source::Imprest:
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Payment Voucher":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Imprest Claim":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Petty Cash Voucher":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Fund Disbursement":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Director Payroll":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                // END;
                // RESET;
                end;
            }
            action("Print Duplicate")
            {
                Caption = 'Print Duplicate';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                //charles
                //TESTFIELD(Status,Status::Open);
                end;
            }
            action("E-Mail Voucher")
            {
                Caption = 'E-Mail Voucher';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                //Notices: Codeunit Notices;
                begin
                //TESTFIELD(Status,Status::"Pending Review");
                //Notices.Payments(No);
                end;
            }
            action("Import Payments")
            {
                Caption = 'Import Payments';
                Image = Import;
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                //PaymentImport.GetRec(Rec);
                //   PaymentImport.RUN;
                end;
            }
            action(ApprovalEntries)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID);
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Visible = true;

                action(SendApprovalRequest)
                {
                    Caption = 'Send Review Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        CheckForRequiredFields;
                        VarVariant:=Rec;
                        if ApprovalsMgmtCut.CheckGBFPaymentsApprovalsWorkflowEnable(Rec)then ApprovalsMgmtCut.OnSendGBFPaymentsForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Review Request';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //*ApprovalsMgmt.OnCancelPVApprovalRequest(Rec);
                        Rec.TESTFIELD(Status, Rec.Status::"Pending Review");
                        VarVariant:=Rec;
                        //ApprovalsManagement.OnCancelDocApprovalRequest(VarVariant);
                        ApprovalsMgmtCut.OnCancelGBFPaymentsForApproval(Rec);
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvalls)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    // RunObject = Page 51511013;
                    // RunPageLink = "Document No." = FIELD("No");
                    RunPageMode = View;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF Rec.Status IN[Rec.Status::Released]THEN PostVisible:=TRUE
        ELSE
            PostVisible:=FALSE;
        SetControlAppearance;
    end;
    trigger OnClosePage()
    begin
    /*IF Status=Status::Open THEN
          BEGIN
        
            IF CONFIRM('Send this payment document for approval?',FALSE)=TRUE THEN
              BEGIN
                CheckForRequiredFields;
        
                VarVariant := Rec;
                IF ApprovalsManagement.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                  ApprovalsManagement.OnSendDocForApproval(VarVariant);
                END;
            END;
        
        IF CONFIRM('Do you want to print this document?',FALSE)=TRUE THEN
          BEGIN
            RESET;
            SETFILTER(No,No);
            CASE Source OF
              Source::Imprest:
                BEGIN
                  REPORT.RUN(51511021,TRUE,TRUE,Rec);
                  END;
              Source::"Payment Voucher":
                BEGIN
                  REPORT.RUN(51511013,TRUE,TRUE,Rec);
                  END;
              Source::"Petty Cash Voucher":
                BEGIN
                  REPORT.RUN(51511013,TRUE,TRUE,Rec);
                  END;
              END;
            RESET;
            END;
             */
    end;
    trigger OnDeleteRecord(): Boolean begin
    /*
        IF Posted THEN
        ERROR('You cannot delete the details of the payment voucher at this stage');
        */
    end;
    trigger OnInit()
    begin
        IF Rec.Status IN[Rec.Status::Released]THEN PostVisible:=TRUE
        ELSE
            PostVisible:=FALSE;
    end;
    trigger OnModifyRecord(): Boolean begin
    /*
        IF Posted THEN
        ERROR('You cannot change the details of the payment voucher at this stage');
        IF Posted=TRUE THEN
        ERROR('The transaction has already been posted and therefore cannot be modified.');
        IF Status<>Status::Open THEN
        BEGIN
        ERROR('You cannot modify this voucher');
        END;
        */
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // CurrForm.EDITABLE:=TRUE;
        Rec."Payment Type":=Rec."Payment Type"::Normal;
        Rec."Transaction Type":=Rec."Transaction Type"::Payments;
        //"Account No.":='BK-001';
        Rec.Cashier:=USERID;
    end;
    trigger OnNextRecord(Steps: Integer): Integer begin
        CurrPage.EDITABLE:=TRUE;
    end;
    trigger OnOpenPage()
    begin
        ApprovalsVisible:=FALSE;
        CurrPage.EDITABLE:=TRUE;
        AdvancePaymentVisible:=FALSE;
        Rec."Account Type":=Rec."Account Type"::Customer;
        SetControlAppearance;
        //
        IF Rec.Status IN[Rec.Status::Released]THEN PostVisible:=TRUE
        ELSE
            PostVisible:=FALSE;
    end;
    var ApprovalsMgmtCut: Codeunit "RE Approval Mgmt. Ext";
    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    // RecPayTypes: Record "Receipts and Payment Typess";
    GenJnlLine: Record "Gen. Journal Line";
    DefaultBatch: Record "Gen. Journal Batch";
    LineNo: Integer;
    CustLedger: Record "Vendor Ledger Entry";
    CustLedger1: Record "Vendor Ledger Entry";
    Amt: Decimal;
    FaDepreciation: Record "FA Depreciation Book";
    BankAcc: Record "Bank Account";
    PVLines: Record "PV Lines";
    LastPVLine: Integer;
    PolicyRec: Record "Sales Cr.Memo Header";
    PremiumControlAmt: Decimal;
    BasePremium: Decimal;
    TotalTax: Decimal;
    TotalTaxPercent: Decimal;
    TotalPercent: Decimal;
    SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
    AdjustConversion: Codeunit "Adjust Gen. Journal Balance";
    ApprovalMgt: Codeunit "Approvals Mgmt.";
    // VATCert: Report "VAT Withholding Certificate";
    PVRec: Record "GBF Payments";
    LastEntry: Integer;
    BankLedger: Record "Bank Account Ledger Entry";
    GlLineNo: Integer;
    GLSetup: Record "Cash Management SetupS";
    Link: Text[250];
    //  PaymentImport: XMLport Payments;
    // CBAEFT: Report "CBA EFT";
    CompanyInfo: Record "Company Information";
    SenderAddress: Text[80];
    SenderName: Text[80];
    Subject: Text[100];
    Body: Text[250];
    Recipients: Text[80];
    //  SMTPSetup: Codeunit "SMTP Mail";
    FileName: Text[250];
    Vendor: Record Vendor;
    FileManagement: Codeunit "Filter Tokens";
    PVPosting: Codeunit "Payment- Post";
    // Reinslines: Record "Coinsurance Reinsurance Lines";
    OpenApprovalEntriesExistCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    //CICEFT: Report "CIC EFT Test1";//
    // CashMgtSetup: Record "Cash Management Setup";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //PaymentRelease: Codeunit "Release PV Document";
    "--": Integer;
    VarVariant: Variant;
    // ApprovalsManagement: Codeunit 51403013;
    ApprovalsVisible: Boolean;
    //   ImprestTrip: Record "Imprest Trip";
    AdvancePaymentVisible: Boolean;
    UserSetup: Record "User Setup";
    // BoardOfDirectorsMeetings: Record "Board Of Directors Meetings";
    PayingBankAccountEditable: Boolean;
    PayeeEditable: Boolean;
    RemarksEditable: Boolean;
    RequestDateEditable: Boolean;
    PaymodeEditable: Boolean;
    ChequeNoEditable: Boolean;
    LinesEditable: Boolean;
    PostVisible: Boolean;
    PurchHeader: Record "Purchase Header";
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        IF OpenApprovalEntriesExistForCurrUser = TRUE THEN ApprovalsVisible:=TRUE;
        //MESSAGE('OpenApprovalEntriesExistForCurrUser for current user=%1',OpenApprovalEntriesExistForCurrUser);
        //MESSAGE('OpenApprovalEntriesExist',OpenApprovalEntriesExist);
        // Payment voucher Header field visibility proprty
        PVLines.RESET;
        PVLines.SETRANGE("PV No", Rec.No);
        PVLines.SETFILTER("Advance Payment Amount", '>%1', 0);
        IF PVLines.FIND('-')THEN BEGIN
            AdvancePaymentVisible:=TRUE;
        END;
    end;
    local procedure CheckForRequiredFields()
    var
    //  RequestLines: Record "Request Lines";
    // GroupImprestLines: Record "Group Imprest Lines";
    begin
        //TESTFIELD(Remarks);
        Rec.TESTFIELD(Payee);
        Rec.TESTFIELD("Paying Bank Account");
        Rec.CALCFIELDS("Net Amount");
        IF Rec."Net Amount" = 0 THEN ERROR('Payment amount has not been specicied');
        //check if lines are populated
        PVLines.RESET;
        PVLines.SETRANGE("PV No", Rec.No);
        IF NOT PVLines.FIND('-')THEN ERROR('Kindly populate Payment lines');
        //
        PVLines.RESET;
        PVLines.SETRANGE("PV No", Rec.No);
        IF PVLines.FIND('-')THEN BEGIN
            REPEAT IF PVLines."Payment- Support Docs" = PVLines."Payment- Support Docs"::"LPO/LSO" THEN PVLines.TESTFIELD("LPO/LSO No.");
            UNTIL PVLines.NEXT = 0;
        END;
    end;
    procedure PageControls()
    begin
        IF Rec.Status <> Rec.Status::Released THEN BEGIN //Open
            PayingBankAccountEditable:=TRUE;
            PayeeEditable:=TRUE;
            RemarksEditable:=TRUE;
            RequestDateEditable:=FALSE;
            PaymodeEditable:=TRUE;
            ChequeNoEditable:=FALSE;
            LinesEditable:=TRUE;
        END
        ELSE
        BEGIN //Released
            PayingBankAccountEditable:=TRUE;
            RemarksEditable:=FALSE;
            RequestDateEditable:=FALSE;
            PaymodeEditable:=TRUE;
            ChequeNoEditable:=TRUE;
            LinesEditable:=FALSE;
            CurrPage.UPDATE;
        END;
        IF Rec.Status = Rec.Status::"Pending Review" THEN BEGIN
            PayingBankAccountEditable:=FALSE;
            RemarksEditable:=FALSE;
            PaymodeEditable:=FALSE;
            ChequeNoEditable:=FALSE;
            UserSetup.RESET;
            UserSetup.SETRANGE(UserSetup."User ID", USERID);
            //UserSetup.SETRANGE(UserSetup."Update Payment Lines", TRUE);
            IF NOT UserSetup.FIND('-')THEN BEGIN
                LinesEditable:=FALSE;
                RequestDateEditable:=FALSE;
            END;
        END;
        IF Rec.Posted = TRUE THEN BEGIN
            PayingBankAccountEditable:=FALSE;
            RemarksEditable:=FALSE;
            RequestDateEditable:=FALSE;
            PaymodeEditable:=FALSE;
            ChequeNoEditable:=FALSE;
            LinesEditable:=FALSE;
        END;
    end;
    procedure PageUpdate()
    begin
        xRec:=Rec;
        PageControls();
        CurrPage.UPDATE;
    end;
}
