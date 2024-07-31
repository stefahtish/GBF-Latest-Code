table 50454 "Payment Line"
{
    DrillDownPageID = "Payment Lines List";
    LookupPageID = "Payment Lines List";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
            /*
                IF No <> xRec.No THEN BEGIN
                  GenLedgerSetup.GET;
                  IF "Payment Type"="Payment Type"::Normal THEN BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Normal Payments No");
                  END
                  ELSE BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Petty Cash Payments No");
                  END;
                  "No. Series" := '';
                END;
                */
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; Type; Code[20])
        {
            NotBlank = true;
            TableRelation = "Receipts and Payment Types".Code WHERE(Type=FILTER(Payment), Blocked=CONST(false));

            trigger OnValidate()
            var
                TarrifCode: Record "Tariff Codes";
            begin
                "Account No.":='';
                "Account Name":='';
                Remarks:='';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);
                if RecPayTypes.Find('-')then begin
                    Grouping:=RecPayTypes."Default Grouping";
                    "Require Surrender":=RecPayTypes."Pending Voucher";
                    "Payment Reference":=RecPayTypes."Payment Reference";
                    "Budgetary Control A/C":=RecPayTypes."Direct Expense";
                    if RecPayTypes."VAT Chargeable" = RecPayTypes."VAT Chargeable"::Yes then begin
                        "VAT Code":=RecPayTypes."VAT Code";
                        if TarrifCode.Get("VAT Code")then "VAT Rate":=TarrifCode.Percentage;
                    end;
                    if RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."Withholding Tax Chargeable"::Yes then begin
                        "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                        if TarrifCode.Get("Withholding Tax Code")then "W/Tax Rate":=TarrifCode.Percentage;
                    end;
                    if RecPayTypes."Calculate Retention" = RecPayTypes."Calculate Retention"::Yes then begin
                        "Retention Code":=RecPayTypes."Retention Code";
                        if TarrifCode.Get("Retention Code")then "Retention Rate":=TarrifCode.Percentage;
                    end;
                end;
                if RecPayTypes.Find('-')then begin
                    "Account Type":=RecPayTypes."Account Type";
                    Validate("Account Type");
                    "Budgetary Control A/C":=RecPayTypes."Direct Expense";
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        if RecPayTypes."Account No." <> '' then RecPayTypes.TestField(RecPayTypes."Account No.");
                        "Account No.":=RecPayTypes."Account No.";
                        Validate("Account No.");
                    end;
                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"Bank Account" then begin
                        "Account No.":=RecPayTypes."Account No.";
                        Validate("Account No.");
                    end;
                end;
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    Date:=PHead.Date;
                    //PHead.TestField("Responsibility Center");
                    "Global Dimension 1 Code":=PHead."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=PHead."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=PHead."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=PHead."Shortcut Dimension 4 Code";
                    "Currency Code":=PHead."Currency Code";
                    "Currency Factor":=PHead."Currency Factor";
                    "Payment Type":=PHead."Payment Type";
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            Caption = 'Mode de paiement';
            OptionMembers = " ", Cash, Cheque, EFT, "Custom 2", "Custom 3", "Custom 4", "Custom 5";
        }
        field(5; "Media Ref No"; Code[20])
        {
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; "Cheque Type"; Code[20])
        {
        //TableRelation = "External Account";
        }
        field(8; "Payee Bank"; Code[25])
        {
            Caption = 'banque du beneficiaire';
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank")then "Payee Sort Code":=Banks."Sort Code";
            end;
        }
        field(9; "Received From"; Text[100])
        {
            Caption = 'Reçu de';
        }
        field(10; "Payment Notification Message"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
            Caption = 'caissier';
        }
        field(12; "Account Type";Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';

            trigger OnValidate()
            var
                PayLines: Record "Payment Line";
            begin
            /* IF PH.GET(No) THEN
                 IF (PH."Intercompany Transaction"=TRUE) AND ("Account Type"="Account Type"::Vendor)  THEN
                 ERROR(Text001); */
            /* PayLines.RESET;
                PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Vendor);
                PayLines.SETRANGE(PayLines.No,No);
                IF PayLines.FIND('-') THEN
                   ERROR('There is already another existing Payment to a Vendor in this document');

                PayLines.RESET;
                PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Customer);
                PayLines.SETRANGE(PayLines.No,No);
                IF PayLines.FIND('-') THEN
                   ERROR('There is already another existing Payment to a Customer in this document');

                IF ("Account Type"= "Account Type"::Vendor) OR  ("Account Type"= "Account Type"::Customer) THEN  BEGIN
                   IF PayLinesExist THEN
                   ERROR('There is already another existing Line for this document');
                END;
                                          */
            end;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Direct Posting"=CONST(true))
            ELSE IF("Account Type"=CONST(Customer))Customer WHERE("Customer Posting Group"=FIELD(Grouping))
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account" WHERE("Bank Acc. Posting Group"=FIELD(Grouping))
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";

            trigger OnValidate()
            var
                Text0001: Label 'The Account number CANNOT be the same as the Paying Bank Account No.';
            begin
                PH.Reset;
                PH.Get(No);
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);
                if "Account Type" in["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner", "Account Type"::"Bank Account"]then Payee:='';
                case "Account Type" of "Account Type"::"G/L Account": begin
                    if "Account No." <> '' then GLAcc.Get("Account No.");
                    "Account Name":=GLAcc.Name;
                    "Gen. Posting Type":=GLAcc."Gen. Posting Type";
                    PH.TestField("Global Dimension 1 Code");
                    PH.TestField("Shortcut Dimension 2 Code");
                end;
                "Account Type"::Customer: begin
                    Cust.Get("Account No.");
                    "Account Name":=Cust.Name;
                    Payee:=Cust.Name;
                    "Payee Email":=Cust."E-Mail";
                    //
                    //        IF CustomerBankAccount.GET("Account No.",Cust."Preferred Bank Account") THEN BEGIN
                    //        "Payee Sort Code":=CustomerBankAccount."Sort Code";
                    //         "Payee Bank":= CustomerBankAccount.Code;
                    //        "Payee Account No":=CustomerBankAccount."Bank Account No.";
                    //        END;
                    if "Global Dimension 1 Code" = '' then begin
                        "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    end;
                end;
                "Account Type"::Vendor: begin
                    if Vend.Get("Account No.")then begin
                        "Account Name":=Vend.Name;
                        Payee:=Vend.Name;
                        "Payee Email":=Vend."E-Mail";
                        //get bank account
                        //        IF VendBankAcc.GET("Account No.",Vend."Preferred Bank Account") THEN BEGIN
                        //        "Payee Sort Code":=VendBankAcc."Sort Code";
                        //           "Payee Bank":= VendBankAcc.Code;
                        //        "Payee Account No":=VendBankAcc."Bank Account No.";
                        //END;
                        //"Vendor Type" := Vend."Vendor Type";
                        if "Global Dimension 1 Code" = '' then begin
                            "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                        end;
                        if PH.Payee = '' then begin
                            PH.Payee:="Account Name";
                            PH.Modify;
                        end;
                    /* IF PH."Payment Notification Message"=''THEN
                                   BEGIN
                                     PH."Payment Notification Message":="Account Name";
                                     PH.MODIFY;
                                   END;*/
                    end;
                end;
                "Account Type"::"Bank Account": begin
                    if BankAcc.Get("Account No.")then "Account Name":=BankAcc.Name;
                    Payee:=BankAcc.Name;
                    //TECHPRO
                    /*PH.TESTFIELD("Paying Bank Account");
                            IF PH."Paying Bank Account" = "Account No." THEN
                               ERROR(Text0001);*/
                    if "Global Dimension 1 Code" = '' then begin
                        "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                    end;
                end;
                "Account Type"::"IC Partner": begin
                    ICPartner.Reset;
                    ICPartner.Get("Account No.");
                    "Account Name":=ICPartner.Name;
                    Payee:=ICPartner.Name;
                end;
                end;
                //Set the application to Invoice if Account type is vendor
                if "Account Type" = "Account Type"::Vendor then "Applies-to Doc. Type":="Applies-to Doc. Type"::Invoice;
                //insert cheque or EFT Batch No
                if PHead.Get(No)then begin
                    "Paying Bank Account":=PH."Paying Bank Account";
                    PaymentHeaderDate:=PH.Date;
                    "Paying Bank Acc No":=PH."Paying Bank Acc No";
                    Validate("Currency Code", PH."Currency Code");
                    if PHead."Pay Mode" = PHead."Pay Mode"::Cheque then "Media Ref No":=PHead."Cheque No."
                    else if PHead."Pay Mode" = PHead."Pay Mode"::"Electronic Funds Transfer" then "Media Ref No":=PHead."EFT Batch No.";
                end;
                //budget control
                CompName:=CompanyName;
                PH.SetRange(PH."No.", No);
                if PH.FindFirst then begin
                    if CompName = 'GEN INS BUS' then begin
                        FirstDay2:=CalcDate('-CM', PH.Date);
                        LastDay2:=CalcDate('CM', PH.Date);
                        BCSU.Get;
                        //get budget and actual amount for the month per expense
                        GLBudgetEntry.SetRange("Budget Name", BCSU."Current Budget Code");
                        GLBudgetEntry.SetRange("G/L Account No.", "Account No.");
                        GLBudgetEntry.SetRange(Date, FirstDay2, LastDay2);
                        if GLBudgetEntry.FindFirst then begin
                            "Expense Budget in Month":=GLBudgetEntry.Amount;
                        end;
                        GLEntry.SetRange("G/L Account No.", "Account No.");
                        GLEntry.SetRange("Posting Date", FirstDay2, LastDay2);
                        if GLEntry.FindFirst then repeat "Expense Actual in Month"+=GLEntry.Amount;
                            until GLEntry.Next = 0;
                        //get budget and actual from year till date
                        FirstDayOfTheYear:=CalcDate('-CY', PH.Date);
                        GLBudgetEntry.Reset;
                        GLBudgetEntry.SetRange("Budget Name", BCSU."Current Budget Code");
                        GLBudgetEntry.SetRange("G/L Account No.", "Account No.");
                        GLBudgetEntry.SetRange(Date, FirstDayOfTheYear, PH.Date);
                        if GLBudgetEntry.FindFirst then repeat "Expense Budget till Date"+=GLBudgetEntry.Amount;
                            until GLBudgetEntry.Next = 0;
                        GLEntry.Reset;
                        GLEntry.SetRange("G/L Account No.", "Account No.");
                        GLEntry.SetRange("Posting Date", FirstDayOfTheYear, PH.Date);
                        if GLEntry.FindFirst then repeat "Expense Actual till Date"+=GLEntry.Amount;
                            until GLEntry.Next = 0;
                        //Calculate Variance
                        "Monthly Variance":="Expense Actual in Month" - "Expense Budget in Month";
                        "Year To Date Variance":="Expense Actual till Date" - "Expense Budget till Date";
                    end;
                end;
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
            Caption = 'Nom du compte';
        }
        field(16; Posted; Boolean)
        {
            Caption = 'Publié';
            FieldClass = Normal;
        }
        field(17; "Date Posted"; Date)
        {
            Caption = 'date de publication';
        }
        field(18; "Time Posted"; Time)
        {
            Caption = 'Heure de publication';
        }
        field(19; "Posted By"; Code[50])
        {
            Caption = 'Posté par';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Montant';

            trigger OnValidate()
            begin
                //Convert Amount
                if "Currency Code" = '' then "Amount LCY":=Amount
                else
                    Validate("Amount LCY", Round(CurrExchRate.ExchangeAmtFCYToLCY(PH.Date, "Currency Code", Amount, "Currency Factor")));
                Validate("Amount LCY");
                //CalculateTax();
                if "Withholding Tax Code" <> '' then begin
                    if TariffCode.Get("Withholding Tax Code")then "W/Tax Rate":=TariffCode.Percentage
                    else
                        "W/Tax Rate":=0;
                    if("W/Tax Rate" <> 0) and (Amount <> 0)then begin
                        Denominator:=100 + "W/Tax Rate";
                        "WHT Amount":="W/Tax Rate" / Denominator * Amount;
                    end;
                    //Convert Amount
                    if "Currency Code" = '' then "Withholding Tax Amount LCY":="WHT Amount"
                    else
                        "Withholding Tax Amount LCY":=Round(CurrExchRate.ExchangeAmtFCYToLCY(PH.Date, "Currency Code", "WHT Amount", "Currency Factor"));
                end;
                "Net Amount":=Amount - "WHT Amount";
                Validate("Net Amount");
                "NetAmount LCY":="Amount LCY" - "Withholding Tax Amount LCY";
                Validate("NetAmount LCY");
                Validate("Withholding Tax Amount LCY");
            end;
        }
        field(21; Remarks; Text[250])
        {
            Caption = 'Remarques';
        }
        field(22; Narration; Text[100])
        {
        }
        field(23; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code WHERE(Type=CONST(VAT));

            trigger OnValidate()
            begin
                if TariffCode.Get("VAT Code")then "VAT Rate":=TariffCode.Percentage
                else
                    "VAT Rate":=0;
                CalculateTax();
            end;
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            Caption = 'Code de retenue à la source';
            TableRelation = "Tariff Codes".Code WHERE(Type=FILTER("W/Tax"|Others));

            trigger OnValidate()
            var
                ///TaxCalc: Codeunit "Tax Calculation";
                CalculationType: Option VAT, "W/Tax", Retention;
            begin
                if "Withholding Tax Code" = '' then begin
                    "WHT Amount":=0;
                    "Withholding Tax Amount LCY":=0;
                end;
                if TariffCode.Get("Withholding Tax Code")then "W/Tax Rate":=TariffCode.Percentage
                else
                    "W/Tax Rate":=0;
                if("W/Tax Rate" <> 0) and (Amount <> 0)then begin
                    Denominator:=100 + "W/Tax Rate";
                    // "WHT Amount":="W/Tax Rate"/Denominator *Amount;
                    "WHT Amount":=Round(("W/Tax Rate" / 100) * Amount);
                    Validate("WHT Amount");
                    //Convert Amount
                    if "Currency Code" = '' then "Withholding Tax Amount LCY":="WHT Amount"
                    else
                        "Withholding Tax Amount LCY":=Round(CurrExchRate.ExchangeAmtFCYToLCY(PH.Date, "Currency Code", "WHT Amount", "Currency Factor"));
                end;
                Validate("Withholding Tax Amount LCY");
                "Net Amount":=Amount - "WHT Amount";
                Validate("Net Amount");
                "NetAmount LCY":="Amount LCY" - "Withholding Tax Amount LCY";
                Validate("NetAmount LCY");
                Validate("Withholding Tax Amount LCY");
            end;
        }
        field(25; "VAT Amount LCY"; Decimal)
        {
            Caption = 'TVA Montant Local';
        }
        field(26; "Withholding Tax Amount LCY"; Decimal)
        {
            Caption = 'Retenue d''impôt à la source Local';

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if(PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
                end;
            end;
            trigger OnValidate()
            begin
                "NetAmount LCY":="Amount LCY" - ("Withholding Tax Amount LCY");
                if "Currency Code" = '' then "Net Amount":=Amount - ("Withholding Tax Amount LCY");
                Validate("NetAmount LCY");
            end;
        }
        field(27; "Net Amount"; Decimal)
        {
            Caption = 'Montant net';

            trigger OnValidate()
            begin
                if PH.Get(No)then begin
                    //Convert Amount
                    if PH."Currency Code" = '' then "NetAmount LCY":=Amount
                    else
                        "NetAmount LCY":=Round(CurrExchRate.ExchangeAmtFCYToLCY(PH.Date, "Currency Code", "Net Amount", "Currency Factor"));
                end;
            end;
        }
        field(28; "Paying Bank Account"; Code[25])
        {
            Caption = 'compte bancaire payant';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if BankAcc.Get("Paying Bank Account")then begin
                    "Bank Sort Code":=BankAcc."Sort Code";
                    "Paying Bank Acc No":=BankAcc."Bank Account No.";
                end;
            end;
        }
        field(29; Payee; Text[100])
        {
            Caption = 'Bénéficiaire';
            Editable = true;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-')then "Function Name":=DimVal.Name;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Branch Code"; Code[20])
        {
            Caption = 'Code d''agence ';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Branch Code");
                if DimVal.Find('-')then "Budget Center Name":=DimVal.Name;
                ValidateShortcutDimCode(2, "Branch Code");
            end;
        }
        field(32; "PO/INV No"; Code[20])
        {
        }
        field(33; "Bank Sort Code"; Code[20])
        {
            Caption = 'IBAN';
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
        }
        field(35; Status; Option)
        {
            Caption = 'Statut';
            OptionMembers = Pending, "1st Approval", "2nd Approval", "Cheque Printing", Posted, Cancelled, Checking, VoteBook;
        }
        field(36; Select; Boolean)
        {
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = "Vendor Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            Caption = 'Type de paiement';
            OptionMembers = Normal, "Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            OptionMembers = Normal, "Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            OptionMembers = Normal, Other;
        }
        field(41; "Apply to"; Code[20])
        {
            Caption = 'Postuler à';
            TableRelation = "Vendor Ledger Entry"."Vendor No." WHERE("Vendor No."=FIELD("Account No."));
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(43; "No of Units"; Decimal)
        {
        }
        field(44; "Surrender Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "Surrender Doc. No"; Code[20])
        {
        }
        field(47; "Vote Book"; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
            /*
                          IF Amount<=0 THEN
                        ERROR('Please enter the Amount');
                
                       //Confirm the Amount to be issued doesnot exceed the budget and amount Committed
                        EVALUATE(CurrMonth,FORMAT(DATE2DMY(Date,2)));
                        EVALUATE(CurrYR,FORMAT(DATE2DMY(Date,3)));
                        EVALUATE(BudgetDate,FORMAT('01'+'/'+CurrMonth+'/'+CurrYR));
                
                          //Get the last day of the month
                
                          LastDay:=CALCDATE('1M', BudgetDate);
                          LastDay:=CALCDATE('-1D',LastDay);
                
                
                        //Get Budget for the G/L
                      IF GenLedSetup.GET THEN BEGIN
                        GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
                        GLAccount.SETRANGE(GLAccount."No.","Vote Book");
                        GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                        {Get the exact Monthly Budget}
                        //Start from first date of the budget.//BudgetDate
                        GLAccount.SETRANGE(GLAccount."Date Filter",GenLedSetup."Current Budget Start Date",LastDay);
                
                        IF GLAccount.FIND('-') THEN BEGIN
                         GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                         MonthBudget:=GLAccount."Budgeted Amount";
                         Expenses:=GLAccount."Net Change";
                         BudgetAvailable:=GLAccount."Budgeted Amount"-GLAccount."Net Change";
                         "Total Allocation":=MonthBudget;
                         "Total Expenditure":=Expenses;
                         END;
                
                
                     END;
                
                     CommitmentEntries.RESET;
                     CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
                     CommitmentEntries.SETRANGE(CommitmentEntries.Account,"Vote Book");
                     CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date",GenLedSetup."Current Budget Start Date",LastDay);
                     CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                     CommittedAmount:=CommitmentEntries."Committed Amount";
                
                     "Total Commitments":=CommittedAmount;
                     Balance:=BudgetAvailable-CommittedAmount;
                     "Balance Less this Entry":=BudgetAvailable-CommittedAmount-Amount;
                     MODIFY;
                     {
                     IF CommittedAmount+Amount>BudgetAvailable THEN
                        ERROR('%1,%2,%3,%4','You have Exceeded Budget for G/L Account No',"Vote Book",'by',
                        ABS(BudgetAvailable-(CommittedAmount+Amount)));
                      }
                     //End of Confirming whether Budget Allows Posting
                */
            end;
        }
        field(48; "Total Allocation"; Decimal)
        {
        }
        field(49; "Total Expenditure"; Decimal)
        {
        }
        field(50; "Total Commitments"; Decimal)
        {
        }
        field(51; Balance; Decimal)
        {
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
        }
        field(53; "Applicant Designation"; Text[100])
        {
        }
        field(54; "Petty Cash"; Boolean)
        {
        }
        field(55; "Supplier Invoice No."; Code[30])
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard));
        }
        field(57; "Imprest Request No"; Code[20])
        {
            //  TableRelation = "Payments-Users" WHERE(Posted = CONST(false));
            trigger OnValidate()
            begin
            /*
                          TotAmt:=0;
                     //On Delete/Change of Request No. then Clear from Imprest Details
                     IF ("Imprest Request No"='') OR ("Imprest Request No"<>xRec."Imprest Request No") THEN
                        LoadImprestDetails.RESET;
                        LoadImprestDetails.SETRANGE(LoadImprestDetails.No,No);
                        IF LoadImprestDetails.FIND('-') THEN BEGIN
                           LoadImprestDetails.DELETEALL;
                           Amount:=TotAmt;
                           "Net Amount":=Amount;
                           MODIFY;
                
                        END;
                     //New Imprest Details
                     ImprestReqDet.RESET;
                     ImprestReqDet.SETRANGE(ImprestReqDet.No,"Imprest Request No");
                     IF ImprestReqDet.FIND('-') THEN BEGIN
                     REPEAT
                         LoadImprestDetails.INIT;
                         LoadImprestDetails.No:=No;
                         LoadImprestDetails.Date:=ImprestReqDet."Account No:";
                         LoadImprestDetails.Type:=ImprestReqDet."Account Name";
                         LoadImprestDetails."Pay Mode":=ImprestReqDet.Amount;
                         LoadImprestDetails."Cheque No":=ImprestReqDet."Due Date";
                         LoadImprestDetails."Cheque Date":=ImprestReqDet."Imprest Holder";
                         LoadImprestDetails.INSERT;
                         TotAmt:=TotAmt+ImprestReqDet.Amount;
                     UNTIL ImprestReqDet.NEXT=0;
                         Amount:=TotAmt;
                         "Account No.":=ImprestReqDet."Imprest Holder";
                         "Net Amount":=Amount;
                         MODIFY;
                     END;
                {
                       //ImprestDetForm.GETRECORD(LoadImprestDetails);
                }
                      */
            end;
        }
        field(58; "Batched Imprest Tot"; Decimal)
        {
            FieldClass = Normal;
        }
        field(59; "Function Name"; Text[100])
        {
        }
        field(60; "Budget Center Name"; Text[100])
        {
        }
        field(61; "Farmer Purchase No"; Code[20])
        {
        }
        field(62; "Transporter Ananlysis No"; Code[20])
        {
        }
        field(63; "User ID"; Code[20])
        {
            TableRelation = user;
        }
        field(64; "Journal Template"; Code[20])
        {
        }
        field(65; "Journal Batch"; Code[20])
        {
        }
        field(66; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(67; "Require Surrender"; Boolean)
        {
            Editable = false;
        }
        field(68; "Commited Ammount"; Decimal)
        {
            FieldClass = FlowFilter;
        //  TableRelation = Table50019.Field4;
        }
        field(69; "Select to Surrender"; Boolean)
        {
        }
        field(71; "Payment Reference"; Option)
        {
            OptionMembers = Normal, "Farmer Purchase";
        }
        field(72; "ID Number"; Code[8])
        {
        }
        field(73; "VAT Rate"; Decimal)
        {
            trigger OnValidate()
            begin
            /*"VAT Amount":=(Amount * 100);
                "VAT Amount":=Amount-("VAT Amount"/(100 + "VAT Rate"));*/
            end;
        }
        field(74; "Amount With VAT"; Decimal)
        {
            Caption = 'Montant avec TVA';
        }
        field(75; "Currency Code"; Code[20])
        {
            Caption = 'Code de devise';
        }
        field(76; "Exchange Rate"; Decimal)
        {
            Caption = 'Taux de change';
        }
        field(77; "Currency Reciprical"; Decimal)
        {
        }
        field(78; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"VAT Product Posting Group".Code;
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-')then "Budget Center Name":=DimVal.Name end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-')then "Budget Center Name":=DimVal.Name end;
        }
        field(83; Committed; Boolean)
        {
        }
        field(84; "Currency Factor"; Decimal)
        {
            Caption = 'Facteur de devise';
        }
        field(85; "NetAmount LCY"; Decimal)
        {
            Caption = 'montant total local';
        }
        field(86; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund;

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if(PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
                end;
            end;
            trigger OnValidate()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if(PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
                end;
            end;
        }
        field(87; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);
                /*PHead.RESET;
                PHead.SETRANGE(PHead."No.",No);
                 IF PHead.FINDFIRST THEN BEGIN
                    IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
                     (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
                       ERROR('You Cannot modify documents that are approved/posted/Sent for Approval');
                 END;*/
                if(Rec."Account Type" <> Rec."Account Type"::Customer) and (Rec."Account Type" <> Rec."Account Type"::Vendor)then Error('You cannot apply to %1', "Account Type");
                //Amount:=0;
                Rec.Validate(Amount);
                PayToVendorNo:=Rec."Account No.";
                VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                if Rec."Applies-to ID" = '' then Rec."Applies-to ID":=Rec.No;
                if Rec."Applies-to ID" = '' then Error(Text000, Rec.FieldCaption(No), Rec.FieldCaption("Applies-to ID"));
                //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                //ApplyVendEntries.SetPVLine(Rec,VendLedgEntry,Rec.FIELDNO("Applies-to ID"));
                ApplyVendEntries.SetRecord(VendLedgEntry);
                ApplyVendEntries.SetTableView(VendLedgEntry);
                ApplyVendEntries.LookupMode(true);
                OK:=ApplyVendEntries.RunModal = ACTION::LookupOK;
                Clear(ApplyVendEntries);
                if not OK then exit;
                VendLedgEntry.Reset;
                VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
                if VendLedgEntry.Find('-')then begin
                    Rec."Applies-to Doc. Type":=0;
                    Rec."Applies-to Doc. No.":='';
                end
                else
                    Rec."Applies-to ID":='';
                //Calculate  Total To Apply
                VendLedgEntry.Reset;
                VendLedgEntry.SetCurrentKey("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.Find('-')then begin
                    VendLedgEntry.CalcSums("Amount to Apply");
                    Amount:=Abs(VendLedgEntry."Amount to Apply");
                    Validate(Amount);
                    if Amount <> 0 then DocumentApplied:=true
                    else
                        DocumentApplied:=false;
                end;
            end;
            trigger OnValidate()
            begin
                //IF "Applies-to Doc. No." <> '' THEN
                //TESTFIELD("Bal. Account No.",'');
                if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and ("Applies-to Doc. No." <> '')then begin
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                end
                else if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '')then SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    else if("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '')then SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            /*PHead.RESET;
                PHead.SETRANGE(PHead."No.",No);
                 IF PHead.FINDFIRST THEN BEGIN
                    IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
                     (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
                       ERROR('You Cannot modify documents that are approved/posted/Sent for Approval');
                 END;*/
            end;
        }
        field(88; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnLookup()
            begin
            /*PHead.RESET;
                PHead.SETRANGE(PHead."No.",No);
                 IF PHead.FINDFIRST THEN BEGIN
                    IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
                     (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
                       ERROR('You Cannot modify documents that are approved/posted/Sent for Approval');
                 END;*/
            end;
            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                //IF "Applies-to ID" <> '' THEN
                //  TESTFIELD("Bal. Account No.",'');
                /*PHead.RESET;
                PHead.SETRANGE(PHead."No.",No);
                 IF PHead.FINDFIRST THEN BEGIN
                    IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
                     (PHead.Status=PHead.Status::"Pending Approval")OR (PHead.Status=PHead.Status::Cancelled) THEN
                       ERROR('You Cannot modify documents that are approved/posted/Sent for Approval');
                 END;*/
                if("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '')then begin
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", "Account No.");
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if VendLedgEntry.FindFirst then VendEntrySetApplID.SetApplId(VendLedgEntry, TempVendLedgEntry, '');
                    VendLedgEntry.Reset;
                end;
                if Amount = 0 then Error(Text002);
            end;
        }
        field(90; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code WHERE(Type=CONST(Retention));

            trigger OnValidate()
            begin
                if TariffCode.Get("Retention Code")then "Retention Rate":=TariffCode.Percentage
                else
                    "Retention Rate":=0;
                CalculateTax();
            end;
        }
        field(91; "Retention  Amount"; Decimal)
        {
        }
        field(92; "Retention Rate"; Decimal)
        {
        }
        field(93; "W/Tax Rate"; Decimal)
        {
        }
        field(94; "Vendor Bank Account"; Code[20])
        {
            Caption = 'Compte bancaire du fournisseur';
            TableRelation = IF("Account Type"=CONST(Vendor))"Vendor Bank Account".Code WHERE("Vendor No."=FIELD("Account No."));

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if(PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
                end;
            end;
            trigger OnValidate()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if(PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
                end;
            end;
        }
        field(95; "Trip No"; Code[20])
        {
        }
        field(96; "Driver No"; Code[20])
        {
        }
        field(97; "Loan No"; Integer)
        {
        }
        field(98; "Payee Email"; Text[50])
        {
            Caption = 'Email du beneficiaire';
        }
        field(99; "Last Modified Date"; DateTime)
        {
        }
        field(100; "Last Modified By"; Code[50])
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
        field(50002; "Entry Type[Income/Expense]"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ", Income, Expense;
        }
        field(50003; "Asset No"; Code[50])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(56000; "Invoice No."; Code[20])
        {
            TableRelation = "Vendor Ledger Entry"."Document No." WHERE(Open=CONST(true), "Document Type"=CONST(Invoice), "Vendor No."=FIELD("Account No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                VendLedger.Reset;
                VendLedger.SetRange(VendLedger."Document No.", "Invoice No.");
                VendLedger.SetRange(VendLedger."Vendor No.", "Account No.");
                VendLedger.SetRange(VendLedger."Document Type", VendLedger."Document Type"::Invoice);
                if VendLedger.FindFirst then begin
                    VendLedger.CalcFields("Remaining Amount");
                    Amount:=-VendLedger."Remaining Amount";
                    "Due Date":=VendLedger."Due Date";
                end end;
        }
        field(56001; "Due Date"; Date)
        {
        }
        field(56002; DocumentApplied; Boolean)
        {
        }
        field(56003; "Vendor Type"; Option)
        {
            OptionCaption = ' ,Landlord,Normal,Law Firm,Broker,Institutions,Registra,Staff Vendor,Agent';
            OptionMembers = " ", Landlord, Normal, "Law Firm", Broker, Institutions, Registra, "Staff Vendor", Agent;
        }
        field(56005; "Payee Account No"; Code[20])
        {
            Caption = 'Numéro de compte du bénéficiaire';
            Editable = true;

            trigger OnValidate()
            begin
                if StrLen("Payee Account No") <> 10 then Error('Account Numbers must have Ten Digits FOR %1 and Payee %2', "Account Name", Payee);
            end;
        }
        field(56006; "Payee Phone No"; Code[20])
        {
            Caption = 'Numéro de téléphone du bénéficiaire';
        }
        field(56007; "Source Document"; Code[20])
        {
            TableRelation = "Payments Header"."No.";
        }
        field(56008; "Gen. Posting Type"; Option)
        {
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ", Purchase, Sale, Settlement;
        }
        field(56009; "VAT Amount"; Decimal)
        {
            Caption = 'Montant de la TVA';
        }
        field(56010; "WHT Amount"; Decimal)
        {
            Caption = 'Montant de la retenue à la source';

            trigger OnValidate()
            begin
                "Net Amount":=Amount - "WHT Amount";
                Validate("Net Amount");
            end;
        }
        field(56011; "Amount LCY"; Decimal)
        {
            Caption = 'Montant Local';

            trigger OnValidate()
            begin
                "NetAmount LCY":="Amount LCY" - "Withholding Tax Amount LCY";
                Validate("NetAmount LCY");
            end;
        }
        field(56012; "Paying Bank Acc No"; Code[50])
        {
            Caption = 'numero du compte bancaire payant';

            trigger OnValidate()
            begin
                if StrLen("Paying Bank Acc No") <> 10 then Error('Account Numbers must have Ten Digits');
            end;
        }
        field(56013; "Expense Code"; Code[20])
        {
            Caption = 'Code de frais';
            TableRelation = "Expense Code".Code;

            trigger OnValidate()
            begin
                //TestStatusOpen;
                //TESTFIELD(Type,Type::"G/L Account");
                if ExpenseHead.Get("Expense Code")then begin
                //Type:=ExpenseHead.Type;
                //VALIDATE(Type);
                //IF ExpenseHead.Type=ExpenseHead.Type::"G/L Account" THEN BEGIN
                //"No.":=ExpenseHead."G/L Account";
                //VALIDATE("No.");
                //END;
                end;
            end;
        }
        field(56014; "Payee Sort Code"; Code[20])
        {
            Caption = 'Beneficiare IBAN';
        }
        field(56015; "Sender ID"; Code[50])
        {
            CalcFormula = Lookup("Approval Entry"."Sender ID" WHERE("Document No."=FIELD(No), "Sequence No."=FILTER(1)));
            Caption = 'Identifiant d''expéditeur';
            FieldClass = FlowField;
        }
        field(56016; "EFT No."; Code[20])
        {
            CalcFormula = Lookup("Payments Header"."EFT Batch No." WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(56017; "Staff ID"; Code[20])
        {
            Caption = 'Identifiant du personnel';
            Editable = true;
            TableRelation = "Employee";

            trigger OnValidate()
            begin
                if Employee.Get("Staff ID")then begin
                    "Staff Name":=Employee."First Name" + ' ' + Employee."Last Name";
                    "Payee Email":=Employee."E-Mail";
                    // "Payee Bank" := Employee."Main Bank";
                    //"Payee Account No" := Employee."Bank Account Number";
                    Payee:=Employee."First Name" + ' ' + Employee."Last Name";
                end;
                PHead.SetRange("No.", No);
                if PHead.FindFirst then begin
                    PHead.Payee:=Payee;
                    // message('%1',payee);
                    PHead.Modify;
                end;
            end;
        }
        field(56018; "Staff Name"; Text[250])
        {
            Caption = 'Nom du personnel';
            Editable = false;
        }
        field(56019; "Payment For"; Option)
        {
            Caption = 'Paiement pour';
            OptionCaption = ',Customer,Vendor,Staff,Others';
            OptionMembers = , Customer, Vendor, Staff, Others;
        }
        field(56020; Bank; Code[20])
        {
            CalcFormula = Lookup("Payments Header"."Paying Bank Account" WHERE("No."=FIELD(No)));
            Caption = 'Banque';
            FieldClass = FlowField;
        }
        field(56021; "Receipt No."; Code[20])
        {
            //TableRelation = "Fit Receipt Header"."No." WHERE(Posted = FILTER(true));
            trigger OnValidate()
            begin
                //to know if pv has been posted for co-insurers receipt already
                if Type = 'COINSURANCE' then begin
                    PaymentLine.Reset;
                    PaymentLine.SetRange("Account No.", "Account No.");
                    PaymentLine.SetRange("Receipt No.", "Receipt No.");
                    if PaymentLine.FindFirst then Error('This receipt has already been utilised!');
                end;
            end;
        }
        field(56022; "Expense Budget in Month"; Decimal)
        {
        }
        field(56023; "Expense Actual in Month"; Decimal)
        {
        }
        field(56024; "Expense Budget till Date"; Decimal)
        {
        }
        field(56025; "Expense Actual till Date"; Decimal)
        {
        }
        field(56026; "Monthly Variance"; Decimal)
        {
        }
        field(56027; "Year To Date Variance"; Decimal)
        {
        }
        field(56028; "Doc Posted"; Boolean)
        {
            CalcFormula = Lookup("Payments Header".Posted WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(56029; CustomerType;Enum CustomerType)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.CustomerType WHERE("No."=FIELD("Account No.")));
        }
    }
    keys
    {
        key(Key1; "Line No.", No, Type)
        {
            SumIndexFields = Amount, "VAT Amount LCY", "Withholding Tax Amount LCY", "Net Amount", "NetAmount LCY", "Retention  Amount";
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            if// (PHead.Status=PHead.Status::Approved)
            (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot Delete this record its already approved/posted/Sent for Approval');
        end;
        TestField(Committed, false);
    end;
    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No", xRec."No. Series", 0D, No, "No. Series");
        end;
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            Date:=PHead.Date;
            PHead.TestField("Responsibility Center");
            //PHead.TESTFIELD("Payment For");
            "Global Dimension 1 Code":=PHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code":=PHead."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code":=PHead."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code":=PHead."Shortcut Dimension 4 Code";
            "Currency Code":=PHead."Currency Code";
            "Currency Factor":=PHead."Currency Factor";
            "Payment Type":=PHead."Payment Type";
            Validate("Payment For", PHead."Payment For");
            Narration:=PHead."Payment Narration";
            if BankAcc.Get(PHead."Paying Bank Account")then begin
                "Bank Sort Code":=BankAcc."Sort Code";
                "Paying Bank Acc No":=BankAcc."Bank Account No.";
            end;
        end;
        //
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            if//  (PHead.Status=PHead.Status::Approved)
            (PHead.Status = PHead.Status::Posted) or (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled)then Error('You Cannot modify documents that are approved/posted/Sent for Approval');
        end;
        TestField(Committed, false);
    end;
    trigger OnModify()
    begin
        /*
       PHead.RESET;
       PHead.SETRANGE(PHead."No.",No);
        IF PHead.FINDFIRST THEN BEGIN
           IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
            (PHead.Status=PHead.Status::"Pending Approval") THEN
              ERROR('You Cannot modify documents that are approved/posted/Sent for Approval');
        END;
        */
        TestField(Committed, false);
    end;
    var PH: Record "Payments Header";
    //BSetup: Record "Farmer Purchase Broker Setup";
    VLedgEntry: Record "Vendor Ledger Entry";
    ICPartner: Record "IC Partner";
    FPurch: Record "Purch. Inv. Header";
    GLAcc: Record "G/L Account";
    Cust: Record Customer;
    Vend: Record Vendor;
    FA: Record "Fixed Asset";
    BankAcc: Record "Bank Account";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    GenLedgerSetup: Record "Cash Office Setup";
    RecPayTypes: Record "Receipts and Payment Types";
    CashierLinks: Record "Cash Office User Template";
    GLAccount: Record "G/L Account";
    EntryNo: Integer;
    SingleMonth: Boolean;
    DateFrom: Date;
    DateTo: Date;
    Budget: Decimal;
    CurrMonth: Code[10];
    CurrYR: Code[10];
    BudgDate: Text[30];
    BudgetDate: Date;
    YrBudget: Decimal;
    BudgetDateTo: Date;
    BudgetAvailable: Decimal;
    GenLedSetup: Record "Cash Office Setup";
    "Total Budget": Decimal;
    MonthBudget: Decimal;
    Expenses: Decimal;
    Header: Text[250];
    "Date From": Text[30];
    "Date To": Text[30];
    LastDay: Date;
    // LoadImprestDetails: Record "Cash Payment Line";
    TotAmt: Decimal;
    DimVal: Record "Dimension Value";
    PHead: Record "Payments Header";
    VendLedgEntry: Record "Vendor Ledger Entry";
    VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
    GenJnlApply: Codeunit "Gen. Jnl.-Apply";
    GenJnILine: Record "Gen. Journal Line";
    ApplyVendEntries: Page "Apply Vendor Entries";
    TariffCode: Record "Tariff Codes";
    DimMgt: Codeunit DimensionManagement;
    VendLedger: Record "Vendor Ledger Entry";
    Text001: Label 'Account Type cannot be of type Vendor for an Intercompany Transaction.';
    Denominator: Decimal;
    CurrExchRate: Record "Currency Exchange Rate";
    ExpenseHead: Record "Expense Code";
    Text002: Label 'Please ensure you have clicked "OK" Button on Applies to Doc No';
    Banks: Record Banks;
    VendBankAcc: Record "Vendor Bank Account";
    Employee: Record "Employee";
    PaymentLine: Record "Payment Line";
    LastDay2: Date;
    FirstDay2: Date;
    CurrentMonth: Integer;
    GLEntry: Record "G/L Entry";
    GLBudgetEntry: Record "G/L Budget Entry";
    BCSU: Record "Budgetary Control Setup";
    GLAccNo: Code[20];
    FirstDayOfTheYear: Date;
    PaymentHeaderDate: Date;
    text1: Label 'date is %1';
    CompName: Code[100];
    CustomerBankAccount: Record "Customer Bank Account";
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply":=VendLedgEntry."Remaining Amount";
            end
            else
                VendLedgEntry."Amount to Apply":=0;
            VendLedgEntry."Accepted Payment Tolerance":=0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance":=false;
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;
    procedure CalculateTax()
    var
        CalculationType: Option VAT, "W/Tax", Retention;
        // TaxCalc: Codeunit "Tax Calculation";
        TotalTax: Decimal;
    begin
        "VAT Amount LCY":=0;
        "Withholding Tax Amount LCY":=0;
        "Retention  Amount":=0;
        TotalTax:=0;
        "Net Amount":=0;
        if Amount <> 0 then begin
            if "VAT Rate" <> 0 then begin
                // "VAT Amount LCY" := TaxCalc.CalculateTax(Rec, CalculationType::VAT);
                TotalTax:=TotalTax + "VAT Amount LCY" end;
            if "W/Tax Rate" <> 0 then begin
                //"Withholding Tax Amount LCY" := TaxCalc.CalculateTax(Rec, CalculationType::"W/Tax");
                TotalTax:=TotalTax + "Withholding Tax Amount LCY" end;
            if "Retention Rate" <> 0 then begin
                //"Retention  Amount" := TaxCalc.CalculateTax(Rec, CalculationType::Retention);
                TotalTax:=TotalTax + "Retention  Amount" end;
        end;
        "Net Amount":=Amount - TotalTax;
        Validate("Net Amount");
    end;
    procedure PayLinesExist(): Boolean var
        PayLine: Record "Payment Line";
    begin
        PayLine.Reset;
        PayLine.SetRange(No, No);
        exit(PayLine.FindFirst);
    end;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Payment', "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
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
}
