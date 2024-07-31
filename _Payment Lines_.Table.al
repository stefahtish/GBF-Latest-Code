table 50125 "Payment Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "Account Type"; enum "Gen. Journal Account Type")
        {
            /*trigger OnValidate()
                var
                    Error001: Label 'Payment | Receipt Type %1 has an Acccount Type %2 not similar to the selected Account Type %2';
                    ReceiptPayment: Record "Receipts and Payment Types";
                begin
                    if ReceiptPayment.Get("Expenditure Type", "Payment Type") then begin
                        if ReceiptPayment."Account Type" <> "Account Type" then
                            Error(Error001, "Expenditure Type", ReceiptPayment."Account Type", "Account Type");
                    end;
                   // "Account No" := '';
                    //"Account Name" := '';
                end;
                */
        }
        field(5; "Account No"; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST(Customer)) Customer
            ELSE IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Account Type" = CONST(Item)) Item;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                // if "Payment Type" <> "Payment Type"::"Bank Transfer" then begin
                //     if "Expenditure Type" = '' then
                //         Error('Kindly select an appropriate %1 type', "Payment Type");
                // end;
                GetPaymentHeader;
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No") then;
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                            Description := GLAccount.Name;
                            //Update G/L
                            "G/L Account to Debit" := "Account No";
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No") then;
                            Vendor.TestField("Vendor Bank Code");
                            Vendor.TestField("Vendor Bank Branch Code");
                            //Vendor.TestField("Bank Account Name");
                            //Vendor.CalcFields("Vendor Swift Code");
                            "Account Name" := Vendor.Name;
                            Description := Vendor.Name;
                            Payee := Vendor.Name;
                            "Our Account No." := Vendor."Our Account No.";
                            "Sort Code" := Vendor."Sort Code";
                            //insert bank
                            "Payee Account Name" := Vendor.Name;
                            Validate("Payee Bank Code", Vendor."Vendor Bank Code");
                            Validate("Payee Bank Branch Code", Vendor."Vendor Bank Branch Code");
                            Validate("Payee Bank Account No", Vendor."Vendor Bank Account No");
                            Validate("Payee Swift Code", Vendor."Vendor Swift Code");
                            VendPostingGrp.Reset();
                            VendPostingGrp.SetRange(Code, Vendor."Vendor Posting Group");
                            IF VendPostingGrp.FindFirst() then "G/L Account to Debit" := VendPostingGrp."Payables Account";
                            //Get payee
                            PaymentRec.Reset;
                            PaymentRec.SetRange(PaymentRec."No.", No);
                            if PaymentRec.FindFirst then begin
                                PaymentRec.Payee := "Account Name";
                                PaymentRec."On behalf of" := "Account Name";
                                PaymentRec.Modify;
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No");
                            "Account Name" := Customer.Name;
                            payee := Customer.Name;
                            Description := Customer.Name;
                            Validate("Payee Bank Code", Customer."Bank Code");
                            Validate("Payee Bank Branch Code", Customer."Bank Branch Code");
                            Validate("Payee Bank Account No", Customer."Bank Account No");
                            Validate("Payee Swift Code");
                            CustPostGrp.Reset();
                            CustPostGrp.SetRange(Code, Customer."Customer Posting Group");
                            If CustPostGrp.FindFirst() then "G/L Account to Debit" := CustPostGrp."Receivables Account";
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No");
                            "Account Name" := Bank.Name;
                            Currency := Bank."Currency Code";
                            if "Account No" = PaymentRec."Source Bank" then Error('Receiving bank cannot be same as Source Bank');
                            //insert bank
                            //Bank.TestField("Bank code");
                            Bank.TestField("Bank Branch No.");
                            Bank.TestField("Bank Account No.");
                            Bank.TestField(Name);
                            Validate("Payee Bank Code", Bank."Bank Code");
                            Validate("Payee Bank Branch Code", Bank."Bank Branch No.");
                            Validate("Payee Bank Account No", Bank."Bank Account No.");
                            "Payee Account Name" := Bank.Name;
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;
                PaymentRec.Reset;
                PaymentRec.SetRange(PaymentRec."No.", No);
                if PaymentRec.FindFirst then begin
                    "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    //Validate("Shortcut Dimension 3 Code");
                    if Description = '' then PaymentLines.Description := PaymentRec."Payment Narration";
                    if Purpose = '' then PaymentLines.Purpose := PaymentLines.Description;
                end;
                //Validate(Amount);
            end;
        }
        field(6; "Account Name"; Text[100])
        {
        }
        field(7; Description; Text[2048])
        {
        }
        field(8; Amount; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            var
                PmtLines: Record "Payment Lines";
                Pmts: Record Payments;
                Pmts2: Record Payments;
                UsedAmt: Decimal;
                StaffNo: Code[20];
            begin
                Pmts2.Reset();
                Pmts2.SetRange("No.", No);
                Pmts2.setrange("Payment Type", Pmts2."Payment Type"::Imprest);
                if Pmts2.FindFirst() then begin
                    StaffNo := Pmts2."Staff No.";
                    UsedAmt := 0;
                    if "Line Type" = "Line Type"::Normal then begin
                        Pmts.Reset();
                        Pmts.SetFilter("No.", '<>%1', No);
                        Pmts.SetRange("Staff No.", StaffNo);
                        Pmts.SetRange("Payment Type", Pmts."Payment Type"::Imprest);
                        if Pmts.Find('-') then
                            repeat
                                PmtLines.Reset();
                                PmtLines.SetRange(No, Pmts."No.");
                                PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                                PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                                PmtLines.SetRange("Line Type", PmtLines."Line Type"::Normal);
                                if PmtLines.Find('-') then
                                    repeat
                                        UsedAmt += PmtLines.Amount;
                                    until PmtLines.Next() = 0;
                            until Pmts.next = 0;
                    end;
                    if "Line Type" = "Line Type"::Item then begin
                        repeat
                            PmtLines.Reset();
                            PmtLines.SetFilter(No, '<>%1', No);
                            PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                            PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                            PmtLines.SetRange("Line Type", PmtLines."Line Type"::Item);
                            PmtLines.SetRange("Item No.", "Item No.");
                            if PmtLines.Find('-') then
                                repeat
                                    UsedAmt += PmtLines.Amount;
                                until PmtLines.Next() = 0;
                        until Pmts.next = 0;
                    end;
                    if "Line Type" = "Line Type"::"Running Cost" then begin
                        PmtLines.Reset();
                        PmtLines.SetFilter(No, '<>%1', No);
                        PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                        PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                        PmtLines.SetRange("Line Type", PmtLines."Line Type"::"Running Cost");
                        PmtLines.SetRange(Description, Description);
                        if PmtLines.Find('-') then
                            repeat
                                UsedAmt += PmtLines.Amount;
                            until PmtLines.Next() = 0;
                    end;
                end;
                if "Activity Work Programme" <> '' then begin
                    if (Amount + UsedAmt) > "Activity Maximum Amount" then Error('Amount allocated to user will be exceeded by %1', (Amount + UsedAmt - "Activity Maximum Amount"));
                end;
                VATAmount := 0;
                "W/Tax Amount" := 0;
                WTVATAmount := 0;
                "VAT Amount" := 0;
                "W/Tax Amount" := 0;
                "Retention Amount" := 0;
                "W/T VAT Amount" := 0;
                CSetup.Get;
                CSetup.TestField("Rounding Precision");
                if CSetup."Rounding Type" = CSetup."Rounding Type"::Up then
                    Direction := '>'
                else if CSetup."Rounding Type" = CSetup."Rounding Type"::Nearest then
                    Direction := '='
                else if CSetup."Rounding Type" = CSetup."Rounding Type"::Down then Direction := '<';
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if "VAT Code" <> '' then begin
                                if GLAccount.Get("Account No") then;
                                if VATSetup.Get(GLAccount."VAT Bus. Posting Group", "VAT Code") then begin
                                    if VATSetup."VAT %" <> 0 then begin
                                        if "VAT Exclusive" = false then
                                            VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction)
                                        else
                                            VATAmount := Round(((Amount) * (VATSetup."VAT %" / 100)), CSetup."Rounding Precision", Direction);
                                        NetAmount := (Amount) - VATAmount;
                                        "VAT Amount" := VATAmount;
                                        if CSetup."Post VAT" then //Check IF VAT is to be posted
                                            "Net Amount" := Amount - VATAmount
                                        else
                                            "Net Amount" := Amount;
                                        if "W/Tax Code" <> '' then begin
                                            if GLAccount.Get("Account No") then
                                                if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                                    "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                    "W/Tax Amount" := "W/TAmount";
                                                    NetAmount := NetAmount - "W/TAmount";
                                                    if CSetup."Post VAT" then //Check IF VAT is to be posted
                                                        "Net Amount" := NetAmount
                                                    else
                                                        "Net Amount" := Amount - "W/TAmount";
                                                end;
                                        end;
                                        if "W/T VAT Code" <> '' then begin //Compute W/T VAT
                                            if GLAccount.Get("Account No") then;
                                            if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/T VAT Code") then begin
                                                if VATSetup2.Get(GLAccount."Gen. Bus. Posting Group", "VAT Code") then;
                                                WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)), CSetup."Rounding Precision", Direction);
                                                "W/T VAT Amount" := WTVATAmount;
                                                NetAmount := NetAmount - WTVATAmount;
                                                "Net Amount" := "Net Amount" - WTVATAmount;
                                            end;
                                        end;
                                    end
                                    else begin
                                        "Net Amount" := Amount;
                                        NetAmount := Amount;
                                        if "W/Tax Code" <> '' then begin
                                            if GLAccount.Get("Account No") then
                                                if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                                    "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                    "W/Tax Amount" := "W/TAmount";
                                                    NetAmount := NetAmount - "W/TAmount";
                                                    "Net Amount" := Amount - "W/TAmount";
                                                end;
                                        end;
                                    end;
                                end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then begin
                                    if GLAccount.Get("Account No") then
                                        if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        end;
                                end;
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            if "VAT Code" <> '' then begin
                                if Customer.Get("Account No") then
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "VAT Code") then begin
                                        VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        if VATSetup."VAT %" <> 0 then begin
                                            NetAmount := (Amount) - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            if CSetup."Post VAT" then //Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            else
                                                "Net Amount" := Amount;
                                            if "W/Tax Code" <> '' then begin
                                                if Customer.Get("Account No") then
                                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        if CSetup."Post VAT" then //Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        else
                                                            "Net Amount" := Amount - "W/TAmount";
                                                    end;
                                            end;
                                            if "W/T VAT Code" <> '' then begin //Compute W/T VAT
                                                if GLAccount.Get("Account No") then;
                                                if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/T VAT Code") then begin
                                                    if VATSetup2.Get(GLAccount."Gen. Bus. Posting Group", "VAT Code") then;
                                                    WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)), CSetup."Rounding Precision", Direction);
                                                    "W/T VAT Amount" := WTVATAmount;
                                                    NetAmount := NetAmount - WTVATAmount;
                                                    "Net Amount" := "Net Amount" - WTVATAmount;
                                                end;
                                            end;
                                        end
                                        else begin
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            if "W/Tax Code" <> '' then begin
                                                if Customer.Get("Account No") then
                                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - "W/TAmount";
                                                    end;
                                            end;
                                        end;
                                    end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then begin
                                    if Customer.Get("Account No") then
                                        if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        end;
                                end;
                            end;
                        end;
                    "Account Type"::Vendor:
                        begin
                            if "VAT Code" <> '' then begin
                                if Vendor.Get("Account No") then
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "VAT Code") then begin
                                        if VATSetup."VAT %" <> 0 then begin
                                            if "Vatable Amount" = 0 then
                                                VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction)
                                            else
                                                VATAmount := Round((("Vatable Amount") * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := (Amount) - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            if CSetup."Post VAT" then //Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            else
                                                "Net Amount" := Amount;
                                            if "W/Tax Code" <> '' then begin
                                                if Vendor.Get("Account No") then
                                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        if "Levied Invoice H" = false then begin //To cater for levied invoices
                                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                            "W/Tax Amount" := "W/TAmount";
                                                            NetAmount := Round((NetAmount - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                                        end
                                                        else if "Levied Invoice H" = true then begin //To cater for levied invoices
                                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                            "W/Tax Amount" := "W/TAmount";
                                                            "10% Not Wtheld" := Round(((10 / 100) * "Vatable Amount"), CSetup."Rounding Precision", Direction);
                                                            NetAmount := Round(("Vatable Amount" + "Other Charges" - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                                        end;
                                                        if CSetup."Post VAT" then //Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        else
                                                            "Net Amount" := Round((Amount - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                                    end;
                                            end;
                                            if "W/T VAT Code" <> '' then begin //Compute W/T VAT
                                                if Vendor.Get("Account No") then
                                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/T VAT Code") then begin
                                                        if VATSetup2.Get(Vendor."VAT Bus. Posting Group", "VAT Code") then begin
                                                            if "Levied Invoice H" = false then begin
                                                                WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)), CSetup."Rounding Precision", Direction);
                                                                "W/T VAT Amount" := WTVATAmount;
                                                                NetAmount := NetAmount - WTVATAmount;
                                                                "Net Amount" := "Net Amount" - WTVATAmount;
                                                            end
                                                            else if "Levied Invoice H" = true then begin
                                                                WTVATAmount := Round(("Vatable Amount" * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                                                "W/T VAT Amount" := WTVATAmount;
                                                                NetAmount := NetAmount - WTVATAmount;
                                                                "Net Amount" := "Net Amount" - WTVATAmount;
                                                            end;
                                                        end;
                                                    end;
                                            end;
                                        end
                                        else begin
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            if "W/Tax Code" <> '' then begin
                                                if Vendor.Get("Account No") then
                                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - "W/TAmount";
                                                    end;
                                            end;
                                        end;
                                    end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then begin
                                    if Vendor.Get("Account No") then
                                        if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        end;
                                end;
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        "Net Amount" := Amount;
                end;
                //Convert FCY to LCY
                CurrencyRec.InitRoundingPrecision;
                if Currency = '' then
                    "Amount (LCY)" := Round(Amount, CurrencyRec."Amount Rounding Precision")
                else begin
                    if CurrencyRec.Get(Currency) then "Amount (LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Date, Currency, Amount, CurrExchRate.ExchangeRate(Date, Currency)), CurrencyRec."Amount Rounding Precision");
                end;
            end;
        }
        field(9; Posted; Boolean)
        {
            Editable = false;
        }
        field(10; "Posted Date"; Date)
        {
        }
        field(11; "Posted Time"; Time)
        {
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(16; "W/Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(17; "Retention Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(18; "VAT Amount"; Decimal)
        {
        }
        field(19; "W/Tax Amount"; Decimal)
        {
        }
        field(20; "Retention Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate(Amount)
            end;
        }
        field(21; "Net Amount"; Decimal)
        {
        }
        field(22; "W/T VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(23; "W/T VAT Amount"; Decimal)
        {
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = "Vendor Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            OptionCaption = 'Payment Voucher,Imprest,Staff Claim,Imprest Surrender,Petty Cash,Bank Transfer,Petty Cash Surrender,Receipt,Staff Advance,Receipt-Property,Input Tax,Service Charge,Service Charge Surrender';
            OptionMembers = "Payment Voucher",Imprest,"Staff Claim","Imprest Surrender","Petty Cash","Bank Transfer","Petty Cash Surrender",Receipt,"Staff Advance","Receipt-Property","Input Tax","Service Charge","Service Charge Surrender","Service Charge Claim";
        }
        field(39; Purpose; Text[2048])
        {
        }
        field(83; Committed; Boolean)
        {
        }
        field(85; "NetAmount LCY"; Decimal)
        {
            Caption = 'Net Amount (KSH)';
        }
        field(86; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(87; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                ApplyVendEntries: Page "Apply Vendor Entries";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);
                IF (Rec."Account Type" <> Rec."Account Type"::Customer) AND (Rec."Account Type" <> Rec."Account Type"::Vendor) THEN ERROR('You cannot apply to %1', "Account Type");
                Rec.Amount := 0;
                Rec.VALIDATE(Amount);
                PayToVendorNo := Rec."Account No";
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
                VendLedgEntry.SETRANGE(Open, TRUE);
                IF Rec."Applies-to ID" = '' THEN Rec."Applies-to ID" := Rec.No;
                IF Rec."Applies-to ID" = '' THEN ERROR(Text000, Rec.FIELDCAPTION(No), Rec.FIELDCAPTION("Applies-to ID"));
                //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                //ApplyVendEntries.SetPVLine(Rec,VendLedgEntry,Rec.FIELDNO("Applies-to ID"));
                ApplyVendEntries.SETRECORD(VendLedgEntry);
                ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                ApplyVendEntries.LOOKUPMODE(TRUE);
                OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                CLEAR(ApplyVendEntries);
                IF NOT OK THEN EXIT;
                VendLedgEntry.RESET;
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
                VendLedgEntry.SETRANGE(Open, TRUE);
                VendLedgEntry.SETRANGE("Applies-to ID", Rec."Applies-to ID");
                IF VendLedgEntry.FIND('-') THEN BEGIN
                    Rec."Applies-to Doc Type" := Rec."Applies-to Doc Type"::" ";
                    Rec."Applies-to Doc. No." := '';
                END
                ELSE
                    Rec."Applies-to ID" := '';
                //Calculate  Total To Apply
                VendLedgEntry.RESET;
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
                VendLedgEntry.SETRANGE(Open, TRUE);
                VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                IF VendLedgEntry.FIND('-') THEN BEGIN
                    VendLedgEntry.CALCSUMS("Amount to Apply");
                    Amount := ABS(VendLedgEntry."Amount to Apply");
                    VALIDATE(Amount);
                END;
            end;

        }
        field(88; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                /*
                    //IF "Applies-to ID" <> '' THEN
                    //  TESTFIELD("Bal. Account No.",'');
                    IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN BEGIN
                      VendLedgEntry.SETCURRENTKEY("Vendor No.",Open);
                      VendLedgEntry.SETRANGE("Vendor No.","Account No.");
                      VendLedgEntry.SETRANGE(Open,TRUE);
                      VendLedgEntry.SETRANGE("Applies-to ID",xRec."Applies-to ID");
                      IF VendLedgEntry.FINDFIRST THEN
                        VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,0,0,'');
                      VendLedgEntry.RESET;
                    END;
                    */
            end;
        }
        field(89; "Actual Spent"; Decimal)
        {
            trigger OnValidate()
            begin
                "Remaining Amount" := Amount - "Actual Spent" - "Cash Receipt Amount";
            end;
        }
        field(90; "Remaining Amount"; Decimal)
        {
        }
        field(91; "Actual Spent (LCY)"; Decimal)
        {
            Caption = 'Actual Spent (KSH)';
        }
        field(92; "Remaining Amount (LCY)"; Decimal)
        {
            Caption = 'Remaining Amount (KSH)';
        }
        field(93; "Cash Receipt Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Actual Spent");
            end;
        }
        field(94; "Cash Receipt Amount (LCY)"; Decimal)
        {
            Caption = 'Cash Receipt Amount (KSH)';
        }
        field(95; "Expenditure Type"; Code[20])
        {
            TableRelation = IF ("Payment Type" = FILTER(Imprest)) "Receipts and Payment Types".Code WHERE(Type = FILTER(Imprest))
            ELSE IF ("Payment Type" = FILTER("Payment Voucher")) "Receipts and Payment Types".Code WHERE(Type = FILTER(Payment))
            ELSE IF ("Payment Type" = FILTER("Petty Cash")) "Receipts and Payment Types".Code WHERE(Type = FILTER("Petty Cash"))
            ELSE IF ("Payment Type" = FILTER(Receipt)) "Receipts and Payment Types".Code WHERE(Type = FILTER(Receipt))
            ELSE IF ("Payment Type" = FILTER("Staff Claim")) "Receipts and Payment Types".Code WHERE(Type = FILTER(Claim))
            ELSE IF ("Payment Type" = FILTER("Receipt-Property")) "Receipts and Payment Types".Code WHERE(Type = FILTER("Receipt-Property"))
            ELSE IF ("Payment Type" = FILTER("Input Tax")) "Receipts and Payment Types".Code WHERE(Type = FILTER("Input Tax"))
            ELSE IF ("Payment Type" = FILTER("Service Charge" | "Service Charge Claim")) "Receipts and Payment Types".Code WHERE(Type = CONST("Service Charge"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                GetPaymentHeader;
                RecTypes.Reset;
                RecTypes.SetRange(Code, "Expenditure Type");
                case PaymentRec."Payment Type" of
                    PaymentRec."Payment Type"::"Payment Voucher":
                        RecTypes.SetRange(Type, RecTypes.Type::Payment);
                    PaymentRec."Payment Type"::"Petty Cash":
                        RecTypes.SetRange(Type, RecTypes.Type::"Petty Cash");
                    PaymentRec."Payment Type"::Imprest:
                        RecTypes.SetRange(Type, RecTypes.Type::Imprest);
                    PaymentRec."Payment Type"::"Staff Claim":
                        RecTypes.SetRange(Type, RecTypes.Type::Claim);
                    PaymentRec."Payment Type"::Receipt:
                        RecTypes.SetRange(Type, RecTypes.Type::Receipt);
                    PaymentRec."Payment Type"::"Input Tax":
                        RecTypes.SetRange(Type, RecTypes.Type::"Input Tax");
                    PaymentRec."Payment Type"::"Service Charge", PaymentRec."Payment Type"::"Service Charge Claim":
                        RecTypes.SetRange(Type, RecTypes.Type::"Service Charge");
                end;
                if RecTypes.FindFirst then begin
                    "Account Type" := RecTypes."Account Type";
                    "Account No" := RecTypes."Account No.";
                    if "Account No" <> '' then Validate("Account No");
                    "Imprest Payment" := RecTypes."Imprest Payment";
                    "Claim Payment" := RecTypes."Claim Payment";
                    "Shortcut Dimension 3 Code" := RecTypes."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 1 Code" := RecTypes."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := RecTypes."Shortcut Dimension 2 Code";
                    // Description:=RecTypes.Description;
                    "Based On Travel Rates" := RecTypes."Based On Travel Rates Table";
                    if "Based On Travel Rates" then begin
                        "No of Days" := GetNoOfDays;
                        Amount := GetDestinationRate;
                        Validate(Amount);
                    end
                    else begin
                        if "Daily Rate" <> 0 then Amount := "Daily Rate" * "No of Days";
                        Validate(Amount);
                    end;
                end;
            end;
        }
        field(96; Comments; Text[250])
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(481; "Bank Acc"; Code[20])
        {
            CalcFormula = Lookup(Payments."Paying Bank Account" WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(482; "Receiving Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(483; "Vendor Invoice"; Code[20])
        {
        }
        field(484; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                BudgetEntry: record "G/L Budget Entry";
                Participants: record "Activity Work Programme Lines";
                GLSetup: record "General Ledger Setup";
                Items: record "Activity Work Programme Lines";
                WorkProgramme: Record "Activity Work Programme";
                PmtLines: Record "Payment Lines";
                Pmts: Record Payments;
                Pmts2: Record Payments;
                UserSetup: Record "User Setup";
                UsedAmt: Decimal;
                ImprestActivityLines: record "Imprest Line Activities";
                StaffNo: Code[20];
                LineNo: Integer;
                Qty: Integer;
                Facilitators: Record "Activity Work Programme Lines";
            begin
                //     ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                GLSetup.get;
                BudgetEntry.Reset();
                // BudgetEntry.SetRange("Global Dimension 2 Code", PaymentRec."Shortcut Dimension 2 Code");
                BudgetEntry.SetFilter("Budget Name", GLSetup."Current Budget");
                BudgetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                if BudgetEntry.FindFirst() then begin
                    "Account No" := BudgetEntry."G/L Account No.";
                    "Account Type" := "Account Type"::"G/L Account";
                    //Validate("Account No");
                end;
                PmtLines.Reset();
                PmtLines.SetRange(No, No);
                PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                PmtLines.SetFilter("Line Type", '=%1|=%2', PmtLines."Line Type"::Item, PmtLines."Line Type"::"Running Cost");
                if PmtLines.FindSet() then PmtLines.DeleteAll();
                PmtLines.Reset();
                PmtLines.SetCurrentKey(No, "Line No");
                PmtLines.SetRange(No, No);
                if PmtLines.FindLast() then LineNo := PmtLines."Line No";
                if "Payment Type" = "Payment Type"::Imprest then begin
                    if "Activity Work Programme" <> '' then begin
                        WorkProgramme.Get("Activity Work Programme");
                        if WorkProgramme."Created By" = UserId then begin
                            Items.Reset();
                            Items.SetRange("No.", "Activity Work Programme");
                            Items.SetRange(Type, Items.Type::Items);
                            Items.SetRange("Purchase Type", Items."Purchase Type"::Imprest);
                            if Items.Find('-') then begin
                                repeat
                                    UsedAmt := 0;
                                    Qty := 0;
                                    PmtLines.Reset();
                                    PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                                    PmtLines.SetFilter("Item No.", '<>%1', '');
                                    PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                                    PmtLines.SetRange("Line Type", PmtLines."Line Type"::Item);
                                    PmtLines.SetRange("Item No.", Items."Item No.");
                                    if PmtLines.Find('-') then
                                        repeat
                                            Qty += PmtLines.Quantity;
                                        //Message('%1', Qty);
                                        until PmtLines.Next() = 0;
                                    if Qty < Items.Quantity then begin
                                        LineNo += 1000;
                                        PmtLines.Init();
                                        PmtLines.No := No;
                                        PmtLines."Item No." := Items."Item No.";
                                        PmtLines."Payment Type" := PmtLines."Payment Type"::Imprest;
                                        PmtLines."Line Type" := PmtLines."Line Type"::Item;
                                        PmtLines."Activity Maximum Amount" := Items.Amount;
                                        PmtLines."Account Type" := PmtLines."Account Type"::"G/L Account";
                                        PmtLines."Account No" := "Account No";
                                        PmtLines.Description := Items.Description;
                                        PmtLines.Quantity := Items.Quantity - Qty;
                                        PmtLines."Estimated Unit Cost" := Items."Unit Cost";
                                        PmtLines.Amount := PmtLines.Quantity * PmtLines."Estimated Unit Cost";
                                        PmtLines."Activity Work Programme" := "Activity Work Programme";
                                        PmtLines."Line No" := LineNo;
                                        PmtLines.Insert();
                                        PaymentRec.Requisition := true;
                                        PaymentRec.Modify();
                                    end;
                                until Items.Next() = 0;
                            end;
                            Facilitators.Reset();
                            Facilitators.SetRange("No.", "Activity Work Programme");
                            Facilitators.SetRange(Type, Items.Type::Facilitators);
                            if Facilitators.Find('-') then begin
                                repeat
                                    UsedAmt := 0;
                                    PmtLines.Reset();
                                    PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                                    PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                                    PmtLines.SetRange("Line Type", PmtLines."Line Type"::"Running Cost");
                                    PmtLines.SetRange(Description, Facilitators.Description);
                                    if PmtLines.Find('-') then
                                        repeat
                                            UsedAmt += PmtLines.Amount;
                                        until PmtLines.Next() = 0;
                                    if UsedAmt < Facilitators.Amount then begin
                                        LineNo += 1000;
                                        PmtLines.Init();
                                        PmtLines.No := No;
                                        PmtLines."Payment Type" := PmtLines."Payment Type"::Imprest;
                                        PmtLines."Line Type" := PmtLines."Line Type"::"Running Cost";
                                        PmtLines.Description := Facilitators.Description;
                                        PmtLines."Activity Maximum Amount" := Facilitators.Amount;
                                        PmtLines."Account Type" := PmtLines."Account Type"::"G/L Account";
                                        PmtLines."Account No" := "Account No";
                                        PmtLines."Activity Work Programme" := "Activity Work Programme";
                                        PmtLines.Amount := Facilitators.Amount - UsedAmt;
                                        PmtLines."Line No" := LineNo;
                                        PmtLines.Insert();
                                        // PaymentRec.FacilitatorsReq := true;
                                        PaymentRec.Modify();
                                    end;
                                until Facilitators.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(485; "Shortcut Dimension 4 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(486; "Imprest Holder"; Code[20])
        {
        }
        field(487; "Surrender Date"; Date)
        {
        }
        field(488; "Vatable Amount"; Decimal)
        {
        }
        field(489; "Other Charges"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(490; "10% Not Wtheld"; Decimal)
        {
        }
        field(491; "Levied Invoice H"; Boolean)
        {
            CalcFormula = Lookup(Payments."Levied Invoice" WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(492; "Imprest Receipt No."; Code[20])
        {
            Editable = false;
        }
        field(493; Destination; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Destination."Destination Code";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // if "No of Days" <> 0 then
                //     Amount := GetDestinationRate();
                Amount := GetDestinationRate();
            end;
        }
        field(494; "Daily Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(495; "Claim Receipt No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(496; "Expenditure Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(497; "Expenditure Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(498; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // if "Expenditure Type" <> '' then
                //     Validate("Expenditure Type");
                if Destination <> '' then begin
                    "Per Diem" := GetDestinationRate();
                    validate("Per Diem");
                end;
            end;
        }
        field(499; "VAT Exclusive"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(500; "Based On Travel Rates"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(501; "Sort Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(502; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(503; "Imprest No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payments."No." WHERE(Status = FILTER(Released), Posted = CONST(false), "Payment Type" = FILTER(Imprest));

            trigger OnValidate()
            begin
                if PaymentRec.Get("Imprest No.") then begin
                    PaymentLines.Reset;
                    PaymentLines.SetRange(PaymentLines."Imprest No.", "Imprest No.");
                    if PaymentLines.FindFirst then Error('This Imprest is already in PV Number %1', PaymentLines.No);
                    //Get Total Imprest Amount
                    PaymentRec.CalcFields("Imprest Amount", "Total Net Amount");
                    "Account No" := PaymentRec."Account No.";
                    "Account Name" := PaymentRec."Account Name";
                    Amount := PaymentRec."Imprest Amount";
                    Validate(Amount);
                    Description := PaymentRec."Payment Narration";
                end;
            end;
        }
        field(504; "Claim Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General Claim,Medical Claim';
            OptionMembers = "General Claim","Medical Claim";
        }
        field(505; "Imprest Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(506; "Claim Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(507; "Claim No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Payments."No." WHERE(Status = FILTER(Released), Posted = CONST(false), "Payment Type" = FILTER("Staff Claim"));

            trigger OnValidate()
            begin
                if PaymentRec.Get("Claim No.") then begin
                    StaffNo := PaymentRec."Staff No.";
                    AccName := PaymentRec.Payee;
                    PaymentLines.Reset;
                    PaymentLines.SetRange(PaymentLines."Claim No.", "Claim No.");
                    if PaymentLines.FindFirst then Error('This Claim is already in PV Number %1', PaymentLines.No);
                    //Get Claim Details
                    PaymentLines2.Reset;
                    PaymentLines2.SetRange(PaymentLines2.No, "Claim No.");
                    if PaymentLines2.Find('-') then begin
                        //Gets total amount in case of multilined claim
                        PaymentLines2.CalcSums(Amount);
                        "Account No" := PaymentLines2."Account No";
                        //Validate("Account No");
                        Description := PaymentLines2.Description + '_' + StaffNo + '-' + AccName;
                        Amount := PaymentLines2.Amount;
                        Validate(Amount);
                        "Expenditure Date" := PaymentLines2."Expenditure Date";
                        "Expenditure Description" := PaymentLines2."Expenditure Description";
                        "Claim Receipt No." := PaymentLines2."Claim Receipt No.";
                    end;
                end;
            end;
        }
        field(508; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                // IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
                //  TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
                // IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
                //  ERROR(Text006,"Gen. Posting Type");
                // CheckVATInAlloc;
                // IF "Gen. Posting Type" > 0 THEN
                //  VALIDATE("VAT Prod. Posting Group");
                // IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
                //  VALIDATE("Use Tax",FALSE)
            end;
        }
        field(509; Currency; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(510; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (KSH)';
            DataClassification = ToBeClassified;
        }
        field(511; "Applies-to Doc Type"; enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(512; "General Expense Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(513; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No of Days" <> 0 then Validate("No of Days");
                if "End Date" <> 0D then if "End Date" < "Start Date" then Error('End date must be greater than start date');
            end;
        }
        field(514; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Start Date" <> 0D then if "End Date" < "Start Date" then Error('End date must be greater than start date');
                //Get no of days
                if ("End Date" <> 0D) and ("Start Date" <> 0D) then "No of Days" := ("End Date" - "Start Date") + 1;
                Validate("No of Days");
                // if not "Activity Imprest" then
                //     if "No of Days" <> 0 then
                //         Validate("No of Days");
            end;
        }
        field(515; "Distance Covered"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Rate per Kilometer");
            end;
        }
        field(516; "Travel From"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Destination;
        }
        field(517; "Vehicle Reg No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(518; "CC Rating"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(519; Returned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(520; "Vehicle CC"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vehicle CC Setup";

            trigger OnValidate()
            var
                CC: Record "Vehicle CC Setup";
            begin
                if CC.Get("Vehicle CC") then begin
                    "Rate per Kilometer" := CC."Rate per Kilometer";
                    Validate("Rate per Kilometer");
                end;
            end;
        }
        field(521; "Rate per Kilometer"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount := "Rate per Kilometer" * "Distance Covered";
                if Mileage > 0 then begin
                    if Amount > Mileage then begin
                        "Amount To be claimed" := Amount - Mileage;
                        Amount := Mileage;
                    end;
                    Validate(Amount);
                end;
            end;
        }
        field(522; "Activity Work Programme"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Activity Work Programme" where(Status = const(Approved));

            trigger OnValidate()
            var
                BudgetEntry: record "G/L Budget Entry";
                Items: record "Activity Work Programme Lines";
                Participants: record "Activity Work Programme Lines";
                GLSetup: record "General Ledger Setup";
                WorkProgramme: Record "Activity Work Programme";
                PmtLines: Record "Payment Lines";
                Pmts: Record Payments;
                Pmts2: Record Payments;
                UserSetup: Record "User Setup";
                UsedAmt: Decimal;
                ImprestActivityLines: record "Imprest Line Activities";
                StaffNo: Code[20];
                LineNo: Integer;
            begin
                ImprestActivityLines.Reset();
                ImprestActivityLines.SetRange("Imprest No", No);
                ImprestActivityLines.SetRange("Imprest Line No", "Line No");
                if ImprestActivityLines.FindSet() then ImprestActivityLines.DeleteAll();
                if WorkProgramme.get("Activity Work Programme") then;
                WorkProgramme.TestField("Shortcut Dimension 3 Code");
                Description := WorkProgramme.Description;
                if "Payment Type" = "Payment Type"::Imprest then begin
                    Pmts2.Reset();
                    Pmts2.SetRange("No.", No);
                    Pmts2.setrange("Payment Type", Pmts2."Payment Type"::Imprest);
                    if Pmts2.FindFirst() then begin
                        StaffNo := Pmts2."Staff No.";
                        UsedAmt := 0;
                        Pmts.Reset();
                        Pmts.SetFilter("No.", '<>%1', No);
                        Pmts.SetRange("Staff No.", StaffNo);
                        Pmts.SetRange("Payment Type", Pmts."Payment Type"::Imprest);
                        if Pmts.Find('-') then
                            repeat
                                PmtLines.Reset();
                                PmtLines.SetRange(No, Pmts."No.");
                                PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                                PmtLines.SetRange("Line Type", PmtLines."Line Type"::Normal);
                                PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                                if PmtLines.Find('-') then
                                    repeat
                                        UsedAmt += PmtLines.Amount;
                                    until PmtLines.Next() = 0;
                            until Pmts.next = 0;
                        if "Activity Maximum Amount" <= UsedAmt then Error('You have used your allocated amount for workplan %1', "Activity Work Programme");
                        Pmts2."Payment Narration" := WorkProgramme.Description;
                        Pmts2.Modify();
                    end;
                    //ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                    GLSetup.get;
                    GetPaymentHeader();
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Shortcut Dimension 3 Code" := WorkProgramme."Shortcut Dimension 3 Code";
                    if UsedAmt > 0 then begin
                        "Per Diem" := "Activity Maximum Amount" - UsedAmt;
                        Transport := 0;
                        Mileage := 0;
                        Amount := "Per Diem";
                    end;
                end;
                if "Payment Type" = "Payment Type"::"Staff Claim" then begin
                    Pmts2.Reset();
                    Pmts2.SetRange("No.", No);
                    Pmts2.setrange("Payment Type", Pmts2."Payment Type"::"Staff Claim");
                    if Pmts2.FindFirst() then begin
                        StaffNo := Pmts2."Staff No.";
                        UsedAmt := 0;
                        Pmts.Reset();
                        Pmts.SetFilter("No.", '<>%1', No);
                        Pmts.SetRange("Staff No.", StaffNo);
                        Pmts.SetRange("Payment Type", Pmts."Payment Type"::"Staff Claim");
                        if Pmts.Find('-') then
                            repeat
                                PmtLines.Reset();
                                PmtLines.SetRange(No, Pmts."No.");
                                PmtLines.SetFilter("Activity Work Programme", '<>%1', '');
                                PmtLines.SetRange("Line Type", PmtLines."Line Type"::Normal);
                                PmtLines.SetRange("Activity Work Programme", "Activity Work Programme");
                                if PmtLines.Find('-') then
                                    repeat
                                        UsedAmt += PmtLines.Amount;
                                    until PmtLines.Next() = 0;
                            until Pmts.next = 0;
                        Pmts2."Payment Narration" := WorkProgramme.Description;
                        Pmts2.Modify();
                        if "Activity Maximum Amount" <= UsedAmt then Error('You have used your allocated amount for workplan %1', "Activity Work Programme");
                    end;
                    //ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                    GLSetup.get;
                    GetPaymentHeader();
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Shortcut Dimension 3 Code" := WorkProgramme."Shortcut Dimension 3 Code";
                    if UsedAmt > 0 then begin
                        Mileage := "Activity Maximum Amount" - UsedAmt;
                    end;
                end;
                Validate("Shortcut Dimension 3 Code");
            end;
        }
        field(523; "Work Programme Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(524; "Travel Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fare,Mileage';
            OptionMembers = " ",Fare,Mileage;
        }
        field(525; "Activity Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(526; "Activity Imprest"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist(Payments where("No." = field(No)));
        }
        field(527; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnValidate()
            var
                Items: Record Item;
            begin
                Items.reset;
                Items.SetRange("No.", "Item No.");
                if Items.FindFirst() then Description := Items.Description;
            end;
        }
        field(528; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount := "Estimated Unit Cost" * Quantity;
            end;
        }
        field(529; "Estimated Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Amount := "Estimated Unit Cost" * Quantity;
            end;
        }
        field(530; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Item,"Running Cost";
        }
        field(531; Transport; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(532; "Per Diem"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(533; Mileage; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotals();
            end;
        }
        field(534; "Amount To be claimed"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(535; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(536; "Payee Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank Code") then
                    "Payee Bank Code Name" := Banks.Name
                else
                    "Payee Bank Code Name" := '';
                Validate("Payee Swift Code");
                if "Member No." <> '' then validate("Member No.");
            end;
        }
        field(537; "Payee Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code" = FIELD("Payee Bank Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if BankBranchess.Get("Payee Bank Code", "Payee Bank Branch Code") then
                    "Payee Bank Branch Name" := BankBranchess."Branch Name"
                else
                    "Payee Bank Branch Name" := '';
                Validate("Payee Swift Code");
                if "Member No." <> '' then validate("Member No.");
            end;
        }
        field(538; "Payee Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Payee Swift Code");
                if "Member No." <> '' then validate("Member No.");
            end;
        }
        field(539; "Payee Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                Banks: Record banks;
                BankBranches: Record "Bank Branches";
                BanksAcc: record "Bank Account";
                PayModes: record "Payment Method";
                PaymentRec: record payments;
            begin
                if "Payee Swift Code" = '' then begin
                    Banks.Reset();
                    Banks.SetRange(Code, "Payee Bank Code");
                    if Banks.findfirst then begin
                        BankBranches.reset;
                        BankBranches.setrange("Bank Code", "Payee Bank Code");
                        BankBranches.setrange("Branch Code", "Payee Bank Branch Code");
                        if BankBranches.FindFirst() then "Payee Swift Code" := BankBranches."SWIFT Code";
                    end;
                end;
                if "Pay Mode" = '' then begin
                    if PaymentRec.Get(No) then;
                    "POP Code" := PaymentRec."POP Code";
                end;
                BanksAcc.reset;
                BanksAcc.SetRange("No.", PaymentRec."Paying Bank Account");
                if BanksAcc.FindFirst() then begin
                    if BanksAcc."SWIFT Code" = "Payee Swift Code" then begin
                        PayModes.Reset();
                        PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::BT);
                        if PayModes.FindFirst() then "Pay Mode" := PayModes.Code;
                    end
                    else begin
                        PayModes.Reset();
                        PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::ACH);
                        if PayModes.FindFirst() then "Pay Mode" := PayModes.Code;
                    end;
                    //end;
                end;
                BanksAcc.reset;
                BanksAcc.SetRange("No.", PaymentRec."Source Bank");
                if BanksAcc.FindFirst() then begin
                    if BanksAcc."SWIFT Code" = "Payee Swift Code" then begin
                        PayModes.Reset();
                        PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::BT);
                        if PayModes.FindFirst() then "Pay Mode" := PayModes.Code;
                    end
                    else begin
                        PayModes.Reset();
                        PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::ACH);
                        if PayModes.FindFirst() then "Pay Mode" := PayModes.Code;
                    end;
                    //end;
                end;
                if "Account Type" = "Account Type"::Vendor then
                    if Vendor.Get("Account No") then begin
                        if Vendor."Vendor Bank Code" = '' then Vendor.Validate("Vendor Bank Code", "Payee Bank Code");
                        if Vendor."Vendor Bank Branch Code" = '' then Vendor.Validate("Vendor Bank Branch Code", "Payee Bank Branch Code");
                        if Vendor."Vendor Bank Account No" = '' then Vendor."Vendor Bank Account No" := "Payee Bank Account No";
                        if Vendor."Vendor Swift Code" = '' then Vendor."Vendor Swift Code" := "Payee Swift Code";
                    end;
                if Amount > 1000000 then begin
                    PayModes.Reset();
                    PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::RTGS);
                    if PayModes.FindFirst() then "Pay Mode" := PayModes.Code;
                end;
            end;
        }
        field(540; "Payee Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(541; "Payee Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(542; "Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(543; "POP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POP Codes";
        }
        field(9632; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor where("Vendor Type" = filter(Vendor));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Vendor.Get("Member No.") then begin
                    if Vendor."Vendor Bank Code" = '' then Vendor.Validate("Vendor Bank Code", "Payee Bank Code");
                    if Vendor."Vendor Bank Branch Code" = '' then Vendor.Validate("Vendor Bank Branch Code", "Payee Bank Branch Code");
                    if Vendor."Vendor Bank Account No" = '' then Vendor."Vendor Bank Account No" := "Payee Bank Account No";
                    if Vendor."Vendor Swift Code" = '' then Vendor."Vendor Swift Code" := "Payee Swift Code";
                    "Payroll No." := Vendor."Staff No.";
                end;
            end;
        }
        field(9633; Payee; Text[2048])
        {
        }
        field(9634; "Bank Code"; Code[150])
        {
            TableRelation = Banks;
        }
        field(9635; "Bank Branch Code"; Code[50])
        {
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code" = FIELD("Bank Code"));
        }
        field(96365; "Bank Account Number"; Code[20])
        {
        }
        field(96371; "Pay Mode"; Code[20])
        {
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                PayMethod: Record "Payment Method";
                Vendor: Record Vendor;
            begin
                CalcFields("Pay Mode Type");
                case "Pay Mode Type" of // "Pay Mode Type"::EFT, "Pay Mode Type"::RTGS:
                //     begin
                //         if Vendor.Get("Account No.") then begin
                //             Validate("Payee Bank Code", Vendor."Vendor Bank Code");
                //             Validate("Payee Bank Branch Code", Vendor."Vendor Bank Branch Code");
                //             Validate("Payee Bank Account No", Vendor."Vendor Bank Account No");
                //             Validate("Payee Swift Code", Vendor."Vendor Swift Code");
                //         end;
                //     end;
                end;
            end;
        }
        field(96372; "Pay Mode Type"; Enum "Payment Balance Account Type")
        {
            CalcFormula = Lookup("Payment Method"."Bal. Account Type" WHERE(Code = FIELD("Pay Mode")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10000; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,Rejected,,Closed,Archived,Finance Approved';
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Rejected,Closed,Archived,"Finance Approved";
            CalcFormula = Lookup(Payments.Status WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(96373; "Payee Account Name"; Text[200])
        {
        }
        field(96378; "Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(96386; "Bal Account Type"; enum "Gen. Journal Account Type")
        {
            trigger OnValidate()
            var
                Error001: Label 'Payment | Receipt Type %1 has an Acccount Type %2 not similar to the selected Account Type %2';
                ReceiptPayment: Record "Receipts and Payment Types";
            begin
                // if ReceiptPayment.Get("Expenditure Type", "Payment Type") then begin
                //     if ReceiptPayment."Account Type" <> "Account Type" then
                //         Error(Error001, "Expenditure Type", ReceiptPayment."Account Type", "Account Type");
                // end;
                "Bal Account No" := '';
            end;
        }
        field(96382; "G/L Account to Debit"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(96387; "Bal Account No"; Code[20])
        {
            TableRelation = IF ("Bal Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Bal Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Bal Account Type" = CONST(Customer)) Customer
            ELSE IF ("Bal Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Bal Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Bal Account Type" = CONST(Item)) Item;

            trigger OnValidate()
            begin
                if "Payment Type" <> "Payment Type"::"Bank Transfer" then begin
                end;
                GetPaymentHeader;
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No") then;
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                            //Update G/L
                            "G/L Account to Debit" := "Account No";
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No") then;
                            Vendor.TestField("Vendor Bank Code");
                            Vendor.TestField("Vendor Bank Branch Code");
                            Vendor.TestField("Bank Account Name");
                            "Account Name" := Vendor.Name;
                            Payee := Vendor.Name;
                            "Our Account No." := Vendor."Our Account No.";
                            "Sort Code" := Vendor."Sort Code";
                            //insert bank
                            "Payee Account Name" := Vendor."Bank Account Name";
                            Validate("Payee Bank Code", Vendor."Vendor Bank Code");
                            Validate("Payee Bank Branch Code", Vendor."Vendor Bank Branch Code");
                            Validate("Payee Bank Account No", Vendor."Vendor Bank Account No");
                            Validate("Payee Swift Code", Vendor."Vendor Swift Code");
                            VendPostingGrp.Reset();
                            VendPostingGrp.SetRange(Code, Vendor."Vendor Posting Group");
                            IF VendPostingGrp.FindFirst() then "G/L Account to Debit" := VendPostingGrp."Payables Account";
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No");
                            "Account Name" := Customer.Name;
                            payee := Customer.Name;
                            Validate("Payee Bank Code", Customer."Bank Code");
                            Validate("Payee Bank Branch Code", Customer."Bank Branch Code");
                            Validate("Payee Bank Account No", Customer."Bank Account No");
                            Validate("Payee Swift Code");
                            CustPostGrp.Reset();
                            CustPostGrp.SetRange(Code, Customer."Customer Posting Group");
                            If CustPostGrp.FindFirst() then "G/L Account to Debit" := CustPostGrp."Receivables Account";
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No");
                            "Account Name" := Bank.Name;
                            Currency := Bank."Currency Code";
                            if "Account No" = PaymentRec."Source Bank" then Error('Receiving bank cannot be same as Source Bank');
                            //insert bank
                            Bank.TestField("Bank code");
                            Bank.TestField("Bank Branch No.");
                            Bank.TestField("Bank Account No.");
                            Bank.TestField(Name);
                            Validate("Payee Bank Code", Bank."Bank Code");
                            Validate("Payee Bank Branch Code", Bank."Bank Branch No.");
                            Validate("Payee Bank Account No", Bank."Bank Account No.");
                            "Payee Account Name" := Bank."Bank Account Name";
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;
                PaymentRec.Reset;
                PaymentRec.SetRange(PaymentRec."No.", No);
                if PaymentRec.FindFirst then begin
                    "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    Validate("Shortcut Dimension 3 Code");
                    if Description = '' then PaymentLines.Description := PaymentRec."Payment Narration";
                    if Purpose = '' then PaymentLines.Purpose := PaymentLines.Description;
                end;
                Validate(Amount);
            end;
        }
        field(96381; "System Amount"; Decimal)
        {
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            TableRelation = Job;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1020; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Project Planning Line No.';

            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
                JobPlanningLine.SetRange("Job No.", "Job No.");
                JobPlanningLine.SetRange("Job Task No.", "Job Task No.");
                JobPlanningLine.SetRange(Type, JobPlanningLine.Type::"G/L Account");
                // JobPlanningLine.SetRange("No.", "Account No.");
                JobPlanningLine.SetRange("Usage Link", true);
                JobPlanningLine.SetRange("System-Created Entry", false);
                if PAGE.RunModal(0, JobPlanningLine) = ACTION::LookupOK then Validate("Job Planning Line No.", JobPlanningLine."Line No.");
            end;
            // trigger OnValidate()
            // var
            //     JobPlanningLine: Record "Job Planning Line";
            // begin
            //     if "Job Planning Line No." <> 0 then begin
            //         JobPlanningLine.Get("Job No.", "Job Task No.", "Job Planning Line No.");
            //         JobPlanningLine.TestField("Job No.", "Job No.");
            //         JobPlanningLine.TestField("Job Task No.", "Job Task No.");
            //         JobPlanningLine.TestField(Type, JobPlanningLine.Type::"G/L Account");
            //         JobPlanningLine.TestField("No.", "Account No.");
            //         JobPlanningLine.TestField("Usage Link", true);
            //         JobPlanningLine.TestField("System-Created Entry", false);
            //         "Job Line Type" := JobPlanningLine.ConvertToJobLineType();
            //         Validate("Job Remaining Qty.", JobPlanningLine."Remaining Qty." - "Job Quantity");
            //     end else
            //         Validate("Job Remaining Qty.", 0);
            // end;
        }
    }
    keys
    {
        key(Key1; No, "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        //TestField("Expenditure Type");
        //Restrict Claim to 1 line
        // PaymentLines.RESET;
        // PaymentLines.SETRANGE(PaymentLines."Payment Type",PaymentLines."Payment Type"::"Staff Claim");
        // PaymentLines.SETRANGE(PaymentLines.No,No);
        // IF PaymentLines.COUNT >0 THEN
        //  ERROR('You cannot have more than 1 claim line');
        if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
            PaymentRec.Reset();
            PaymentRec.SetRange("No.", No);
            if PaymentRec.FindFirst() then begin
                if PaymentRec."Payment Type" = PaymentRec."Payment Type"::"Imprest Surrender" then begin
                    PmtLines.Reset();
                    PmtLines.SetRange(No, PaymentRec."Imprest Issue Doc. No");
                    if PmtLines.FindFirst() then begin
                        "Shortcut Dimension 3 Code" := PmtLines."Shortcut Dimension 3 Code";
                        "Shortcut Dimension 2 Code" := PmtLines."Shortcut Dimension 2 Code";
                        "Account No" := PmtLines."Account No";
                        "Account Type" := PmtLines."Account Type";
                        Validate("Account No");
                    end;
                end;
            end;
        end;
    end;

    trigger OnDelete()
    var
        Payment: record payments;
    begin
        Payment.setrange("No.", No);
        Payment.SetFilter(status, '<>%1', payment.status::open);
        if Payment.findfirst then begin
            error('you cannot delete an approved/Pending approval line')
        end
    end;

    var
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        Customer: Record Customer;
        Bank: Record "Bank Account";
        Pmts: Record Payments;
        PmtLines: Record "Payment Lines";
        FixedAsset: Record "Fixed Asset";
        RecTypes: Record "Receipts and Payment Types";
        DimMgt: Codeunit DimensionManagement;
        VATAmount: Decimal;
        "W/TAmount": Decimal;
        RetAmount: Decimal;
        NetAmount: Decimal;
        VATSetup: Record "VAT Posting Setup";
        CSetup: Record "Cash Management Setups";
        Direction: Text[30];
        WTVATAmount: Decimal;
        VATSetup2: Record "VAT Posting Setup";
        GLSetup: Record "General Ledger Setup";
        PaymentRec: Record Payments;
        ProcurementPlan: Record "Procurement Plan";
        HasGotGLSetup: Boolean;
        Text000: Label '%1 cannot be blank';
        GLSetupShortcutDimCode: array[8] of Code[20];
        PaymentLines: Record "Payment Lines";
        PaymentLines2: Record "Payment Lines";
        StaffNo: Code[50];
        AccName: Text;
        CurrencyRec: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Banks: Record Banks;
        BankBranchess: Record "Bank Branches";
        PayMethods: Record "Payment Method";
        VendPostingGrp: Record "Vendor Posting Group";
        CustPostGrp: Record "Customer Posting Group";

    procedure UpdateTotals()
    var
        myInt: Integer;
    begin
        Amount := Transport + "Per Diem" + "Mileage";
        Validate(Amount);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        PaymentRec: Record Payments;
    begin
        OldDimSetID := "Dimension Set ID";
        //  DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
            //MODIFY;
            //IF SalesLinesExist THEN
            //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        end;
        //Fetch Output and Ourcome from Budget
        if PaymentRec.Get(No) then;
        if FieldNumber = 5 then begin
            GLSetup.Get;
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-') then begin
                //Global Dimensions
                OldDimSetID := "Dimension Set ID";
                if PaymentRec."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(1, "Shortcut Dimension 1 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(1, PaymentRec."Shortcut Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify;
                    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID := "Dimension Set ID";
                if PaymentRec."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(2, "Shortcut Dimension 2 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(2, PaymentRec."Shortcut Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify;
                    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(3, GLBudget."Budget Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify;
                end;
                //Dim Value 4
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(4, GLBudget."Budget Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify;
                end;
            end;
        end;
        //G/L Account
        if FieldNumber = 6 then begin
            GLSetup.Get;
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 4 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-') then begin
                if "Account Type" <> "Account Type"::"G/L Account" then begin
                    "Account Type" := "Account Type"::"G/L Account";
                    //MODIFY;
                end;
                if "Account No" <> GLBudget."G/L Account No." then begin
                    "Account No" := GLBudget."G/L Account No.";
                    Validate("Account No");
                    //MODIFY;
                end;
            end;
        end;
    end;

    procedure GetCurrency()
    begin
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" := DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Payment Type", No, "Line No"));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        PaymentRec: Record Payments;
    begin
        /*if PaymentRec.Get(No) then;
            if FieldNumber = 5 then
                if PaymentRec."Multi-Donor" then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    if "Dimension Set ID" <> 0 then
                        DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                    else
                        DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

            if FieldNumber = 6 then
                if PaymentRec."Multi-Donor" then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    if "Dimension Set ID" <> 0 then
                        DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                    else
                        DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

            DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
            ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);*/
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ValidateSurrenderLines()
    var
        ShortcutDimCode: array[8] of Code[20];
    begin
        TestField(Purpose);
        //TestField("Shortcut Dimension 1 Code");
        //TestField("Shortcut Dimension 2 Code");
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
        GetGLSetup();
        // IF ShortcutDimCode[5]='' THEN
        //  ERROR(Text000,GLSetupShortcutDimCode[5]);
        // IF ShortcutDimCode[6]='' THEN
        //  ERROR(Text000,GLSetupShortcutDimCode[6]);
    end;

    procedure CheckDocType(): Boolean
    begin
        PaymentRec.Reset;
        PaymentRec.SetRange("Payment Type", "Payment Type");
        PaymentRec.SetRange("No.", No);
        if PaymentRec.Find('-') then begin
            if PaymentRec."Multi-Donor" then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure ImprestLineExist(): Boolean
    var
        ImprestRec: Record Payments;
        ImprestLines: Record "Payment Lines";
    begin
        ImprestRec.Reset;
        ImprestRec.SetRange("Payment Type", ImprestRec."Payment Type"::"Imprest Surrender");
        ImprestRec.SetRange("No.", No);
        if ImprestRec.FindFirst then begin
            ImprestLines.Reset;
            ImprestLines.CalcFields(Status);
            ImprestLines.SetRange(No, ImprestRec."Imprest Issue Doc. No");
            ImprestLines.SetRange("Line No", "Line No");
            if ImprestLines.Find('-') then exit(true);
        end;
    end;

    procedure ImprestLineExist2(): Boolean
    var
        ImprestRec: Record Payments;
        ImprestLines: Record "Payment Lines";
    begin
        ImprestRec.Reset;
        ImprestRec.SetRange("Payment Type", ImprestRec."Payment Type"::"Imprest Surrender");
        ImprestRec.SetRange("No.", No);
        if ImprestRec.FindFirst then begin
            ImprestLines.Reset;
            ImprestLines.CalcFields(Status);
            ImprestLines.SetRange(No, ImprestRec."Imprest Issue Doc. No");
            ImprestLines.SetRange("Line No", "Line No");
            ImprestLines.SetRange(Status, Status::Released);
            if ImprestLines.Find('-') then begin

            end;
        end;
    end;

    procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    procedure InsertPaymentTypes()
    var
        PaymentLines: Record "Payment Lines";
    begin
        PaymentRec.Reset;
        PaymentRec.SetRange(PaymentRec."No.", No);
        if PaymentRec.FindFirst then begin
            case PaymentRec."Payment Type" of
                PaymentRec."Payment Type"::"Bank Transfer":
                    "Payment Type" := "Payment Type"::"Bank Transfer";
                PaymentRec."Payment Type"::Imprest:
                    begin
                        "Payment Type" := "Payment Type"::Imprest;
                        "Account Type" := "Account Type"::"G/L Account";
                        //"No of Days":=GetNoOfDays;
                    end;
                PaymentRec."Payment Type"::"Imprest Surrender":
                    begin
                        "Payment Type" := "Payment Type"::"Imprest Surrender";
                        "Account Type" := "Account Type"::"G/L Account";
                    end;
                PaymentRec."Payment Type"::"Payment Voucher":
                    "Payment Type" := "Payment Type"::"Payment Voucher";
                PaymentRec."Payment Type"::"Petty Cash":
                    begin
                        "Payment Type" := "Payment Type"::"Petty Cash";
                        "Account Type" := "Account Type"::"G/L Account";
                    end;
                PaymentRec."Payment Type"::"Petty Cash Surrender":
                    begin
                        "Payment Type" := "Payment Type"::"Petty Cash Surrender";
                        "Account Type" := "Account Type"::"G/L Account";
                    end;
                PaymentRec."Payment Type"::Receipt:
                    "Payment Type" := "Payment Type"::Receipt;
                PaymentRec."Payment Type"::"Staff Advance":
                    begin
                        "Payment Type" := "Payment Type"::"Staff Advance";
                        "Account Type" := "Account Type"::"G/L Account";
                    end;
                PaymentRec."Payment Type"::"Receipt-Property":
                    "Payment Type" := "Payment Type"::"Receipt-Property";
                PaymentRec."Payment Type"::"Staff Claim":
                    begin
                        "Payment Type" := "Payment Type"::"Staff Claim";
                        "Account Type" := "Account Type"::"G/L Account";
                    end;
                PaymentRec."Payment Type"::"Input Tax":
                    "Payment Type" := "Payment Type"::"Input Tax";
                PaymentRec."Payment Type"::"Service Charge":
                    "Payment Type" := "Payment Type"::"Service Charge";
                PaymentRec."Payment Type"::"Service Charge Surrender":
                    "Payment Type" := "Payment Type"::"Service Charge Surrender";
                PaymentRec."Payment Type"::"Service Charge Claim":
                    "Payment Type" := "Payment Type"::"Service Charge Claim";
            end;
            //Testing Components Within Range Of Said Concepts.
        end;
    end;

    local procedure GetDestinationRate(): Decimal
    var
        TotalAmount: Decimal;
        DestinationSetup: Record Destination;
        DestinationRate: Record "Destination Rate Entry";
        Pmts: Record Payments;
    begin
        if Pmts.get(No) then;
        if Pmts."Claim Type" <> Pmts."Claim Type"::"Mileage Claim" then begin
            DestinationSetup.Reset;
            DestinationSetup.SetRange("Destination Code", Pmts.Destination);
            if DestinationSetup.FindFirst then begin
                DestinationRate.Reset;
                DestinationRate.SetRange("Destination Code", Pmts.Destination);
                DestinationRate.SetRange("Employee Job Group", GetJobGroup);
                DestinationRate.SetRange("Advance Code", "Expenditure Type");
                if DestinationRate.FindFirst then begin
                    "Daily Rate" := DestinationRate."Daily Rate (Amount)";
                    TotalAmount := "Daily Rate" * "No of Days";
                    exit(TotalAmount);
                end
                else
                    Error('The job group rates for destination %1 have not been set up.', Pmts.Destination);
            end
            else
                Error('The destination %1 is not set up.', Pmts.Destination);
        end
        else
            exit(Amount);
    end;

    local procedure GetJobGroup(): Code[50]
    var
        Employee: Record Employee;
    begin
        if PaymentRec.Get(No) then begin
            PaymentRec.TestField("Staff No.");
            Employee.Reset;
            Employee.SetRange("No.", PaymentRec."Staff No.");
            if Employee.FindFirst then exit(Employee."Salary Scale");
        end
    end;

    local procedure GetNoOfDays(): Integer
    begin
        if PaymentRec.Get(No) then exit(PaymentRec."No of Days");
    end;

    procedure GetAppliedDoc(): Code[50]
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedVendorLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        if "Applies-to ID" <> '' then begin
            case "Account Type" of
                "Account Type"::Customer:
                    begin
                        DetailedCustLedgEntry.Reset;
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Customer No.", "Account No");
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Document No.", No);
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Credit Amount", Amount);
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                        if DetailedCustLedgEntry.Find('-') then begin
                            DetailedCustLedgEntry2.Reset;
                            DetailedCustLedgEntry2.SetRange(DetailedCustLedgEntry2."Cust. Ledger Entry No.", DetailedCustLedgEntry."Cust. Ledger Entry No.");
                            if DetailedCustLedgEntry2.Find('-') then exit(DetailedCustLedgEntry2."Document No.");
                        end;
                    end;
                "Account Type"::Vendor:
                    begin
                        DetailedVendorLedgEntry.Reset;
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Vendor No.", "Account No");
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Document No.", No);
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Debit Amount", Amount);
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Entry Type", DetailedVendorLedgEntry."Entry Type"::Application);
                        if DetailedVendorLedgEntry.Find('-') then begin
                            DetailedVendorLedgEntry2.Reset;
                            DetailedVendorLedgEntry2.SetRange(DetailedVendorLedgEntry2."Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                            if DetailedVendorLedgEntry2.Find('-') then exit(DetailedVendorLedgEntry2."Document No.");
                        end;
                    end;
            end;
        end;
    end;

    local procedure GetPaymentHeader()
    begin
        if PaymentRec.Get(No) then;
    end;


}
