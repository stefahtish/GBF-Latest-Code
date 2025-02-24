page 50100 "Apply Vendor Entries2"
{
    Caption = 'Apply Vendor Entries';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Line,Entry';
    SourceTable = "Vendor Ledger Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("ApplyingVendLedgEntry.""Posting Date"""; ApplyingVendLedgEntry."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Specifies the posting date of the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Document Type"""; ApplyingVendLedgEntry."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document Type';
                    Editable = false;
                    ToolTip = 'Specifies the document type of the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Document No."""; ApplyingVendLedgEntry."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the document number of the entry to be applied.';
                }
                field(ApplyingVendorNo; ApplyingVendLedgEntry."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor No.';
                    Editable = false;
                    ToolTip = 'Specifies the vendor number of the entry to be applied.';
                    Visible = false;
                }
                field(ApplyingVendorName; ApplyingVendLedgEntry."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Name';
                    Editable = false;
                    ToolTip = 'Specifies the vendor name of the entry to be applied.';
                    Visible = VendNameVisible;
                }
                field(ApplyingDescription; ApplyingVendLedgEntry.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies the description of the entry to be applied.';
                    Visible = false;
                }
                field("ApplyingVendLedgEntry.""Currency Code"""; ApplyingVendLedgEntry."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the currency that amounts are shown in.';
                }
                field("ApplyingVendLedgEntry.Amount"; ApplyingVendLedgEntry.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Remaining Amount"""; ApplyingVendLedgEntry."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;

                field(AppliesToID; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                    Visible = AppliesToIDVisible;

                    trigger OnValidate()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then Error(CannotSetAppliesToIDErr);
                        SetVendApplId(true);
                        CurrPage.Update(false);
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor account that the entry is linked to.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the name of the vendor account that the entry is linked to.';
                    Visible = VendNameVisible;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies a description of the vendor entry.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = false;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("CalcApplnRemainingAmount(""Remaining Amount"")"; CalcApplnRemainingAmount(Rec."Remaining Amount"))
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Remaining Amount';
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Amount to Apply"; Rec."Amount to Apply")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount to apply.';

                    trigger OnValidate()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
                        if (xRec."Amount to Apply" = 0) or (Rec."Amount to Apply" = 0) and ((ApplnType = ApplnType::"Applies-to ID") or (CalcType = CalcType::Direct)) then SetVendApplId(false);
                        Rec.Get(Rec."Entry No.");
                        AmountToApplyOnAfterValidate;
                    end;
                }
                field(ApplnAmountToApply; CalcApplnAmountToApply(Rec."Amount to Apply"))
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Amount to Apply';
                    ToolTip = 'Specifies the amount to apply.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';

                    trigger OnValidate()
                    begin
                        RecalcApplnAmount;
                    end;
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                    Visible = false;
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';

                    trigger OnValidate()
                    begin
                        RecalcApplnAmount;
                    end;
                }
                field("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"; CalcApplnRemainingAmount(Rec."Remaining Pmt. Disc. Possible"))
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Pmt. Disc. Possible';
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies if the entry to be applied is positive.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
            }
            group(Control41)
            {
                ShowCaption = false;

                fixed(Control1903222401)
                {
                    ShowCaption = false;

                    group("Appln. Currency")
                    {
                        Caption = 'Appln. Currency';

                        field(ApplnCurrencyCode; ApplnCurrencyCode)
                        {
                            ApplicationArea = Suite;
                            Editable = false;
                            ShowCaption = false;
                            TableRelation = Currency;
                            ToolTip = 'Specifies the currency code that the amount will be applied in, in case of different currencies.';
                        }
                    }
                    group(Control1900545201)
                    {
                        Caption = 'Amount to Apply';

                        field(AmountToApply; AppliedAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Amount to Apply';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Pmt. Disc. Amount")
                    {
                        Caption = 'Pmt. Disc. Amount';

                        field(PmtDiscountAmount; -PmtDiscAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Pmt. Disc. Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the payment discount amounts granted on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group(Rounding)
                    {
                        Caption = 'Rounding';

                        field(ApplnRounding; ApplnRounding)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Rounding';
                            Editable = false;
                            ToolTip = 'Specifies the rounding difference when you apply entries in different currencies to one another. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Applied Amount")
                    {
                        Caption = 'Applied Amount';

                        field(AppliedAmount; AppliedAmount + (-PmtDiscAmount) + ApplnRounding)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts in the Amount to Apply field, Pmt. Disc. Amount field, and the Rounding. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Available Amount")
                    {
                        Caption = 'Available Amount';

                        field(ApplyingAmount; ApplyingAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Available Amount';
                            Editable = false;
                            ToolTip = 'Specifies the amount of the journal entry, purchase credit memo, or current vendor ledger entry that you have selected as the applying entry.';
                        }
                    }
                    group(Balance)
                    {
                        Caption = 'Balance';

                        field(ControlBalance; AppliedAmount + (-PmtDiscAmount) + ApplyingAmount + ApplnRounding)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies any extra amount that will remain after the application.';
                        }
                    }
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;

                action("Applied E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applied E&ntries';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Applied Vendor Entries";
                    RunPageOnRec = true;
                    ToolTip = 'View the ledger entries that have been applied to this record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Detailed Vendor Ledg. Entries";
                    RunPageLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Vendor Ledger Entry No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a summary of the all posted entries and adjustments related to a specific vendor ledger entry.';
                }
                action(Navigate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                        Navigate.Run;
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Application")
            {
                Caption = '&Application';
                Image = Apply;

                action(ActionSetAppliesToID)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Set Applies-to ID';
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Set the Applies-to ID field on the posted entry to automatically be filled in with the document number of the entry in the journal.';

                    trigger OnAction()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then Error(CannotSetAppliesToIDErr);
                        SetVendApplId(false);
                    end;
                }
                action(ActionPostApplication)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Application';
                    Ellipsis = true;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ToolTip = 'Define the document number of the ledger entry to use to perform the application. In addition, you specify the Posting Date for the application.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(false);
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(true);
                    end;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("Show Only Selected Entries to Be Applied")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Only Selected Entries to Be Applied';
                    Image = ShowSelected;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'View the selected ledger entries that will be applied to the specified record.';

                    trigger OnAction()
                    begin
                        ShowAppliedEntries := not ShowAppliedEntries;
                        if ShowAppliedEntries then
                            if CalcType = CalcType::GenJnlLine then
                                Rec.SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
                            else begin
                                VendEntryApplID := UserId;
                                if VendEntryApplID = '' then VendEntryApplID := '***';
                                Rec.SetRange("Applies-to ID", VendEntryApplID);
                            end
                        else
                            Rec.SetRange("Applies-to ID");
                    end;
                }
            }
            action(ShowPostedDocument)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Posted Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Show details for the posted payment, invoice, or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowDoc
                end;
            }
            action(ShowDocumentAttachment)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Document Attachment';
                Enabled = HasDocumentAttachment;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'View documents or images that are attached to the posted invoice or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowPostedDocAttachment;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if ApplnType = ApplnType::"Applies-to Doc. No." then CalcApplnAmount;
        HasDocumentAttachment := Rec.HasPostedDocAttachment;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle;
    end;

    trigger OnInit()
    begin
        AppliesToIDVisible := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
        if Rec."Applies-to ID" <> xRec."Applies-to ID" then CalcApplnAmount;
        exit(false);
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        /* if CalcType = CalcType::Direct then begin
             Vend.Get("Vendor No.");
             ApplnCurrencyCode := Vend."Currency Code";
             FindApplyingEntry;
         end;*/
        PurchSetup.Get();
        VendNameVisible := PurchSetup."Copy Vendor Name to Entries";
        AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";
        GLSetup.Get();
        if CalcType = CalcType::GenJnlLine then CalcApplnAmount;
        PostingDone := false;
        IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RaiseError: Boolean;
    begin
        if CloseAction = ACTION::LookupOK then LookupOKOnPush;
        if ApplnType = ApplnType::"Applies-to Doc. No." then begin
            if OK then begin
                RaiseError := ApplyingVendLedgEntry."Posting Date" < Rec."Posting Date";
                OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry, Rec, RaiseError, CalcType, PmtDiscAmount);
                if RaiseError then begin
                    OK := false;
                    Error(EarlierPostingDateErr, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.", Rec."Document Type", Rec."Document No.");
                end;
            end;
            if OK then begin
                if Rec."Amount to Apply" = 0 then Rec."Amount to Apply" := Rec."Remaining Amount";
                CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
            end;
        end;
        if CheckActionPerformed then begin
            Rec := ApplyingVendLedgEntry;
            Rec."Applying Entry" := false;
            if AppliesToID = '' then begin
                Rec."Applies-to ID" := '';
                Rec."Amount to Apply" := 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
        end;
    end;

    var
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLine: Record "Gen. Journal Line";
        PurchHeader: Record "Purchase Header";
        Vend: Record Vendor;
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PurchPost: Codeunit "Purch.-Post";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        Navigate: Page Navigate;
        GenJnlLineApply: Boolean;
        ApplnDate: Date;
        ApplnRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        AmountRoundingPrecision: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        StyleTxt: Text;
        CalcType: Option Direct,GenJnlLine,PurchHeader;
        VendEntryApplID: Code[50];
        AppliesToID: Code[50];
        ValidExchRate: Boolean;
        Text002: Label 'You must select an applying entry before you can post the application.';
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        CannotSetAppliesToIDErr: Label 'You cannot set Applies-to ID while selecting Applies-to Doc. No.';
        ShowAppliedEntries: Boolean;
        OK: Boolean;
        EarlierPostingDateErr: Label 'You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.';
        PostingDone: Boolean;
        [InDataSet]
        AppliesToIDVisible: Boolean;
        ActionPerformed: Boolean;
        Text012: Label 'The application was successfully posted.';
        Text013: Label 'The %1 entered must not be before the %1 on the %2.';
        Text019: Label 'Post application process has been canceled.';
        IsOfficeAddin: Boolean;
        HasDocumentAttachment: Boolean;
        VendNameVisible: Boolean;

    protected var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        GenJnlLine2: Record "Gen. Journal Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;
        ApplnCurrencyCode: Code[10];
        DifferentCurrenciesInAppln: Boolean;

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line"; ApplnTypeSelect: Integer)
    begin
        GenJnlLine := NewGenJnlLine;
        GenJnlLineApply := true;
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then ApplyingAmount := GenJnlLine.Amount;
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then ApplyingAmount := -GenJnlLine.Amount;
        ApplnDate := GenJnlLine."Posting Date";
        ApplnCurrencyCode := GenJnlLine."Currency Code";
        CalcType := CalcType::GenJnlLine;
        case ApplnTypeSelect of
            GenJnlLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            GenJnlLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;
        SetApplyingVendLedgEntry;
    end;

    procedure SetPurch(NewPurchHeader: Record "Purchase Header"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer)
    begin
        PurchHeader := NewPurchHeader;
        Rec.CopyFilters(NewVendLedgEntry);
        PurchPost.SumPurchLines(PurchHeader, 0, TotalPurchLine, TotalPurchLineLCY, VATAmount, VATAmountText);
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::"Return Order", PurchHeader."Document Type"::"Credit Memo":
                ApplyingAmount := TotalPurchLine."Amount Including VAT"
            else
                ApplyingAmount := -TotalPurchLine."Amount Including VAT";
        end;
        ApplnDate := PurchHeader."Posting Date";
        ApplnCurrencyCode := PurchHeader."Currency Code";
        CalcType := CalcType::PurchHeader;
        case ApplnTypeSelect of
            PurchHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PurchHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;
        SetApplyingVendLedgEntry;
    end;

    procedure SetVendLedgEntry(NewVendLedgEntry: Record "Vendor Ledger Entry")
    begin
        Rec := NewVendLedgEntry;
    end;

    procedure SetApplyingVendLedgEntry()
    var
        Vendor: Record Vendor;
    begin
        OnBeforeSetApplyingVendLedgEntry(ApplyingVendLedgEntry, GenJnlLine);
        case CalcType of
            CalcType::PurchHeader:
                begin
                    ApplyingVendLedgEntry."Posting Date" := PurchHeader."Posting Date";
                    if PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order" then
                        ApplyingVendLedgEntry."Document Type" := ApplyingVendLedgEntry."Document Type"::"Credit Memo"
                    else
                        ApplyingVendLedgEntry."Document Type" := PurchHeader."Document Type".AsInteger();
                    ApplyingVendLedgEntry."Document No." := PurchHeader."No.";
                    ApplyingVendLedgEntry."Vendor No." := PurchHeader."Pay-to Vendor No.";
                    ApplyingVendLedgEntry.Description := PurchHeader."Posting Description";
                    ApplyingVendLedgEntry."Currency Code" := PurchHeader."Currency Code";
                    if ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingVendLedgEntry.Amount := TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := TotalPurchLine."Amount Including VAT";
                    end
                    else begin
                        ApplyingVendLedgEntry.Amount := -TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := -TotalPurchLine."Amount Including VAT";
                    end;
                    CalcApplnAmount;
                end;
            CalcType::Direct:
                begin
                    if Rec."Applying Entry" then begin
                        if ApplyingVendLedgEntry."Entry No." <> 0 then VendLedgEntry := ApplyingVendLedgEntry;
                        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
                        if Rec."Applies-to ID" = '' then SetVendApplId(false);
                        Rec.CalcFields(Amount);
                        ApplyingVendLedgEntry := Rec;
                        if VendLedgEntry."Entry No." <> 0 then begin
                            Rec := VendLedgEntry;
                            Rec."Applying Entry" := false;
                            SetVendApplId(false);
                        end;
                        Rec.SetFilter("Entry No.", '<> %1', ApplyingVendLedgEntry."Entry No.");
                        ApplyingAmount := ApplyingVendLedgEntry."Remaining Amount";
                        ApplnDate := ApplyingVendLedgEntry."Posting Date";
                        ApplnCurrencyCode := ApplyingVendLedgEntry."Currency Code";
                    end;
                    CalcApplnAmount;
                end;
            CalcType::GenJnlLine:
                begin
                    ApplyingVendLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                    ApplyingVendLedgEntry."Document Type" := GenJnlLine."Document Type";
                    ApplyingVendLedgEntry."Document No." := GenJnlLine."Document No.";
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then begin
                        ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Bal. Account No.";
                        Vendor.Get(ApplyingVendLedgEntry."Vendor No.");
                        ApplyingVendLedgEntry.Description := Vendor.Name;
                    end
                    else begin
                        ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Account No.";
                        ApplyingVendLedgEntry.Description := GenJnlLine.Description;
                    end;
                    ApplyingVendLedgEntry."Currency Code" := GenJnlLine."Currency Code";
                    ApplyingVendLedgEntry.Amount := GenJnlLine.Amount;
                    ApplyingVendLedgEntry."Remaining Amount" := GenJnlLine.Amount;
                    CalcApplnAmount;
                end;
        end;
    end;

    procedure SetVendApplId(CurrentRec: Boolean)
    var
        RaiseError: Boolean;
    begin
        if CalcType = CalcType::GenJnlLine then begin
            RaiseError := ApplyingVendLedgEntry."Posting Date" < Rec."Posting Date";
            OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry, Rec, RaiseError, CalcType, PmtDiscAmount);
            if RaiseError then Error(EarlierPostingDateErr, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.", Rec."Document Type", Rec."Document No.");
        end;
        if ApplyingVendLedgEntry."Entry No." <> 0 then GenJnlApply.CheckAgainstApplnCurrency(ApplnCurrencyCode, Rec."Currency Code", GenJnlLine."Account Type"::Vendor, true);
        VendLedgEntry.Copy(Rec);
        if CurrentRec then
            VendLedgEntry.SetRecFilter
        else
            CurrPage.SetSelectionFilter(VendLedgEntry);
        if GenJnlLineApply then
            VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, GenJnlLine."Applies-to ID")
        else
            VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, PurchHeader."Applies-to ID");
        ActionPerformed := VendLedgEntry."Applies-to ID" <> '';
        CalcApplnAmount;
    end;

    procedure CalcApplnAmount()
    begin
        OnBeforeCalcApplnAmount(Rec, GenJnlLine);
        AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := false;
        case CalcType of
            CalcType::Direct:
                begin
                    FindAmountRounding;
                    VendEntryApplID := UserId;
                    if VendEntryApplID = '' then VendEntryApplID := '***';
                    VendLedgEntry := ApplyingVendLedgEntry;
                    AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    AppliedVendLedgEntry.SetRange("Vendor No.", Rec."Vendor No.");
                    AppliedVendLedgEntry.SetRange(Open, true);
                    if AppliesToID = '' then
                        AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID)
                    else
                        AppliedVendLedgEntry.SetRange("Applies-to ID", AppliesToID);
                    if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                        VendLedgEntry.CalcFields("Remaining Amount");
                        AppliedVendLedgEntry.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                    end;
                    HandleChosenEntries(0, VendLedgEntry."Remaining Amount", VendLedgEntry."Currency Code", VendLedgEntry."Posting Date");
                end;
            CalcType::GenJnlLine:
                begin
                    FindAmountRounding;
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then CODEUNIT.Run(CODEUNIT::"Exchange Acc. G/L Journal Line", GenJnlLine);
                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                AppliedVendLedgEntry.CalcFields("Remaining Amount");
                                if AppliedVendLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                                    AppliedVendLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmtFCYToFCY(ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Amount");
                                    AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmtFCYToFCY(ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                    AppliedVendLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmtFCYToFCY(ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Amount to Apply");
                                end;
                                if AppliedVendLedgEntry."Amount to Apply" <> 0 then
                                    AppliedAmount := Round(AppliedVendLedgEntry."Amount to Apply", AmountRoundingPrecision)
                                else
                                    AppliedAmount := Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);
                                if PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine, AppliedVendLedgEntry, 0, false) and ((Abs(GenJnlLine.Amount) + ApplnRoundingPrecision >= Abs(AppliedAmount - AppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) or (GenJnlLine.Amount = 0)) then PmtDiscAmount := AppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                if not DifferentCurrenciesInAppln then DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";
                                CheckRounding;
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                GenJnlLine2 := GenJnlLine;
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                                AppliedVendLedgEntry.SetRange(Open, true);
                                AppliedVendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                                HandleChosenEntries(1, GenJnlLine2.Amount, GenJnlLine2."Currency Code", GenJnlLine2."Posting Date");
                            end;
                    end;
                end;
            CalcType::PurchHeader:
                begin
                    FindAmountRounding;
                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                AppliedVendLedgEntry.CalcFields("Remaining Amount");
                                if AppliedVendLedgEntry."Currency Code" <> ApplnCurrencyCode then AppliedVendLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmtFCYToFCY(ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Amount");
                                AppliedAmount := AppliedAmount + Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);
                                if not DifferentCurrenciesInAppln then DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";
                                CheckRounding;
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", PurchHeader."Pay-to Vendor No.");
                                AppliedVendLedgEntry.SetRange(Open, true);
                                AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."Applies-to ID");
                                HandleChosenEntries(2, ApplyingAmount, ApplnCurrencyCode, ApplnDate);
                            end;
                    end;
                end;
        end;
        OnAfterCalcApplnAmount(Rec, AppliedAmount, ApplyingAmount);
    end;

    local procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = Rec."Currency Code" then exit(Amount);
        if ApplnDate = 0D then ApplnDate := Rec."Posting Date";
        ApplnRemainingAmount := CurrExchRate.ApplnExchangeAmtFCYToFCY(ApplnDate, Rec."Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);
        OnAfterCalcApplnRemainingAmount(Rec, ApplnRemainingAmount);
        exit(ApplnRemainingAmount);
    end;

    local procedure CalcApplnAmountToApply(AmountToApply: Decimal): Decimal
    var
        ApplnAmountToApply: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = Rec."Currency Code" then exit(AmountToApply);
        if ApplnDate = 0D then ApplnDate := Rec."Posting Date";
        ApplnAmountToApply := CurrExchRate.ApplnExchangeAmtFCYToFCY(ApplnDate, Rec."Currency Code", ApplnCurrencyCode, AmountToApply, ValidExchRate);
        OnAfterCalcApplnAmountToApply(Rec, AmountToApply, ApplnAmountToApply);
        exit(ApplnAmountToApply);
    end;

    local procedure FindAmountRounding()
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init();
            Currency.Code := '';
            Currency.InitRoundingPrecision;
        end
        else if ApplnCurrencyCode <> Currency.Code then Currency.Get(ApplnCurrencyCode);
        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    procedure CheckRounding()
    begin
        ApplnRounding := 0;
        case CalcType of
            CalcType::PurchHeader:
                exit;
            CalcType::GenJnlLine:
                if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund) then
                    exit;
        end;
        if ApplnCurrencyCode = '' then
            ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
        else begin
            if ApplnCurrencyCode <> Rec."Currency Code" then Currency.Get(ApplnCurrencyCode);
            ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        end;
        if (Abs((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) and DifferentCurrenciesInAppln then ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
    end;

    procedure GetVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgEntry := Rec;
    end;

    local procedure FindApplyingEntry()
    begin
        if CalcType = CalcType::Direct then begin
            VendEntryApplID := UserId;
            if VendEntryApplID = '' then VendEntryApplID := '***';
            VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
            VendLedgEntry.SetRange("Vendor No.", Rec."Vendor No.");
            if AppliesToID = '' then
                VendLedgEntry.SetRange("Applies-to ID", VendEntryApplID)
            else
                VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetRange("Applying Entry", true);
            if VendLedgEntry.FindFirst then begin
                VendLedgEntry.CalcFields(Amount, "Remaining Amount");
                ApplyingVendLedgEntry := VendLedgEntry;
                Rec.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                ApplyingAmount := VendLedgEntry."Remaining Amount";
                ApplnDate := VendLedgEntry."Posting Date";
                ApplnCurrencyCode := VendLedgEntry."Currency Code";
            end;
            CalcApplnAmount;
        end;
    end;

    local procedure HandleChosenEntries(Type: Option Direct,GenJnlLine,PurchHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date)
    var
        TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        PossiblePmtdisc: Decimal;
        OldPmtdisc: Decimal;
        CorrectionAmount: Decimal;
        RemainingAmountExclDiscounts: Decimal;
        CanUseDisc: Boolean;
        FromZeroGenJnl: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeHandledChosenEntries(Type, CurrentAmount, CurrencyCode, PostingDate, AppliedVendLedgEntry, IsHandled);
        if IsHandled then exit;
        if not AppliedVendLedgEntry.FindSet(false, false) then exit;
        repeat
            TempAppliedVendLedgEntry := AppliedVendLedgEntry;
            TempAppliedVendLedgEntry.Insert();
        until AppliedVendLedgEntry.Next = 0;
        FromZeroGenJnl := (CurrentAmount = 0) and (Type = Type::GenJnlLine);
        repeat
            if not FromZeroGenJnl then TempAppliedVendLedgEntry.SetRange(Positive, CurrentAmount < 0);
            if TempAppliedVendLedgEntry.FindFirst then begin
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedVendLedgEntry, PostingDate);
                case Type of
                    Type::Direct:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscVend(VendLedgEntry, TempAppliedVendLedgEntry, 0, false, false);
                    Type::GenJnlLine:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine2, TempAppliedVendLedgEntry, 0, false)
                    else
                        CanUseDisc := false;
                end;
                if CanUseDisc and (Abs(TempAppliedVendLedgEntry."Amount to Apply") >= Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) then
                    if Abs(CurrentAmount) > Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible") then begin
                        PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                    end
                    else if Abs(CurrentAmount) = Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible") then begin
                        PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        AppliedAmount += CorrectionAmount;
                    end
                    else if FromZeroGenJnl then begin
                        PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                    end
                    else begin
                        PossiblePmtdisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        RemainingAmountExclDiscounts := TempAppliedVendLedgEntry."Remaining Amount" - PossiblePmtdisc - TempAppliedVendLedgEntry."Max. Payment Tolerance";
                        if Abs(CurrentAmount) + Abs(CalcOppositeEntriesAmount(TempAppliedVendLedgEntry)) >= Abs(RemainingAmountExclDiscounts) then begin
                            PmtDiscAmount += PossiblePmtdisc;
                            AppliedAmount += CorrectionAmount;
                        end;
                        CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                    end
                else begin
                    if ((CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply") * CurrentAmount) >= 0 then AppliedAmount += CorrectionAmount;
                    CurrentAmount += TempAppliedVendLedgEntry."Amount to Apply";
                end;
            end
            else begin
                TempAppliedVendLedgEntry.SetRange(Positive);
                TempAppliedVendLedgEntry.FindFirst;
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedVendLedgEntry, PostingDate);
            end;
            if OldPmtdisc <> PmtDiscAmount then
                AppliedAmount += TempAppliedVendLedgEntry."Remaining Amount"
            else
                AppliedAmount += TempAppliedVendLedgEntry."Amount to Apply";
            OldPmtdisc := PmtDiscAmount;
            if PossiblePmtdisc <> 0 then
                CorrectionAmount := TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Amount to Apply"
            else
                CorrectionAmount := 0;
            if not DifferentCurrenciesInAppln then DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedVendLedgEntry."Currency Code";
            TempAppliedVendLedgEntry.Delete();
            TempAppliedVendLedgEntry.SetRange(Positive);
        until not TempAppliedVendLedgEntry.FindFirst;
        CheckRounding;
    end;

    local procedure AmountToApplyOnAfterValidate()
    begin
        if ApplnType <> ApplnType::"Applies-to Doc. No." then begin
            CalcApplnAmount;
            CurrPage.Update(false);
        end;
    end;

    local procedure RecalcApplnAmount()
    begin
        CurrPage.Update(true);
        CalcApplnAmount;
    end;

    local procedure LookupOKOnPush()
    begin
        OK := true;
    end;

    local procedure PostDirectApplication(PreviewMode: Boolean)
    var
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
        PostApplication: Page "Post Application";
        Applied: Boolean;
        ApplicationDate: Date;
        appli: record "Apply Unapply Parameters";
        NewApplicationDate: Date;
        NewDocumentNo: Code[20];
    begin
        if CalcType = CalcType::Direct then begin
            if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                Rec := ApplyingVendLedgEntry;
                ApplicationDate := VendEntryApplyPostedEntries.GetApplicationDate(Rec);
                PostApplication.SetParameters(appli);
                if ACTION::OK = PostApplication.RunModal then begin
                    PostApplication.GetParameters(appli); //eddie(NewDocumentNo, NewApplicationDate);
                    if NewApplicationDate < ApplicationDate then Error(Text013, Rec.FieldCaption("Posting Date"), Rec.TableCaption);
                end
                else
                    Error(Text019);
                if PreviewMode then
                    VendEntryApplyPostedEntries.PreviewApply(Rec, appli)
                else
                    Applied := VendEntryApplyPostedEntries.Apply(Rec, appli);
                if (not PreviewMode) and Applied then begin
                    Message(Text012);
                    PostingDone := true;
                    CurrPage.Close;
                end;
            end
            else
                Error(Text002);
        end
        else
            Error(Text003);
    end;

    local procedure CheckActionPerformed(): Boolean
    begin
        if ActionPerformed then exit(false);
        if (not (CalcType = CalcType::Direct) and not OK and not PostingDone) or (ApplnType = ApplnType::"Applies-to Doc. No.") then exit(false);
        exit((CalcType = CalcType::Direct) and not OK and not PostingDone);
    end;

    procedure SetAppliesToID(AppliesToID2: Code[50])
    begin
        AppliesToID := AppliesToID2;
    end;

    procedure ExchangeAmountsOnLedgerEntry(Type: Option Direct,GenJnlLine,PurchHeader; CurrencyCode: Code[10]; var CalcVendLedgEntry: Record "Vendor Ledger Entry"; PostingDate: Date)
    var
        CalculateCurrency: Boolean;
    begin
        CalcVendLedgEntry.CalcFields("Remaining Amount");
        if Type = Type::Direct then
            CalculateCurrency := ApplyingVendLedgEntry."Entry No." <> 0
        else
            CalculateCurrency := true;
        if (CurrencyCode <> CalcVendLedgEntry."Currency Code") and CalculateCurrency then begin
            CalcVendLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(CalcVendLedgEntry."Remaining Amount", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcVendLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(CalcVendLedgEntry."Remaining Pmt. Disc. Possible", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcVendLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(CalcVendLedgEntry."Amount to Apply", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
        end;
        OnAfterExchangeAmountsOnLedgerEntry(CalcVendLedgEntry, VendLedgEntry, CurrencyCode);
    end;

    procedure CalcOppositeEntriesAmount(var TempAppliedVendorLedgerEntry: Record "Vendor Ledger Entry" temporary) Result: Decimal
    var
        SavedAppliedVendorLedgerEntry: Record "Vendor Ledger Entry";
        CurrPosFilter: Text;
    begin
        CurrPosFilter := TempAppliedVendorLedgerEntry.GetFilter(Positive);
        if CurrPosFilter <> '' then begin
            SavedAppliedVendorLedgerEntry := TempAppliedVendorLedgerEntry;
            TempAppliedVendorLedgerEntry.SetRange(Positive, not TempAppliedVendorLedgerEntry.Positive);
            if TempAppliedVendorLedgerEntry.FindSet then
                repeat
                    TempAppliedVendorLedgerEntry.CalcFields("Remaining Amount");
                    Result += TempAppliedVendorLedgerEntry."Remaining Amount";
                until TempAppliedVendorLedgerEntry.Next = 0;
            TempAppliedVendorLedgerEntry.SetFilter(Positive, CurrPosFilter);
            TempAppliedVendorLedgerEntry := SavedAppliedVendorLedgerEntry;
        end;
    end;

    procedure GetApplnCurrencyCode(): Code[10]
    begin
        exit(ApplnCurrencyCode);
    end;

    procedure GetCalcType(): Integer
    begin
        exit(CalcType);
    end;

    procedure SetPaymentLine(NewPaymentLine: Record "Payment Lines"; ApplnTypeSelect: Integer)
    var
        PaymentRec: Record Payments;
        PaymentLine: Record "Payment Lines";
        PaymentLineApply: Boolean;
        ApplyingAmount: Decimal;
        ApplnDate: Date;
        ApplnCurrencyCode: Code[20];
        CalcType: Option Direct,GenJnlLine,SalesHeader,ServHeader,Payments;
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
    begin
        PaymentLine := NewPaymentLine;
        PaymentLineApply := TRUE;
        PaymentRec.GET(PaymentLine.No);
        IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN ApplyingAmount := PaymentLine.Amount;
        ApplnDate := PaymentRec.Date;
        ApplnCurrencyCode := PaymentRec.Currency;
        CalcType := CalcType::Payments;
        CASE ApplnTypeSelect OF
            PaymentLine.FIELDNO("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PaymentLine.FIELDNO("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        END;
        SetApplyingVendLedgEntry;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmountToApply(VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplnAmountToApply: Decimal; var ApplnAmtToApply: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnRemainingAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplnRemainingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterExchangeAmountsOnLedgerEntry(var CalcVendorLedgerEntry: Record "Vendor Ledger Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry"; CurrencyCode: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcApplnAmount(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnBeforeHandledChosenEntries(Type: Option Direct,GenJnlLine,PurchHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date; var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var RaiseError: Boolean; CalcType: Option; PmtDiscAmount: Decimal)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeSetApplyingVendLedgEntry(var ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
}
