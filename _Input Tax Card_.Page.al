page 50298 "Input Tax Card"
{
    DeleteAllowed = false;
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                group("Account Details")
                {
                    field("Account Type"; Rec."Account Type")
                    {
                    }
                    field("Account No."; Rec."Account No.")
                    {
                    }
                    field("Account Name"; Rec."Account Name")
                    {
                    }
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
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
            part(Lines; "Input Tax Lines")
            {
                Editable = PostedEditable;
                SubPageLink = No = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
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
                        ReceiptsPost.PostInputTax(Rec);
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
                        Payments.Reset;
                        Payments.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Receipt Custom", false, true, Payments);
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
                        Payments.Reset;
                        Payments.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Receipt Custom", true, false, Payments);
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
                        Payments.Reset;
                        Payments.SetRange("No.", Rec."No.");
                        REPORT.Run(Report::"Receipt Custom", false, true, Payments);
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Input Tax";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Input Tax";
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
        BalAccType: Enum "Payment Balance Account Type";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        DocPosted := not Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then BalAccType := PaymentMethod."Bal. Account Type";
        if BalAccType = BalAccType::Cheque then
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
