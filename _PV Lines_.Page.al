page 51505 "PV Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "PV Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(control)
            {
                field("Account Type"; Rec."Account Type")
                {
                    OptionCaption = 'G/L Account,Customer,Supplier,Bank Account,Fixed Asset';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Account Type" = Rec."Account Type"::Customer THEN BEGIN
                            PaymentsRec.RESET;
                            PaymentsRec.SETRANGE(No, Rec."PV No");
                            IF PaymentsRec.FIND('-')THEN BEGIN
                                IF PaymentsRec.Source = PaymentsRec.Source::Imprest THEN BEGIN
                                    ERROR('You are not allowed to add Customer Acounts at this stage. Please refer to the trip creation Process.');
                                END;
                            END;
                        END;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment- Support Docs"; Rec."Payment- Support Docs")
                {
                    ApplicationArea = All;
                }
                field("LPO/LSO No."; Rec."LPO/LSO No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies to Doc. No"; Rec."Applies to Doc. No")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.VALIDATE(Description);
                        Rec."Applies to Doc. No":='';
                        //"Apply to ID":='';
                        Amt:=0;
                        Rec."VAT Amount":=0;
                        Rec."W/Tax Amount":=0;
                        Rec."Net Amount":=0;
                        IF Rec."Account Type" = Rec."Account Type"::Customer THEN BEGIN
                            CustLedger.RESET;
                            CustLedger.SETCURRENTKEY(CustLedger."Customer No.", Open, "Document No.");
                            CustLedger.SETRANGE(CustLedger."Customer No.", Rec."Account No");
                            CustLedger.SETRANGE(Open, TRUE);
                            //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
                            CustLedger.CALCFIELDS(CustLedger.Amount);
                            IF PAGE.RUNMODAL(Page::"Customer Ledger Entries", CustLedger) = ACTION::LookupOK THEN BEGIN
                                IF CustLedger."Applies-to ID" <> '' THEN BEGIN
                                    CustLedger1.RESET;
                                    CustLedger1.SETCURRENTKEY(CustLedger1."Customer No.", Open, "Applies-to ID");
                                    CustLedger1.SETRANGE(CustLedger1."Customer No.", Rec."Account No");
                                    CustLedger1.SETRANGE(Open, TRUE);
                                    //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
                                    CustLedger1.SETRANGE("Applies-to ID", CustLedger."Applies-to ID");
                                    IF CustLedger1.FIND('-')THEN BEGIN
                                        REPEAT CustLedger1.CALCFIELDS(CustLedger1.Amount);
                                            Amt:=Amt + ABS(CustLedger1.Amount);
                                        UNTIL CustLedger1.NEXT = 0;
                                    END;
                                    IF Amt <> Amt THEN //ERROR('Amount is not equal to the amount applied on the application form');
                                        IF Rec.Amount = 0 THEN Rec.Amount:=Amt;
                                    Rec."Net Amount":=Rec.Amount;
                                    Rec.VALIDATE(Amount);
                                    Rec."Applies to Doc. No":=CustLedger."Document No.";
                                //"Apply to ID":=CustLedger."Applies-to ID";
                                END
                                ELSE
                                BEGIN
                                    IF Rec.Amount <> ABS(CustLedger.Amount)THEN CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                                    IF Rec.Amount = 0 THEN Rec.Amount:=ABS(CustLedger."Remaining Amount");
                                    Rec.VALIDATE(Amount);
                                    //ERROR('Amount is not equal to the amount applied on the application form');
                                    Rec."Applies to Doc. No":=CustLedger."Document No.";
                                // "Apply to ID":=CustLedger."Applies-to ID";
                                END;
                            END;
                            //IF "Apply to ID" <> '' THEN
                            //"Apply to":='';
                            Rec.VALIDATE(Amount);
                        END;
                        IF Rec."Account Type" = Rec."Account Type"::Vendor THEN BEGIN
                            VendLedger.RESET;
                            VendLedger.SETCURRENTKEY(VendLedger."Vendor No.", Open, "Document No.");
                            VendLedger.SETRANGE(VendLedger."Vendor No.", Rec."Account No");
                            VendLedger.SETRANGE(Open, TRUE);
                            //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
                            VendLedger.CALCFIELDS(VendLedger.Amount);
                            IF PAGE.RUNMODAL(Page::"Vendor Ledger Entries", VendLedger) = ACTION::LookupOK THEN BEGIN
                                IF VendLedger."Applies-to ID" <> '' THEN BEGIN
                                    VendLedger1.RESET;
                                    VendLedger1.SETCURRENTKEY(VendLedger1."Vendor No.", Open, "Applies-to ID");
                                    VendLedger1.SETRANGE(VendLedger1."Vendor No.", Rec."Account No");
                                    VendLedger1.SETRANGE(Open, TRUE);
                                    //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
                                    VendLedger1.SETRANGE(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                                    IF VendLedger1.FIND('-')THEN BEGIN
                                        REPEAT VendLedger1.CALCFIELDS(VendLedger1.Amount);
                                            Amt:=Amt + ABS(VendLedger1.Amount);
                                        UNTIL VendLedger1.NEXT = 0;
                                    END;
                                    IF Amt <> Amt THEN //ERROR('Amount is not equal to the amount applied on the application form');
                                        IF Rec.Amount = 0 THEN Rec.Amount:=Amt;
                                    Rec.VALIDATE(Amount);
                                    Rec."Applies to Doc. No":=VendLedger."Document No.";
                                //"Apply to ID":=CustLedger."Applies-to ID";
                                END
                                ELSE
                                BEGIN
                                    IF Rec.Amount <> ABS(VendLedger.Amount)THEN VendLedger.CALCFIELDS(VendLedger."Remaining Amount");
                                    IF Rec.Amount = 0 THEN Rec.Amount:=ABS(VendLedger."Remaining Amount");
                                    Rec.VALIDATE(Amount);
                                    //ERROR('Amount is not equal to the amount applied on the application form');
                                    Rec."Applies to Doc. No":=VendLedger."Document No.";
                                // "Apply to ID":=CustLedger."Applies-to ID";
                                END;
                            END;
                            Rec."Net Amount":=ABS(VendLedger.Amount);
                            //IF "Apply to ID" <> '' THEN
                            //"Apply to":='';
                            Rec.VALIDATE(Amount);
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Order Description"; Rec."Order Description")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    Caption = 'Bank Account No.';
                    Enabled = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    Caption = 'Branch Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Caption = 'VAT % Applied';
                    Visible = true;
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Caption = 'VAT % Amount';
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("W/VTax Code"; Rec."W/VTax Code")
                {
                    Caption = 'W/H VAT Applied';
                    ApplicationArea = All;
                }
                field("W/VTax Amount"; Rec."W/VTax Amount")
                {
                    Caption = 'W/H VAT Amount';
                    ApplicationArea = All;
                }
                field("Income Tax Code"; Rec."Income Tax Code")
                {
                    Caption = 'W/H Income Tax Applied';
                    ApplicationArea = All;
                }
                field("Income Tax Amount"; Rec."Income Tax Amount")
                {
                    Caption = 'W/H Income Tax Amount';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Gross Amount (VAT Inc.)';
                    ApplicationArea = All;
                }
                field("Retention Amount"; Rec."Retention Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Advance / Retention Amount"; Rec."Advance Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Expense G/L Account"; Rec."Expense G/L Account")
                {
                    Caption = 'Advance Amount Control Account';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;
    trigger OnDeleteRecord(): Boolean begin
    /*
        PaymentsRec.RESET;
        PaymentsRec.SETRANGE(PaymentsRec.No,"PV No");
        PaymentsRec.SETFILTER(Status,'<>%1',PaymentsRec.Status::Open);
        IF PaymentsRec.FIND('-') THEN
         ERROR('You cannot delete a record when the PV status is not Open');
         */
    end;
    trigger OnModifyRecord(): Boolean begin
    /*
        PaymentsRec.RESET;
        PaymentsRec.SETRANGE(No,"PV No");
        PaymentsRec.SETFILTER(Status,'<>%1',PaymentsRec.Status::Open);
        IF PaymentsRec.FIND('-') THEN
           ERROR('You only modify an open record');
        */
    end;
    var GenJnlLine: Record "Gen. Journal Line";
    DefaultBatch: Record "Gen. Journal Batch";
    //  RecPayTypes: Record "Receipts and Payment Typess";
    CurrExchRate: Record "Currency Exchange Rate";
    Amt: Decimal;
    CustLedger: Record "Cust. Ledger Entry";
    CustLedger1: Record "Cust. Ledger Entry";
    VendLedger: Record "Vendor Ledger Entry";
    VendLedger1: Record "Vendor Ledger Entry";
    PolicyRec: Record "Sales Invoice Header";
    PremiumControlAmt: Decimal;
    BasePremium: Decimal;
    TotalTax: Decimal;
    TotalTaxPercent: Decimal;
    TotalPercent: Decimal;
    SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
    PaymentsRec: Record "GBF Payments";
    ShortcutDimCode: array[8]of Code[20];
    GlobalDimCode: Code[20];
}
