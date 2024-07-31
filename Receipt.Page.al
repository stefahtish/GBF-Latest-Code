page 50143 Receipt
{
    PageType = Card;
    Permissions =;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = Payments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PostedEditable;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = DocPosted;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = ChequePayment;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = ChequePayment;
                }
                field("Imprest Surrender Receipt"; Rec."Imprest Surrender Receipt")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                group(Dimensions)
                {
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                    }
                }
                group(Control30)
                {
                    ShowCaption = false;
                    Visible = Rec."Imprest Surrender Receipt" = TRUE;

                    field("Imprest Surrender Doc. No"; Rec."Imprest Surrender Doc. No")
                    {
                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                            CurrPage.Update;
                        end;
                    }
                }
                field("Received From"; Rec."Received From")
                {
                    Editable = DocPosted;
                    ShowMandatory = true;
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    Editable = DocPosted;
                    Visible = false;
                }
                field("Bank Code"; Rec."Paying Bank Account")
                {
                    Editable = DocPosted;
                    ShowMandatory = true;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                }
                group(Control17)
                {
                    ShowCaption = false;
                    Visible = NormalReceiptLines;

                    field("Receipt Amount"; Rec."Receipt Amount")
                    {
                    }
                }
                group(Control19)
                {
                    ShowCaption = false;
                    Visible = ImprestReceiptLines;

                    field("Imp Surr Receipt Amount"; Rec."Imp Surr Receipt Amount")
                    {
                        Caption = 'Surrender Receipt Amount';
                    }
                }
                field(Currency; Rec.Currency)
                {
                    Editable = DocPosted;
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
            part("Receipt Lines"; "Receipt Lines")
            {
                Editable = PostedEditable;
                SubPageLink = No = FIELD("No.");
                Visible = NormalReceiptLines;
            }
            part(Control18; "Imprest Surrender Lines")
            {
                Editable = PostedEditable;
                SubPageLink = No = FIELD("Imprest Surrender Doc. No");
                Visible = ImprestReceiptLines;
            }
        }
    }
    actions
    {
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
                        //    / FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    Caption = 'P&ost';
                    Enabled = DocPosted;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.TestField("Pay Mode");
                        Rec.TestField("Received From");
                        //TESTFIELD("On behalf of");
                        ReceiptsPost.PostReceipt(Rec);
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Post and Print")
                {
                    Caption = 'P&ost and Print';
                    Enabled = DocPosted;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        ReceiptsPost.PostReceipt(Rec);
                        Commit;
                        //RESET;
                        //BankLedgerEntry.SETRANGE(BankLedgerEntry."Document No.","No.");
                        //REPORT.RUN(51519009,FALSE,TRUE,BankLedgerEntry);
                        //RESET;
                        if CompanyName = 'Utalii Hotel' then begin
                            Payments.Reset;
                            Payments.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", false, true, Payments);
                        end
                        else begin
                            Payments2.Reset;
                            Payments2.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", false, true, Payments2);
                        end;
                        //ReportSelections.Print(ReportSelections.Usage::"Cust.Receipt",Rec,Rec.FIELDNO("No."));//SalesHeader.FIELDNO("Bill-to Customer No."));
                    end;
                }
                action("Print Receipt")
                {
                    Enabled = NOT DocPosted;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Posted = false then Error(Text000, Rec."No.");
                        Rec.Reset;
                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."No.");
                        REPORT.Run(Report::Receipt, true, true, BankLedgerEntry);
                        Rec.Reset;
                    end;
                }
                action(Preview)
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if CompanyName = 'Utalii Hotel' then begin
                            Payments.Reset;
                            Payments.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", true, false, Payments);
                        end
                        else begin
                            Payments2.Reset;
                            Payments2.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", true, false, Payments2);
                        end;
                        //ReportSelections.Print(ReportSelections.Usage::"Cust.Receipt",Rec,Rec.FIELDNO("No."))
                    end;
                }
                action("Reprint Receipt")
                {
                    Image = PrintInstallment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = NOT DocPosted;

                    trigger OnAction()
                    begin
                        if CompanyName = 'Utalii Hotel' then begin
                            Payments.Reset;
                            Payments.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", false, true, Payments);
                        end
                        else begin
                            Payments2.Reset;
                            Payments2.SetRange("No.", Rec."No.");
                            REPORT.Run(Report::"Receipt Custom", false, true, Payments2);
                        end;
                        //ReportSelections.Print(ReportSelections.Usage::"Cust.Receipt",Rec,Rec.FIELDNO("No."))
                    end;
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
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::Receipt;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        ReceiptsPost: Codeunit "Payments Management";
        [InDataSet]
        DocPosted: Boolean;
        PaymentMethod: Record "Payment Method";
        [InDataSet]
        ChequePayment: Boolean;
        Text000: Label 'Receipt No %1 has not been posted';
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        [InDataSet]
        ImprestReceiptLines: Boolean;
        [InDataSet]
        NormalReceiptLines: Boolean;
        PostedEditable: Boolean;
        Payments: Record Payments;
        Company: Record Company;
        ReportSelections: Record "Report Selections";
        Payments2: Record Payments;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        DocPosted := not Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if ChequePayment and not DocPosted then ChequePayment := false;
        if Rec."Imprest Surrender Doc. No" = '' then begin
            ImprestReceiptLines := false;
            NormalReceiptLines := true;
        end
        else begin
            ImprestReceiptLines := true;
            NormalReceiptLines := false;
        end;
        if Rec.Posted then begin
            PostedEditable := false;
        end
        else begin
            PostedEditable := true;
        end;
    end;
}
