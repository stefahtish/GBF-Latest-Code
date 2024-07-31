table 50453 "Receipt Line"
{
    LookupPageID = "Receipts Line";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
            TableRelation = "Receipts Header"."No.";
        }
        field(2; Date; Date)
        {
            CalcFormula = Lookup("Receipts Header".Date WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(3; Type; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code WHERE(Type=FILTER(Receipt), Blocked=CONST(false));

            trigger OnValidate()
            begin
                "Account No.":='';
                "Account Name":='';
                Remarks:='';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                if RecPayTypes.Find('-')then begin
                    "Account Type":=RecPayTypes."Account Type";
                    "Transaction Name":=RecPayTypes.Description;
                    Grouping:=RecPayTypes."Default Grouping";
                    Remarks:=RecPayTypes."Transation Remarks";
                    "Customer Payment On Account":=RecPayTypes."Customer Payment On Account";
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        //IF RecPayTypes."G/l Account No."<>''THEN
                        RecPayTypes.TestField(RecPayTypes."Account No.");
                        "Account No.":=RecPayTypes."Account No.";
                        if "Account No." <> '' then Validate("Account No.");
                    end;
                end;
                //Check if the batch account has been inserted it the "Customer Payment On Account" is true
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                /*
                IF RecPayTypes.FIND('-') THEN
                  BEGIN
                    //check if the receipt type has Customer Payment On Account as True
                      IF RecPayTypes."Customer Payment On Account"=TRUE THEN
                        BEGIN
                          //check if the Receivable Batch Account is entered
                          SRSetup.GET();
                          SRSetup.TESTFIELD(SRSetup."Receivable Batch Account");
                        END;
                
                  END;
                  */
                RHead.Reset;
                RHead.SetRange(RHead."No.", No);
                if RHead.FindFirst then begin
                    Date:=RHead.Date;
                    //RHead.TESTFIELD("Responsibility Center");
                    "Global Dimension 1 Code":=RHead."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=RHead."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=RHead."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=RHead."Shortcut Dimension 4 Code";
                    "Currency Code":=RHead."Currency Code";
                    "Currency Factor":=RHead."Currency Factor";
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            OptionMembers = " ", Cash, Cheque, EFT, "Deposit Slip", "Banker's Cheque", RTGS, Custom3;

            trigger OnValidate()
            begin
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get();
                if "Pay Mode" = "Pay Mode"::"Deposit Slip" then begin
                    "Bank Account":=GenLedgerSetup."Default Bank Deposit Slip A/C";
                end;
            end;
        }
        field(5; "Cheque/Deposit Slip No"; Code[20])
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(6; "Cheque/Deposit Slip Date"; Date)
        {
            trigger OnValidate()
            begin
            /*
                GenLedgerSetup.GET;
                IF CALCDATE(GenLedgerSetup."Cheque Reject Period","Cheque/Deposit Slip Date")<=TODAY THEN
                  BEGIN
                    ERROR('The cheque date is not within the allowed range.');
                  END;
                
                CheckSlipDetails();
                 */
            end;
        }
        field(7; "Cheque/Deposit Slip Type"; Option)
        {
            OptionMembers = " ", " Local", "Up Country";
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No." WHERE("Global Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"));
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
        }
        field(12; "Account Type";Enum "Gen. Journal Account Type")
        {
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Direct Posting"=CONST(true))
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";

            trigger OnValidate()
            begin
                "Account Name":='';
                if "Account Type" in["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner"]then case "Account Type" of "Account Type"::"G/L Account": begin
                        GLAcc.Get("Account No.");
                        "Account Name":=GLAcc.Name;
                        //"Global Dimension 1 Code":=GLAcc."Global Dimension 1 Code";
                        "VAT Bus. Posting Group":=GLAcc."VAT Bus. Posting Group";
                        "VAT Prod. Posting Group":=GLAcc."VAT Prod. Posting Group";
                        "Gen. Posting Type":=GLAcc."Gen. Posting Type";
                        "Gen. Bus. Posting Group":=GLAcc."Gen. Bus. Posting Group";
                        "Gen. Prod. Posting Group":=GLAcc."Gen. Prod. Posting Group";
                        VATSetup.Reset;
                        VATSetup.SetRange(VATSetup."VAT Bus. Posting Group", "VAT Bus. Posting Group");
                        VATSetup.SetRange(VATSetup."VAT Prod. Posting Group", "VAT Prod. Posting Group");
                        if VATSetup.Find('-')then begin
                            "VAT %":=VATSetup."VAT %";
                        end;
                    end;
                    "Account Type"::Customer: begin
                        Cust.Get("Account No.");
                        "Account Name":=Cust.Name;
                        if "Global Dimension 1 Code" = '' then begin
                            "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                        end;
                    end;
                    "Account Type"::Vendor: begin
                        Vend.Get("Account No.");
                        "Account Name":=Vend.Name;
                        if "Global Dimension 1 Code" = '' then begin
                            "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                        end;
                    end;
                    "Account Type"::"Bank Account": begin
                        BankAcc.Get("Account No.");
                        "Account Name":=BankAcc.Name;
                        if "Global Dimension 1 Code" = '' then begin
                            "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                        end;
                    end;
                    "Account Type"::"Fixed Asset": begin
                        FA.Get("Account No.");
                        "Account Name":=FA.Description;
                        "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    end;
                    "Account Type"::"IC Partner": begin
                        ICPartner.Reset;
                        ICPartner.Get("Account No.");
                        "Account Name":=ICPartner.Name;
                    end;
                    end;
            /*
                {Check if the global dimension 1 code has een selected by the user}
                IF ("Global Dimension 1 Code"='') AND ("Account Type"<>"Account Type"::"G/L Account")THEN
                  BEGIN
                    ERROR('Please ensure that the Function code is selected');
                  END;
                */
            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[50])
        {
        }
        field(20; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                if TariffCode.Get("WHT Code")then begin
                    "WHT Amount":=Amount * TariffCode.Percentage / 100;
                    "Net Amount":=Amount - "WHT Amount";
                end
                else
                    "Net Amount":=Amount;
                if TariffCode.Get("VAT Code")then begin
                    "VAT Amount":=Amount * TariffCode.Percentage / 100;
                    "Amount Inc. VAT":="Net Amount" + "VAT Amount";
                end
                else
                begin
                    "Amount Inc. VAT":=Amount - "WHT Amount";
                    "Net Amount":=Amount - "WHT Amount";
                end;
                "Amount Inc. VAT Inc. WHT":="Net Amount" + "WHT Amount" + "VAT Amount";
                NetAmountLCY:="Net Amount";
            end;
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(23; "Branch Code"; Code[20])
        {
        }
        field(24; "Agent Code"; Code[20])
        {
        }
        field(25; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(28; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0: 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0: 15;
            Editable = true;
            MinValue = 0;

            trigger OnValidate()
            begin
            /*IF "Currency Factor"<>0 THEN
                 "NetAmount LCY":="Net Amount"/"Currency Factor"
                 ELSE
                  "NetAmount LCY":="Net Amount";
                  */
            end;
        }
        field(31; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"]then TestField("VAT Bus. Posting Group", '');
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(32; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"]then TestField("VAT Prod. Posting Group", '');
                "VAT %":=0;
                "VAT Calculation Type":="VAT Calculation Type"::"Normal VAT";
                if "Gen. Posting Type" <> 0 then begin
                    if not VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group")then VATPostingSetup.Init;
                    "VAT Calculation Type":=VATPostingSetup."VAT Calculation Type";
                    case "VAT Calculation Type" of "VAT Calculation Type"::"Normal VAT": "VAT %":=VATPostingSetup."VAT %";
                    "VAT Calculation Type"::"Full VAT": case "Gen. Posting Type" of "Gen. Posting Type"::Sale: begin
                            VATPostingSetup.TestField("Sales VAT Account");
                            TestField("Account No.", VATPostingSetup."Sales VAT Account");
                        end;
                        "Gen. Posting Type"::Purchase: begin
                            VATPostingSetup.TestField("Purchase VAT Account");
                            TestField("Account No.", VATPostingSetup."Purchase VAT Account");
                        end;
                        end;
                    end;
                end;
                Validate("VAT %");
            end;
        }
        field(33; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ", Purchase, Sale, Settlement;

            trigger OnValidate()
            begin
                if "Account Type" in["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"]then TestField("Gen. Posting Type", "Gen. Posting Type"::" ");
                if("Gen. Posting Type" = "Gen. Posting Type"::Settlement) and (CurrFieldNo <> 0)then Error(Text001, "Gen. Posting Type");
                if "Gen. Posting Type" > 0 then Validate("VAT Prod. Posting Group");
            end;
        }
        field(34; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"]then TestField("Gen. Bus. Posting Group", '');
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group")then Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(35; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"]then TestField("Gen. Prod. Posting Group", '');
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group")then Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(36; "VAT Calculation Type";Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
        }
        field(37; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(38; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(39; "User ID"; Code[30])
        {
            TableRelation = user;
        }
        field(40; "Apply to"; Code[30])
        {
        }
        field(41; "Apply to ID"; Code[20])
        {
            Editable = true;
        }
        field(42; "Dest Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(43; "Dest Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(44; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(45; "Print No."; Integer)
        {
        }
        field(46; Status; Option)
        {
            OptionMembers = " ", Normal, "Post Dated", Posted;
        }
        field(47; "Deposit Slip Time"; Time)
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(48; "Teller ID"; Code[50])
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(49; "Customer Payment On Account"; Boolean)
        {
        }
        field(50; Select; Boolean)
        {
        }
        field(51; "Batch Posted"; Boolean)
        {
        }
        field(52; "Transaction No."; Code[20])
        {
        }
        field(53; "Cheque/Deposit Slip Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(54; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(55; Confirmed; Boolean)
        {
        }
        field(56; Reconciled; Boolean)
        {
        }
        field(57; "Orig. Cashier"; Code[30])
        {
            CalcFormula = Lookup("Receipts Header".Cashier WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(58; Cancelled; Boolean)
        {
        }
        field(59; "Cancelled By"; Code[30])
        {
        }
        field(60; "Cancelled Date"; Date)
        {
        }
        field(61; "Cancelled Time"; Time)
        {
        }
        field(62; "Post Dated"; Boolean)
        {
        }
        field(63; "Cheque Retrieved"; Boolean)
        {
        }
        field(64; "Register Number"; Integer)
        {
        }
        field(65; "From Entry No"; Integer)
        {
        }
        field(66; "To Entry No"; Integer)
        {
        }
        field(67; "Batch Posted UserID"; Code[50])
        {
        }
        field(68; "BD Register Number"; Integer)
        {
        }
        field(69; "BD From Number"; Integer)
        {
        }
        field(70; "BD To Number"; Integer)
        {
        }
        field(71; "Reversal By"; Code[20])
        {
        }
        field(72; "Reversal Date"; Date)
        {
        }
        field(73; "Reversal Time"; Time)
        {
        }
        field(74; "Reversal Register No."; Integer)
        {
        }
        field(75; "Reversal From Entry No."; Integer)
        {
        }
        field(76; "Reversal To Entry No."; Integer)
        {
        }
        field(77; Reversed; Boolean)
        {
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(85; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund;
        }
        field(86; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                BilToCustNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Receipt Apply",Rec);
                if(Rec."Account Type" <> Rec."Account Type"::Customer) and (Rec."Account Type" <> Rec."Account Type"::Vendor)then Error('You cannot apply to %1', "Account Type");
                //Amount:=0;
                Rec.Validate(Amount);
                BilToCustNo:=Rec."Account No.";
                CustLedgEntry.SetCurrentKey("Customer No.", Open);
                CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                CustLedgEntry.SetRange(Open, true);
                if Rec."Applies-to ID" = '' then Rec."Applies-to ID":=Rec.No;
                if Rec."Applies-to ID" = '' then Error(Text000, Rec.FieldCaption(No), Rec.FieldCaption("Applies-to ID"));
                // ApplyCustEntries.SetReceipts(Rec, CustLedgEntry, Rec.FieldNo("Applies-to ID"));
                ApplyCustEntries.SetRecord(CustLedgEntry);
                ApplyCustEntries.SetTableView(CustLedgEntry);
                ApplyCustEntries.LookupMode(true);
                OK:=ApplyCustEntries.RunModal = ACTION::LookupOK;
                Clear(ApplyCustEntries);
                if not OK then exit;
                CustLedgEntry.Reset;
                CustLedgEntry.SetCurrentKey("Customer No.", Open);
                CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
                if CustLedgEntry.Find('-')then begin
                    Rec."Applies-to Doc. Type":=0;
                    Rec."Applies-to Doc. No.":='';
                end
                else
                    Rec."Applies-to ID":='';
                //Calculate Total Amount
                CustLedgEntry.Reset;
                CustLedgEntry.SetCurrentKey("Customer No.", Open, "Applies-to ID");
                CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.Find('-')then begin
                    CustLedgEntry.CalcSums(CustLedgEntry."Amount to Apply");
                //  Amount:=ABS(CustLedgEntry."Amount to Apply");
                // VALIDATE(Amount);
                end;
            end;
            trigger OnValidate()
            begin
                if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and ("Applies-to Doc. No." <> '')then begin
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                end
                else if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '')then SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    else if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '')then SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            end;
        }
        field(87; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempCustLedgEntry: Record "Cust. Ledger Entry";
            begin
                if("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '')then begin
                    CustLedgEntry.SetCurrentKey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if CustLedgEntry.FindFirst then CustEntrySetApplID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    CustLedgEntry.Reset;
                end;
            end;
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
        field(68000; "Transaction Case"; Option)
        {
            Description = '//CRDNAV';
            OptionCaption = ' ,Loan Disbursement,Principal Repayment,Interest Due,Interest Paid,Loan Penalty,Loan Adjustment,Vat Paid,Vat Due,Admin Fees Due,Admin Fees Paid,Loan Opening,Pre-Term Interest,Lease Repossession';
            OptionMembers = " ", "Loan Disbursement", "Principal Repayment", "Interest Due", "Interest Paid", "Loan Penalty", "Loan Adjustment", "Vat Paid", "Vat Due", "Admin Fees Due", "Admin Fees Paid", "Loan Opening", "Pre-Term Interest", "Lease Repossession";

            trigger OnValidate()
            begin
                if "Transaction Case" = "Transaction Case"::"Loan Disbursement" then Description:='Loan Disbursement';
                if "Transaction Case" = "Transaction Case"::"Principal Repayment" then Description:='Principal Repayment';
                if "Transaction Case" = "Transaction Case"::"Interest Paid" then Description:='Interest Paid';
                if "Transaction Case" = "Transaction Case"::"Vat Paid" then Description:='Vat Paid';
                if "Transaction Case" = "Transaction Case"::"Loan Penalty" then Description:='Loan Penalty';
                if "Transaction Case" = "Transaction Case"::"Admin Fees Paid" then Description:='Admin Fees Paid';
                if "Transaction Case" = "Transaction Case"::"Pre-Term Interest" then Description:='Pre-Term Interest';
                if "Transaction Case" = "Transaction Case"::"Lease Repossession" then Description:='Lease Repossession Fees';
                Validate("Loan No");
            end;
        }
        field(68001; "Loan No"; Code[20])
        {
        /* Description = '//CRDNAV';
             TableRelation = IF ("Account Type" = CONST(Customer));
             trigger OnValidate()
             begin
                 if LoansRec.Get("Loan No") then begin
                     Validate("Loan Product Type", LoansRec."Loan Product Type");
             Validate("Old Loans", LoansRec."Old Loans");

             LoanScheduleRec.Reset;
             LoanScheduleRec.SetRange("Loan No.", "Loan No");
             LoanScheduleRec.SetRange("Repayment Date", "Loan Schedule Date");
             if LoanScheduleRec.Find('-') then begin
                         if "Transaction Case" = "Transaction Case"::"Principal Repayment" then
                             Amount := Round(LoanScheduleRec."Principal Repayment", 0.01, '=')
                         else
                             if "Transaction Case" = "Transaction Case"::"Interest Paid" then
                                 Amount := Round(LoanScheduleRec."Monthly Interest", 0.01, '=');
             Validate(Amount);
                     end;
                 end;
             end;*/
        }
        field(68002; Description; Text[30])
        {
            Description = '//CRDNAV';
        }
        field(68003; "WHT Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code;

            trigger OnValidate()
            var
                // TaxCalc: Codeunit "Tax Calculation";
                CalculationType: Option VAT, "W/Tax", Retention, "Card Commission";
            begin
                /*IF TariffCode.GET("Tariff Code") THEN
                  "Tarrif Percent":=TariffCode.Percentage
                ELSE
                  "Tarrif Percent":=0;
                  IF "Tarrif Percent"<>0 THEN
                   "Tariff Amount":= TaxCalc.CalculateCardCom(Rec,CalculationType::"Card Commission");

                CalculateTax();
               */
                /*
                 IF TariffCode.GET("WHT Code") THEN
                   "Tarrif Percent":=TariffCode.Percentage
                 ELSE
                   "Tarrif Percent":=0;
                   IF "Tarrif Percent"<>0 THEN
                    "WHT Amount":=Amount* "Tarrif Percent"/100;
                     VALIDATE("Net Amount",Amount-"WHT Amount");
               */
                Validate(Amount);
            end;
        }
        field(68004; "WHT Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Net Amount", Amount - "WHT Amount");
            end;
        }
        field(68005; "Tarrif Percent"; Decimal)
        {
        }
        field(68006; "Net Amount"; Decimal)
        {
            trigger OnValidate()
            begin
            /*IF "Currency Factor"<>0 THEN
                 "NetAmount LCY":="Net Amount"/"Currency Factor"
                 ELSE
                   "NetAmount LCY":="Net Amount";
               */
            /*
                IF  RHead.GET(No) THEN BEGIN
                IF RHead."Currency Code"<>'' THEN BEGIN
                ExRateAmount:= CurrExchRate.GetExchangeRate(RHead.Date,RHead."Currency Code");
                NetAmountLCY:= "Net Amount"*ExRateAmount;
                END ELSE
                NetAmountLCY:= "Net Amount";
                END;
                */
            end;
        }
        field(68007; NetAmountLCY; Decimal)
        {
        }
        field(68008; "Management Fees"; Boolean)
        {
        }
        field(68009; "Processing Fees"; Boolean)
        {
        }
        field(68010; "Purchase Option"; Boolean)
        {
        }
        field(68011; "Loan Product Type"; Code[10])
        {
        }
        field(68012; "Old Loans"; Boolean)
        {
            Description = '//CRDNAV';
            Editable = false;
        }
        field(68013; "Fees Code"; Code[20])
        {
            Description = '//CRDNAV';
        }
        field(68014; "Loan Schedule Date"; Date)
        {
            trigger OnValidate()
            begin
                Validate("Loan No");
            end;
        }
        field(68015; Bank; Code[20])
        {
            CalcFormula = Lookup("Receipts Header"."Bank Code" WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(68016; Payee; Text[250])
        {
            CalcFormula = Lookup("Receipts Header"."Received From" WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(68017; "Rent Start Date"; Date)
        {
        }
        field(68018; "Rent End Date"; Date)
        {
        }
        field(68023; "Loan Repayment Code"; Code[20])
        {
        //  TableRelation = "Loan Repayment Schedule"."Repayment Code" WHERE("Loan No." = FIELD("Loan No"));
        }
        field(68024; "Property Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68025; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68026; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68027; "VAT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Codes".Code;

            trigger OnValidate()
            var
                //  TaxCalc: Codeunit "Tax Calculation";
                CalculationType: Option VAT, "W/Tax", Retention, "Card Commission";
            begin
                /*IF TariffCode.GET("Tariff Code") THEN
                  "Tarrif Percent":=TariffCode.Percentage
                ELSE
                  "Tarrif Percent":=0;
                  IF "Tarrif Percent"<>0 THEN
                   "Tariff Amount":= TaxCalc.CalculateCardCom(Rec,CalculationType::"Card Commission");

                CalculateTax();

                IF TariffCode.GET("WHT Code") THEN
                  "Tarrif Percent":=TariffCode.Percentage
                ELSE
                  "Tarrif Percent":=0;
                  IF "Tarrif Percent"<>0 THEN
                   "VAT Amount":=Amount* "Tarrif Percent"/100;
                    VALIDATE("Net Amount",Amount-"WHT Amount");
              */
                Validate(Amount);
            end;
        }
        field(68028; "Amount Inc. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68029; "Amount Inc. VAT Inc. WHT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Line No.", No)
        {
            SumIndexFields = Amount, "Total Amount";
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Posted = true then Error('The transaction has already been posted and therefore cannot be modified.');
    end;
    trigger OnInsert()
    begin
        RHead.Reset;
        RHead.SetRange(RHead."No.", No);
        if RHead.FindFirst then begin
            "Global Dimension 1 Code":=RHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code":=RHead."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code":=RHead."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code":=RHead."Shortcut Dimension 4 Code";
        end;
    end;
    trigger OnModify()
    begin
        RHead.Reset;
        RHead.SetRange(RHead."No.", No);
        if RHead.FindFirst then begin
            if RHead.Posted then Error('The transaction has already been posted and therefore cannot be modified.');
        end;
    /* IF (Posted=TRUE) AND ("Customer Payment On Account"=FALSE)  THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');
         IF (Posted=TRUE) AND ("Customer Payment On Account"=TRUE)  AND ("Batch Posted"=TRUE) THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');*/
    end;
    trigger OnRename()
    begin
        if Posted = true then Error('The transaction has already been posted and therefore cannot be modified.');
    end;
    var GLAcc: Record "G/L Account";
    Cust: Record Customer;
    Vend: Record Vendor;
    FA: Record "Fixed Asset";
    BankAcc: Record "Bank Account";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    GenLedgerSetup: Record "Cash Office Setup";
    RecPayTypes: Record "Receipts and Payment Types";
    VATPostingSetup: Record "VAT Posting Setup";
    Text001: Label 'The %1 option can only be used internally in the system.';
    GenBusPostingGrp: Record "Gen. Business Posting Group";
    GenProdPostingGrp: Record "Gen. Product Posting Group";
    Currency: Record Currency;
    CurrExchRate: Record "Currency Exchange Rate";
    Cust2: Record Customer;
    Vend2: Record Vendor;
    BankAcc2: Record "Bank Account";
    BankAcc3: Record "Bank Account";
    Text002: Label 'LCY';
    VATSetup: Record "VAT Posting Setup";
    RecLine: Record "Receipt Line";
    SRSetup: Record "Sales & Receivables Setup";
    ICPartner: Record "IC Partner";
    RHead: Record "Receipts Header";
    CustLedgEntry: Record "Cust. Ledger Entry";
    CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
    ApplyCustEntries: Page "Apply Customer Entries";
    DimMgt: Codeunit DimensionManagement;
    TariffCode: Record "Tariff Codes";
    // LPT: Record "Loan Product Types";
    //LoansRec: Record Loans;
    //LoanScheduleRec: Record "Loan Repayment Schedule";
    Text1: Label 'amt is %1';
    ExRateAmount: Decimal;
    local procedure SetCurrencyCode(AccType2: Option "G/L Account", Customer, Vendor, "Bank Account"; AccNo2: Code[20]): Boolean begin
        "Currency Code":='';
        if AccNo2 <> '' then case AccType2 of AccType2::Customer: if Cust2.Get(AccNo2)then "Currency Code":=Cust2."Currency Code";
            AccType2::Vendor: if Vend2.Get(AccNo2)then "Currency Code":=Vend2."Currency Code";
            AccType2::"Bank Account": if BankAcc2.Get(AccNo2)then "Currency Code":=BankAcc2."Currency Code";
            end;
        exit("Currency Code" <> '');
    end;
    local procedure GetCurrency()
    begin
    end;
    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]begin
        if CurrencyCode <> '' then exit(CurrencyCode)
        else
            exit(Text002);
    end;
    procedure CheckSlipDetails()
    var
        IsExistent: Boolean;
    begin
        //this function checks the details on the deposit slip to ensure no double presentation of slips
        //the checks will be the slip date,slip no,slip time and teller and the account
        IsExistent:=false;
        case "Pay Mode" of "Pay Mode"::"Deposit Slip", "Pay Mode"::Cheque: begin
            //reset the variable for holding the records
            RecLine.Reset;
            //RecLine.SETRANGE(RecLine."Account Type","Account Type");
            //RecLine.SETRANGE(RecLine."Account No.","Account No.");
            RecLine.SetRange(RecLine."Pay Mode", "Pay Mode");
            RecLine.SetRange(RecLine."Cheque/Deposit Slip Type", "Cheque/Deposit Slip Type");
            RecLine.SetRange(RecLine."Cheque/Deposit Slip No", "Cheque/Deposit Slip No");
            RecLine.SetRange(RecLine."Cheque/Deposit Slip Date", "Cheque/Deposit Slip Date");
            RecLine.SetRange(RecLine."Deposit Slip Time", "Deposit Slip Time");
            RecLine.SetRange(RecLine."Teller ID", "Teller ID");
            //check if there is a record with the same details
            if RecLine.Find('-')then begin
                repeat if(RecLine."Line No." <> "Line No.")then begin
                        IsExistent:=true;
                    end;
                until RecLine.Next = 0;
            end;
        end;
        end;
        //ask for user confirmation is the IsExistent
        if IsExistent then begin
            if Confirm('Bank Deposit Slip(s) with the same details exist. Continue?', false) = false then begin
                Error('Operation Cancelled by User Interrupt');
            end;
        end;
    end;
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; CustomerNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetCurrentKey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliesToDocNo);
        CustLedgEntry.SetRange("Customer No.", CustomerNo);
        CustLedgEntry.SetRange(Open, true);
        if CustLedgEntry.FindFirst then begin
            if CustLedgEntry."Amount to Apply" = 0 then begin
                CustLedgEntry.CalcFields("Remaining Amount");
                CustLedgEntry."Amount to Apply":=CustLedgEntry."Remaining Amount";
            end
            else
                CustLedgEntry."Amount to Apply":=0;
            CustLedgEntry."Accepted Payment Tolerance":=0;
            CustLedgEntry."Accepted Pmt. Disc. Tolerance":=false;
            CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry);
        end;
    end;
    procedure ShowDimensions()
    begin
    /* "Dimension Set ID" :=
           DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Receipt', "Line No."));
         //VerifyItemLineDim;
         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
         */
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
    procedure CalculateTax()
    var
        CalculationType: Option VAT, "W/Tax", Retention, "Card Commission";
        //TaxCalc: Codeunit "Tax Calculation";
        TotalTax: Decimal;
    begin
        "WHT Amount":=0;
        TotalTax:=0;
        if "Tarrif Percent" <> 0 then begin
            // "WHT Amount" := TaxCalc.CalculateCardCom(Rec, CalculationType::"Card Commission");
            TotalTax:=TotalTax + "WHT Amount" end;
        "Net Amount":=Amount - TotalTax;
        Validate("Net Amount");
    end;
}
