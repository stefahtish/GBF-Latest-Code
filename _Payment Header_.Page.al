page 50841 "Payment Header"
{
    // //Use if Cheque is to be Validated
    // Payments.RESET;
    // Payments.SETRANGE(Payments."No.","No.");
    // IF Payments.FINDFIRST THEN
    //   BEGIN
    //     IF Payments."Pay Mode"=Payments."Pay Mode"::Cheque THEN
    //       BEGIN
    //          IF STRLEN(Payments."Cheque No.")<>6 THEN
    //           BEGIN
    //             ERROR ('Invalid Cheque Number Inserted');
    //           END;
    //       END;
    //   END;
    // **************************************************************************************
    // //Use if Paying Bank Account should not be overdrawn
    // 
    // //get the source account balance from the database table
    // BankAcc.RESET;
    // BankAcc.SETRANGE(BankAcc."No.",Payment."Paying Bank Account");
    // BankAcc.SETRANGE(BankAcc."Bank Type",BankAcc."Bank Type"::Cash);
    // IF BankAcc.FINDFIRST THEN
    //   BEGIN
    //     Payments.TESTFIELD(Payments.Date,TODAY);
    //     BankAcc.CALCFIELDS(BankAcc."Balance (LCY)");
    //     "Current Source A/C Bal.":=BankAcc."Balance (LCY)";
    //     IF ("Current Source A/C Bal."-Payment."Total Net Amount")<0 THEN
    //       BEGIN
    //         ERROR('The transaction will result in a negative balance in the BANK ACCOUNT.');
    //       END;
    //   END;
    Caption = 'Bank Payment Vouchers';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER(<> "Petty Cash"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                    Importance = Promoted;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension3CodeEditable;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Payment For"; Rec."Payment For")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Intercompany Transaction"; Rec."Intercompany Transaction")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control7)
            {
                ShowCaption = false;

                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment to';
                    Editable = true;
                    Importance = Promoted;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                }
                field("Officer Name"; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        Rec.TestField("Paying Bank Account");
                        PVHead.Reset;
                        PVHead.SetRange(PVHead."Paying Bank Account", Rec."Paying Bank Account");
                        PVHead.SetRange(PVHead."Pay Mode", PVHead."Pay Mode"::Cheque);
                        if PVHead.FindFirst then begin
                            repeat
                                if PVHead."Cheque No." = Rec."Cheque No." then begin
                                    if PVHead."No." <> Rec."No." then begin
                                        Error('The Cheque Number has already been utilised');
                                    end;
                                end;
                            until PVHead.Next = 0;
                        end;
                    end;
                }
                field("EFT Batch No."; Rec."EFT Batch No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Payment Release DateEditable";
                }
                field("Payment Notification Message"; Rec."Payment Notification Message")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(PVLines; "Payment Lines List")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = No = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(Control21; "Vendor Transactions FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Name = FIELD(Payee);
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';

                action("Sharing Matrix")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Matrice de partage';
                    Image = MiniForm;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Payments.Reset;
                        Payments.SetRange("No.", Rec."External Doc No");
                        if (Payments.FindFirst) then begin
                            /*  "IC Share Matrix".Reset;
                                  // "IC Share Matrix".SetRange(RequestNo, Payments."No.");
                                  PAGE.RunModal(51520011, "IC Share Matrix");
                              end else begin
                                  "IC Share Matrix".Reset;
                                  //"IC Share Matrix".SetRange(RequestNo, "No.");
                                  PAGE.RunModal(51520011, "IC Share Matrix");
                                  */
                        end;
                    end;
                }
                action(PostPayment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Post PV Entries
                        CurrPage.SaveRecord;
                        if (Rec.Posted <> true) then //TESTFIELD("Payment For");
                            /*CompName:=COMPANYNAME;
                            IF CompName<>'Haskal' THEN BEGIN

                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No,"No.");
                            IF PayLine.FINDFIRST THEN BEGIN
                             REPEAT

                              PayLine.TESTFIELD("Payee Email");
                              IF "Pay Mode"<>"Pay Mode"::Cheque THEN
                              IF "Currency Code"='' THEN
                              PayLine.TESTFIELD("Payee Account No");
                             UNTIL PayLine.NEXT =0 ;

                            END;
                           END;
                            */
                            if Confirm(Text005, true) then begin
                                Rec.TestField(Status, Rec.Status::Approved);
                                // PostCustomDocs.PostPV(Rec);
                            end;
                    end;
                }
                separator(Separator1102755026)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                    begin
                        if Rec."Payment Type" = Rec."Payment Type"::Normal then
                            DocumentType := DocumentType::"Payment Voucher"
                        else
                            DocumentType := DocumentType::"Express Pv";
                        Approvalentries.Setrecordfilters(DATABASE::"Payments Header", DocumentType, Rec."No.");
                        Approvalentries.Run;
                    end;
                }
                action("Send for Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not LinesExists then Error('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then Error('There are some lines that have not been committed');
                        CompName := CompanyName;
                        if CompName <> 'Haskal' then begin
                            PayLine.Reset;
                            PayLine.SetRange(PayLine.No, Rec."No.");
                            if PayLine.FindSet then begin
                                repeat
                                    PayLine.TestField("Payee Email");
                                //PayLine.TESTFIELD("Payee Account No");
                                until PayLine.Next = 0;
                            end;
                        end;
                        //Release the PV for Approval
                        //IF ApprovalMgt.SendPVApprovalRequest(Rec) THEN;
                    end;
                }
                action("Print preview")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        if CompanyName = 'Leadway VIE' then
                            REPORT.Run(51519925, true, true, Rec)
                        else
                            REPORT.Run(Report::Enquiries, true, true, Rec);
                    end;
                }
                action("Cancel Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ///IF ApprovalMgt.CancelPVApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Separator1102755009)
                {
                }
                action("Check Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin
                        BCSetup.Get;
                        if not BCSetup.Mandatory then exit;
                        if not AllFieldsEntered then Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                        /*First Check whether other lines are already committed.
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                            Commitments.SetRange(Commitments."Document No.", "No.");
                            if Commitments.Find('-') then begin
                                if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                                Commitments.Reset;
                                Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                                Commitments.SetRange(Commitments."Document No.", "No.");
                                Commitments.DeleteAll;
                            end;*/
                        // CheckBudgetAvail.CheckPayments(Rec);
                    end;
                }
                action("Cancel Budget Committment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin
                            exit
                        end;
                        /*
                                                Commitments.Reset;
                                                Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                                                Commitments.SetRange(Commitments."Document No.", "No.");
                                                Commitments.DeleteAll;
                        */
                        PayLine.Reset;
                        PayLine.SetRange(PayLine.No, Rec."No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine.Committed := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
                        end;
                    end;
                }
                separator(Separator1102755033)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then Error('You can only print a Payment Voucher after it is fully Approved');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(Report::Enquiries, true, true, Rec);
                        Rec.Reset;
                        CurrPage.Update;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Bank Letter")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Letter';

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line";
                    begin
                        if Rec.Status = Rec.Status::Pending then Error('You cannot Print until the document is released for approval');
                        FilterbyPayline.Reset;
                        FilterbyPayline.SetFilter(FilterbyPayline.No, Rec."No.");
                        REPORT.Run(Report::Enquiries, true, true, FilterbyPayline);
                        Rec.Reset;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Funds Mgt Comment List";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                }
                separator(Separator1102756005)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                    begin
                        if Rec.Status = Rec.Status::Posted then Error('Please reverse this document first'); //TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_Type::"Payment Voucher";
                            //CheckBudgetAvail.ReverseEntries(Doc_Type, "No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end
                        else
                            Error(Text001);
                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';

                action("Copy Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Loan';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /* prAssignEmp.Reset;
                             prAssignEmp.SetRange(prAssignEmp.Status, prAssignEmp.Status::Posted);
                             if prAssignEmp.FindSet then
                                 if PAGE.RunModal(51519545, prAssignEmp) = ACTION::LookupOK then
                                     InsertPvLine(prAssignEmp);
                                     */
                    end;
                }
                action("Copy Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Invoice';
                }
                action("Get Payment Request Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Get Payment Request Lines';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RecLines: Record "Payment Line";
                        PaymentsHeader: Record "Payments Header";
                        PaymentsLine: Record "Payment Line";
                    begin
                        /*
                        PaymentsHeader.INIT;
                          PaymentsHeader.TRANSFERFIELDS(Rec);
                          PaymentsHeader."No.":='';
                        PaymentsHeader.INSERT(TRUE);
                        
                        PaymentsHeader."Global Dimension 1 Code":="Global Dimension 1 Code";
                        PaymentsHeader."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                        PaymentsHeader.MODIFY;
                        
                        
                        RecLines.SETRANGE(RecLines.No,"No.");
                        IF RecLines.FINDSET THEN
                        REPEAT
                          PaymentsLine.INIT;
                          PaymentsLine.TRANSFERFIELDS(RecLines);
                          PaymentsLine.No:="No.";
                          PaymentsLine.INSERT(TRUE);
                        UNTIL RecLines.NEXT=0;
                        
                        
                        Status:=Status::Posted;
                        Posted:=TRUE;
                        "Date Posted":=TODAY;
                        "Time Posted":=TIME;
                        MODIFY;
                        
                        PAGE.RUN(51519905,PaymentsHeader);
                        */
                        CurrPage.Update(true);
                        InsertRequestLines();
                    end;
                }
                action("Combined Voucher")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bon combiné';
                    Image = Voucher;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        // ConvertedPRequest.Reset;
                        //ConvertedPRequest.SetRange(VoucherNo, "No.");
                        //PAGE.Run(51520088, ConvertedPRequest, "No.");
                    end;
                }
                action("Cheque Printing")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vérification de l''impression';
                    Image = Check;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then Error('You can only print a Payment Voucher after it is fully Approved');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51519675, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Update Vendor Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    //Image = payment;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PayLine.SetRange(PayLine.No, Rec."No.");
                        if PayLine.FindFirst then
                            repeat
                                if PayLine.Type = 'VENDOR' then
                                    if Vendor.Get(PayLine."Account No.") then
                                        if VBA.Get(PayLine."Account No.", Vendor."Preferred Bank Account Code") then begin
                                            //  PayLine."Payee Sort Code" := VBA."Sort Code";
                                            PayLine."Payee Bank" := VBA.Code;
                                            PayLine."Payee Account No" := VBA."Bank Account No.";
                                            PayLine.Modify;
                                        end;
                            until PayLine.Next = 0;
                    end;
                }
                action("Send Eft")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                    trigger OnAction()
                    begin
                        PVLine.Reset;
                        PVLine.SetRange(PVLine.No, Rec."No.");
                        if PVLine.Find('-') then
                            repeat /*  Integrator.GenerateEFT("EFT Batch No.", "No.", PVLine."Line No.", PVLine."Account No.", PVLine."Account Type", PVLine."Account Name",
                              PVLine."Payee Account No", PVLine."Payee Sort Code", PVLine.Payee, PVLine.Amount, PVLine."Net Amount", PVLine."Bank Sort Code", PVLine."Paying Bank Acc No",
                              PVLine."Paying Bank Account", PVLine."Payee Phone No", PVLine.Narration, "Payment Release Date", PVLine."Payee Email", PVLine."Apply to ID", LastApprover);
                         */
                            until PVLine.Next = 0;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //Currpageupdate;
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;
        ShortcutDimension2CodeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        "Cheque TypeEditable" := true;
        "Payment Release DateEditable" := true;
        "Cheque No.Editable" := true;
        OnBehalfEditable := true;
        BankEditabl := true;
        PaymodeEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::Normal;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec.Validate("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec.Validate("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        //OnAfterGetCurrRecord;
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        /*
            IF Status=Status::"Pending Approval" THEN
            CurrPage.EDITABLE:=FALSE;
            */
        /*
            IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
              FILTERGROUP(2);
              SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
              FILTERGROUP(0);
            END;
              */
        /*UserSetup.GET(USERID);
            IF NOT UserSetup."Modify PV" THEN BEGIN
            xRec := Rec;
            IF Status<>Status::Pending THEN
            BEGIN
              CurrPage.EDITABLE:=FALSE;
              CurrPage.UPDATE;
            END;
            END;
            */
        /*IF Status<>Status::Pending THEN
            BEGIN
              CurrPage.EDITABLE:=FALSE;
              CurrPage.UPDATE;
              END; */
        //UpdatePageControls;
    end;

    var
        PayLine: Record "Payment Line";
        //PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        //CheckBudgetAvail: Codeunit "Budgetary Control";
        //Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        StatusEditable: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;
        //prAssignEmp: Record prAssignEmployeeLoan;
        //"IC Share Matrix": Record "IC Partner Share";
        Text003: Label 'This is a shared Expense. Do you want to generate Intercompany Journals?';
        //IntercompanyJnlBLD: Codeunit "Intercompany Journal Builder";
        GenJnlTemp: Record "Gen. Journal Template";
        Text004: Label 'Any payment for a vendor must have Invoice No.';
        //PostCustomDocs: Codeunit "Post Custom Documents";
        //  ConvertedPRequest: Record "Converted Payment Requests";
        UserSetup: Record "User Setup";
        Text005: Label 'Do you want to post the voucher?';
        CompName: Text[250];
        VBA: Record "Vendor Bank Account";
        Vendor: Record Vendor;
        //Integrator: Codeunit "Integrator Function Base";
        PVLine: Record "Payment Line";
        LastApprover: Text[250];

    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "CshMgt Application";
    begin
        InvText := '';
        Appl.Reset;
        Appl.SetRange(Appl."Document Type", Appl."Document Type"::PV);
        Appl.SetRange(Appl."Document No.", Rec."No.");
        Appl.SetRange(Appl."Line No.", LineNo);
        if Appl.FindFirst then begin
            repeat
                InvText := CopyStr(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
            until Appl.Next = 0;
        end;
    end;
    //procedure InsertApproval()
    //var
    /*  Appl: Record "CshMgt Approvals";
    LineNo: Integer;
begin
    LineNo := 0;
    Appl.Reset;
    if Appl.FindLast then begin
        LineNo := Appl."Line No.";
    end;

    LineNo := LineNo + 1;

    Appl.Reset;
    Appl.Init;
    Appl."Line No." := LineNo;
    Appl."Document Type" := Appl."Document Type"::PV;
    Appl."Document No." := "No.";
    Appl."Document Date" := Date;
    Appl."Process Date" := Today;
    Appl."Process Time" := Time;
    Appl."Process User ID" := UserId;
    Appl."Process Name" := "Current Status";
    //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
    Appl.Insert;
end;
*/
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end
        else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then Exists := true;
    end;

    procedure UpdatePageControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := true;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
        end
        else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then "Cheque TypeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            if Rec."Cheque Type" <> Rec."Cheque Type"::"Computer Check" then "Cheque No.Editable" := true;
            "Invoice Currency CodeEditable" := false;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            "Currency CodeEditable" := true;
            GlobalDimension1CodeEditable := true;
            "Payment NarrationEditable" := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;
            PVLinesEditable := true;
        end
        else begin
            "Currency CodeEditable" := false;
            GlobalDimension1CodeEditable := false;
            "Payment NarrationEditable" := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //  PVLinesEditable :=FALSE;
        end;
        if Rec.Status = Rec.Status::Posted then begin
            PaymodeEditable := false;
            BankEditabl := false;
            OnBehalfEditable := false;
            RespEditabl := false;
            //  PVLinesEditable :=FALSE;
        end;
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No." = '') or (PayLines.Amount <= 0) then AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine."Account Type", PayLine."Account Type"::Customer);
        exit(PayLine.FindFirst);
    end;

    local procedure CurrpageupdateOld()
    begin
        xRec := Rec;
        UpdatePageControls();
        CurrPage.Update;
        //Set the filters here
        Rec.SetRange(Posted, false);
        Rec.SetRange("Payment Type", Rec."Payment Type"::Normal);
        Rec.SetFilter(Status, '<>Cancelled');
    end;

    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Pending then
            StatusEditable := true
        else
            StatusEditable := false;
    end;

    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        UpdatePageControls();
        CurrPage.Update;
    end;
    /*
        procedure InsertPvLine(prAssignEmpLoan: Record prAssignEmployeeLoan)
        var
            PvLine: Record "Payment Line";
        begin
            PayLine.Reset;
            PayLine.SetRange(PayLine."Loan No", prAssignEmpLoan."Entry No");
            if PayLine.FindFirst then
                Error('Another %1 Payment Voucher number %2 already exist for this loan', PayLine.Status, PayLine.No);
            //exit();

            PvLine.Init;
            PvLine."Line No." := 0;
            PvLine.Type := 'LOAN';
            PvLine.No := "No.";
            PvLine.Date := Today;
            PvLine."Account Type" := PvLine."Account Type"::Customer;
            PvLine."Account No." := prAssignEmpLoan."Employee Code";
            PvLine."Account Name" := prAssignEmpLoan."Transaction Name" + 'Loan for employee' + prAssignEmpLoan."Employee Code";
            PvLine.Remarks := prAssignEmpLoan."Transaction Name" + 'Loan for employee' + prAssignEmpLoan."Employee Code";
            PvLine.Narration := prAssignEmpLoan."Transaction Name" + 'Loan for employee' + prAssignEmpLoan."Employee Code";
            PvLine.Validate(Amount, prAssignEmpLoan.Balance);
            PvLine."Loan No" := prAssignEmpLoan."Entry No";

            PvLine.Insert;
        end;
    */
    procedure InsertRequestLines()
    var
        Counter: Integer;
        Request: Record "Payments Header";
        //RequestList: Page "Payment Request List";
        RequestLines: Record "Payment Line";
        Line: Record "Payment Line";
    begin
        Request.SetRange(Request.Status, Request.Status::Approved);
        if Request.FindSet then begin
            /*       RequestList.LookupMode(true);
                       RequestList.SetTableView(Request);
                       if RequestList.RunModal = ACTION::LookupOK then begin
                           RequestList.SetSelection(Request);
                           Counter := Request.Count;
                           if Counter > 0 then begin
                               if Request.FindSet then
                                   repeat
                                       RequestLines.Reset;
                                       RequestLines.SetRange(RequestLines.No, Request."No.");
                                       RequestLines.FindSet;
                                       repeat
                                           Line.Init;
                                           Line.TransferFields(RequestLines);
                                           Line.No := "No.";
                                           Line.Insert(true);
                                       until RequestLines.Next = 0;
                                       Request.Status := Status::Posted;
                                       Request.Posted := true;
                                       Request."Date Posted" := Today;
                                       Request."Time Posted" := Time;
                                       Request.Modify;
                                   until Request.Next = 0;
                           end;
                       */
        end;
    end;
}
