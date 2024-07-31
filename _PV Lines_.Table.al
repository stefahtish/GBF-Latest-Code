table 50742 "PV Lines"
{
    DrillDownPageID = "PV Lines";
    LookupPageID = "PV Lines";

    fields
    {
        field(1; "PV No"; Code[20])
        {
            trigger OnValidate()
            begin
                "Account Type":="Account Type"::Vendor;
                IF PV.GET("PV No")THEN BEGIN
                    IF PV."Account Type" = PV."Account Type"::Vendor THEN BEGIN
                        "Account Type":="Account Type"::Vendor;
                        "Account No":=PV."Account No.";
                        "Account Name":=PV."Account Name";
                    END
                    ELSE IF PV."Account Type" = PV."Account Type"::Customer THEN BEGIN
                            "Account Type":="Account Type"::Customer;
                            "Account No":=PV."Account No.";
                            "Account Name":=PV."Account Name";
                        END
                        ELSE
                        BEGIN
                            "Account Type":="Account Type"::"G/L Account";
                            "Account No":='';
                        END;
                END;
            end;
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";

            trigger OnValidate()
            begin
            //  VALIDATE("PV No");
            end;
        }
        field(3; "Account No"; Code[100])
        {
            Caption = 'Account No.';
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor WHERE(Blocked=FILTER(<>All), Blocked=FILTER(<>Payment))
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";

            trigger OnValidate()
            begin
                IF "Account Type" IN["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account", "Account Type"::"IC Partner"]THEN CASE "Account Type" OF "Account Type"::"G/L Account": BEGIN
                        GLAcc.GET("Account No");
                        "Account Name":=GLAcc.Name;
                        IF NOT GLAcc."Direct Posting" THEN ERROR('You cannot select a control account');
                    // "VAT Code":=RecPayTypes."VAT Code";
                    // "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                    // "Global Dimension 1 Code":='';
                    END;
                    "Account Type"::Customer: BEGIN
                        Cust.GET("Account No");
                        "Account Name":=Cust.Name;
                    //"VAT Code":=Cust."Default VAT Code";
                    //"Withholding Tax Code":=Cust."Default Withholding Tax Code";
                    //"Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    //Payee:="Account Name";
                    //"KBA Branch Code":=Cust."Preferred Bank Account";
                    //"Bank Account No":=Cust."Our Account No.";
                    END;
                    "Account Type"::Vendor: BEGIN
                        Vend.GET("Account No");
                        "Account Name":=Vend.Name;
                        VendBank.SETRANGE(VendBank."Vendor No.", "Account No");
                        VendBank.SETFILTER(VendBank."Bank Branch No.", '<>%1', '');
                        IF VendBank.FIND('-')THEN "KBA Branch Code":=VendBank."Bank Branch No.";
                        "Bank Account No":=VendBank."Bank Account No.";
                        "Payment- Support Docs":="Payment- Support Docs"::"LPO/LSO";
                    //"Withholding Tax Code":=Vend."Withholding Tax Code";
                    //"KBA Branch Code":=VendBank."Bank Branch No.";
                    //"Bank Account No":=VendBank."Bank Account No.";
                    //"Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                    //Payee:="Account Name";
                    //"KBA Branch Code":=Vend."Preferred Bank Account";
                    //"Bank Account No":=Vend."Our Account No.";
                    // if Vend."PIN No." = '' then Error('You cannot proceed because vendor %1 No. %2 KRA pin is blank', Vend.Name, Vend."No.");
                    END;
                    "Account Type"::"Bank Account": BEGIN
                        BankAcc.GET("Account No");
                        "Account Name":=BankAcc.Name;
                    // "VAT Code":=RecPayTypes."VAT Code";
                    // "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                    // "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                    END;
                    "Account Type"::"Fixed Asset": BEGIN
                        FA.GET("Account No");
                        "Account Name":=FA.Description;
                    //"VAT Code":=FA."Default VAT Code";
                    //"Withholding Tax Code":=FA."Default Withholding Tax Code";
                    // "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    END;
                    END;
                //Charles
                PV.RESET;
                PV.SETRANGE(No, "PV No");
                IF PV.FIND('-')THEN BEGIN
                    IF PV.Payee = '' THEN BEGIN
                        IF PV.Source <> PV.Source::Imprest THEN BEGIN
                            PV.Payee:="Account Name";
                        END;
                        PV.MODIFY;
                    END;
                END;
            //VALIDATE(Payee);
            end;
        }
        field(4; "Account Name"; Text[150])
        {
        }
        field(5; Description; Text[250])
        {
            trigger OnValidate()
            begin
            /*
                IF PV.GET("PV No") THEN BEGIN
                  "Account Type":=PV."Account Type";
                  "Account No":=PV."Account No."
                END;
                VALIDATE("Account No");
                */
            end;
        }
        field(6; Amount; Decimal)
        {
            DecimalPlaces = 2: 2;

            trigger OnValidate()
            begin
                VALIDATE("Applies to Doc. No");
                CSetup.GET;
                //   /  CSetup.TESTFIELD("Rounding Precision");
                IF CSetup."Rounding Type" = CSetup."Rounding Type"::Up THEN Direction:='>'
                ELSE IF CSetup."Rounding Type" = CSetup."Rounding Type"::Nearest THEN Direction:='='
                    ELSE IF CSetup."Rounding Type" = CSetup."Rounding Type"::Down THEN Direction:='<';
                "Retention Amount":=0;
                "W/TAmount":=0;
                "W/Tax Amount":=0;
                "W/VTax Amount":=0;
                "VAT Amount":=0;
                "Income Tax Amount":=0;
                "Net Amount":=Amount;
                //MODIFY;
                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "Retention Code");
                IF TaxTarriffCode.FIND('-')THEN BEGIN
                    "Retention Amount":=ROUND(Amount * (TaxTarriffCode.Percentage / 100), 0.01, '=');
                    "Net Amount":=ROUND(Amount - "Retention Amount", 0.01, '=');
                END;
                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "VAT Code");
                IF TaxTarriffCode.FIND('-')THEN BEGIN
                    "VAT Amount":=ROUND("Net Amount" * (1 / (1 + (TaxTarriffCode.Percentage / 100))), 0.01, '=');
                    "VAT Amount":=ROUND("VAT Amount" * (TaxTarriffCode.Percentage / 100), 0.01, '=');
                    "Net Amount":=ROUND(Amount - ("Retention Amount" + "VAT Amount"), 0.01, '=');
                END;
                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "W/VTax Code");
                IF TaxTarriffCode.FIND('-')THEN BEGIN
                    "W/VTax Amount":=ROUND("Net Amount" * (TaxTarriffCode.Percentage / 100), 1, '=');
                END;
                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "W/Tax Code");
                IF TaxTarriffCode.FIND('-')THEN BEGIN
                    "W/Tax Amount":=ROUND("Net Amount" * (TaxTarriffCode.Percentage / 100), 1, '=');
                END;
                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "Income Tax Code");
                IF TaxTarriffCode.FIND('-')THEN BEGIN
                    "Income Tax Amount":=ROUND("Net Amount" * (TaxTarriffCode.Percentage / 100), 1, '=');
                END;
                "Net Amount":=ROUND(Amount - ("W/Tax Amount" + "W/VTax Amount" + "Retention Amount" + "Income Tax Amount" + "Advance Payment Amount"), 0.1, '=');
                //Find Exchange Rate Here
                IF Payments.GET("PV No")THEN BEGIN
                    IF Payments.Currency <> '' THEN BEGIN
                        "Net Amount (LCY)":=ROUND(Payments."Exchange Rate" * "Net Amount", 0.1, '=');
                        "Amount(LCY)":=ROUND(Payments."Exchange Rate" * "Net Amount", 0.1, '=');
                    END
                    ELSE
                    BEGIN
                        "Amount(LCY)":=ROUND(Amount, 0.1, '=');
                        "Net Amount (LCY)":=ROUND("Net Amount", 0.1, '=');
                    END;
                END;
                FullDetails:='';
                IF Payments.GET("PV No")THEN BEGIN
                    IF Payments.Source <> Payments.Source::Imprest THEN BEGIN
                        PVLines.RESET;
                        PVLines.SETRANGE(PVLines."PV No", Payments.No);
                        IF PVLines.FINDSET THEN BEGIN
                            REPEAT FullDetails:=FullDetails;
                            UNTIL PVLines.NEXT = 0;
                            Payments.Remarks:=FullDetails;
                            Payments.MODIFY;
                        END;
                    END;
                END;
            end;
        }
        field(7; Grouping; Code[10])
        {
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; "Applies to Doc. No"; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
            begin
                "Applies to Doc. No":='';
                Amt:=0;
                VATAmount:=0;
                "W/TAmount":=0;
                CASE "Account Type" OF "Account Type"::Customer: BEGIN
                    CustLedger.RESET;
                    CustLedger.SETCURRENTKEY(CustLedger."Customer No.", Open, "Document No.");
                    CustLedger.SETRANGE(CustLedger."Customer No.", "Account No");
                    CustLedger.SETRANGE(Open, TRUE);
                    CustLedger.CALCFIELDS(CustLedger.Amount);
                    IF PAGE.RUNMODAL(0, CustLedger) = ACTION::LookupOK THEN BEGIN
                        IF CustLedger."Applies-to ID" <> '' THEN BEGIN
                            CustLedger1.RESET;
                            CustLedger1.SETCURRENTKEY(CustLedger1."Customer No.", Open, "Applies-to ID");
                            CustLedger1.SETRANGE(CustLedger1."Customer No.", "Account No");
                            CustLedger1.SETRANGE(Open, TRUE);
                            CustLedger1.SETRANGE("Applies-to ID", CustLedger."Applies-to ID");
                            IF CustLedger1.FIND('-')THEN BEGIN
                                REPEAT CustLedger1.CALCFIELDS(CustLedger1."Remaining Amount");
                                    Amt:=Amt + ABS(CustLedger1."Remaining Amount");
                                    Description:=CustLedger1.Description;
                                UNTIL CustLedger1.NEXT = 0;
                            END;
                            IF Amt <> Amt THEN //ERROR('Amount is not equal to the amount applied on the application form');
                                IF Amount = 0 THEN Amount:=Amt;
                            VALIDATE(Amount);
                            "Applies to Doc. No":=CustLedger."Document No.";
                        END
                        ELSE
                        BEGIN
                            IF Amount <> ABS(CustLedger.Amount)THEN CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                            IF Amount = 0 THEN Amount:=ABS(CustLedger."Remaining Amount");
                            VALIDATE(Amount);
                            "Applies to Doc. No":=CustLedger."Document No.";
                        END;
                    END;
                    VALIDATE(Amount);
                END;
                "Account Type"::Vendor: BEGIN
                    VendLedger.RESET;
                    VendLedger.SETCURRENTKEY(VendLedger."Vendor No.", Open, "Document No.");
                    VendLedger.SETRANGE(VendLedger."Vendor No.", "Account No");
                    VendLedger.SETRANGE(VendLedger."Document Type", "Applies-to Doc. Type");
                    VendLedger.SETRANGE(Open, TRUE);
                    VendLedger.CALCFIELDS("Remaining Amount");
                    IF PAGE.RUNMODAL(0, VendLedger) = ACTION::LookupOK THEN BEGIN
                        IF VendLedger."Applies-to ID" <> '' THEN BEGIN
                            VendLedger1.RESET;
                            VendLedger1.SETCURRENTKEY(VendLedger1."Vendor No.", Open, "Applies-to ID");
                            VendLedger1.SETRANGE(VendLedger1."Vendor No.", "Account No");
                            VendLedger1.SETRANGE(VendLedger1."Document Type", "Applies-to Doc. Type");
                            VendLedger1.SETRANGE(Open, TRUE);
                            VendLedger1.SETRANGE(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                            IF VendLedger1.FIND('-')THEN BEGIN
                                REPEAT VendLedger1.CALCFIELDS(VendLedger1."Remaining Amount");
                                    NetAmount:=NetAmount + ABS(VendLedger1."Remaining Amount");
                                UNTIL VendLedger1.NEXT = 0;
                                Description:=VendLedger1.Description;
                            END;
                            IF NetAmount <> NetAmount THEN //ERROR('Amount is not equal to the amount applied on the application form');
                                IF Amount = 0 THEN Amount:=NetAmount;
                            VALIDATE(Amount);
                            "Applies to Doc. No":=VendLedger."Document No.";
                        END
                        ELSE
                        BEGIN
                            IF Amount <> ABS(VendLedger."Remaining Amount")THEN VendLedger.CALCFIELDS(VendLedger."Remaining Amount");
                            IF Amount = 0 THEN Amount:=ABS(VendLedger."Remaining Amount");
                            VALIDATE(Amount);
                            "Applies to Doc. No":=VendLedger."Document No.";
                        END;
                    END;
                    Amount:=ABS(VendLedger."Remaining Amount");
                    VALIDATE(Amount);
                END;
                END;
            end;
            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
            begin
                //VALIDATE(Description);
                CASE "Account Type" OF "Account Type"::Customer: BEGIN
                    CustLedger.RESET;
                    CustLedger.SETRANGE("Customer No.", "Account No");
                    CustLedger.SETRANGE(Open, TRUE);
                    CustLedger.SETRANGE("Document No.", "Applies to Doc. No");
                    IF CustLedger.FIND('-')THEN BEGIN
                        "Applies-to Doc. Type":=CustLedger."Document Type";
                        //Added to Autopopulate the Invoice Description
                        Description:=CustLedger.Description;
                    END;
                END;
                "Account Type"::Vendor: BEGIN
                    "Expense G/L Account":='';
                    VendLedger.RESET;
                    VendLedger.SETRANGE("Vendor No.", "Account No");
                    VendLedger.SETRANGE(Open, TRUE);
                    VendLedger.SETRANGE("Document No.", "Applies to Doc. No");
                    IF VendLedger.FIND('-')THEN BEGIN
                        "Applies-to Doc. Type":=VendLedger."Document Type";
                        //Added to Autopopulate the Invoice Description
                        Description:=VendLedger.Description;
                    END;
                    PostedInvoice.RESET;
                    PostedInvoice.SETRANGE("No.", "Applies to Doc. No");
                    IF PostedInvoice.FIND('-')THEN BEGIN
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Document No.", PostedInvoice."No.");
                        IF PurchInvLine.FIND('-')THEN BEGIN
                            REPEAT IF PurchInvLine."Receipt No." <> '' THEN ReceiptNo:=PurchInvLine."Receipt No.";
                            UNTIL PurchInvLine.NEXT = 0;
                            // RecHeader.RESET;
                            // RecHeader.SETRANGE("Order No.", ReceiptNo);
                            // Message('hellow');
                            // IF RecHeader.FIND('-') THEN
                            //     IF Order.GET(RecHeader."No.") THEN
                            Rec."Order Description":=PurchInv."Posting Description";
                            "Expense G/L Account":=PurchInvLine."No.";
                            MODIFY;
                        END;
                    END;
                END;
                END;
                //CHARLES
                IF "Applies to Doc. No" <> '' THEN BEGIN
                    // MESSAGE('here1');
                    PostedInvoice.RESET;
                    PostedInvoice.SETRANGE(PostedInvoice."No.", Rec."Applies to Doc. No");
                    IF PostedInvoice.FIND('-')THEN BEGIN
                        //PostedInvoice.GET("Applies to Doc. No");
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Document No.", PostedInvoice."No.");
                        IF PurchInvLine.FIND('-')THEN BEGIN
                            Desc:=PurchInvLine.Description;
                            "Order Description":=Desc;
                        // MESSAGE(Desc);
                        END;
                    END;
                END
                ELSE
                    Desc:="Order Description";
            // MESSAGE(FORMAT(Desc));
            end;
        }
        field(13; "Benefit ID"; Code[20])
        {
        }
        field(15; "Policy No"; Code[30])
        {
        }
        field(16; "Amt Premium Currency"; Decimal)
        {
        }
        field(17; "Amt Reporting Currency"; Decimal)
        {
        }
        field(18; Underwriter; Code[20])
        {
        // TableRelation = Vendor WHERE ("Vendor Type" = CONST ("Law firms"));
        }
        field(19; "Policy Type"; Code[20])
        {
        }
        field(20; "Claim Line Line No"; Integer)
        {
        }
        field(21; "Patients Name"; Text[250])
        {
        }
        field(22; Insured; Text[30])
        {
        }
        field(23; "Client Type"; Text[30])
        {
        }
        field(24; "Plan Type"; Text[130])
        {
        }
        field(25; Provider; Text[130])
        {
        }
        field(26; Payee; Text[130])
        {
        }
        field(27; "Date of Service"; Date)
        {
        }
        field(28; Diagnosis; Text[250])
        {
        }
        field(29; "Expense G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(30; "Notification date"; Date)
        {
        }
        field(31; "Date settled"; Date)
        {
        }
        field(32; "External Reference"; Code[20])
        {
        }
        field(33; YOA; Code[10])
        {
        }
        field(34; ChequeNo; Code[20])
        {
        }
        field(35; "Pay member"; Decimal)
        {
        }
        field(36; "Pay Provider"; Decimal)
        {
        }
        field(37; "Denial Reason Code"; Code[10])
        {
        }
        field(38; "Denial Statement"; Text[150])
        {
            FieldClass = Normal;
        }
        field(39; "Payment Frequency"; Code[20])
        {
        }
        field(40; "Premium Due Date"; Date)
        {
        }
        field(41; "PV Posted"; Boolean)
        {
            CalcFormula = Lookup("GBF Payments".Posted WHERE(No=FIELD("PV No")));
            FieldClass = FlowField;
        }
        field(42; "Bal. Account Type"; Option)
        {
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";
        }
        field(43; "Bal. Account No."; Code[30])
        {
        }
        field(44; "KBA Branch Code"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(45; "Bank Account No"; Code[250])
        {
        }
        field(46; "W/Tax Code"; Code[20])
        {
            TableRelation = "Tax Tarriff Code".Code WHERE(Type=CONST("W/Tax"));

            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(47; "VAT Amount"; Decimal)
        {
            Editable = false;
        }
        field(48; "W/Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(49; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(50; "Loan No"; Code[20])
        {
        }
        field(51; "Asset No"; Code[20])
        {
            TableRelation = "Fixed Asset";
        }
        field(52; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(53; "VAT Code"; Code[20])
        {
            TableRelation = "Tax Tarriff Code".Code WHERE(Type=CONST(VAT), Blocked=FILTER(false));

            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(54; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund;
        }
        field(55; "Retention Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(56; "Retention Amount"; Decimal)
        {
        }
        field(57; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(58; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(59; "Sub Department"; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(0));
        }
        field(60; "Transaction Type"; Option)
        {
            OptionCaption = ',Registration Fee,Deposit Contribution,Share Contribution,Loan,Loan Repayment,Withdrawal,Interest Due,Interest Paid,Investment,Dividend Paid,Processing Fee,Withholding Tax,BBF Contribution,Admin Charges,Commission';
            OptionMembers = , "Registration Fee", "Deposit Contribution", "Share Contribution", Loan, "Loan Repayment", Withdrawal, "Interest Due", "Interest Paid", Investment, "Dividend Paid", "Processing Fee", "Withholding Tax", "BBF Contribution", "Admin Charges", Commission;
        }
        field(61; "Commission Amount"; Decimal)
        {
        }
        field(62; "Admin Charges"; Decimal)
        {
        }
        field(63; "LPO/LSO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type"=FILTER(Order), Status=FILTER(Released), "Buy-from Vendor No."=FIELD("Account No"));
        }
        field(64; "Payment- Support Docs"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Memo,LPO/LSO,Contract,Payment Certificate,Payroll,Taxes';
            OptionMembers = Memo, "LPO/LSO", Contract, "Payment Certificate", Payroll, Taxes;
        }
        field(50000; "Investment Asset No."; Code[20])
        {
        //TableRelation = "Proc. Plan_Budget revisions";
        }
        field(50001; "Investment Transaction Type"; Option)
        {
            OptionCaption = ' ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Other Income,Expenses,Principal';
            OptionMembers = " ", Acquisition, Disposal, Interest, Dividend, Bonus, Revaluation, "Share-split", Premium, Discounts, "Other Income", Expenses, Principal;
        }
        field(50004; "Insurance Trans Type"; Option)
        {
            OptionCaption = ' ,Premium,Commission,Tax,Wht,Excess,Claim Reserve,Claim Payment,Reinsurance Premium,Reinsurance Commission,Reinsurance Premium Taxes,Reinsurance Commission Taxes,Net Premium,Claim Recovery,Salvage,Reinsurance Claim Reserve,Reinsurance Recovery Payment ,Accrued Reinsurance Premium,Deposit Premium,XOL Adjustment Premium';
            OptionMembers = " ", Premium, Commission, Tax, Wht, Excess, "Claim Reserve", "Claim Payment", "Reinsurance Premium", "Reinsurance Commission", "Reinsurance Premium Taxes", "Reinsurance Commission Taxes", "Net Premium", "Claim Recovery", Salvage, "Reinsurance Claim Reserve", "Reinsurance Recovery Payment ", "Accrued Reinsurance Premium", "Deposit Premium", "XOL Adjustment Premium";
        }
        field(50007; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50009; "XOL Layer"; Code[10])
        {
        // TableRelation = "XOL Layers".Layer WHERE("Treaty Code" = FIELD("Treaty Code"),
        // "Addendum Code" = FIELD("Treaty Addendum"));
        }
        field(50010; "No. of Units"; Decimal)
        {
        }
        field(65; "Supplier Invoice No"; code[35])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No."=FIELD("Applies to Doc. No")));
        }
        field(66; "Supplier Invoice Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Document Date" WHERE("No."=FIELD("Applies to Doc. No")));
        }
        field(50011; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount:="No. of Units" * "Unit Price";
                VALIDATE(Amount);
            end;
        }
        field(50012; "Order Description"; Text[250])
        {
        }
        field(50013; "W/VTax Amount"; Decimal)
        {
            Editable = false;
        }
        field(50014; "W/VTax Code"; Code[20])
        {
            TableRelation = "Tax Tarriff Code".Code WHERE(Type=CONST("W/VTax"));

            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(50015; "Income Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(50016; "Income Tax Code"; Code[20])
        {
            TableRelation = "Tax Tarriff Code".Code WHERE(Type=CONST("Income Tax"));

            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(50017; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50018; "Advance Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE(Amount);
            end;
        }
        field(50019; "Net Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "PV No", "Line No")
        {
        // Clustered = true;
        // SumIndexFields = Amount, "Net Amount";
        }
    }
    fieldgroups
    {
    }
    // trigger OnDelete()
    // begin
    //     IF Payments.GET("PV No") THEN BEGIN
    //         IF Payments.Posted THEN
    //             ERROR('You cannot delete the lines at this stage');
    //         //For Funds Disbursements strictly Use the schedules
    //         IF Payments.Source = Payments.Source::"Fund Disbursement" THEN BEGIN
    //             DisbursementSchedule.RESET;
    //             DisbursementSchedule.SETRANGE(DisbursementSchedule."PV No", Payments.No);
    //             IF DisbursementSchedule.FIND('-') THEN BEGIN
    //                 REPEAT
    //                     DisbursementSchedule."PV No" := '';
    //                     DisbursementSchedule."PV Prepared" := FALSE;
    //                     DisbursementSchedule.Process := FALSE;
    //                     DisbursementSchedule.MODIFY;
    //                 UNTIL DisbursementSchedule.NEXT = 0;
    //             END;
    //         END;
    //         // Allow for Updating
    //         UserSetup.RESET;
    //         UserSetup.SETRANGE(UserSetup."User ID", USERID);
    //         // UserSetup.SETRANGE(UserSetup."Update Payment Lines", TRUE);
    //         IF NOT UserSetup.FIND('-') THEN BEGIN
    //             IF Payments.Status <> Payments.Status::Open THEN
    //                 ERROR('You cannot delete the line at this stage');
    //         END;
    //     END;
    // end;
    trigger OnInsert()
    begin
        IF Payments.GET("PV No")THEN BEGIN
            //For Funds Disbursements strictly Use the schedules
            IF Payments.Source = Payments.Source::"Fund Disbursement" THEN ERROR('PV %1 is for has a disbursement schedule %2', Payments.No, Payments."Fund Disbursement No");
            IF Payments.Status <> Payments.Status::Open THEN ERROR('You cannot insert the line at this stage');
            IF Payments.GET("PV No")THEN BEGIN
                RecPayTypes.RESET;
                RecPayTypes.SETRANGE(RecPayTypes.Code, Payments.Type);
                RecPayTypes.SETRANGE(RecPayTypes.Type, RecPayTypes.Type::Payment);
                IF RecPayTypes.FINDFIRST THEN BEGIN
                    //    "Insurance Trans Type" := RecPayTypes."Insurance Trans Type";
                    IF RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" THEN BEGIN
                        "Account Type":=RecPayTypes."Account Type";
                        "Account No":=RecPayTypes."G/L Account";
                    END
                    ELSE
                    BEGIN
                        "Account Type":=RecPayTypes."Account Type";
                        "Account No":=RecPayTypes."G/L Account";
                    END;
                END;
            END;
        END;
        IF RecPayTypes.GET(Payments.Type, RecPayTypes.Type::Payment)THEN BEGIN
            //   "Insurance Trans Type" := RecPayTypes."Insurance Trans Type";
            //  "Investment Transaction Type" := RecPayTypes."Investment Transaction Type";
            IF RecPayTypes."VAT Chargeable" = RecPayTypes."VAT Chargeable"::Yes THEN "VAT Code":=RecPayTypes."VAT Code";
            IF RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."Withholding Tax Chargeable"::Yes THEN "W/Tax Code":=RecPayTypes."Withholding Tax Code";
            IF "Account No" <> '' THEN VALIDATE("Account No");
        END;
    end;
    trigger OnModify()
    begin
    /*
        IF Payments.GET("PV No") THEN
          BEGIN
          IF Payments.Posted THEN
          ERROR ('You cannot delete the lines at this stage');
           //For Funds Disbursements strictly Use the schedules
         IF Payments.Source=Payments.Source::"Fund Disbursement" THEN
          ERROR('PV %1 is for has a disbursement schedule %2',Payments.No,Payments."Fund Disbursement No");
          // Allow for Updating
          UserSetup.RESET;
          UserSetup.SETRANGE(UserSetup."User ID",USERID);
          UserSetup.SETRANGE(UserSetup."Update Payment Lines",TRUE);
          IF NOT UserSetup.FIND('-') THEN BEGIN
            IF Payments.Status<>Payments.Status::Open THEN
           ERROR('You cannot delete the line at this stage');
          END;
          IF Payments.Source=Payments.Source::"Imprest Claim" THEN
          ERROR('Cannot modify the line that originated from imprest claim');
          Payments.Cashier:=USERID ;
          Payments.MODIFY;
        END;
        */
    end;
    trigger OnRename()
    begin
        IF Payments.GET("PV No")THEN BEGIN
            IF Payments.Status <> Payments.Status::Open THEN ERROR('You cannot Rename at this stage');
        END;
    end;
    var ReceiptNo: Code[10];
    PostedInvoice: Record "Purch. Inv. Header";
    PurchInvLine: Record "Purch. Inv. Line";
    Desc: Text;
    RecPayTypes: Record "Receipts and Payment Typess";
    GLAcc: Record "G/L Account";
    Cust: Record Customer;
    Vend: Record Vendor;
    FA: Record "Fixed Asset";
    BankAcc: Record "Bank Account";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    GenLedgerSetup: Record "General Ledger Setup";
    CurrExchRate: Record "Currency Exchange Rate";
    Payments: Record "GBF Payments";
    PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    PV: Record "GBF Payments";
    CurrencyExchange: Record "Currency Exchange Rate";
    SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
    AccNo: Code[20];
    AccType: Option "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";
    CustLedgEntry: Record "Cust. Ledger Entry";
    VendLedgEntry: Record "Vendor Ledger Entry";
    PurchInv: Record "Purch. Inv. Header";
    Amt: Decimal;
    Direction: Text[30];
    VATAmount: Decimal;
    "W/TAmount": Decimal;
    RetAmount: Decimal;
    NetAmount: Decimal;
    VATSetup: Record "VAT Posting Setup";
    CustLedger: Record "Cust. Ledger Entry";
    CustLedger1: Record "Cust. Ledger Entry";
    VendLedger: Record "Vendor Ledger Entry";
    VendLedger1: Record "Vendor Ledger Entry";
    GLAccount: Record "G/L Account";
    Customer: Record Customer;
    Vendor: Record Vendor;
    Bank: Record "Bank Account";
    FixedAsset: Record "Fixed Asset";
    CSetup: Record "Cash Management SetupS";
    DimMgt: Codeunit DimensionManagement;
    // Treaty: Record Treaty;
    //  CoinsuranceReinsuranceLines: Record "Coinsurance Reinsurance Lines";
    //XOLLayers: Record "XOL Layers";
    BalanceRemain: Decimal;
    VendBank: Record "Vendor Bank Account";
    PVLines: Record "PV Lines";
    RecHeader: Record "Purch. Rcpt. Header";
    "Order": Record "Purchase Header";
    TaxTarriffCode: Record "Tax Tarriff Code";
    FullDetails: Text[250];
    //  DisbursementSchedule: Record "Disbursement Schedule";
    UserSetup: Record "User Setup";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    // DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    // DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    // DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure ShowDimensions()
    begin
    // "Dimension Set ID" :=
    //   DimMgt.EditDimensionSet2(
    //     "Dimension Set ID", STRSUBSTNO('%1 %2', "PV No", "Line No"),
    //     "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20])
    begin
    // DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}
