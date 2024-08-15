codeunit 50104 "Payments Management"
{
    trigger OnRun()
    begin
    end;

    var
        Batch: Record "Gen. Journal Batch";
        CMSetup: Record "Cash Management Setups";
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        NumberText: array[2] of Text[80];
        CurrencyCodeText: Code[10];
        Acct: Record "G/L Account";
        Text000: Label 'There is a remaining amount of %1 are you sure you want to create a receipt for this amount?';
        Text001: Label '&Post and Create &Receipt,&Post';
        Text002: Label 'Are you sure you want to post Imprest No %1 ?';
        Text003: Label 'The Imprest No %1  has not been fully approved';
        Text004: Label 'The Imprest Lines are empty';
        Text005: Label 'Amount cannot be zero';
        Text006: Label 'Imprest %1 has been posted';
        Text007: Label 'Are you sure you want to post Imprest Surrender No. %1 ?';
        Text008: Label 'The Imprest Surrender No. %1 has not been fully approved';
        Text009: Label 'The Imprest Surrender Lines are empty';
        Text010: Label 'Imprest %1 has been surrendered';
        Text011: Label 'Are you sure tou want to post Imprest Memo %1 ?';
        Text012: Label 'The Imprest Memo amount is zero';
        Text013: Label 'The Imprest Surrender has already been posted';
        Text014: Label 'Are you sure you want to post petty cash surrender No %1 ?';
        Text015: Label 'Petty Cash %1 has been surrendered';
        Text016: Label 'Actual amount spent cannot be zero';
        Text017: Label 'Are you sure you want to post receipt no. %1 ?';
        Text018: Label 'The receipt is already posted';
        Text019: Label 'Dept %1 has not been commited, kindly commit before posting';
        Text020: Label 'The Petty Cash Remaining amount must be zero';
        Text021: Label 'Create a Petty Cash Voucher,Create a Payment Voucher, Create a Staff Claim';
        Text022: Label 'Please Choose one of these options';
        WText001: Label 'Last Check No. must be filled in.';
        WText002: Label 'Filters on %1 and %2 are not allowed.';
        WText003: Label 'XXXXXXXXXXXXXXXX';
        WText004: Label 'must be entered.';
        WText005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        WText006: Label 'Salesperson';
        WText007: Label 'Purchaser';
        WText008: Label 'Both Bank Accounts must have the same currency.';
        WText009: Label 'Our Contact';
        WText010: Label 'XXXXXXXXXX';
        WText011: Label 'XXXX';
        WText012: Label 'XX.XXXXXXXXXX.XXXX';
        WText013: Label '%1 already exists.';
        WText014: Label 'Check for %1 %2';
        WText015: Label 'Payment';
        WText016: Label 'In the Check report, One Check per Vendor and Document No.\';
        WText017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        WText018: Label 'XXX';
        WText019: Label 'Total';
        WText020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        WText021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        WText022: Label 'NON-NEGOTIABLE';
        WText023: Label 'Test print';
        WText024: Label 'XXXX.XX';
        WText025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        WText026: Label 'ZERO';
        WText027: Label 'HUNDRED';
        WText028: Label 'AND';
        WText029: Label '%1 results in a written number that is too long.';
        WText030: Label ' is already applied to %1 %2 for customer %3.';
        WText031: Label ' is already applied to %1 %2 for vendor %3.';
        WText032: Label 'ONE';
        WText033: Label 'TWO';
        WText034: Label 'THREE';
        WText035: Label 'FOUR';
        WText036: Label 'FIVE';
        WText037: Label 'SIX';
        WText038: Label 'SEVEN';
        WText039: Label 'EIGHT';
        WText040: Label 'NINE';
        WText041: Label 'TEN';
        WText042: Label 'ELEVEN';
        WText043: Label 'TWELVE';
        WText044: Label 'THIRTEEN';
        WText045: Label 'FOURTEEN';
        WText046: Label 'FIFTEEN';
        WText047: Label 'SIXTEEN';
        WText048: Label 'SEVENTEEN';
        WText049: Label 'EIGHTEEN';
        WText050: Label 'NINETEEN';
        WText051: Label 'TWENTY';
        WText052: Label 'THIRTY';
        WText053: Label 'FORTY';
        WText054: Label 'FIFTY';
        WText055: Label 'SIXTY';
        WText056: Label 'SEVENTY';
        WText057: Label 'EIGHTY';
        WText058: Label 'NINETY';
        WText059: Label 'THOUSAND';
        WText060: Label 'MILLION';
        WText061: Label 'BILLION';
        PaymentLine: Record "Payment Lines";
        CustLedgEntry, CustLedgEntry2 : Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        CurrencyRec: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CheckLedgerEntry: Record "Check Ledger Entry";
        PaymentToleranceMgt: Codeunit PaymentToleranceCUExtension;
        ApplyCustEntries: Page "Apply Customer Entries Custom";
        ApplyVendEntries: Page "Apply Vendor Entries Custom";
        AccNo: Code[20];
        CurrencyCode2: Code[10];
        OK: Boolean;
        AccType: Enum "Gen. Journal Account Type";
        CentsTxt: Label 'CENTS';
        Temp: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        Committment: Codeunit Committment;
        ChequePayment: Boolean;
        PaymentsRec: Record Payments;
        HRSetup: Record "Human Resources Setup";
        Apportionment: Codeunit Apportionment;
        ConfirmFundsReceiptErr: Label 'User must confirm funds receipt before posting';

    procedure "Post Payment Voucher"(PV: Record Payments)
    var
        PVLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        PaymentMethod: Record "Payment Method";
        ChequeRegister: Record "Cheque Register";
        ImprestRec: Record Payments;
        ClaimsRec: Record Payments;
        PVDate: Date;
        BalAccType: enum "Payment Balance Account Type";
    begin
        ChequePayment := false;
        if Confirm('Are you sure you want to post the Payment Voucher No. ' + PV."No." + ' ?') = true then begin
            Temp.Get(UserId);
            JTemplate := Temp."Payment Journal Template";
            JBatch := Temp."Payment Journal Batch";
            if JTemplate = '' then begin
                Error('Ensure the PV Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the PV Batch is set up in the Cash Office Setup')
            end;
            if PV.Status <> PV.Status::Released then Error('The Payment Voucher No %1 has not been fully approved', PV."No.");
            if PV.Posted then Error('Payment Voucher %1 has been posted', PV."No.");
            PV.TestField(Date);
            PV.TestField("Paying Bank Account");
            PV.TestField(PV.Payee);
            PV.TestField(PV."Pay Mode");
            //PV.TestField("Responsibility Center");
            if PaymentMethod.Get(PV."Pay Mode") then BalAccType := PaymentMethod."Bal. Account Type";
            /*CASE BalAccType OF
              BalAccType::EFT:
                PVDate:=PV."EFT Date";
              BalAccType::Cheque:
                PVDate:=PV."Cheque Date";
              BalAccType::RTGS:
                PVDate:=PV."RTGS Date";
              ELSE
                PVDate:=PV.Date;
            END;*/
            if PV."Payment Release Date" = 0D then Error('Please input postin date');
            PVDate := PV."Payment Release Date";
            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ChequePayment := true;
                PV.TestField(PV."Cheque No");
                PV.TestField(PV."Cheque Date");
            end;
            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then begin
                PV.TestField(PV."EFT Date");
                PV.TestField(PV."EFT Reference");
            end;
            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then begin
                PV.TestField(PV."RTGS Date");
            end;
            //Check Lines
            PV.CalcFields("Total Amount");
            if PV."Total Amount" = 0 then Error('Amount is cannot be zero');
            PVLines.Reset;
            PVLines.SetRange(PVLines.No, PV."No.");
            if not PVLines.FindLast then Error('Payment voucher Lines cannot be empty');
            CMSetup.Get();
            CMSetup.TestField("Payment Voucher Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Bank Entries
            LineNo := LineNo + 10000;
            PV.CalcFields(PV."Total Amount", "Total Net Amount");
            PVLines.Reset;
            PVLines.SetRange(PVLines.No, PV."No.");
            PVLines.Validate(PVLines.Amount);
            PVLines.CalcSums(PVLines.Amount);
            PVLines.CalcSums(PVLines."W/Tax Amount");
            PVLines.CalcSums(PVLines."VAT Amount");
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := PV."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if PV.Date = 0D then Error('You must specify the PV date');
            // GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := PVDate;
            GenJnLine."Document No." := PV."No.";
            if ChequePayment then begin
                GenJnLine."External Document No." := PV."Cheque No";
                GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            end;
            GenJnLine.Description := PV.Payee;
            GenJnLine.Amount := -PV."Total Net Amount";
            GenJnLine."Currency Code" := PV.Currency;
            GenJnLine.Validate(GenJnLine."Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := PV."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PV."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if BalAccType = BalAccType::EFT then GenJnLine."EFT Reference" := PV."EFT Reference";
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //PV Lines Entries
            PVLines.Reset;
            PVLines.SetRange(PVLines.No, PV."No.");
            if PVLines.FindFirst then begin
                repeat
                    if PVLines."Levied Invoice H" = true then begin //brian
                        PVLines.Validate(PVLines.Amount);
                    end;
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PVLines."Account Type";
                    GenJnLine."Account No." := PVLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if PV.Date = 0D then Error('You must specify the PV date');
                    // GenJnLine."Posting Date":=TODAY;
                    GenJnLine."Posting Date" := PVDate;
                    GenJnLine."Document No." := PV."No.";
                    GenJnLine."External Document No." := PV."Cheque No";
                    GenJnLine.Description := format(PVLines.Description, 100);
                    // GenJnLine."Reason Code" := PVLines."General Expense Code";
                    GenJnLine.Amount := PVLines."Net Amount";
                    GenJnLine."Currency Code" := PV.Currency;
                    GenJnLine.Validate(GenJnLine."Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    //Set these fields to blanks
                    GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                    GenJnLine.Validate("Gen. Posting Type");
                    GenJnLine."Gen. Bus. Posting Group" := '';
                    GenJnLine.Validate("Gen. Bus. Posting Group");
                    GenJnLine."Gen. Prod. Posting Group" := '';
                    GenJnLine.Validate("Gen. Prod. Posting Group");
                    GenJnLine."VAT Bus. Posting Group" := '';
                    GenJnLine.Validate("VAT Bus. Posting Group");
                    GenJnLine."VAT Prod. Posting Group" := '';
                    GenJnLine.Validate("VAT Prod. Posting Group");
                    //
                    GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::Invoice;
                    GenJnLine."Applies-to Doc. No." := PVLines."Applies-to Doc. No.";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    GenJnLine."Applies-to ID" := PVLines."Applies-to ID";
                    // GenJnLine."Reason Code" := PVLines."General Expense Code";
                    GenJnLine."Gen. Posting Type" := PVLines."Gen. Posting Type";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    //Post VAT
                    if CMSetup."Post VAT" then begin
                        if PVLines."VAT Code" <> '' then begin
                            LineNo := LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := PVLines."Account Type";
                            GenJnLine."Account No." := PVLines."Account No";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            if PV.Date = 0D then Error('You must specify the PV date');
                            // GenJnLine."Posting Date":=TODAY;
                            GenJnLine."Posting Date" := PVDate;
                            GenJnLine."Document No." := PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            GenJnLine.Description := format(PVLines.Description, 96) + ' VAT';
                            // GenJnLine."Reason Code" := PVLines."General Expense Code";
                            GenJnLine.Amount := PVLines."VAT Amount";
                            GenJnLine."Currency Code" := PV.Currency;
                            GenJnLine.Validate(GenJnLine."Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            // GenJnLine."Reason Code" := PVLines."General Expense Code";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                            LineNo := LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                            case PVLines."Account Type" of
                                PVLines."Account Type"::"G/L Account":
                                    begin
                                        GLAccount.Get(PVLines."Account No");
                                        GLAccount.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                                PVLines."Account Type"::Vendor:
                                    begin
                                        Vendor.Get(PVLines."Account No");
                                        Vendor.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                                PVLines."Account Type"::Customer:
                                    begin
                                        Customer.Get(PVLines."Account No");
                                        Customer.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                            end;
                            if PV.Date = 0D then Error('You must specify the PV date');
                            // GenJnLine."Posting Date":=TODAY;
                            GenJnLine."Posting Date" := PVDate;
                            GenJnLine."Document No." := PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            GenJnLine.Description := format(PVLines.Description, 96) + ' VAT';
                            // GenJnLine."Reason Code" := PVLines."General Expense Code";
                            GenJnLine.Amount := -PVLines."VAT Amount";
                            GenJnLine."Currency Code" := PV.Currency;
                            GenJnLine.Validate(GenJnLine."Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            // GenJnLine."Reason Code" := PVLines."General Expense Code";
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        end;
                        //End of Posting VAT
                    end;
                    //Post Withholding Tax
                    if PVLines."W/Tax Code" <> '' then begin
                        //PVLines.VALIDATE(PVLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := PVLines."Account Type";
                        GenJnLine."Account No." := PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then Error('You must specify the PV date');
                        // GenJnLine."Posting Date":=TODAY;
                        GenJnLine."Posting Date" := PVDate;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := format(PVLines.Description, 90) + ' W/Tax';
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        GenJnLine.Amount := PVLines."W/Tax Amount";
                        GenJnLine."Currency Code" := PV.Currency;
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of
                            PVLines."Account Type"::"G/L Account":
                                begin
                                    GLAccount.Get(PVLines."Account No");
                                    GLAccount.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/Tax Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Vendor:
                                begin
                                    Vendor.Get(PVLines."Account No");
                                    Vendor.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/Tax Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Customer:
                                begin
                                    Customer.Get(PVLines."Account No");
                                    Customer.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/Tax Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                        end;
                        if PV.Date = 0D then Error('You must specify the PV date');
                        // GenJnLine."Posting Date":=TODAY;
                        GenJnLine."Posting Date" := PVDate;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := format(PVLines.Description, 90) + ' W/Tax';
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        GenJnLine.Amount := -PVLines."W/Tax Amount";
                        GenJnLine."Currency Code" := PV.Currency;
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    end;
                    //End of Posting Withholding Tax
                    //Post Withholding VAT
                    if PVLines."W/T VAT Code" <> '' then begin
                        //PVLines.VALIDATE(PVLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := PVLines."Account Type";
                        GenJnLine."Account No." := PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then Error('You must specify the PV date');
                        // GenJnLine."Posting Date":=TODAY;
                        GenJnLine."Posting Date" := PVDate;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := format(PVLines.Description, 90) + ' W/Tax VAT';
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        GenJnLine.Amount := PVLines."W/T VAT Amount";
                        GenJnLine."Currency Code" := PV.Currency;
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of
                            PVLines."Account Type"::"G/L Account":
                                begin
                                    GLAccount.Get(PVLines."Account No");
                                    GLAccount.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/T VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Vendor:
                                begin
                                    Vendor.Get(PVLines."Account No");
                                    Vendor.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/T VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Customer:
                                begin
                                    Customer.Get(PVLines."Account No");
                                    Customer.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/T VAT Code") then GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                        end;
                        if PV.Date = 0D then Error('You must specify the PV date');
                        // GenJnLine."Posting Date":=TODAY;
                        GenJnLine."Posting Date" := PVDate;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := format(PVLines.Description, 90) + ' W/Tax VAT';
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        GenJnLine.Amount := -PVLines."W/T VAT Amount";
                        GenJnLine."Currency Code" := PV.Currency;
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        // GenJnLine."Reason Code" := PVLines."General Expense Code";
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    end;
                //End of Posting Withholding VAT
                until PVLines.Next = 0;
            end;
            //
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", PV."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                PV.Posted := true;
                PV."Posted By" := UserId;
                PV."Posted Date" := Today;
                PV."Time Posted" := Time;
                PV.Modify;
                if PV."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset;
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", PV."No.");
                    if CheckLedgerEntry.FindFirst then begin
                        CheckLedgerEntry."Check No." := PV."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify;
                    end;
                    //Modify Cheque as Posted in cheque register
                    if PV."Cheque Type" = PV."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset;
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", PV."Cheque No");
                        if ChequeRegister.FindFirst then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := PV."Cheque Date";
                            ChequeRegister."Posted By" := UserId;
                            ChequeRegister.Modify;
                        end;
                    end;
                end;
                //Modify imprest as posted-Utalii
                /*PVLines.Reset;
                PVLines.SetRange(PVLines.No, PV."No.");
                if PVLines.Find('-') then begin
                    repeat
                        if PVLines."Imprest No." <> '' then begin
                            if ImprestRec.Get(PVLines."Imprest No.") then;
                            ImprestRec.Posted := true;
                            ImprestRec."Posted By" := UserId;
                            ImprestRec."Posted Date" := Today;
                            ImprestRec."Time Posted" := Time;
                            ImprestRec."Imprest Posted by PV" := PV."No.";
                            ImprestRec.Modify;
                            Commit;
                            Committment.UncommitImprest(ImprestRec);
                            Commit;
                            Committment.EncumberImprest(ImprestRec);
                            Commit;
                        end;
                    until PVLines.Next = 0;
                end;*/
                //Modify claims as posted-Utalii
                /*PVLines.Reset;
                PVLines.SetRange(PVLines.No, PV."No.");
                if PVLines.Find('-') then begin
                    repeat
                        if PVLines."Claim No." <> '' then begin
                            if ClaimsRec.Get(PVLines."Claim No.") then;
                            ClaimsRec.Posted := true;
                            ClaimsRec."Posted By" := UserId;
                            ClaimsRec."Posted Date" := Today;
                            ClaimsRec."Time Posted" := Time;
                            ClaimsRec.Modify;
                            Commit;
                            Committment.ReverseStaffClaimCommittment(ClaimsRec);
                        end;
                    until PVLines.Next = 0;
                end;*/
                //Uncommit PV
                Committment.UncommitPV(PV);
                Commit;
                //Apportion Inter-Company Expenses
                if PV.Apportion then Apportionment.CreatePaymentApportionEntry(PV);
            end;
        end;
    end;
    // procedure CreatePaymentVoucher(var Pmts: Record Payments)
    // var
    //     PVHeader: Record Payments;
    //     PVLines: Record "Payment Lines";
    //     PmtLines: Record "Payment Lines";
    //     SalesLines: record "Sales Line";
    //     PurchLines: Record "Purch. Inv. Line";
    //     PurchHeader: record "Purch. Inv. Header";
    //     SalesHeader: record "Sales Header";
    //     Payments: record payments;
    //     CashMgmt: Record "Cash Management Setups";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     DocNo: Code[20];
    //     ReceiptsPaymentType: record "Receipts and Payment Types";
    //     OrderCode: code[20];
    //     InvoiceCode: Code[20];
    //     ImprestCode: Code[20];
    //     CustLedgerEntry: Record "Cust. Ledger Entry";
    //     VendorLedgerEntry: Record "Vendor Ledger Entry";
    // begin
    //     CashMgmt.Get();
    //     case Pmts."Requested Payment" of
    //         Pmts."Requested Payment"::Invoice:
    //             begin
    //                 PVHeader.Init();
    //                 PVHeader.TransferFields(Pmts);
    //                 PVHeader."Payment Type" := PVHeader."Payment Type"::"Payment Voucher";
    //                 PVHeader."No." := NoSeriesMgt.GetNextNo(CashMgmt."PV Nos", TODAY, TRUE);
    //                 DocNo := PVHeader."No.";
    //                 PVHeader.Requisition := false;
    //                 PVHeader.Status := PVHeader.Status::Open;
    //                 PVHeader.Insert();
    //                 PurchLines.Reset();
    //                 PurchLines.SetRange("Document No.", Pmts."Document No.");
    //                 if PurchLines.Find('-') then
    //                     repeat
    //                         PVLines.Init();
    //                         PVLines.No := PVHeader."No.";
    //                         ReceiptsPaymentType.Reset();
    //                         ReceiptsPaymentType.SetRange("Account Type", ReceiptsPaymentType."Account Type"::Vendor);
    //                         if ReceiptsPaymentType.FindFirst() then begin
    //                             PVLines."Expenditure Type" := ReceiptsPaymentType.Code;
    //                         end;
    //                         PVLines.validate("Expenditure Type");
    //                         PurchHeader.reset;
    //                         PurchHeader.SetRange("No.", Pmts."Document No.");
    //                         if PurchHeader.FindFirst() then
    //                             PVLines."Account No" := PurchHeader."Pay-to Vendor No.";
    //                         if PVLines."Account No" <> '' then
    //                             PVLines.validate("Account No");
    //                         VendorLedgerEntry.Reset();
    //                         VendorLedgerEntry.SetRange("Document No.", Pmts."Document No.");
    //                         if VendorLedgerEntry.FindFirst() then begin
    //                             VendorLedgerEntry."Applies-to ID" := PVHeader."No.";
    //                             VendorLedgerEntry.Modify();
    //                             PVLines."Applies-to ID" := PVHeader."No.";
    //                         end;
    //                         PVLines.Amount := PurchLines.Amount;
    //                         PVLines."Applies-to Doc. No." := PurchLines."Document No.";
    //                         PVLines.insert;
    //                     until PurchLines.Next() = 0;
    //             end;
    //         Pmts."Requested Payment"::Imprest:
    //             begin
    //                 PVHeader.Init();
    //                 PVHeader.TransferFields(Pmts);
    //                 PVHeader."Payment Type" := PVHeader."Payment Type"::"Payment Voucher";
    //                 PVHeader."No." := NoSeriesMgt.GetNextNo(CashMgmt."PV Nos", TODAY, TRUE);
    //                 DocNo := PVHeader."No.";
    //                 PVHeader.Requisition := false;
    //                 PVHeader.Status := PVHeader.Status::Open;
    //                 PVHeader.Insert();
    //                 PmtLines.Reset();
    //                 PmtLines.SetRange(No, Pmts."Document No.");
    //                 if PmtLines.Find('-') then
    //                     repeat
    //                         PVLines.Init();
    //                         PVLines.No := PVHeader."No.";
    //                         ReceiptsPaymentType.Reset();
    //                         ReceiptsPaymentType.SetRange("Account Type", ReceiptsPaymentType."Account Type"::Customer);
    //                         if ReceiptsPaymentType.FindFirst() then
    //                             PVLines."Expenditure Type" := ReceiptsPaymentType.Code;
    //                         PVLines.validate("Expenditure Type");
    //                         Payments.Reset;
    //                         Payments.SetRange("No.", Pmts."Document No.");
    //                         if Payments.FindFirst() then
    //                             PVLines."Account No" := Payments."Account No.";
    //                         if PVLines."Account No" <> '' then
    //                             PVLines.validate("Account No");
    //                         CustLedgerEntry.Reset();
    //                         CustLedgerEntry.SetRange("Document No.", Pmts."Document No.");
    //                         if CustLedgerEntry.FindFirst() then begin
    //                             CustLedgerEntry."Applies-to ID" := PVHeader."No.";
    //                             CustLedgerEntry.Modify();
    //                             PVLines."Applies-to ID" := PVHeader."No.";
    //                         end;
    //                         PVLines.Amount := PmtLines.Amount;
    //                         PVLines."Imprest No." := PmtLines.No;
    //                         PVLines.insert;
    //                     until PmtLines.Next() = 0;
    //             end;
    //         Pmts."Requested Payment"::"Staff Claim":
    //             begin
    //                 PVHeader.Init();
    //                 PVHeader.TransferFields(Pmts);
    //                 PVHeader."Payment Type" := PVHeader."Payment Type"::"Payment Voucher";
    //                 PVHeader."No." := NoSeriesMgt.GetNextNo(CashMgmt."PV Nos", TODAY, TRUE);
    //                 DocNo := PVHeader."No.";
    //                 PVHeader.Requisition := false;
    //                 PVHeader.Status := PVHeader.Status::Open;
    //                 PVHeader.Insert();
    //                 PmtLines.Reset();
    //                 PmtLines.SetRange(No, Pmts."Document No.");
    //                 if PmtLines.Find('-') then
    //                     repeat
    //                         PVLines.Init();
    //                         PVLines.No := PVHeader."No.";
    //                         ReceiptsPaymentType.Reset();
    //                         ReceiptsPaymentType.SetRange("Account Type", ReceiptsPaymentType."Account Type"::Customer);
    //                         if ReceiptsPaymentType.FindFirst() then begin
    //                             PVLines."Expenditure Type" := ReceiptsPaymentType.Code;
    //                         end;
    //                         PVLines.validate("Expenditure Type");
    //                         Payments.reset;
    //                         Payments.SetRange("No.", Pmts."Document No.");
    //                         if Payments.FindFirst() then
    //                             PVLines."Account No" := Payments."Account No.";
    //                         if PVLines."Account No" <> '' then
    //                             PVLines.validate("Account No");
    //                         CustLedgerEntry.Reset();
    //                         CustLedgerEntry.SetRange("Document No.", Pmts."Document No.");
    //                         if CustLedgerEntry.FindFirst() then begin
    //                             CustLedgerEntry."Applies-to ID" := PVHeader."No.";
    //                             CustLedgerEntry.Modify();
    //                             PVLines."Applies-to ID" := PVHeader."No.";
    //                         end;
    //                         PVLines.Amount := PmtLines.Amount;
    //                         PVLines."Imprest No." := PmtLines.No;
    //                         PVLines.insert;
    //                     until PmtLines.Next() = 0;
    //             end;
    //     end;
    //     if PVHeader."No." <> '' then begin
    //         Message('Payment Voucher %1 created successfully', PVHeader."No.");
    //         Pmts."PV Created" := true;
    //         Pmts."PV No." := PVHeader."No.";
    //         Pmts.modify;
    //     end;
    // end;
    procedure PostImprest(var Imprest: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        ExtImprestLines: Record "Ext Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        ImpLine: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
        ChequePayment: Boolean;
        ChequeRegister: Record "Cheque Register";
        TotalAmount: Decimal;
    begin
        ChequePayment := false;
        if Confirm(Text002, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then Error(Text003, Imprest."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Imprest Template";
            JBatch := 'IMPREST'; // Temp."Imprest  Batch";
            if JTemplate = '' then begin
                Error('Ensure the Imprest Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
            end;
            Imprest.TestField("Account No.");
            Imprest.TestField("Paying Bank Account");
            Imprest.TestField(Date);
            //Imprest.TESTFIELD(Payee);
            Imprest.TestField("Pay Mode");
            PaymentMethod.Get(Imprest."Pay Mode");
            //Check Commitment
            ImprestLines.Reset;
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then begin
                repeat
                    if IsAccountVotebookEntry(ImprestLines."Account No") then begin
                        Commitment.FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetup.Get;
                        //DimValue.GET(GLSetup."Shortcut Dimension 6 Code",ShortcutDimValue[6]);
                        //DimValueName:=DimValue.Name;
                        // if (Commitment.IsAccountVotebookEntry(ImprestLines."Account No")) and not Commitment.LineCommitted(Imprest."No.", ImprestLines."Account No", ImprestLines."Line No") then
                        //     Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                    end;
                until ImprestLines.Next = 0;
            end;
            //External Lines
            ExtImprestLines.Reset;
            ExtImprestLines.SetRange(No, Imprest."No.");
            if ExtImprestLines.Find('-') then begin
                repeat
                    if IsAccountVotebookEntry(ExtImprestLines."Account No") then begin
                        Commitment.FetchDimValue(ExtImprestLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetup.Get;
                    end;
                until ExtImprestLines.Next = 0;
            end;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Imprest.TestField("Cheque No");
                Imprest.TestField("Cheque Date");
                ChequePayment := true;
            end;
            //Check if the imprest Lines have been populated
            ImprestLines.SetRange(ImprestLines.No, Imprest."No.");
            ExtImprestLines.SetRange(ExtImprestLines.No, Imprest."No.");
            if not (ImprestLines.FindLast) and not (ExtImprestLines.FindLast) then Error(Text004);
            Imprest.CalcFields("Total Amount", "Total Amount 1", "Total Amount 2");
            TotalAmount := Imprest."Total Amount 1" + Imprest."Total Amount 2";
            //     IF Imprest."Imprest Amount"=0 THEN
            //      ERROR(Text005);
            if Imprest.Posted then Error(Text006, Imprest."No.");
            CMSetup.Get();
            //CMSetup.TESTFIELD("Imprest Due Date");
            //CMSetup.TESTFIELD("Imprest Journal Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            // Batch.Init;
            // if CMSetup.Get() then
            //     Batch."Journal Template Name" := JTemplate;
            // Batch.Name := JBatch;
            // if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
            //     Batch.Insert;
            LineNo := 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := 'IMPREST';
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Account No." := Imprest."Paying Bank Account";
            GenJnLine."Posting Date" := Today;
            GenJnLine."Document No." := Imprest."No.";
            if ChequePayment then begin
                GenJnLine."External Document No." := Imprest."Cheque No";
                GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            end;
            GenJnLine.Description := Imprest.Payee;
            GenJnLine.Amount := -TotalAmount;
            GenJnLine.Validate(Amount);

            // GenJnLine."Reason Code" := ImprestLines."General Expense Code";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::Customer;
            GenJnLine."Bal. Account No." := Imprest."Account No.";
            GenJnLine."Posting Group" := GetCustomerPostingGroup(Imprest."Account No.");
            GenJnLine."Currency Code" := Imprest.Currency;
            GenJnLine.Validate("Bal. Account No.");
            GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Customer Transaction Type" := GenJnLine."Customer Transaction Type"::Imprest;
            GenJnLine."Due Date" := Imprest."Surrender Date";
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.Find('-') then begin
                if Imprest."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset;
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Imprest."No.");
                    if CheckLedgerEntry.FindFirst then begin
                        CheckLedgerEntry."Check No." := Imprest."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify;
                    end;
                    //Modify Cheque as Posted in cheque register
                    if Imprest."Cheque Type" = Imprest."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset;
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Imprest."Cheque No");
                        if ChequeRegister.FindFirst then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Imprest."Cheque Date";
                            ChequeRegister."Posted By" := UserId;
                            ChequeRegister.Modify;
                        end;
                    end;
                end;
                //Encumber
                Commitment.UncommitImprest(Imprest);
                Commitment.EncumberImprest(Imprest);
                //Update the Imprest Deadline
                //   IF CMSetup."Imprest Due Date"<>DueDate THEN
                //   Imprest."Imprest Deadline":=CALCDATE(CMSetup."Imprest Due Date",TODAY);
                //   Imprest.MODIFY;
                Imprest.Posted := true;
                Imprest."Posted By" := UserId;
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest.Modify();
            end;
        end;
    end;

    procedure "Post ImprestSurrenderBCK"(var ImprestSurrender: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        LineNo: Integer;
        GenJnLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        Window: Dialog;
        Selection: Integer;
    begin
        /*
            IF CONFIRM(Text007,FALSE,ImprestSurrender."No.")=TRUE THEN BEGIN
              ImprestSurrender.TESTFIELD("Surrender Date");
              //Check if amount surrendered is less than amount advanced
              ImprestSurrender.CALCFIELDS("Remaining Amount");
              IF ImprestSurrender."Remaining Amount">0 THEN
                  Selection:= STRMENU(Text001,1);
              IF ImprestSurrender.Status<>ImprestSurrender.Status::Released THEN
                 ERROR(Text008,ImprestSurrender."No.");
                ImprestSurrender.TESTFIELD("Account No.");
                ImprestSurrender.TESTFIELD("Paying Bank Account");
                ImprestSurrender.TESTFIELD(Date);
                ImprestSurrender.TESTFIELD(Payee);
                ImprestSurrender.TESTFIELD("Pay Mode");
             IF ImprestSurrender."Pay Mode"='CHEQUE' THEN BEGIN
                 ImprestSurrender.TESTFIELD("Cheque No");
                 ImprestSurrender.TESTFIELD("Cheque Date");
              END;
              //Check if the imprest Lines have been populated
              ImprestLines.RESET;
              ImprestLines.SETRANGE(ImprestLines.No,ImprestSurrender."No.");
              IF NOT ImprestLines.FINDLAST  THEN
               ERROR(Text009);
              ImprestLines.RESET;
              ImprestLines.SETRANGE(ImprestLines.No,ImprestSurrender."No.");
              ImprestLines.CALCSUMS("Actual Spent");
              {IF ImprestLines."Actual Spent"=0 THEN
               ERROR('Actual Spent Amount cannot be zero');}
              IF ImprestSurrender.Surrendered THEN
               ERROR(Text010,ImprestSurrender."No.");
            //MESSAGE('Tuko hapa!');
               GLSetup.GET;
               CMSetup.GET();
              // Delete Lines Present on the General Journal Line
              GenJnLine.RESET;
              GenJnLine.SETRANGE(GenJnLine."Journal Template Name",CMSetup."Imprest Surrender Template");
              GenJnLine.SETRANGE(GenJnLine."Journal Batch Name",ImprestSurrender."No.");
              GenJnLine.DELETEALL;
              Batch.INIT;
              IF CMSetup.GET() THEN
              Batch."Journal Template Name":=CMSetup."Imprest Surrender Template";
              Batch.Name:=ImprestSurrender."No.";
              IF NOT Batch.GET(Batch."Journal Template Name",Batch.Name) THEN
              Batch.INSERT;
              //Staff entries
              LineNo:=10000;
              ImprestLines.RESET;
              ImprestLines.SETRANGE(ImprestLines.No,ImprestSurrender."No.");
              ImprestLines.CALCSUMS("Actual Spent");
              GenJnLine.INIT;
              GenJnLine."Journal Template Name":=CMSetup."Imprest Surrender Template";
              GenJnLine."Journal Batch Name":=ImprestSurrender."No.";
              GenJnLine."Line No.":=LineNo;
              GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
              GenJnLine."Account No.":=ImprestSurrender."Account No.";
              GenJnLine."Posting Date":=TODAY";
              GenJnLine."Document No.":=ImprestSurrender."No.";
              GenJnLine."External Document No.":=ImprestSurrender."Cheque No";
              GenJnLine.Description:=ImprestSurrender.Payee;
              GenJnLine.Amount:=-ImprestLines."Actual Spent";
              GenJnLine.VALIDATE(Amount);
              GenJnLine."Applies-to Doc. No.":=ImprestSurrender."No.";
              GenJnLine.VALIDATE("Applies-to Doc. No.");
              GenJnLine."Shortcut Dimension 1 Code":=ImprestSurrender."Shortcut Dimension 1 Code";
              GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
              GenJnLine."Shortcut Dimension 2 Code":=ImprestSurrender."Shortcut Dimension 2 Code";
              GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                IF GenJnLine.Amount<>0 THEN
                  GenJnLine.INSERT;
              //Create Receipt IF Chosen
              IF Selection=1 THEN BEGIN
                  //Insert Header
                  ImprestSurrender.CALCFIELDS("Remaining Amount");
                  IF ImprestSurrender."Remaining Amount">0 THEN BEGIN
                  IF ImprestSurrender."Receipt Created"=FALSE THEN BEGIN
                  {
                  ReceiptHeader.INIT;
                  ReceiptHeader."No.":=NoSeriesMgt.GetNextNo(GLSetup."Receipt Nos",TODAY,TRUE);
                  ReceiptHeader.Date:=ImprestSurrender."Imprest Surrender Date";
                  ReceiptHeader."Received From":=ImprestSurrender.Payee;
                  ReceiptHeader."On Behalf Of":=ImprestSurrender."On behalf of";
                  ReceiptHeader."Global Dimension 1 Code":=ImprestSurrender."Global Dimension 1 Code";
                  ReceiptHeader."Global Dimension 2 Code":=ImprestSurrender."Global Dimension 2 Code";
                  IF NOT ReceiptHeader.GET(ReceiptHeader."No.") THEN
                  ReceiptHeader.INSERT;
                  }
                  END;
                  END;
              END;
               //Expenses
               ImprestLines.RESET;
               ImprestLines.SETRANGE(ImprestLines.No,ImprestSurrender."No.");
               IF ImprestLines.FINDFIRST THEN BEGIN
                REPEAT
                LineNo:=LineNo+10000;
                GenJnLine.INIT;
                GenJnLine."Journal Template Name":=CMSetup."Imprest Surrender Template";
                GenJnLine."Journal Batch Name":=ImprestSurrender."No.";
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=ImprestLines."Account Type";
                  IF GenJnLine."Account Type" = ImprestLines."Account Type"::"Fixed Asset" THEN
                  GenJnLine."FA Posting Type":=GenJnLine."FA Posting Type"::"Acquisition Cost";
                GenJnLine."Account No.":=ImprestLines."Account No.";
                GenJnLine.VALIDATE("Account No.");
                GenJnLine."Posting Date":=TODAY";
                GenJnLine."Document No.":=ImprestSurrender."No.";
                GenJnLine.Description:=ImprestLines.Description;
                GenJnLine.Amount:=ImprestLines."Actual Spent";
                GenJnLine.VALIDATE(Amount);
                //Set these fields to blanks
                GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                GenJnLine.VALIDATE("Gen. Posting Type");
                GenJnLine."Gen. Bus. Posting Group":='';
                GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                GenJnLine."Gen. Prod. Posting Group":='';
                GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                GenJnLine."VAT Bus. Posting Group":='';
                GenJnLine.VALIDATE("VAT Bus. Posting Group");
                GenJnLine."VAT Prod. Posting Group":='';
                GenJnLine.VALIDATE("VAT Prod. Posting Group");
                //
                GenJnLine."Shortcut Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
                GenJnLine."Shortcut Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                //Ushindi...Insert Job Nos
                GenJnLine."Job No.":=ImprestLines."Job No.";
                GenJnLine.VALIDATE(GenJnLine."Job No.");
                GenJnLine."Job Task No.":=ImprestLines."Job Task No.";
                //MESSAGE('Tuko hapa!');
                GenJnLine.VALIDATE(GenJnLine."Job Task No.");
                GenJnLine."Job Quantity":=ImprestLines."Job Quantity";
                GenJnLine.VALIDATE(GenJnLine."Job Quantity");
                //End Of Ushindi changes
                IF GenJnLine.Amount<>0 THEN
                  GenJnLine.INSERT;
                //Insert Receipt Lines
                IF Selection=1 THEN BEGIN
                   IF ImprestLines."Remaining Amount">0 THEN BEGIN
                      IF ImprestSurrender."Receipt Created"=FALSE THEN BEGIN
                      {
                      ReceiptLine.INIT;
                      ReceiptLine."Line No":=LineNo;
                      ReceiptLine."Receipt No.":=ReceiptHeader."No.";
                      ReceiptLine."Account Type":=ImprestSurrender."Account Type";
                      ReceiptLine."Account No.":=ImprestSurrender."Account No.";
                      ReceiptLine."Account Name":=ImprestSurrender."Account Name";
                      ReceiptLine.Description:=ImprestLines.Description;
                      ReceiptLine.Amount:=ImprestLines."Remaining Amount";
                      ReceiptLine."Global Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                      ReceiptLine."Global Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                      IF NOT ReceiptLine.GET(ReceiptLine."Line No",ReceiptLine."Receipt No.") THEN
                       ReceiptLine.INSERT;
                      }
                      END;
                   END;
                END;
                UNTIL ImprestLines.NEXT=0;
              END;
              CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnLine);
              { GLEntry.RESET;
               GLEntry.SETRANGE(GLEntry."Document No.",ImprestSurrender."No.");
               GLEntry.SETRANGE(GLEntry.Reversed,FALSE);
               GLEntry.SETRANGE("Posting Date",TODAY);
               IF GLEntry.FINDFIRST THEN BEGIN}
               ImprestSurrender.Surrendered:=TRUE;
               IF Selection=1 THEN
               ImprestSurrender."Receipt Created":=TRUE;
               ImprestSurrender.MODIFY;
               //Uncommit Entries made to the varoius expenses accounts
               Committment.UncommitImprest(ImprestSurrender);
               //END;
            END;
            */
    end;

    procedure PostPettyCash(PCASH: Record Payments)
    var
        PCASHLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        PCLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
    begin
        if Confirm('Are you sure you want to post the Petty Cash Voucher No. ' + PCASH."No." + ' ?') = true then begin
            if PCASH.Status <> PCASH.Status::Released then Error('The Petty Cash Voucher No %1 has not been fully approved', PCASH."No.");
            if PCASH.Posted then Error('Petty Cash Voucher %1 has been posted', PCASH."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Petty Cash Template";
            JBatch := PCASH."No."; // Temp."Petty Cash Batch";
            if JTemplate = '' then begin
                Error('Ensure the Petty Cash Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Petty Cash Batch is set up in the Cash Office Setup')
            end;
            PCASH.TestField(Date);
            PCASH.TestField("Paying Bank Account");
            //PCASH.TESTFIELD(PCASH.Payee);
            PCASH.TestField(PCASH."Pay Mode");
            if PCASH."Payment Release Date" = 0D then Error('Kindly input posting date');
            PaymentMethod.Get(PCASH."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                PCASH.TestField(PCASH."Cheque No");
                PCASH.TestField(PCASH."Cheque Date");
            end;
            //Check Commitment
            PCASHLines.Reset;
            PCASHLines.SetRange(No, PCASH."No.");
            if PCASHLines.Find('-') then begin
                repeat
                    if IsAccountVotebookEntry(PCASHLines."Account No") then begin
                        Commitment.FetchDimValue(PCASHLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetup.Get;
                        //DimValue.GET(GLSetup."Shortcut Dimension 1 Code",ShortcutDimValue[1]);
                        //DimValueName:=DimValue.Name;
                        if not Commitment.LineCommitted(PCASH."No.", PCASHLines."Account No", PCASHLines."Line No") then Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                    end;
                until PCASHLines.Next = 0;
            end;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                PCASH.TestField("Cheque No");
                PCASH.TestField("Cheque Date");
            end;
            //Check Lines
            PCASH.CalcFields("Petty Cash Amount");
            if PCASH."Petty Cash Amount" = 0 then Error('Amount cannot be zero');
            PCASHLines.Reset;
            PCASHLines.SetRange(PCASHLines.No, PCASH."No.");
            if not PCASHLines.FindLast then Error('Petty Cash voucher Lines cannot be empty');
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Bank Entries
            LineNo := LineNo + 10000;
            PCASH.CalcFields(PCASH."Petty Cash Amount");
            PCASHLines.Reset;
            PCASHLines.SetRange(PCASHLines.No, PCASH."No.");
            PCASHLines.Validate(PCASHLines.Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := PCASH."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if PCASH.Date = 0D then Error('You must specify the PCASH date');
            GenJnLine."Posting Date" := PCASH."Payment Release Date"; //TODAY;
            GenJnLine."Document No." := PCASH."No.";
            GenJnLine."External Document No." := PCASH."Cheque No";
            GenJnLine."Payment Method Code" := PCASH."Pay Mode";
            GenJnLine.Description := format(PCASH."Payment Narration", 70) + ' ' + PCASH.Payee; //+'Pay To:'+PCASH.Payee;
            GenJnLine.Amount := -PCASH."Petty Cash Amount";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount); //
            GenJnLine.Validate("Bal. Account No.");
            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::Customer;
            GenJnLine."Bal. Account No." := PCASH."Account No.";
            GenJnLine.Validate("Bal. Account No.");
            GenJnLine."Posting Group" := GetCustomerPostingGroup(PCASH."Account No.");
            GenJnLine."Shortcut Dimension 1 Code" := PCASH."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PCASH."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := PCASH."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //End of Posting Withholding Tax
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", PCASH."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                //Encumber
                //   Commitment.EncumberPayments(PCASH);
                //
            end;
            PCASH.Posted := true;
            PCASH."Posted By" := UserId;
            PCASH."Posted Date" := Today;
            PCASH."Time Posted" := Time;
            PCASH.Modify;
            //Update Petty Cash Lines
            UpdatePCLines(PCASH);
        end;
    end;

    procedure PostStaffClaim(Claim: Record Payments)
    var
        ClaimLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        CLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
        ChequePayment: Boolean;
        ChequeRegister: Record "Cheque Register";
    begin
        ChequePayment := false;
        Claim.TestField("Posting Date");
        if Confirm('Are you sure you want to post the Staff Claim No. ' + Claim."No." + ' ?') = true then begin
            if Claim.Status <> Claim.Status::Released then Error('The Staff Claim No %1 has not been fully approved', Claim."No.");
            if Claim.Posted then Error('Staff Claim %1 has been posted', Claim."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Claim Template";
            JBatch := Claim."No."; // Temp."Claim  Batch";
            if JTemplate = '' then begin
                Error('Ensure the Claims Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Claims Batch is set up in the Cash Office Setup')
            end;
            //Check Apportionment
            if Claim.Apportion then Apportionment.CheckApportionment(Claim."No.");
            Claim.TestField(Date);
            Claim.TestField("Paying Bank Account");
            //Claim.TESTFIELD(Claim.Payee);
            Claim.TestField(Claim."Pay Mode");
            PaymentMethod.Get(Claim."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField(Claim."Cheque No");
                Claim.TestField(Claim."Cheque Date");
                ChequePayment := true;
            end;
            //Check Commitment
            ClaimLines.Reset;
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then begin
                repeat
                    if IsAccountVotebookEntry(ClaimLines."Account No") then begin
                        Commitment.FetchDimValue(ClaimLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetup.Get;
                        //DimValue.GET(GLSetup."Shortcut Dimension 1 Code",ShortcutDimValue[1]);
                        //DimValueName:=DimValue.Name;
                        // if not Commitment.LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No") then
                        //     Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                    end;
                until ClaimLines.Next = 0;
            end;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField("Cheque No");
                Claim.TestField("Cheque Date");
            end;
            //Check Lines
            Claim.CalcFields("Petty Cash Amount");
            if Claim."Petty Cash Amount" = 0 then Error('Amount cannot be zero');
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if not ClaimLines.FindLast then Error('Staff Claim Lines cannot be empty');
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if ClaimLines.Find('-') then begin
                repeat
                    ClaimLines.TestField("Expenditure Date");
                    //ClaimLines.TESTFIELD("Claim Receipt No.");
                    ClaimLines.TestField("Expenditure Description");
                until ClaimLines.Next = 0;
            end;
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Bank Entries
            LineNo := LineNo + 10000;
            Claim.CalcFields(Claim."Petty Cash Amount");
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            ClaimLines.Validate(ClaimLines.Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Claim."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if Claim.Date = 0D then Error('You must specify the Claim date');
            GenJnLine."Posting Date" := Claim."Posting Date";
            GenJnLine."Document No." := Claim."No.";
            if ChequePayment then begin
                GenJnLine."External Document No." := Claim."Cheque No";
                GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; //inserts check ledger entry
            end;
            GenJnLine."Payment Method Code" := Claim."Pay Mode";
            GenJnLine.Description := 'Staff Claim:' + Claim.Payee;
            GenJnLine.Amount := -Claim."Petty Cash Amount";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Claim."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Claim."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Claim."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Claim Entries
            ClaimLines.Reset;
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then begin
                repeat
                    ClaimLines.Validate(ClaimLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ClaimLines."Account Type";
                    GenJnLine."Account No." := ClaimLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine."Posting Date" := Claim."Posting Date";
                    GenJnLine."Document No." := Claim."No.";
                    GenJnLine."External Document No." := Claim."Cheque No";
                    GenJnLine."Payment Method Code" := Claim."Pay Mode";
                    GenJnLine.Description := format(ClaimLines.Description, 90);
                    GenJnLine.Amount := ClaimLines.Amount;
                    GenJnLine."Currency Code" := Claim.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    // GenJnLine."Reason Code" := ClaimLines."General Expense Code";
                    //    GenJnLine."Applies-to Doc. No.":=ClaimLines."Applies-to Doc. No.";
                    //    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    //    GenJnLine."Applies-to ID":=ClaimLines."Applies-to ID";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until ClaimLines.Next = 0;
            end;
            //End of Posting Withholding Tax
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Claim."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                Claim.Posted := true;
                Claim."Posted By" := UserId;
                Claim."Posted Date" := Claim."Posting Date";
                Claim."Time Posted" := Time;
                Claim.Modify;
                if Claim."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset;
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Claim."No.");
                    if CheckLedgerEntry.FindFirst then begin
                        CheckLedgerEntry."Check No." := Claim."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify;
                    end;
                    //Modify Cheque as Posted in cheque register
                    if Claim."Cheque Type" = Claim."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset;
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Claim."Cheque No");
                        if ChequeRegister.FindFirst then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Claim."Cheque Date";
                            ChequeRegister."Posted By" := UserId;
                            ChequeRegister.Modify;
                        end;
                    end;
                end;
                //Encumber
                //Commitment.EncumberPayments(Claim);
                //Apportion Card
                if Claim.Apportion then Apportionment.CreatePaymentApportionEntry(Claim);
            end;
        end;
    end;

    procedure PostInterBank(InterBank: Record Payments)
    var
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        CLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
    begin
        if Confirm('Are you sure you want to post the Bank Transfer No. ' + InterBank."No." + ' ?') = true then begin
            if InterBank.Status <> InterBank.Status::Released then Error('The Bank Transfer No %1 has not been fully approved', InterBank."No.");
            if InterBank.Posted then Error('Bank Transfer %1 has been posted', InterBank."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Inter Bank Template Name";
            JBatch := InterBank."No."; // Temp."Inter Bank Batch Name";
            if JTemplate = '' then begin
                Error('Ensure the Petty Cash Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Petty Cash Batch is set up in the Cash Office Setup')
            end;
            InterBank.TestField(Date);
            // IF InterBank."Receiving Amount LCY"<>InterBank."Source Amount LCY" THEN
            //  ERROR('Receiving Amount of %3.%1 must be same as Source Amount %4.%2',InterBank."Receiving Bank Amount",InterBank."Source Bank Amount",InterBank.Currency,InterBank."Source Currency");
            //Check Amounts
            InterBank.CalcFields("Petty Cash Amount");
            if InterBank."Receiving Bank Amount" = 0 then Error('Amount cannot be zero');
            if InterBank."Receiving Amount LCY" <> InterBank."Source Amount LCY" then Error('Please make sure both Receiving and Source Amounts are the same');
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Receiving Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Account No.";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then Error('You must specify the InterBank date');
            //  GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := InterBank.Date;
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := InterBank."Pay Mode";
            GenJnLine.Description := InterBank."Payment Narration"; //'Inter Bank Transfer from '+InterBank."Source Bank"+' Bank';
            GenJnLine.Amount := InterBank."Receiving Bank Amount";
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Currency Code" := InterBank.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Source Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Source Bank";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then Error('You must specify the InterBank date');
            //  GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := InterBank.Date;
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := InterBank."Pay Mode";
            GenJnLine.Description := InterBank."Payment Narration"; //'Inter Bank Transfer to '+InterBank."Account No."+' Bank';
            GenJnLine.Amount := -InterBank."Source Bank Amount";
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Currency Code" := InterBank."Source Currency";
            GenJnLine.Validate("Currency Code");
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //End of Posting
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", InterBank."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                InterBank.Posted := true;
                InterBank."Posted By" := UserId;
                InterBank."Posted Date" := Today;
                InterBank."Time Posted" := Time;
                InterBank.Modify;
            end;
        end;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        Cents: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText026)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, WText027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END
                ELSE IF (Tens * 10 + Ones) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
            Cents := Round(No, 2) * 100;
        END;
        IF Cents = 0 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, '')
        ELSE IF Cents <= 20 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'AND ' + OnesText[Cents] + ' ' + CentsTxt + ' ')
        ELSE BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText028 + ' '); // + ' CENTS ');
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[(Cents MOD 100) DIV 10]);
            IF Cents MOD 10 <> 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Cents MOD 10] + ' ' + CentsTxt)
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + CentsTxt);
        END;
        IF CurrencyCode <> '' THEN AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
        /*AddToNoText(NoText,NoTextIndex,PrintExponent,WText028);
            DecimalPosition:=GetDecimalPosition;

            CentsValue:= No * DecimalPosition;

            //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');
            AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition)+' '+CentsTxt));
            IF CurrencyCode <> '' THEN
              AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);*/
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then Error(WText029, AddText);
        end;
        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := WText032;
        OnesText[2] := WText033;
        OnesText[3] := WText034;
        OnesText[4] := WText035;
        OnesText[5] := WText036;
        OnesText[6] := WText037;
        OnesText[7] := WText038;
        OnesText[8] := WText039;
        OnesText[9] := WText040;
        OnesText[10] := WText041;
        OnesText[11] := WText042;
        OnesText[12] := WText043;
        OnesText[13] := WText044;
        OnesText[14] := WText045;
        OnesText[15] := WText046;
        OnesText[16] := WText047;
        OnesText[17] := WText048;
        OnesText[18] := WText049;
        OnesText[19] := WText050;
        TensText[1] := '';
        TensText[2] := WText051;
        TensText[3] := WText052;
        TensText[4] := WText053;
        TensText[5] := WText054;
        TensText[6] := WText055;
        TensText[7] := WText056;
        TensText[8] := WText057;
        TensText[9] := WText058;
        ExponentText[1] := '';
        ExponentText[2] := WText059;
        ExponentText[3] := WText060;
        ExponentText[4] := WText061;
    end;

    procedure "Post ImprestSurrender"(var Imprest: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        ExtImprestLines: Record "Ext Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        ImprestHeader: Record Payments;
        Commitment: Codeunit Committment;
        IsActivity: Boolean;
        WP: Record "Activity Work Programme";
    begin
        if Confirm(Text007, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then Error(Text008, Imprest."No.");
            Imprest.TestField("Imprest Issue Doc. No");
            Imprest.TestField("Posting Date");
            //Imprest.CalcFields("Imprest Amount", Imprest."Actual Amount Spent", "Cash Receipt Amount");
            if Imprest."Imprest Amount" = 0 then Error(Text005);
            // IF Imprest."Actual Amount Spent"=0 THEN
            //  ERROR(Text016);
            if Imprest.Surrendered then Error(Text013, Imprest."No.");
            if Imprest.Apportion then Apportionment.CheckApportionment(Imprest."No.");
            IsActivity := false;
            //Get surrender template
            Temp.Get(UserId);
            JTemplate := Temp."Imprest Sur Template";
            JBatch := Temp."Imprest Sur Batch"; //Imprest."No."; //
            if JTemplate = '' then begin
                Error('Ensure the Imprest Surrender Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Imprest Surrender Batch is set up in the Cash Office Setup')
            end;
            CMSetup.Get();
            //CMSetup.TESTFIELD("Imprest Due Date");
            CMSetup.TestField(CMSetup."Imprest Surrender Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            LineNo := LineNo + 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
            GenJnLine."Posting Group" := GetCustomerPostingGroup(Imprest."Account No.");
            GenJnLine."Account No." := Imprest."Account No.";
            GenJnLine."Posting Date" := Imprest."Posting Date";
            GenJnLine."Document No." := Imprest."No.";
            GenJnLine."External Document No." := Imprest."Imprest Issue Doc. No";
            GenJnLine.Description := 'Imprest Surrendered by: ' + Imprest.Payee;
            GenJnLine.Amount := -Imprest."Actual Amount Spent";
            GenJnLine."Currency Code" := Imprest.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine."Applies-to Doc. No." := Imprest."Imprest Issue Doc. No";//GetImprestPostedPV(Imprest."Imprest Issue Doc. No");
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            GenJnLine."Customer Transaction Type" := GenJnLine."Customer Transaction Type"::Imprest;
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            /*// Post receipt or payment to  the customer
             LineNo:=LineNo+10000;
             GenJnLine.INIT;
                IF CMSetup.GET THEN
             GenJnLine."Journal Template Name":=JTemplate;
             GenJnLine."Journal Batch Name":=Imprest."No.";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
             GenJnLine."Account No.":=Imprest."Account No.";
             GenJnLine.VALIDATE(GenJnLine."Account No.");
             GenJnLine."Posting Date":=TODAY;
             GenJnLine."Document No.":=Imprest."No.";
             GenJnLine."External Document No.":=Imprest."Cheque No";
             GenJnLine."Payment Method Code":=Imprest."Pay Mode";
             GenJnLine.Description:=Imprest."Account Name";
             GenJnLine.Amount:=(Imprest."Actual Amount Spent"-Imprest."Imprest Amount");
             GenJnLine."Currency Code":=Imprest.Currency;
             GenJnLine.VALIDATE("Currency Code");
             GenJnLine.VALIDATE(GenJnLine.Amount);
             GenJnLine."Bal. Account Type":=GenJnLine."Account Type"::"Bank Account";
             GenJnLine."Bal. Account No.":=Imprest."Paying Bank Account";
             GenJnLine.VALIDATE("Bal. Account No.");
             GenJnLine."Shortcut Dimension 1 Code":=ImprestLines."Shortcut Dimension 1 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=ImprestLines."Shortcut Dimension 2 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
             GenJnLine."Dimension Set ID":=ImprestLines."Dimension Set ID";
             GenJnLine.VALIDATE(GenJnLine."Dimension Set ID");
             //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
             //GenJnLine."Applies-to Doc. No.":=Imprest."Imprest Issue Doc. No";
             GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
             IF GenJnLine.Amount<0 THEN
             GenJnLine.INSERT;*/
            //IMP surrender Lines Entries
            //Check if Activity Imprest
            ImprestHeader.Get(Imprest."Imprest Issue Doc. No");
            // if ImprestHeader.Type = ImprestHeader.Type::Activity then begin
            //     IsActivity := true;
            //     ImprestLines.Reset;
            //     ImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            //     ImprestLines.SetRange(No, Imprest."No.");
            //     ImprestLines.SetFilter("Activity Work Programme", '<>%1', '');
            //     if ImprestLines.Find('-') then begin
            //         WP.Get(ImprestLines."Activity Work Programme");
            //         LineNo := LineNo + 10000;
            //         GenJnLine.Init;
            //         GenJnLine."Journal Template Name" := JTemplate;
            //         GenJnLine."Journal Batch Name" := JBatch;
            //         GenJnLine."Line No." := LineNo;
            //         GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
            //         GenJnLine."Account No." := WP."Account No";
            //         GenJnLine.Validate(GenJnLine."Account No.");
            //         if Imprest."Surrender Date" = 0D then
            //             Error('You must specify the surrender date');
            //         GenJnLine."Posting Date" := Today;
            //         GenJnLine."Document No." := Imprest."No.";
            //         //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
            //         GenJnLine.Description := format(WP.Description, 90);
            //         GenJnLine.Amount := Imprest."Actual Amount Spent";
            //         GenJnLine."Currency Code" := Imprest.Currency;
            //         GenJnLine.Validate("Currency Code");
            //         GenJnLine.Validate(GenJnLine.Amount);
            //         GenJnLine."Shortcut Dimension 1 Code" := WP."Shortcut Dimension 1 Code";
            //         GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            //         GenJnLine."Shortcut Dimension 2 Code" := WP."Shortcut Dimension 2 Code";
            //         GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            //         GenJnLine."Dimension Set ID" := WP."Dimension Set ID";
            //         GenJnLine.Validate(GenJnLine."Dimension Set ID");
            //         //GenJnLine."VAT Bus. Posting Group":='LOCAL';
            //         //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
            //         if GenJnLine.Amount <> 0 then
            //             GenJnLine.Insert;
            //     end;
            // end else begin
            ImprestLines.Reset;
            ImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then begin
                repeat
                    ImprestLines.Validate(ImprestLines.Amount);
                    ImprestLines.TestField(Purpose);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ImprestLines."Account Type";
                    GenJnLine."Account No." := ImprestLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if Imprest."Surrender Date" = 0D then Error('You must specify the surrender date');
                    GenJnLine."Posting Date" := Imprest."Posting Date";
                    GenJnLine."Document No." := Imprest."No.";
                    //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                    GenJnLine.Description := format(ImprestLines.Purpose, 90);
                    GenJnLine.Amount := ImprestLines."Actual Spent";
                    GenJnLine."Currency Code" := Imprest.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
                    GenJnLine.Validate("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
                    GenJnLine.Validate("Shortcut Dimension 2 Code");
                    //GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
                    // GenJnLine."Reason Code" := ImprestLines."General Expense Code";
                    //GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                    //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    if Imprest."Cash Receipt Amount" <> 0 then begin
                        //Receipt Lines Entries
                        if (ImprestLines."Cash Receipt Amount" <> 0) and (ImprestLines."Imprest Receipt No." = '') then begin
                            ImprestLines.TestField("Receiving Bank");
                            LineNo := LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                            GenJnLine."Account No." := Imprest."Account No.";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine."Posting Group" := GetCustomerPostingGroup(Imprest."Account No.");
                            GenJnLine."Posting Date" := Imprest."Posting Date";
                            GenJnLine."Document No." := Imprest."No.";
                            GenJnLine."External Document No." := Imprest."Cheque No";
                            GenJnLine."Payment Method Code" := Imprest."Pay Mode";
                            GenJnLine.Description := Imprest."Account Name";
                            GenJnLine.Amount := -ImprestLines."Cash Receipt Amount";
                            GenJnLine."Currency Code" := Imprest.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                            GenJnLine."Bal. Account No." := ImprestLines."Receiving Bank";
                            GenJnLine.Validate("Bal. Account No.");

                            // GenJnLine."Reason Code" := ImprestLines."General Expense Code";
                            //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                            GenJnLine."Applies-to Doc. No." := Imprest."Imprest Issue Doc. No";// GetImprestPostedPV(Imprest."Imprest Issue Doc. No");
                            GenJnLine."Customer Transaction Type" := GenJnLine."Customer Transaction Type"::Imprest;
                            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                            // GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                            // GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            // GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                            // GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            // GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                            //GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
                            GenJnLine.Validate("Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
                            GenJnLine.Validate("Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        end;
                    end;
                until ImprestLines.Next = 0;
            end;
            //External Imprest Surrender Lines
            ExtImprestLines.Reset;
            ExtImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            ExtImprestLines.SetRange(No, Imprest."No.");
            if ExtImprestLines.Find('-') then begin
                repeat
                    ExtImprestLines.Validate(ExtImprestLines.Amount);
                    ExtImprestLines.TestField(Purpose);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ExtImprestLines."Account Type";
                    GenJnLine."Account No." := ExtImprestLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if Imprest."Surrender Date" = 0D then Error('You must specify the surrender date');
                    GenJnLine."Posting Date" := Imprest."Posting Date";
                    GenJnLine."Document No." := Imprest."No.";
                    //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                    GenJnLine.Description := format(ExtImprestLines.Purpose, 90);
                    GenJnLine.Amount := ExtImprestLines."Actual Spent";
                    GenJnLine."Currency Code" := Imprest.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ExtImprestLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ExtImprestLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ExtImprestLines."Dimension Set ID";
                    // GenJnLine."Reason Code" := ImprestLines."General Expense Code";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                    //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    if Imprest."Cash Receipt Amount" <> 0 then begin
                        //Receipt Lines Entries
                        if (ExtImprestLines."Cash Receipt Amount" <> 0) and (ExtImprestLines."Imprest Receipt No." = '') then begin
                            ExtImprestLines.TestField("Receiving Bank");
                            LineNo := LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                            GenJnLine."Account No." := Imprest."Account No.";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine."Posting Group" := GetCustomerPostingGroup(Imprest."Account No.");
                            GenJnLine."Posting Date" := Imprest."Posting Date";
                            GenJnLine."Document No." := Imprest."No.";
                            GenJnLine."External Document No." := Imprest."Cheque No";
                            GenJnLine."Payment Method Code" := Imprest."Pay Mode";
                            GenJnLine.Description := Imprest."Account Name";
                            GenJnLine.Amount := -ExtImprestLines."Cash Receipt Amount";
                            GenJnLine."Currency Code" := Imprest.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                            GenJnLine."Bal. Account No." := ExtImprestLines."Receiving Bank";
                            GenJnLine.Validate("Bal. Account No.");

                            // GenJnLine."Reason Code" := ImprestLines."General Expense Code";
                            //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                            GenJnLine."Applies-to Doc. No." := Imprest."Imprest Issue Doc. No";//GetImprestPostedPV(Imprest."Imprest Issue Doc. No");
                            GenJnLine."Customer Transaction Type" := GenJnLine."Customer Transaction Type"::Imprest;
                            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                            GenJnLine."Shortcut Dimension 1 Code" := ExtImprestLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := ExtImprestLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := ExtImprestLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        end;
                    end;
                until ExtImprestLines.Next = 0;
            end;
        end;
        CheckIfBalancing(JTemplate, JBatch);
        GenJnLine.Reset;
        GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
        GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
        GLEntry.Reset;
        GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
        GLEntry.SetRange(GLEntry.Reversed, false);
        if GLEntry.FindFirst then begin
            //Imprest.MODIFY(TRUE);    //Carol
            Imprest.Posted := true;
            Imprest."Posted By" := UserId;
            Imprest."Posted Date" := Imprest."Posting Date";
            Imprest."Time Posted" := Time;
            Imprest.Surrendered := true;
            Imprest."Surrender Date" := Imprest."Posting Date";
            Imprest."Surrendered By" := UserId;
            Imprest.Modify;
            //Create a Payment Voucher or Petty Cash if there's a receipted amount
            //Imprest.CalcFields("Cash Receipt Amount", "Actual Amount Spent", "Imprest Amount");
            if Imprest."Actual Amount Spent" > Imprest."Imprest Amount" then begin
                CreatePVPettyCash(Imprest);
            end;
            //Uncommit Entries made to the varoius expenses accounts
            // if IsActivity then
            //     Commitment.UncommitWP(ImprestHeader)
            // else
            //     Commitment.UnencumberImprest(Imprest);
            Commit;
            ImprestHeader.Reset;
            ImprestHeader.SetRange(ImprestHeader."No.", Imprest."Imprest Issue Doc. No");
            if ImprestHeader.Find('-') then begin
                ImprestHeader.Surrendered := true;
                ImprestHeader."Surrender Date" := Imprest."Surrender Date";
                ImprestHeader."Surrendered By" := Imprest."Surrendered By";
                ImprestHeader.Modify;
            end;
            if Imprest.Apportion then Apportionment.CreatePaymentApportionEntry(Imprest);
        end;
    end;
    // end;
    procedure GetCustomerPostingGroup(DocNo: Code[20]): Code[20]
    var
        Cust: Record Customer;
    begin
        Cust.SetRange("No.", DocNo);
        if Cust.FindFirst() then begin
            Cust.TestField("Imprest Posting Group");
            exit(Cust."Imprest Posting Group");
        end;
    end;

    procedure PostPettyCashSurrender(var PCash: Record Payments)
    var
        PCLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        PaymentRec: Record Payments;
        Commitment: Codeunit Committment;
    begin
        if Confirm(Text014, false, PCash."No.") = true then begin
            if PCash.Status <> PCash.Status::Released then Error(Text003, PCash."No.");
            PCash.TestField("Surrender Date");
            PCash.CalcFields("Petty Cash Amount", PCash."Actual Petty Cash Amount Spent");
            if PCash."Petty Cash Amount" = 0 then Error(Text005);
            if PCash."Payment Release Date" = 0D then Error('Please input posting date');
            // IF PCash."Actual Petty Cash Amount Spent"=0 THEN
            //  ERROR(Text016);
            if PCash."Remaining Amount" <> 0 then Error(Text020);
            if PCash.Surrendered then Error(Text015, PCash."No.");
            if PCash.Apportion then Apportionment.CheckApportionment(PCash."No.");
            CMSetup.Get();
            CMSetup.TestField("Petty Cash Surrender Template");
            GenJnLine.Reset;
            GenJnLine.SetRange("Journal Template Name", CMSetup."Petty Cash Surrender Template");
            GenJnLine.SetRange("Journal Batch Name", PCash."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            Batch."Journal Template Name" := CMSetup."Petty Cash Surrender Template";
            Batch.Name := PCash."No.";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            LineNo := 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name" := CMSetup."Petty Cash Surrender Template";
            GenJnLine."Journal Batch Name" := PCash."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
            GenJnLine."Account No." := PCash."Account No.";
            GenJnLine."Posting Group" := GetCustomerPostingGroup(PCash."Account No.");
            GenJnLine."Posting Date" := PCash."Payment Release Date";
            GenJnLine."Document No." := PCash."No.";
            GenJnLine.Description := 'Petty Cash Surrendered by: ' + PCash.Payee;
            GenJnLine.Amount := -PCash."Actual Petty Cash Amount Spent";
            GenJnLine.Validate(Amount);
            GenJnLine."Currency Code" := PCash.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine."Shortcut Dimension 1 Code" := PCash."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PCash."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := PCash."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::" ";
            GenJnLine."Applies-to Doc. No." := PCash."Petty Cash Issue Doc.No";
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Petty Cash surrender Lines Entries
            PCLines.Reset;
            PCLines.SetRange(PCLines.No, PCash."No.");
            if PCLines.FindFirst then begin
                repeat
                    PCLines.Validate(PCLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := CMSetup."Petty Cash Surrender Template";
                    GenJnLine."Journal Batch Name" := PCash."No.";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PCLines."Account Type";
                    GenJnLine."Account No." := PCLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if PCash."Surrender Date" = 0D then Error('You must specify the surrender date');
                    GenJnLine."Posting Date" := PCash."Payment Release Date";
                    GenJnLine."Document No." := PCash."No.";
                    PCLines.TestField(Purpose);
                    GenJnLine.Description := CopyStr(PCLines.Purpose, 1, 100);
                    GenJnLine.Amount := PCLines."Actual Spent";
                    GenJnLine."Currency Code" := PCash.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := PCLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PCLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate("Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PCLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::Sale;
                    // GenJnLine."Reason Code" := PCLines."General Expense Code";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    //Receipt Lines Entries
                    if PCLines."Cash Receipt Amount" <> 0 then begin
                        PCLines.TestField("Receiving Bank");
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Petty Cash Surrender Template";
                        GenJnLine."Journal Batch Name" := PCash."No.";
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                        GenJnLine."Posting Group" := GetCustomerPostingGroup(PCash."Account No.");
                        GenJnLine."Account No." := PCash."Account No.";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        GenJnLine."Posting Date" := PCash."Payment Release Date";
                        GenJnLine."Document No." := PCash."No.";
                        GenJnLine."External Document No." := PCash."Cheque No";
                        GenJnLine."Payment Method Code" := PCash."Pay Mode";
                        GenJnLine.Description := PCash."Account Name";
                        GenJnLine.Amount := -PCLines."Cash Receipt Amount";
                        GenJnLine."Currency Code" := PCash.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                        GenJnLine."Bal. Account No." := PCLines."Receiving Bank";
                        GenJnLine.Validate("Bal. Account No.");
                        GenJnLine."Shortcut Dimension 1 Code" := PCLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PCLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PCLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::" ";
                        GenJnLine."Applies-to Doc. No." := PCash."Petty Cash Issue Doc.No";
                        // GenJnLine."Reason Code" := PCLines."General Expense Code";
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    end;
                until PCLines.Next = 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", PCash."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            //GLEntry.SETRANGE("Posting Date",PCash."Payment Release Date");
            if GLEntry.FindFirst then begin
                PCash.Posted := true;
                PCash."Posted By" := UserId;
                PCash."Posted Date" := Today;
                PCash."Time Posted" := Time;
                PCash.Surrendered := true;
                PCash."Surrendered By" := UserId;
                PCash."Date Surrendered" := Today;
                PCash.Modify;
                //PaymentRec.SETRANGE("Petty Cash Issue Doc.No",PCash."No.");
                PaymentRec.Reset;
                PaymentRec.SetRange("No.", PCash."Petty Cash Issue Doc.No");
                if PaymentRec.Find('-') then begin
                    PaymentRec."Surrender Date" := PCash."Surrender Date";
                    PaymentRec."Surrendered By" := PCash."Surrendered By";
                    PaymentRec.Surrendered := true;
                    PaymentRec.Modify(true);
                end;
                /*IF PaymentRec.GET(PaymentRec."Payment Type"::"Petty Cash",PCash."Petty Cash Issue Doc. No") THEN BEGIN
                   PaymentRec.Surrendered:=TRUE;
                   PaymentRec.MODIFY;
                END;*/
                //Carol
                //Uncommit Entries made to the varoius expenses accounts
                Commitment.UnencumberPettyCash(PCash);
                Commit;
                //Apportion
                if PCash.Apportion then Apportionment.CreatePaymentApportionEntry(PCash);
            end;
        end;
    end;

    local procedure UpdatePCLines(PCash: Record Payments)
    var
        PCLines: Record "Payment Lines";
        PVLines: Record "Payment Lines";
    begin
        /*
            PVLines.RESET;
            PVLines.SETRANGE(No,PCash."No.");
             IF PVLines.FIND('-') THEN
               REPEAT
                PCLines.INIT;
                PCLines.No:=PVLines.No;
                PCLines."Line No":=PVLines."Line No";
                PCLines."Account Type":=PVLines."Account Type";
                PCLines."Account No":=PVLines."Account No";
                PCLines."Account Name":=PVLines."Account Name";
                PCLines.Description:=PVLines.Description;
                PCLines.Amount:=PVLines.Amount;
                PCLines.VALIDATE(Amount);
                 IF NOT PCLines.GET(PCLines.No,PCLines."Line No") THEN
                 PCLines.INSERT;
               UNTIL
              PVLines.NEXT=0;
              */
    end;

    procedure PostReceipt(ReceiptRec: Record Payments)
    var
        RcptLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        PaymentMethod: Record "Payment Method";
    begin
        if Confirm(Text017, false, ReceiptRec."No.") = true then begin
            if ReceiptRec.Posted then Error(Text018, ReceiptRec."No.");
            ReceiptRec.TestField("Paying Bank Account");
            ReceiptRec.TestField("Received From");
            ReceiptRec.TestField(Date);
            ReceiptRec.TestField("Pay Mode");
            if ReceiptRec."Payment Release Date" = 0D then Error('Please input posting date');
            if PaymentMethod.Get(ReceiptRec."Pay Mode") then;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ReceiptRec.TestField("Cheque No");
                ReceiptRec.TestField("Cheque Date");
            end;
            ReceiptRec.CalcFields("Receipt Amount");
            ReceiptRec.CalcFields("Imp Surr Receipt Amount");
            //Check Lines
            RcptLines.Amount := ReceiptRec."Receipt Amount"; //Added this line to enable the receipts to pick the amount   //Carol
            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                if ReceiptRec."Receipt Amount" = 0 then Error('Amount cannot be zero');
            end;
            if ReceiptRec."Imprest Surrender Doc. No" <> '' then begin
                if ReceiptRec."Imp Surr Receipt Amount" = 0 then Error('Imprest Receipt Amount cannot be zero');
            end;
            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                RcptLines.Reset;
                //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
                RcptLines.SetRange(No, ReceiptRec."No.");
                if not RcptLines.FindLast then Error('Receipt Lines cannot be empty');
            end;
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Receipt Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", ReceiptRec."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := CMSetup."Receipt Template";
            Batch.Name := ReceiptRec."No.";
            if not Batch.Get(Batch."Journal Template Name", ReceiptRec."No.") then Batch.Insert;
            //Bank Entries
            LineNo := LineNo + 10000;
            RcptLines.Reset;
            //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
            RcptLines.SetRange(No, ReceiptRec."No.");
            RcptLines.Validate(Amount);
            RcptLines.CalcSums(Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
            GenJnLine."Journal Batch Name" := ReceiptRec."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := ReceiptRec."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if ReceiptRec.Date = 0D then Error('You must specify the Receipt date');
            //Removed under request of Utalii Accounts//
            //GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := ReceiptRec."Payment Release Date";
            GenJnLine."Document No." := ReceiptRec."No.";
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then GenJnLine."External Document No." := ReceiptRec."Cheque No";
            // if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::MPESA then
            // GenJnLine."External Document No." := ReceiptRec."Mpesa Reference";
            GenJnLine."Payment Method Code" := ReceiptRec."Pay Mode";
            GenJnLine.Description := ReceiptRec."Received From";
            if ReceiptRec."Imprest Surrender Doc. No" <> '' then
                GenJnLine.Amount := ReceiptRec."Imp Surr Receipt Amount"
            else
                GenJnLine.Amount := ReceiptRec."Receipt Amount";
            GenJnLine."Currency Code" := ReceiptRec.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := ReceiptRec."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ReceiptRec."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                //Receipt Lines Entries
                RcptLines.Reset;
                //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
                RcptLines.SetRange(No, ReceiptRec."No.");
                if RcptLines.FindFirst then begin
                    repeat
                        RcptLines.Validate(RcptLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
                        GenJnLine."Journal Batch Name" := ReceiptRec."No.";
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := RcptLines."Account Type";
                        GenJnLine."Account No." := RcptLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        GenJnLine."Posting Date" := ReceiptRec."Payment Release Date";
                        GenJnLine."Document No." := ReceiptRec."No.";
                        GenJnLine."External Document No." := ReceiptRec."Cheque No";
                        GenJnLine."Payment Method Code" := ReceiptRec."Pay Mode";
                        GenJnLine.Description := format(RcptLines.Description, 90);
                        GenJnLine.Amount := -RcptLines.Amount;
                        GenJnLine."Currency Code" := ReceiptRec.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                        GenJnLine."Gen. Posting Type" := RcptLines."Gen. Posting Type";
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        GenJnLine."Applies-to Doc. No." := RcptLines."Applies-to Doc. No.";
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        GenJnLine."Applies-to ID" := RcptLines."Applies-to ID";
                        if ReceiptRec."Payment Type" = ReceiptRec."Payment Type"::"Receipt-Property" then GenJnLine."Loan No" := ReceiptRec."TPS Loan No.";
                        if ReceiptRec."Deposit Receipt" then GenJnLine.Deposit := true;
                        if ReceiptRec."Service Charge Pmt" then GenJnLine."TPS Transaction Type" := GenJnLine."TPS Transaction Type"::"Service Charge Paid";
                        // GenJnLine."Reason Code" := RcptLines."General Expense Code";
                        //GenJnLine."Loan No." := RcptLines."TPS No.";
                        //Lydia
                        //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    until RcptLines.Next = 0;
                end;
            end
            else begin
                //Receipt Lines Entries
                RcptLines.Reset;
                RcptLines.SetRange(No, ReceiptRec."Imprest Surrender Doc. No");
                if RcptLines.FindFirst then begin
                    repeat
                        LineNo := LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
                        GenJnLine."Journal Batch Name" := ReceiptRec."No.";
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                        GenJnLine."Account No." := GetCustAccNo(ReceiptRec."Imprest Surrender Doc. No");
                        GenJnLine.Validate(GenJnLine."Account No.");
                        //Removed under request of Utalii Accounts//
                        //GenJnLine."Posting Date":=TODAY;
                        GenJnLine."Posting Date" := ReceiptRec."Payment Release Date";
                        GenJnLine."Document No." := ReceiptRec."No.";
                        GenJnLine."External Document No." := ReceiptRec."Cheque No";
                        GenJnLine."Payment Method Code" := ReceiptRec."Pay Mode";
                        GenJnLine.Description := format(RcptLines.Description, 90);
                        GenJnLine.Amount := -RcptLines."Cash Receipt Amount";
                        GenJnLine."Currency Code" := ReceiptRec.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                        GenJnLine."Applies-to Doc. No." := GetImprestForReceipt(ReceiptRec."Imprest Surrender Doc. No");
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        if ReceiptRec."Deposit Receipt" then GenJnLine.Deposit := true;
                        // GenJnLine."Reason Code" := RcptLines."General Expense Code";
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    until RcptLines.Next = 0;
                end;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", ReceiptRec."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                ReceiptRec.Posted := true;
                ReceiptRec."Posted Date" := Today;
                ReceiptRec."Time Posted" := Time;
                ReceiptRec."Posted By" := UserId;
                ReceiptRec.Modify;
                if ReceiptRec."Imprest Surrender Doc. No" <> '' then begin
                    RcptLines.Reset;
                    RcptLines.SetRange(No, ReceiptRec."Imprest Surrender Doc. No");
                    if RcptLines.Find('-') then
                        repeat
                            RcptLines."Imprest Receipt No." := ReceiptRec."No.";
                            RcptLines.Modify;
                        until RcptLines.Next = 0;
                end;
            end;
        end;
    end;

    procedure ApplyEntry(var Rec: Record "Payment Lines")
    var
        Text000: Label 'You must specify %1 or %2.';
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text002: Label 'Do you wish to continue?';
        Text003: Label 'The update has been interrupted to respect the warning.';
        Text005: Label 'The %1  must be Customer or Vendor.';
        Text006: Label 'All entries in one application must be in the same currency.';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies. ';
        PaymentRec: Record Payments;
    begin
        PaymentLine.Copy(Rec);
        PaymentRec.Get(PaymentLine.No);
        PaymentLine.GetCurrency;
        AccType := PaymentLine."Account Type";
        AccNo := PaymentLine."Account No";
        case AccType of
            AccType::Customer:
                begin
                    CustLedgEntry.SetRange("Applies-to ID");
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    if PaymentLine."Applies-to ID" = '' then PaymentLine."Applies-to ID" := PaymentLine.No;
                    if PaymentLine."Applies-to ID" = '' then Error(Text000, PaymentLine.FieldCaption(No), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyCustEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    ApplyCustEntries.SetRecord(CustLedgEntry);
                    ApplyCustEntries.SetTableView(CustLedgEntry);
                    ApplyCustEntries.LookupMode(true);
                    OK := ApplyCustEntries.RunModal = ACTION::LookupOK;
                    Clear(ApplyCustEntries);
                    if not OK then exit;
                    CustLedgEntry.Reset;
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if CustLedgEntry.Find('-') then begin
                        CurrencyCode2 := CustLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, CustLedgEntry."Document No.");
                                //CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                                CustLedgEntry.CalcFields("Remaining Amount");
                                CustLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Amount", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Amount" := Round(CustLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Pmt. Disc. Possible", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := Round(CustLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(CustLedgEntry."Amount to Apply", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Amount to Apply" := Round(CustLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsCust(Rec, CustLedgEntry, 0, false) and (Abs(CustLedgEntry."Amount to Apply") >= Abs(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")) then
                                    PaymentLine.Amount := PaymentLine.Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := Abs(PaymentLine.Amount - CustLedgEntry."Amount to Apply");
                            until CustLedgEntry.Next = 0;
                            PaymentLine.Validate(Amount);
                        end
                        else
                            repeat //CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                            until CustLedgEntry.Next = 0;
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not Confirm(Text001 + Text002, true, PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency, CustLedgEntry."Currency Code") then Error(Text003);
                                PaymentRec.Currency := CustLedgEntry."Currency Code"
                            end
                            else
                                ;
                        //CheckAgainstApplnCurrency(PaymentRec.Currency, CustLedgEntry."Currency Code", AccType::Customer, true);
                        PaymentLine."Applies-to Doc Type" := PaymentLine."Applies-to Doc Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end
                    else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify;
                    // Check Payment Tolerance
                    /* IF  Rec.Amount <> 0 THEN
                                   IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                                     EXIT;
                                */
                end;
            AccType::Vendor:
                begin
                    VendLedgEntry.SetRange("Applies-to ID");
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    if PaymentLine."Applies-to ID" = '' then begin
                        PaymentLine."Applies-to ID" := PaymentLine.No;
                    end;
                    if PaymentLine."Applies-to ID" = '' then Error(Text000, PaymentRec.FieldCaption("No."), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyVendEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableView(VendLedgEntry);
                    ApplyVendEntries.LookupMode(true);
                    OK := ApplyVendEntries.RunModal = ACTION::LookupOK;
                    Clear(ApplyVendEntries);
                    if not OK then exit;
                    VendLedgEntry.Reset;
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if VendLedgEntry.Find('-') then begin
                        PaymentLine."Vendor Invoice" := VendLedgEntry."Document No.";
                        // "Applies-to Doc. Type":=VendLedgEntry."Document Type";
                        PaymentLine.Modify;
                        CurrencyCode2 := VendLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, VendLedgEntry."Document No.");
                                //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                                VendLedgEntry.CalcFields("Remaining Amount");
                                VendLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(VendLedgEntry."Remaining Amount", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Remaining Amount" := Round(VendLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(VendLedgEntry."Remaining Pmt. Disc. Possible", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Remaining Pmt. Disc. Possible" := Round(VendLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(VendLedgEntry."Amount to Apply", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Amount to Apply" := Round(VendLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsVend(Rec, VendLedgEntry, 0, false) and (Abs(VendLedgEntry."Amount to Apply") >= Abs(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")) then
                                    PaymentLine.Amount := PaymentLine.Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := PaymentLine.Amount - VendLedgEntry."Amount to Apply";
                            until VendLedgEntry.Next = 0;
                            PaymentLine.Validate(Amount);
                        end
                        else
                            repeat //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                            until VendLedgEntry.Next = 0;
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not Confirm(Text001 + Text002, true, PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency, VendLedgEntry."Currency Code") then Error(Text003);
                                PaymentRec.Currency := VendLedgEntry."Currency Code"
                            end
                            else
                                ;
                        //CheckAgainstApplnCurrency(PaymentRec.Currency, VendLedgEntry."Currency Code", AccType::Vendor, true);
                        PaymentLine."Applies-to Doc Type" := PaymentLine."Applies-to Doc Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end
                    else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify;
                    // Check Payment Tolerance
                    /*
                                IF  Rec.Amount <> 0 THEN
                                  IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                                    EXIT;
                                */
                end;
            else
                Error(Text005, PaymentLine.FieldCaption("Account Type"));
        end;
        Rec := PaymentLine;
    end;

    procedure CheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        if ApplnCurrencyCode = CompareCurrencyCode then exit(true);
        case AccType of
            AccType::Customer:
                begin
                    SalesSetup.Get;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    case CurrencyAppln of
                        CurrencyAppln::No:
                            begin
                                if ApplnCurrencyCode <> CompareCurrencyCode then
                                    if Message then
                                        Error(Text006)
                                    else
                                        exit(false);
                            end;
                        CurrencyAppln::EMU:
                            begin
                                GLSetup.Get;
                                if not Currency.Get(ApplnCurrencyCode) then Currency."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency2.Get(CompareCurrencyCode) then Currency2."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency."EMU Currency" or not Currency2."EMU Currency" then
                                    if Message then
                                        Error(Text007)
                                    else
                                        exit(false);
                            end;
                    end;
                end;
            AccType::Vendor:
                begin
                    PurchSetup.Get;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    case CurrencyAppln of
                        CurrencyAppln::No:
                            begin
                                if ApplnCurrencyCode <> CompareCurrencyCode then
                                    if Message then
                                        Error(Text006)
                                    else
                                        exit(false);
                            end;
                        CurrencyAppln::EMU:
                            begin
                                GLSetup.Get;
                                if not Currency.Get(ApplnCurrencyCode) then Currency."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency2.Get(CompareCurrencyCode) then Currency2."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency."EMU Currency" or not Currency2."EMU Currency" then
                                    if Message then
                                        Error(Text007)
                                    else
                                        exit(false);
                            end;
                    end;
                end;
        end;
        exit(true);
    end;

    local procedure GetCurrency()
    var
        PaymentRec: Record Payments;
    begin
        PaymentRec.Get(PaymentLine.No);
        if PaymentRec.Currency = '' then
            CurrencyRec.InitRoundingPrecision
        else begin
            CurrencyRec.Get(PaymentRec.Currency);
            CurrencyRec.TestField("Amount Rounding Precision");
        end;
    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record Currency;
        PaymentRec: Record Payments;
    begin
        if PaymentRec.Get(PaymentLine.No) then;
        if PaymentRec.Currency = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.Get(PaymentRec.Currency);
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    procedure GetUserName(UserName: Text): Text
    var
        UserDetails: Record User;
    begin
        UserDetails.Reset;
        UserDetails.SetRange("User Name", UserName);
        if UserDetails.FindFirst then
            if UserDetails."Full Name" <> '' then
                exit(UserDetails."Full Name")
            else
                exit(UserName);
    end;

    local procedure CreatePVPettyCash(Imprest: Record Payments)
    var
        PaymentRec: Record Payments;
        PaymentLines: Record "Payment Lines";
        ImprestLines: Record "Payment Lines";
        OptionNumber: Integer;
        PaymentsPost: Codeunit "Payments Management";
    begin
        OptionNumber := DIALOG.StrMenu(Text021, 0, Text022);
        //Header
        PaymentRec.Init;
        PaymentRec.TransferFields(Imprest);
        PaymentRec."No." := '';
        case OptionNumber of
            1:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Petty Cash";
                    PaymentRec."Paying Bank Account" := PaymentRec.GetPettyCashBank;
                end;
            2:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Payment Voucher";
                    PaymentRec."Paying Bank Account" := Imprest."Paying Bank Account";
                end;
            3:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Staff Claim";
                    PaymentRec."Paying Bank Account" := Imprest."Paying Bank Account";
                    PaymentRec."Imprest Surrender Doc. No" := Imprest."No.";
                end;
        end;
        PaymentRec.Status := PaymentRec.Status::Open;
        PaymentRec.Posted := false;
        PaymentRec."Posted By" := '';
        PaymentRec."Posted Date" := 0D;
        PaymentRec."Posting Date" := 0D;
        PaymentRec."Time Posted" := 0T;
        PaymentRec.Insert(true);
        //Imprest.CalcFields("Actual Amount Spent", "Imprest Amount");
        //Lines
        PaymentLines.Init;
        PaymentLines.No := PaymentRec."No.";
        PaymentLines."Line No" := 1000;
        PaymentLines."Account Type" := PaymentLines."Account Type"::Customer;
        PaymentLines."Account No" := Imprest."Account No.";
        PaymentLines.Description := 'Refund';

        PaymentLines.Amount := Imprest."Actual Amount Spent" - Imprest."Imprest Amount";
        PaymentLines.Validate(Amount);
        case OptionNumber of
            1:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Petty Cash";
            2:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Payment Voucher";
            3:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Staff Claim";

        end;
        case OptionNumber OF
            3:
                PaymentLines."Expenditure Type" := 'OVERSPEND'

        END;
        case OptionNumber OF
            3:
                PaymentLines."Expenditure date" := PaymentRec.Date

        END;
        case OptionNumber OF
            3:
                PaymentLines."Expenditure Description" := 'Staff Claim' + PaymentRec."No."

        END;
        case OptionNumber OF
            3:
                PaymentLines."Claim Type" := PaymentRec."Claim Type"::"General Claim";

        END;
        case OptionNumber OF
            3:
                PaymentLines."Job No." := PaymentLines."Job No.";

        END;
        case OptionNumber OF
            3:
                PaymentLines."Job Task No." := PaymentLines."Job Task No.";

        END;
        case OptionNumber OF
            3:
                PaymentRec."Imprest Surrender Doc. No" := Imprest."No.";

        END;
        case OptionNumber OF
            3:
                PaymentRec."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code"

        END;
        case OptionNumber OF
            3:
                PaymentRec."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";

        END;



        if PaymentLines.Amount <> 0 then PaymentLines.Insert(true);
        case OptionNumber of
            1:
                PAGE.Run(Page::"Petty Cash", PaymentRec);
            2:
                PAGE.Run(Page::"Payment Voucher", PaymentRec);
            3:
                PAGE.Run(Page::"Staff Claim", PaymentRec);
        end;

        case OptionNumber OF
            3:
                begin
                    PaymentRec.Posted := true;
                    PaymentRec."Posted By" := UserId;
                    PaymentRec."Posted Date" := today;
                    PaymentRec."Time Posted" := Time;
                    PaymentRec.Status := PaymentRec.Status::Released;
                    PaymentRec.Modify;
                end;


        END;

    end;

    local procedure GetCustAccNo(DocNo: Code[20]) CustNo: Code[20]
    var
        Payments: Record Payments;
    begin
        if Payments.Get(DocNo) then CustNo := Payments."Account No.";
    end;

    procedure CheckIfBalancing(JournalName: Code[40]; BatchName: Code[40])
    var
        GenJnlLine: Record "Gen. Journal Line";
        AmountBal: Decimal;
    begin
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", JournalName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        GenJnlLine.SetRange("Bal. Account No.", ' ');
        GenJnlLine.CalcSums("Amount (LCY)");
        AmountBal := GenJnlLine."Amount (LCY)";
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", JournalName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        GenJnlLine.SetFilter("Bal. Account No.", '');
        GenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        if GenJnlLine.FindLast then GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - AmountBal;
        GenJnlLine.Validate("Amount (LCY)");
        GenJnlLine.Modify;
    end;

    procedure GetEFTName(): Text
    var
        EFTCount: Integer;
        EFTValue: Integer;
        EFTFileNaming: Record "EFT File Naming";
        //FileSystem: Automation BC;
        CashSetup: Record "Cash Management Setups";
        PaymentMethod: Record "Payment Method";
        PaymentRec: Record Payments;
        FileName: Text;
        TodayText: Text;
        TodayTextFormatted: Text;
    begin
        CashSetup.Get;
        PaymentMethod.Reset;
        PaymentMethod.SetRange("Bal. Account Type", PaymentMethod."Bal. Account Type"::EFT);
        if PaymentMethod.FindFirst then begin
            PaymentRec.Reset;
            PaymentRec.SetRange(PaymentRec."Payment Type", PaymentRec."Payment Type"::"Payment Voucher");
            PaymentRec.SetRange(PaymentRec."Pay Mode", PaymentMethod.Code);
            PaymentRec.SetRange(PaymentRec."EFT File Generated", true);
            PaymentRec.SetFilter(PaymentRec.Date, '=%1', Today);
            if PaymentRec.Find('-') then
                EFTCount := PaymentRec.Count
            else
                EFTCount := 0;
            EFTValue := EFTCount + 1;
            //EFT Naming
            EFTFileNaming.Reset;
            EFTFileNaming.SetRange(EFTFileNaming.Value, EFTValue);
            if EFTFileNaming.FindFirst then begin
                TodayText := Format(Today);
                TodayTextFormatted := DelChr(TodayText, '=', '/');
                /*  Clear(FileSystem);
                 if Create(FileSystem, false, true) then begin
                     if not FileSystem.FolderExists(CashSetup."EFT Path") then
                         FileSystem.CreateFolder(CashSetup."EFT Path");
                 end; */
                FileName := CashSetup."EFT Path" + 'EFT ' + TodayTextFormatted + EFTFileNaming.Character + '.xlsx';
                exit(FileName);
            end
            else
                Error('No EFT Naming Setup Located');
        end;
    end;

    local procedure GetImprestForReceipt(SurrenderDoc: Code[20]): Code[20]
    var
        Payments: Record Payments;
        Imprest: Record Payments;
    begin
        if Payments.Get(SurrenderDoc) then begin
            if Imprest.Get(Payments."Imprest Issue Doc. No") then exit(Imprest."Imprest Posted by PV");
        end;
    end;

    procedure GetDecimalPosition(): Decimal
    var
        GenSetup: Record "General Ledger Setup";
        RoundPrecision: Decimal;
    begin
        if GenSetup."Amount Rounding Precision" = 0 then
            RoundPrecision := 0.01
        else
            RoundPrecision := GenSetup."Amount Rounding Precision";
        exit(1 / RoundPrecision);
    end;

    local procedure GetImprestPostedPV(ImpDocNo: Code[50]): Code[50]
    var
        ImpSurr: Record Payments;
    begin
        if ImpSurr.Get(ImpDocNo) then begin
            if ImpSurr."Imprest Posted by PV" <> '' then
                exit(ImpSurr."Imprest Posted by PV")
            else
                exit(ImpSurr."Imprest Issue Doc. No");
        end;
    end;

    procedure CheckMedicalClaimCeiling(Claims: Record Payments)
    var
        PeriodStart: Date;
        PeriodEnd: Date;
        AmountToDate: Decimal;
        AnnualEntitlement: Decimal;
        Balance: Decimal;
        MedicalCeilingSetup: Record "Medical Ceiling Setup";
        AccountingPeriod: Record "Accounting Period";
        ClaimsRec: Record Payments;
        ClaimsError: Label 'You can not apply for a claim of KES %4 since it exceeds your Annual Medical Claim Entitlement of KES %1. Amount Applied To Date=KES %2 . Current Claim Entitlement Balance=KES %3';
        ClaimLines: Record "Payment Lines";
    begin
        // if Claims."Claim Type" = Claims."Claim Type"::"Medical Claim" then begin
        //     Claims.TestField("Payroll Approval No.");
        //     Claims.TestField("Petty Cash Amount");
        //     Claims.TestField(Date);
        //     //Get Posted Claims in Current Finanical Year
        //     GetCurrentAccountingPeriod(PeriodStart, PeriodEnd, Today);
        //     ClaimsRec.Reset;
        //     ClaimsRec.SetRange("Payment Type", ClaimsRec."Payment Type"::"Staff Claim");
        //     ClaimsRec.SetRange("Account No.", Claims."Account No.");
        //     ClaimsRec.SetRange(Posted, true);
        //     ClaimsRec.SetRange(Date, PeriodStart, PeriodEnd);
        //     if ClaimsRec.Find('-') then begin
        //         repeat
        //             //Lines
        //             ClaimLines.Reset;
        //             ClaimLines.SetRange(No, ClaimsRec."No.");
        //             if ClaimLines.Find('-') then begin
        //                 repeat
        //                     //Get ceiling claims
        //                     if IsMedicalCeilingClaim(ClaimLines."Expenditure Type") then begin
        //                         Claims.TestField("Salary Scale");
        //                         AmountToDate := AmountToDate + ClaimsRec."Petty Cash Amount";
        //                     end;
        //                 until ClaimLines.Next = 0;
        //             end;
        //         until ClaimsRec.Next = 0;
        //     end;
        //     //Check if claim line has ceiling item
        //     ClaimLines.Reset;
        //     ClaimLines.SetRange(No, Claims."No.");
        //     if ClaimLines.FindFirst then begin
        //         if IsMedicalCeilingClaim(ClaimLines."Expenditure Type") then begin
        //             //Get Salary Scale Amount
        //             if MedicalCeilingSetup.Get(Claims."Salary Scale") then
        //                 AnnualEntitlement := MedicalCeilingSetup."Annual Amount"
        //             else
        //                 Error('Medical Ceiling Setup does not exist for %1 Salary Scale', Claims."Salary Scale");
        //             Balance := AnnualEntitlement - AmountToDate;
        //             Claims.CalcFields("Petty Cash Amount");
        //             if AmountToDate + Claims."Petty Cash Amount" > AnnualEntitlement then
        //                 Error(ClaimsError, AnnualEntitlement, AmountToDate, Balance, Claims."Petty Cash Amount");
        //         end;
        //     end;
        // end;
    end;

    procedure GetPeriodStart(CurrentDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset;
        AccountingPeriod.SetFilter("Starting Date", '<%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.Find('+') then exit(AccountingPeriod."Starting Date");
    end;

    procedure GetPeriodEnd(CurrentDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset;
        AccountingPeriod.SetFilter("Starting Date", '>%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.Find('+') then exit(AccountingPeriod."Starting Date");
    end;

    procedure GetCurrentAccountingPeriod(var PeriodStart: Date; var PeriodEnd: Date; CurrentDate: Date)
    var
        AccountingPeriod: Record "Accounting Period";
        AccountingPeriod2: Record "Accounting Period";
    begin
        AccountingPeriod.Reset;
        AccountingPeriod.SetFilter("Starting Date", '<%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.Find('+') then PeriodStart := AccountingPeriod."Starting Date";
        AccountingPeriod2.Reset;
        AccountingPeriod2.SetFilter("Starting Date", '>%1', CurrentDate);
        AccountingPeriod2.SetRange("New Fiscal Year", true);
        if AccountingPeriod2.Find('+') then PeriodEnd := CalcDate('-1D', AccountingPeriod2."Starting Date");
    end;

    procedure IsMedicalCeilingClaim(ClaimType: Code[50]): Boolean
    var
        ClaimTypes: Record "Receipts and Payment Types";
    begin
        ClaimTypes.Reset;
        ClaimTypes.SetRange(Code, ClaimType);
        ClaimTypes.SetRange(Type, ClaimTypes.Type::Claim);
        if ClaimTypes.FindFirst then begin
            if ClaimTypes."Check Medical Ceiling" then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure PostInterBankMultiple(InterBank: Record Payments)
    var
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        InterBankLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
    begin
        if Confirm('Are you sure you want to post the Bank Transfer No. ' + InterBank."No." + ' ?') = true then begin
            if InterBank.Status <> InterBank.Status::Released then Error('The Bank Transfer No %1 has not been fully approved', InterBank."No.");
            if InterBank.Posted then Error('Bank Transfer %1 has been posted', InterBank."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Inter Bank Template Name";
            JBatch := Temp."Inter Bank Batch Name"; //InterBank."No.";
            if JTemplate = '' then begin
                Error('Ensure the InterBank Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the InterBank Batch is set up in the Cash Office Setup')
            end;
            InterBank.TestField(Date);
            if InterBank."Payment Release Date" = 0D then Error('Please enter posting date');
            //Check Amounts
            InterBank.CalcFields("Petty Cash Amount", "Petty Cash Amount (LCY)");
            if InterBank."Source Bank Amount" = 0 then Error('Source Amount cannot be zero');
            if InterBank."Petty Cash Amount (LCY)" <> InterBank."Source Amount LCY" then Error('Please make sure both Total Receiving and Source Bank Amounts are the same');
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Source Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Source Bank";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then Error('You must specify the InterBank date');
            //  GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := InterBank."Payment Release Date";
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := InterBank."Pay Mode";
            GenJnLine.Description := InterBank."Payment Narration"; //'Inter Bank Transfer to '+InterBank."Account No."+' Bank';
            GenJnLine.Amount := -InterBank."Source Bank Amount";
            GenJnLine."Currency Code" := InterBank."Source Currency";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            InterBankLines.SetRange(No, InterBank."No.");
            if InterBankLines.Find('-') then begin
                repeat //Receiving Bank Entries
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                    GenJnLine."Account No." := InterBankLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if InterBank.Date = 0D then Error('You must specify the InterBank date');
                    //  GenJnLine."Posting Date":=TODAY;
                    GenJnLine."Posting Date" := InterBank."Payment Release Date";
                    GenJnLine."Document No." := InterBank."No.";
                    GenJnLine."External Document No." := InterBank."Cheque No";
                    GenJnLine."Payment Method Code" := InterBank."Pay Mode";
                    GenJnLine.Description := InterBank."Payment Narration"; //'Inter Bank Transfer from '+InterBank."Source Bank"+' Bank';
                    GenJnLine.Amount := InterBankLines.Amount;
                    GenJnLine."Currency Code" := InterBankLines.Currency;
                    ;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until InterBankLines.Next = 0;
            end;
            //End of Posting
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", InterBank."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                InterBank.Posted := true;
                InterBank."Posted By" := UserId;
                InterBank."Posted Date" := Today;
                InterBank."Time Posted" := Time;
                InterBank.Modify;
            end;
        end;
    end;

    procedure ArchiveDocument(PayRec: Record Payments)
    begin
        PayRec.Status := PayRec.Status::Archived;
        PayRec.Modify;
    end;

    procedure ReopenDocument(PayRec: Record Payments)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", PayRec."No.");
        if ApprovalEntry.Find('-') then
            // repeat
            //     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
            //     ApprovalEntry.Modify;
            // until ApprovalEntry.Next = 0;
        PayRec.Status := PayRec.Status::Open;
        PayRec.Modify;
    end;

    procedure ApplyEntry(var Rec: Record "Payment Lines"; AutoApply: Boolean)
    var
        Text000: Label 'You must specify %1 or %2.';
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text002: Label 'Do you wish to continue?';
        Text003: Label 'The update has been interrupted to respect the warning.';
        Text005: Label 'The %1  must be Customer or Vendor.';
        Text006: Label 'All entries in one application must be in the same currency.';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies. ';
        PaymentRec: Record Payments;
        EntryNo: Text;
        ApplyingAmount: Decimal;
        AppliedAmount: Decimal;
    begin
        PaymentLine.Copy(Rec);
        PaymentRec.Get(PaymentLine.No);
        PaymentLine.GetCurrency;
        AccType := PaymentLine."Account Type";
        AccNo := PaymentLine."Account No";
        ApplyingAmount := PaymentLine.Amount;
        case AccType of
            AccType::Customer:
                begin
                    CustLedgEntry.SetRange("Applies-to ID");
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    if PaymentLine."Applies-to ID" = '' then PaymentLine."Applies-to ID" := PaymentLine.No;
                    if PaymentLine."Applies-to ID" = '' then Error(Text000, PaymentLine.FieldCaption(No), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyCustEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    if AutoApply then begin
                        CustLedgEntry2.Copy(CustLedgEntry);
                        CustLedgEntry2.SetRange("Document Type", CustLedgEntry2."Document Type"::Invoice);
                        if CustLedgEntry2.FindFirst() then begin
                            repeat
                                if EntryNo = '' then
                                    EntryNo := Format(CustLedgEntry2."Entry No.")
                                else
                                    EntryNo += '|' + Format(CustLedgEntry2."Entry No.");
                                ApplyCustEntries.SetRecord(CustLedgEntry2);
                                ApplyCustEntries.SetTableView(CustLedgEntry2);
                                ApplyCustEntries.SetCustApplId(false);
                                CustLedgEntry2.CalcFields("Remaining Amount");
                                ApplyingAmount -= abs(CustLedgEntry2."Remaining Amount");
                            until (CustLedgEntry2.Next() = 0) or (ApplyingAmount <= 0);
                            OK := true;
                        end;
                    end
                    else begin
                        ApplyCustEntries.SetRecord(CustLedgEntry);
                        ApplyCustEntries.SetTableView(CustLedgEntry);
                        ApplyCustEntries.LookupMode(true);
                        OK := ApplyCustEntries.RunModal = ACTION::LookupOK;
                    end;
                    Clear(ApplyCustEntries);
                    if not OK then exit;
                    ApplyingAmount := 0;
                    CustLedgEntry.Reset;
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if CustLedgEntry.Find('-') then begin
                        CurrencyCode2 := CustLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, CustLedgEntry."Document No.");
                                CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                                CustLedgEntry.CalcFields("Remaining Amount");
                                CustLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Amount", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Amount" := Round(CustLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Pmt. Disc. Possible", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := Round(CustLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(CustLedgEntry."Amount to Apply", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Amount to Apply" := Round(CustLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsCust(Rec, CustLedgEntry, 0, false) and (Abs(CustLedgEntry."Amount to Apply") >= Abs(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")) then
                                    PaymentLine.Amount := PaymentLine.Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := Abs(PaymentLine.Amount - CustLedgEntry."Amount to Apply");
                            until CustLedgEntry.Next = 0;
                        end
                        else
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, CustLedgEntry."Document No.");
                                CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                                CustLedgEntry.CalcFields("Remaining Amount");
                                CustLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Amount", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Amount" := Round(CustLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(CustLedgEntry."Remaining Pmt. Disc. Possible", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Remaining Pmt. Disc. Possible" := Round(CustLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(CustLedgEntry."Amount to Apply", CustLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                CustLedgEntry."Amount to Apply" := Round(CustLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsCust(Rec, CustLedgEntry, 0, false) and (Abs(CustLedgEntry."Amount to Apply") >= Abs(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")) then
                                    AppliedAmount := Abs(CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    AppliedAmount := Abs(CustLedgEntry."Amount to Apply");
                                if (ApplyingAmount + AppliedAmount) > PaymentLine.Amount then AppliedAmount := (PaymentLine.Amount - ApplyingAmount);
                                CustLedgEntry."Amount to Apply" := AppliedAmount;
                                CustLedgEntry.Modify();
                                ApplyingAmount += AppliedAmount;
                            until CustLedgEntry.Next = 0;
                        PaymentLine.Validate(Amount);
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not Confirm(Text001 + Text002, true, PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency, CustLedgEntry."Currency Code") then Error(Text003);
                                PaymentRec.Currency := CustLedgEntry."Currency Code"
                            end
                            else
                                ;
                        CheckAgainstApplnCurrency(PaymentRec.Currency, CustLedgEntry."Currency Code", AccType::Customer, true);
                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end
                    else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify;
                    // Check Payment Tolerance
                    /* IF  Rec.Amount <> 0 THEN
                                   IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                                     EXIT;
                                */
                end;
            AccType::Vendor:
                begin
                    VendLedgEntry.SetRange("Applies-to ID");
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    if PaymentLine."Applies-to ID" = '' then begin
                        PaymentLine."Applies-to ID" := PaymentLine.No;
                    end;
                    if PaymentLine."Applies-to ID" = '' then Error(Text000, PaymentRec.FieldCaption("No."), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyVendEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableView(VendLedgEntry);
                    ApplyVendEntries.LookupMode(true);
                    OK := ApplyVendEntries.RunModal = ACTION::LookupOK;
                    Clear(ApplyVendEntries);
                    if not OK then exit;
                    VendLedgEntry.Reset;
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if VendLedgEntry.Find('-') then begin
                        PaymentLine."Vendor Invoice" := VendLedgEntry."Document No.";
                        // "Applies-to Doc. Type":=VendLedgEntry."Document Type";
                        PaymentLine.Modify;
                        CurrencyCode2 := VendLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, VendLedgEntry."Document No.");
                                //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                                VendLedgEntry.CalcFields("Remaining Amount");
                                VendLedgEntry."Remaining Amount" := CurrExchRate.ExchangeAmount(VendLedgEntry."Remaining Amount", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Remaining Amount" := Round(VendLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Remaining Pmt. Disc. Possible" := CurrExchRate.ExchangeAmount(VendLedgEntry."Remaining Pmt. Disc. Possible", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Remaining Pmt. Disc. Possible" := Round(VendLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Amount to Apply" := CurrExchRate.ExchangeAmount(VendLedgEntry."Amount to Apply", VendLedgEntry."Currency Code", PaymentRec.Currency, PaymentRec.Date);
                                VendLedgEntry."Amount to Apply" := Round(VendLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsVend(Rec, VendLedgEntry, 0, false) and (Abs(VendLedgEntry."Amount to Apply") >= Abs(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")) then
                                    PaymentLine.Amount := PaymentLine.Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := PaymentLine.Amount - VendLedgEntry."Amount to Apply";
                            until VendLedgEntry.Next = 0;
                            PaymentLine.Validate(Amount);
                        end
                        else
                            repeat //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                            until VendLedgEntry.Next = 0;
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not Confirm(Text001 + Text002, true, PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency, VendLedgEntry."Currency Code") then Error(Text003);
                                PaymentRec.Currency := VendLedgEntry."Currency Code"
                            end
                            else
                                ;
                        //CheckAgainstApplnCurrency(PaymentRec.Currency, VendLedgEntry."Currency Code", AccType::Vendor, true);
                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end
                    else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify;
                    // Check Payment Tolerance
                    /*
                                IF  Rec.Amount <> 0 THEN
                                  IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                                    EXIT;
                                */
                end;
            else
                Error(Text005, PaymentLine.FieldCaption("Account Type"));
        end;
        Rec := PaymentLine;
    end;

    procedure ViewAppliedEntries(PLines: Record "Payment Lines")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        AppliedVendorEntriesCustom: Page "Applied Vendor Entries-Custom";
        AppliedCustEntriesCustom: Page "Applied Cust Entries-Custom";
    begin
        case PLines."Account Type" of
            PLines."Account Type"::Vendor:
                begin
                    Clear(AppliedVendorEntriesCustom);
                    VendorLedgerEntry.Reset;
                    VendorLedgerEntry.SetRange("Document No.", PLines.No);
                    if VendorLedgerEntry.FindFirst then begin
                        VendorLedgerEntry2.FilterGroup(10);
                        VendorLedgerEntry2.SetRange("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                        VendorLedgerEntry2.FilterGroup(0);
                        AppliedVendorEntriesCustom.SetTableView(VendorLedgerEntry2);
                        AppliedVendorEntriesCustom.Editable(false);
                        AppliedVendorEntriesCustom.RunModal;
                    end;
                end;
            PLines."Account Type"::Customer:
                begin
                    Clear(AppliedCustEntriesCustom);
                    CustLedgerEntry.Reset;
                    CustLedgerEntry.SetRange("Document No.", PLines.No);
                    if CustLedgerEntry.FindFirst then begin
                        CustLedgerEntry2.FilterGroup(10);
                        CustLedgerEntry2.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
                        CustLedgerEntry2.FilterGroup(0);
                        AppliedCustEntriesCustom.SetTableView(CustLedgerEntry2);
                        AppliedCustEntriesCustom.Editable(false);
                        AppliedCustEntriesCustom.RunModal;
                    end;
                end;
        end;
    end;

    procedure PostVoteTransfer(VotebookTransfer: Record "Votebook Transfer")
    var
        AllocatedAmount: Decimal;
        CommitmentAmount: Decimal;
        EncumbaranceAmount: Decimal;
        ExpenseAmount: Decimal;
        BudgetBalance: Decimal;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        BudgetError: Label 'The Amount %1 in Vote transfer No %2 exceeds the Budget By %3 . Total Allocation=%4 , Commitments=%5 , Actuals=%6, Available Budget=%7';
        NoBudgetError: Label 'No Budget To Check Against';
        Success: Label 'Budget Entry Transferred Successfully';
    begin
        VotebookTransfer.TestField(Date);
        VotebookTransfer.TestField("Budget Name");
        VotebookTransfer.TestField(Amount);
        VotebookTransfer.TestField("Source Vote");
        VotebookTransfer.TestField("Destination Vote");
        //    TESTFIELD("Source Dimension 1");
        //    TESTFIELD("Source Dimension 2");
        //    TESTFIELD("Destination Dimension 1");
        //    TESTFIELD("Destination Dimension 2");
        if VotebookTransfer."Balance As At" = VotebookTransfer."Balance As At"::" " then Error('Please select Budget Balance As At');
        GLSetup.Get;
        GLSetup.TestField("Current Budget");
        GLSetup.TestField("Current Budget Start Date");
        GLSetup.TestField("Current Budget End Date");
        //Get Source Vote Allocation
        GLAccount.Reset;
        GLAccount.SetRange("No.", VotebookTransfer."Source Vote");
        if VotebookTransfer."Balance As At" = VotebookTransfer."Balance As At"::"End of Financial Year" then
            GLAccount.SetRange("Date Filter", GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date")
        else
            GLAccount.SetRange("Date Filter", GLSetup."Current Budget Start Date", Today);
        GLAccount.SetFilter("Budget Filter", VotebookTransfer."Budget Name");
        GLAccount.SetFilter("Global Dimension 1 Filter", VotebookTransfer."Source Dimension 1");
        GLAccount.SetFilter("Global Dimension 2 Filter", VotebookTransfer."Source Dimension 2");
        if GLAccount.Find('-') then begin
            GLAccount.CalcFields("Approved Budget", Commitment, Encumberance, "Net Change", Balance, "Budgeted Amount");
            AllocatedAmount := GLAccount."Approved Budget";
            CommitmentAmount := GLAccount.Commitment;
            EncumbaranceAmount := GLAccount.Encumberance;
            ExpenseAmount := GLAccount."Net Change";
        end;
        BudgetBalance := AllocatedAmount - (CommitmentAmount + EncumbaranceAmount + ExpenseAmount);
        if BudgetBalance <= 0 then Error(NoBudgetError);
        if VotebookTransfer.Amount > BudgetBalance then Error(BudgetError, VotebookTransfer.Amount, VotebookTransfer.No, (VotebookTransfer.Amount - BudgetBalance), AllocatedAmount, (CommitmentAmount + EncumbaranceAmount), ExpenseAmount, BudgetBalance);
        //Insert budget entries
        GLBudgetEntry.Init;
        GLBudgetEntry."Entry No." := GLBudgetEntry.GetNextEntryNo;
        GLBudgetEntry."Budget Name" := VotebookTransfer."Budget Name";
        GLBudgetEntry."G/L Account No." := VotebookTransfer."Source Vote";
        GLBudgetEntry.Date := VotebookTransfer.Date;
        GLBudgetEntry."Global Dimension 1 Code" := VotebookTransfer."Source Dimension 1";
        GLBudgetEntry."Global Dimension 2 Code" := VotebookTransfer."Source Dimension 2";
        GLBudgetEntry.Amount := -VotebookTransfer.Amount;
        GLBudgetEntry.Description := VotebookTransfer.Remarks;
        GLBudgetEntry."User ID" := UserId;
        GLBudgetEntry.Transferred_ := true;
        GLBudgetEntry."Transferred from/To Ac_" := VotebookTransfer."Destination Vote";
        if not GLBudgetEntry.Get(GLBudgetEntry."Entry No.") then GLBudgetEntry.Insert(true);
        GLBudgetEntry.Init;
        GLBudgetEntry."Entry No." := GLBudgetEntry.GetNextEntryNo;
        GLBudgetEntry."Budget Name" := VotebookTransfer."Budget Name";
        GLBudgetEntry."G/L Account No." := VotebookTransfer."Destination Vote";
        GLBudgetEntry.Date := VotebookTransfer.Date;
        GLBudgetEntry."Global Dimension 1 Code" := VotebookTransfer."Destination Dimension 1";
        GLBudgetEntry."Global Dimension 2 Code" := VotebookTransfer."Destination Dimension 2";
        GLBudgetEntry.Amount := VotebookTransfer.Amount;
        GLBudgetEntry.Description := VotebookTransfer.Remarks;
        GLBudgetEntry."User ID" := UserId;
        GLBudgetEntry.Transferred_ := true;
        GLBudgetEntry."Transferred from/To Ac_" := VotebookTransfer."Source Vote";
        if not GLBudgetEntry.Get(GLBudgetEntry."Entry No.") then GLBudgetEntry.Insert(true);
        VotebookTransfer.Posted := true;
        VotebookTransfer."Posted By" := UserId;
        VotebookTransfer."Posted Date" := Today;
        VotebookTransfer.Modify;
        Message(Success);
    end;

    procedure CancelPostedCheque(CheckLedgerEntry: Record "Check Ledger Entry"; EntryType: Option Void,Cancel)
    var
        ChequeRegPage: Page "Cheque Register";
        ChequeRegister: Record "Cheque Register";
        ChequeRegisterCopy: Record "Cheque Register";
        PaymentsRec: Record Payments;
    begin
        if Confirm('Are you sure you want to %1 this cheque?', false, Format(EntryType)) then begin
            //Modify cheque as voided in cheque register
            ChequeRegister.Reset;
            ChequeRegister.SetRange("Cheque No.", CheckLedgerEntry."Check No.");
            ChequeRegister.SetRange("Bank Account No.", CheckLedgerEntry."Bank Account No.");
            if ChequeRegister.FindFirst then begin
                case EntryType of
                    EntryType::Void:
                        begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::"Financially Voided";
                            ChequeRegister.Voided := true;
                            ChequeRegister."Voided By" := UserId;
                            ChequeRegister."Void Date-Time" := CurrentDateTime;
                        end;
                    EntryType::Cancel:
                        begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Cancelled;
                            ChequeRegister.Cancelled := true;
                            ChequeRegister."Cancelled By" := UserId;
                            ChequeRegister."Cancelled Date-Time" := CurrentDateTime;
                        end;
                end;
                ChequeRegister.Modify;
            end;
            Commit;
            if Confirm('Do you want to issue a new cheque for this transaction?', false) then begin
                //Issue a new cheque
                Clear(ChequeRegPage);
                ChequeRegisterCopy.Reset;
                ChequeRegisterCopy.SetRange("Bank Account No.", CheckLedgerEntry."Bank Account No.");
                ChequeRegisterCopy.SetRange("Entry Status", ChequeRegisterCopy."Entry Status"::Printed);
                ChequeRegPage.SetTableView(ChequeRegisterCopy);
                ChequeRegPage.LookupMode(true);
                ChequeRegPage.Editable(false);
                Message('Kindly select a new cheque no. in the next window');
                if ChequeRegPage.RunModal = ACTION::LookupOK then begin
                    ChequeRegPage.GetRecord(ChequeRegisterCopy);
                    if ChequeRegisterCopy."Cheque No." = '' then Error('Kindly select a cheque no to proceed');
                    if Confirm('Do you want to issue cheque no. %1?', false, ChequeRegisterCopy."Cheque No.") then begin
                        CheckLedgerEntry."Check No." := ChequeRegisterCopy."Cheque No.";
                        CheckLedgerEntry.Modify;
                        ChequeRegisterCopy."Entry Status" := ChequeRegisterCopy."Entry Status"::Posted;
                        ChequeRegisterCopy.Issued := true;
                        ChequeRegisterCopy."Issued By" := UserId;
                        ChequeRegisterCopy."Issued Doc No." := CheckLedgerEntry."Document No.";
                        ChequeRegisterCopy.Modify;
                    end;
                    Message('Cheque has been successfully canceled and a new cheque no. %1 has been issued', ChequeRegisterCopy."Cheque No.");
                    //Modify cheque no from PV
                    if PaymentsRec.Get(CheckLedgerEntry."Document No.") then begin
                        PaymentsRec."Cheque No" := ChequeRegisterCopy."Cheque No.";
                        PaymentsRec.Modify;
                    end;
                end;
                CheckLedgerEntry."Entry Status" := CheckLedgerEntry."Entry Status"::Voided;
                CheckLedgerEntry.Modify;
            end;
            case EntryType of
                EntryType::Void:
                    CheckLedgerEntry."Entry Status" := CheckLedgerEntry."Entry Status"::Voided;
                EntryType::Cancel:
                    CheckLedgerEntry."Entry Status" := CheckLedgerEntry."Entry Status"::Voided;
            end;
            CheckLedgerEntry.Modify;
        end;
    end;

    procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        GLAccountRec: Record "G/L Account";
    begin
        GLAccountRec.Reset;
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false);
    end;

    procedure PostInputTax(ReceiptRec: Record Payments)
    var
        RcptLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        PaymentMethod: Record "Payment Method";
    begin
        if Confirm(Text017, false, ReceiptRec."No.") = true then begin
            if ReceiptRec.Posted then Error(Text018, ReceiptRec."No.");
            ReceiptRec.TestField(Date);
            ReceiptRec.TestField("Pay Mode");
            if ReceiptRec."Payment Release Date" = 0D then Error('Please input posting date');
            if PaymentMethod.Get(ReceiptRec."Pay Mode") then;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ReceiptRec.TestField("Cheque No");
                ReceiptRec.TestField("Cheque Date");
            end;
            ReceiptRec.CalcFields("Receipt Amount");
            ReceiptRec.CalcFields("Imp Surr Receipt Amount");
            //Check Lines
            if ReceiptRec."Receipt Amount" = 0 then Error('Amount cannot be zero');
            RcptLines.Reset;
            RcptLines.SetRange(No, ReceiptRec."No.");
            if not RcptLines.FindLast then Error('Receipt Lines cannot be empty');
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Receipt Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", ReceiptRec."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := CMSetup."Receipt Template";
            Batch.Name := ReceiptRec."No.";
            if not Batch.Get(Batch."Journal Template Name", ReceiptRec."No.") then Batch.Insert;
            //Header Entries
            LineNo := LineNo + 10000;
            RcptLines.Reset;
            RcptLines.SetRange(No, ReceiptRec."No.");
            RcptLines.Validate(Amount);
            RcptLines.CalcSums(Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
            GenJnLine."Journal Batch Name" := ReceiptRec."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := ReceiptRec."Account Type";
            GenJnLine."Account No." := ReceiptRec."Account No.";
            GenJnLine.Validate(GenJnLine."Account No.");
            if ReceiptRec.Date = 0D then Error('You must specify the Receipt date');
            GenJnLine."Posting Date" := ReceiptRec."Payment Release Date";
            GenJnLine."Document No." := ReceiptRec."No.";
            GenJnLine."External Document No." := ReceiptRec."Cheque No";
            GenJnLine."Payment Method Code" := ReceiptRec."Pay Mode";
            GenJnLine.Description := ReceiptRec."Payment Narration";
            GenJnLine.Amount := ReceiptRec."Receipt Amount";
            GenJnLine."Currency Code" := ReceiptRec.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := ReceiptRec."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ReceiptRec."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Receipt Lines Entries
            RcptLines.Reset;
            RcptLines.SetRange(No, ReceiptRec."No.");
            if RcptLines.FindFirst then begin
                repeat
                    RcptLines.Validate(RcptLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
                    GenJnLine."Journal Batch Name" := ReceiptRec."No.";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := RcptLines."Account Type";
                    GenJnLine."Account No." := RcptLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine."Posting Date" := ReceiptRec."Payment Release Date";
                    GenJnLine."Document No." := ReceiptRec."No.";
                    GenJnLine."External Document No." := ReceiptRec."Cheque No";
                    GenJnLine."Payment Method Code" := ReceiptRec."Pay Mode";
                    GenJnLine.Description := format(RcptLines.Description, 90);
                    GenJnLine.Amount := -RcptLines.Amount;
                    GenJnLine."Currency Code" := ReceiptRec.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                    GenJnLine."Gen. Posting Type" := RcptLines."Gen. Posting Type";
                    GenJnLine."Applies-to Doc. No." := RcptLines."Applies-to Doc. No.";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    GenJnLine."Applies-to ID" := RcptLines."Applies-to ID";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until RcptLines.Next = 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", ReceiptRec."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                ReceiptRec.Posted := true;
                ReceiptRec."Posted Date" := Today;
                ReceiptRec."Time Posted" := Time;
                ReceiptRec."Posted By" := UserId;
                ReceiptRec.Modify;
            end;
        end;
    end;

    procedure PostServiceChargeImprest(var Imprest: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        ImpLine: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
        ChequePayment: Boolean;
        ChequeRegister: Record "Cheque Register";
    begin
        ChequePayment := false;
        if Confirm(Text002, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then Error(Text003, Imprest."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Imprest Template";
            JBatch := Imprest."No."; // Temp."Imprest  Batch";
            if JTemplate = '' then begin
                Error('Ensure the Imprest Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
            end;
            Imprest.TestField("Account No.");
            Imprest.TestField("Paying Bank Account");
            Imprest.TestField(Date);
            //Imprest.TESTFIELD(Payee);
            Imprest.TestField("Pay Mode");
            PaymentMethod.Get(Imprest."Pay Mode");
            //Check Commitment
            ImprestLines.Reset;
            ImprestLines.SetRange(No, Imprest."No.");
            /* IF ImprestLines.FIND('-') THEN BEGIN
               REPEAT
                 IF IsAccountVotebookEntry(ImprestLines."Account No") THEN BEGIN
                 Commitment.FetchDimValue(ImprestLines."Dimension Set ID",ShortcutDimValue,DimValueName);
                 GLSetup.GET;
                 //DimValue.GET(GLSetup."Shortcut Dimension 6 Code",ShortcutDimValue[6]);
                 //DimValueName:=DimValue.Name;
                   IF (Commitment.IsAccountVotebookEntry(ImprestLines."Account No")) AND NOT Commitment.LineCommitted(Imprest."No.",ImprestLines."Account No",ImprestLines."Line No") THEN
                     ERROR(Text019,ShortcutDimValue[1]+' '+DimValueName[1]);
                 END;
                 UNTIL ImprestLines.NEXT=0;
               END;*/
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Imprest.TestField("Cheque No");
                Imprest.TestField("Cheque Date");
                ChequePayment := true;
            end;
            //Check if the imprest Lines have been populated
            ImprestLines.SetRange(ImprestLines.No, Imprest."No.");
            if not ImprestLines.FindLast then Error(Text004);
            //Imprest.CalcFields("Imprest Amount");
            if Imprest.Posted then Error(Text006, Imprest."No.");
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            LineNo := 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Imprest."Paying Bank Account";
            GenJnLine."Posting Date" := Imprest."Payment Release Date";
            GenJnLine."Document No." := Imprest."No.";
            if ChequePayment then begin
                GenJnLine."External Document No." := Imprest."Cheque No";
                GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            end;
            GenJnLine.Description := Imprest."Payment Narration";
            GenJnLine.Amount := -Imprest."Imprest Amount";
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Bal. Account Type" := Imprest."Account Type";
            GenJnLine."Bal. Account No." := Imprest."Account No.";
            GenJnLine."Currency Code" := Imprest.Currency;
            GenJnLine.Validate("Bal. Account No.");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.Find('-') then begin
                if Imprest."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset;
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Imprest."No.");
                    if CheckLedgerEntry.FindFirst then begin
                        CheckLedgerEntry."Check No." := Imprest."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify;
                    end;
                    //Modify Cheque as Posted in cheque register
                    if Imprest."Cheque Type" = Imprest."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset;
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Imprest."Cheque No");
                        if ChequeRegister.FindFirst then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Imprest."Cheque Date";
                            ChequeRegister."Posted By" := UserId;
                            ChequeRegister.Modify;
                        end;
                    end;
                end;
                //Encumber
                //Commitment.EncumberPayments(Imprest);
                //Update the Imprest Deadline
                //   IF CMSetup."Imprest Due Date"<>DueDate THEN
                //   Imprest."Imprest Deadline":=CALCDATE(CMSetup."Imprest Due Date",TODAY);
                //   Imprest.MODIFY;
                Imprest.Posted := true;
                Imprest."Posted By" := UserId;
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest.Modify();
            end;
        end;
    end;

    procedure PostServiceChargeSurrender(var Imprest: Record Payments)
    var
        ImprestLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        ImprestHeader: Record Payments;
        Commitment: Codeunit Committment;
    begin
        if Confirm(Text007, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then Error(Text008, Imprest."No.");
            Imprest.TestField("Service Charge Issue Doc. No");
            //Imprest.CalcFields("Imprest Amount", Imprest."Actual Amount Spent", "Cash Receipt Amount");
            if Imprest."Imprest Amount" = 0 then Error(Text005);
            if Imprest."Actual Amount Spent" = 0 then Error('Actual Amount Spent must have a value');
            // IF Imprest."Actual Amount Spent"=0 THEN
            //  ERROR(Text016);
            if Imprest.Surrendered then Error(Text013, Imprest."No.");
            if Imprest.Apportion then Apportionment.CheckApportionment(Imprest."No.");
            //Get surrender templater
            Temp.Get(UserId);
            JTemplate := Temp."Imprest Sur Template";
            JBatch := Imprest."No."; // Temp."Imprest Sur Batch";
            if JTemplate = '' then begin
                Error('Ensure the Imprest Surrender Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Imprest Surrender Batch is set up in the Cash Office Setup')
            end;
            CMSetup.Get();
            CMSetup.TestField(CMSetup."Imprest Surrender Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            LineNo := LineNo + 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := Imprest."Account Type";
            GenJnLine."Account No." := Imprest."Account No.";
            GenJnLine."Posting Date" := Today;
            GenJnLine."Document No." := Imprest."No.";
            GenJnLine."External Document No." := Imprest."Service Charge Issue Doc. No";
            GenJnLine.Description := 'Service Charge Surrendered by: ' + Imprest.Payee;
            GenJnLine.Amount := -Imprest."Actual Amount Spent";
            GenJnLine."Currency Code" := Imprest.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            //  GenJnLine."VAT Bus. Posting Group":='LOCAL';
            // GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
            GenJnLine."Applies-to Doc. No." := Imprest."Service Charge Issue Doc. No";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            /*// Post receipt or payment to  the customer
             LineNo:=LineNo+10000;
             GenJnLine.INIT;
                IF CMSetup.GET THEN
             GenJnLine."Journal Template Name":=JTemplate;
             GenJnLine."Journal Batch Name":=Imprest."No.";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
             GenJnLine."Account No.":=Imprest."Account No.";
             GenJnLine.VALIDATE(GenJnLine."Account No.");
             GenJnLine."Posting Date":=TODAY;
             GenJnLine."Document No.":=Imprest."No.";
             GenJnLine."External Document No.":=Imprest."Cheque No";
             GenJnLine."Payment Method Code":=Imprest."Pay Mode";
             GenJnLine.Description:=Imprest."Account Name";
             GenJnLine.Amount:=(Imprest."Actual Amount Spent"-Imprest."Imprest Amount");
             GenJnLine."Currency Code":=Imprest.Currency;
             GenJnLine.VALIDATE("Currency Code");
             GenJnLine.VALIDATE(GenJnLine.Amount);
             GenJnLine."Bal. Account Type":=GenJnLine."Account Type"::"Bank Account";
             GenJnLine."Bal. Account No.":=Imprest."Paying Bank Account";
             GenJnLine.VALIDATE("Bal. Account No.");
             GenJnLine."Shortcut Dimension 1 Code":=ImprestLines."Shortcut Dimension 1 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=ImprestLines."Shortcut Dimension 2 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
             GenJnLine."Dimension Set ID":=ImprestLines."Dimension Set ID";
             GenJnLine.VALIDATE(GenJnLine."Dimension Set ID");
             //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
             //GenJnLine."Applies-to Doc. No.":=Imprest."Imprest Issue Doc. No";
             GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
             IF GenJnLine.Amount<0 THEN
             GenJnLine.INSERT;*/
            //IMP surrender Lines Entries
            ImprestLines.Reset;
            ImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then begin
                repeat
                    ImprestLines.Validate(ImprestLines.Amount);
                    ImprestLines.TestField(Purpose);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ImprestLines."Account Type";
                    GenJnLine."Account No." := ImprestLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if Imprest."Surrender Date" = 0D then Error('You must specify the surrender date');
                    GenJnLine."Posting Date" := Today;
                    GenJnLine."Document No." := Imprest."No.";
                    //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                    GenJnLine.Description := format(ImprestLines.Purpose, 90);
                    GenJnLine.Amount := ImprestLines."Actual Spent";
                    GenJnLine."Currency Code" := Imprest.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                    //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    if Imprest."Cash Receipt Amount" <> 0 then begin
                        //Receipt Lines Entries
                        if (ImprestLines."Cash Receipt Amount" <> 0) and (ImprestLines."Imprest Receipt No." = '') then begin
                            ImprestLines.TestField("Receiving Bank");
                            LineNo := LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := Imprest."Account Type";
                            GenJnLine."Account No." := Imprest."Account No.";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine."Posting Date" := Today;
                            GenJnLine."Document No." := Imprest."No.";
                            GenJnLine."External Document No." := Imprest."Cheque No";
                            GenJnLine."Payment Method Code" := Imprest."Pay Mode";
                            GenJnLine.Description := Imprest."Account Name";
                            GenJnLine.Amount := -ImprestLines."Cash Receipt Amount";
                            GenJnLine."Currency Code" := Imprest.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                            GenJnLine."Bal. Account No." := ImprestLines."Receiving Bank";
                            GenJnLine.Validate("Bal. Account No.");
                            GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                            GenJnLine."Applies-to Doc. No." := Imprest."Service Charge Issue Doc. No";
                            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        end;
                    end;
                until ImprestLines.Next = 0;
            end;
            //CheckIfBalancing(JTemplate,JBatch);
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                Imprest.Posted := true;
                Imprest."Posted By" := UserId;
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest.Surrendered := true;
                Imprest."Surrender Date" := Today;
                Imprest."Surrendered By" := UserId;
                Imprest.Modify;
                //Create a Payment Voucher or Petty Cash if there's a receipted amount
                //Imprest.CalcFields("Cash Receipt Amount", "Actual Amount Spent", "Imprest Amount");
                if Imprest."Actual Amount Spent" > Imprest."Imprest Amount" then begin
                    CreatePVPettyCash(Imprest);
                end;
                //Uncommit Entries made to the varoius expenses accounts
                Commitment.UnencumberImprest(Imprest);
                Commit;
                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."No.", Imprest."Service Charge Issue Doc. No");
                if ImprestHeader.Find('-') then begin
                    ImprestHeader.Surrendered := true;
                    ImprestHeader."Surrender Date" := Imprest."Surrender Date";
                    ImprestHeader."Surrendered By" := Imprest."Surrendered By";
                    ImprestHeader.Modify;
                end;
                if Imprest.Apportion then Apportionment.CreatePaymentApportionEntry(Imprest);
            end;
        end;
    end;

    procedure PostServiceChargeClaim(Claim: Record Payments)
    var
        ClaimLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        CLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit Committment;
        GLSetup: Record "General Ledger Setup";
        ShortcutDimValue: array[8] of Code[20];
        DimValueName: array[8] of Text;
        DimValue: Record "Dimension Value";
        DueDate: DateFormula;
        ChequePayment: Boolean;
        ChequeRegister: Record "Cheque Register";
    begin
        ChequePayment := false;
        if Confirm('Are you sure you want to post the Claim No. ' + Claim."No." + ' ?') = true then begin
            if Claim.Status <> Claim.Status::Released then Error('The Staff Claim No %1 has not been fully approved', Claim."No.");
            if Claim.Posted then Error('Staff Claim %1 has been posted', Claim."No.");
            //Get batches
            Temp.Get(UserId);
            JTemplate := Temp."Claim Template";
            JBatch := Temp."Claim  Batch";
            if JTemplate = '' then begin
                Error('Ensure the Claims Template is set up in Cash Office Setup');
            end;
            if JBatch = '' then begin
                Error('Ensure the Claims Batch is set up in the Cash Office Setup')
            end;
            //Check Apportionment
            if Claim.Apportion then Apportionment.CheckApportionment(Claim."No.");
            Claim.TestField(Date);
            Claim.TestField("Paying Bank Account");
            //Claim.TESTFIELD(Claim.Payee);
            Claim.TestField(Claim."Pay Mode");
            PaymentMethod.Get(Claim."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField(Claim."Cheque No");
                Claim.TestField(Claim."Cheque Date");
                ChequePayment := true;
            end;
            /*//Check Commitment
                ClaimLines.RESET;
                ClaimLines.SETRANGE(No,Claim."No.");
                 IF ClaimLines.FIND('-') THEN BEGIN
                   REPEAT
                   IF IsAccountVotebookEntry(ClaimLines."Account No") THEN BEGIN
                     Commitment.FetchDimValue(ClaimLines."Dimension Set ID",ShortcutDimValue,DimValueName);
                     GLSetup.GET;
                     //DimValue.GET(GLSetup."Shortcut Dimension 1 Code",ShortcutDimValue[1]);
                     //DimValueName:=DimValue.Name;
                       IF NOT Commitment.LineCommitted(Claim."No.",ClaimLines."Account No",ClaimLines."Line No") THEN
                         ERROR(Text019,ShortcutDimValue[1]+' '+DimValueName[1]);
                   END;
                   UNTIL ClaimLines.NEXT=0;
                END;*/
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField("Cheque No");
                Claim.TestField("Cheque Date");
            end;
            //Check Lines
            Claim.CalcFields("Petty Cash Amount");
            if Claim."Petty Cash Amount" = 0 then Error('Amount cannot be zero');
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if not ClaimLines.FindLast then Error('Claim Lines cannot be empty');
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if ClaimLines.Find('-') then begin
                repeat
                    ClaimLines.TestField("Expenditure Date");
                    //ClaimLines.TESTFIELD("Claim Receipt No.");
                    ClaimLines.TestField("Expenditure Description");
                until ClaimLines.Next = 0;
            end;
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get() then Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
            //Bank Entries
            LineNo := LineNo + 10000;
            Claim.CalcFields(Claim."Petty Cash Amount");
            ClaimLines.Reset;
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            ClaimLines.Validate(ClaimLines.Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Claim."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if Claim.Date = 0D then Error('You must specify the Claim date');
            GenJnLine."Posting Date" := Claim."Payment Release Date";
            GenJnLine."Document No." := Claim."No.";
            if ChequePayment then begin
                GenJnLine."External Document No." := Claim."Cheque No";
                GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; //inserts check ledger entry
            end;
            GenJnLine."Payment Method Code" := Claim."Pay Mode";
            GenJnLine.Description := 'Staff Claim:' + Claim.Payee;
            GenJnLine.Amount := -Claim."Petty Cash Amount";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Claim."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Claim."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Claim."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Claim Entries
            ClaimLines.Reset;
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then begin
                repeat
                    ClaimLines.Validate(ClaimLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ClaimLines."Account Type";
                    GenJnLine."Account No." := ClaimLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine."Posting Date" := Claim."Payment Release Date";
                    GenJnLine."Document No." := Claim."No.";
                    GenJnLine."External Document No." := Claim."Cheque No";
                    GenJnLine."Payment Method Code" := Claim."Pay Mode";
                    GenJnLine.Description := format(ClaimLines.Description, 90);
                    GenJnLine.Amount := ClaimLines.Amount;
                    GenJnLine."Currency Code" := Claim.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    //    GenJnLine."Applies-to Doc. No.":=ClaimLines."Applies-to Doc. No.";
                    //    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    //    GenJnLine."Applies-to ID":=ClaimLines."Applies-to ID";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until ClaimLines.Next = 0;
            end;
            //End of Posting
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Claim."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                Claim.Posted := true;
                Claim."Posted By" := UserId;
                Claim."Posted Date" := Today;
                Claim."Time Posted" := Time;
                Claim.Modify;
                if Claim."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset;
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Claim."No.");
                    if CheckLedgerEntry.FindFirst then begin
                        CheckLedgerEntry."Check No." := Claim."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify;
                    end;
                    //Modify Cheque as Posted in cheque register
                    if Claim."Cheque Type" = Claim."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset;
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Claim."Cheque No");
                        if ChequeRegister.FindFirst then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Claim."Cheque Date";
                            ChequeRegister."Posted By" := UserId;
                            ChequeRegister.Modify;
                        end;
                    end;
                end;
                //Encumber
                //Commitment.EncumberPayments(Claim);
                //Apportion Card
                if Claim.Apportion then Apportionment.CreatePaymentApportionEntry(Claim);
            end;
        end;
    end;

    procedure ConfirmPost(Prec: Record Payments)
    var
        ConfPostMsg: Label 'Do you want to apportion before posting?';
        ProceedMsg: Label 'Kindly proceed to apportion';
        ErrorMsg: Label 'Kindly specify whether to apportion or not';
    begin
        /*IF NOT Prec.Apportion THEN
              BEGIN
                IF CONFIRM(ConfPostMsg,TRUE) THEN BEGIN
                  ERROR(ProceedMsg);
                END;
              END;*/
        /* if (not Prec.Apportion) and (not Prec."No Apportion") then
                Error(ErrorMsg); */
    end;

    procedure NotifyPaymentsFundsReceipt(PayRec: Record Payments)
    var
        UserSetup: Record "User Setup";
        EMAIL: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        Recipient: list of [text];
        SenderAddress: Text;
        EmailBody: Label '<p style="font-family:Corbel,Corbel;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Corbel,Corbel;font-size:10pt"> This is to inform your %2 No. %3 has been approved. </br><br>Kindly proceed to Confirm Receipt of Funds in the system. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%4<Strong></p>';
        CompanyInfo: Record "Company Information";
        CashSetup: Record "Cash Management Setups";
        SenderName: Text;
        Subject: text;
    begin
        //Notify on approval
        if PayRec."Payment Type" in [PayRec."Payment Type"::Imprest, PayRec."Payment Type"::"Petty Cash", PayRec."Payment Type"::"Staff Claim"] then begin
            if Confirm('Do you wish to notify payee to Confirm Receipt of Funds?', false) then begin
                CashSetup.Get();
                CompanyInfo.get;
                CashSetup.TestField("Finance Email");
                PayRec.TestField(Cashier);
                UserSetup.Get(PayRec.Cashier);
                UserSetup.TestField("E-Mail");
                SenderAddress := CashSetup."Finance Email";
                SenderName := CompanyInfo.Name;
                Recipient.Add(UserSetup."E-Mail");
                Subject := 'Confirm Funds Receipt';
                Emailmessage.Create(Recipient, Subject, '', true);
                //eddie  Emailmessage.(StrSubsdtNo(EmailBody, PayRec.Payee,
                //                     Format(PayRec."Payment Type"), PayRec."No.",
                //                     'Finance Department'));
                if EMAIL.Send(Emailmessage) then Message('Payee notified successfully');
            end;
        end;
    end;

    procedure CreateCustomer(AppNo: code[20])
    var
        License: record "Licensing dairy Enterprise";
        Customer: Record Customer;
        CustomerBranches: Record "Customer Branches";
        SalesSetup: Record "Sales & Receivables Setup";
        Outlets: Record "License Applicants Branches";
    begin
        SalesSetup.get;
        License.SetRange("Application no", AppNo);
        if License.FindFirst() then begin
            Customer.init;
            if License."Customer Type" = License."Customer Type"::Individual then begin
                Customer.Name := License."First Name" + ' ' + License."Middle Name" + ' ' + License."Last Name";
                Customer."Individual Pin Number" := License."Individual Pin Number";
                Customer."ID Number" := License."ID Number";
            end;
            if License."Customer Type" = License."Customer Type"::"Registered Entity" then begin
                Customer.Name := License."Business Name";
                Customer."Company Pin No." := License."Company Pin Number";
                customer."Company Registration No." := License."Company Registration Number";
            end;
            Customer."Post Code" := License."Post Code";
            Customer.Address := License."Physical Address(Building)";
            //Customer.CustomerType := Customer.CustomerType::License;
            customer."E-Mail" := License."E-Mail";
            customer."Applicant No" := AppNo;
            customer."Customer Posting Group" := SalesSetup."Default Customer Posting Group";
            customer."Gen. Bus. Posting Group" := SalesSetup."Default Gen Business Group";
            customer."VAT Bus. Posting Group" := SalesSetup."Default VAT Posting Group";
            Customer."Phone No." := license."Cell Phone Number 2";
            customer.insert(true);
            Outlets.SetRange("Application no", AppNo);
            if Outlets.find('-') then
                repeat
                    CustomerBranches.Init();
                    CustomerBranches.TransferFields(Outlets);
                    CustomerBranches."Customer No." := Customer."No.";
                    CustomerBranches."Applicant No" := AppNo;
                    CustomerBranches.Insert();
                until Outlets.next() = 0;
            License."Customer No." := Customer."No.";
            License.modify();
            //InvoiceLicenseApplicant(License);
        end;
    end;

    procedure InvoiceLicenseApplicant(AppNo: code[20]; RefNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPostedInv: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        LicenseCateg: record "License and Permit Category";
        GLAcc: code[20];
        License: Record "Licensing dairy Enterprise";
        LicenseApp: Record "License Applications";
        CustomerBranches: Record "Customer Branches";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst() then begin
            if LicenseApp."Invoice No." = '' then begin
                License.SetRange("Application no", AppNo);
                if License.FindFirst() then begin
                    if License."Customer No." = '' then CreateCustomer(License."Application no");
                    CustomerBranches.Reset();
                    CustomerBranches.SetRange("Customer No.", License."Customer No.");
                    if not CustomerBranches.FindFirst() then begin
                        CustomerBranches.Init();
                        CustomerBranches."Customer No." := LicenseApp."Customer No.";
                        CustomerBranches.Branch := LicenseApp.Outlet;
                        CustomerBranches.Insert();
                    end;
                    SalesSetup.get;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := License."Customer No.";
                    SalesHeader.validate("Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No." := License."Customer No.";
                    SalesHeader."Document Date" := today;
                    SalesHeader.Branch := LicenseApp.Outlet;
                    SalesHeader."Due Date" := today;
                    salesheader."Prices Including VAT" := true;
                    SalesHeader."Sell-to Customer Name" := License."First Name" + ' ' + license."Middle Name" + ' ' + License."Last name";
                    salesheader.insert(true);
                    LicenseCateg.reset;
                    LicenseCateg.setrange("License/Permit Category", LicenseApp.Category);
                    if LicenseCateg.FindFirst() then begin
                        LicenseCateg.TestField("Receivables G/L Account");
                        GLAcc := LicenseCateg."Receivables G/L Account";
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := GLAcc;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := (LicenseCateg."Application fees(Ksh)");
                        SalesLines.validate("Unit Price");
                        SalesLines.insert;
                    end;
                    Codeunit.RUN(Codeunit::"Sales-Post", SalesHeader);
                    EmailLicenseApplicant(License."Application no");
                    SalesPostedInv.reset;
                    SalesPostedInv.SetRange("Pre-Assigned No.", SalesHeader."No.");
                    if SalesPostedInv.FindFirst() then begin
                        SalesPostedInv.CalcFields("Remaining Amount");
                        LicenseApp."Invoice No." := SalesPostedInv."No.";
                        LicenseApp.Amount := SalesPostedInv."Remaining Amount";
                    end;
                    LicenseApp.Submitted := TRUE;
                    //LicenseApp.Status := LicenseApp.Status::"Pending inspection";
                    LicenseApp.Modify();
                end;
            end;
        end;
    end;

    procedure InvoiceLicenseApplicationRenewal(AppNo: code[20]; RefNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPostedInv: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        LicenseCateg: record "License and Permit Category";
        GLAcc: code[20];
        License: Record "Licensing dairy Enterprise";
        LicenseApp: Record "License Renewals";
        CustomerBranches: Record "Customer Branches";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst() then begin
            if LicenseApp."Invoice No." = '' then begin
                License.SetRange("Application no", AppNo);
                if License.FindFirst() then begin
                    if License."Customer No." = '' then CreateCustomer(License."Application no");
                    CustomerBranches.Reset();
                    CustomerBranches.SetRange("Customer No.", License."Customer No.");
                    if not CustomerBranches.FindFirst() then begin
                        CustomerBranches.Init();
                        CustomerBranches."Customer No." := LicenseApp."Customer No.";
                        CustomerBranches.Branch := LicenseApp.Outlet;
                        CustomerBranches.Insert();
                    end;
                    SalesSetup.get;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := License."Customer No.";
                    SalesHeader.validate("Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No." := License."Customer No.";
                    SalesHeader."Document Date" := today;
                    SalesHeader.Branch := LicenseApp.Outlet;
                    SalesHeader."Due Date" := today;
                    salesheader."Prices Including VAT" := true;
                    SalesHeader."Sell-to Customer Name" := License."First Name" + ' ' + license."Middle Name" + ' ' + License."Last name";
                    salesheader.insert(true);
                    LicenseCateg.reset;
                    LicenseCateg.setrange("License/Permit Category", LicenseApp.Category);
                    if LicenseCateg.FindFirst() then begin
                        GLAcc := LicenseCateg."Receivables G/L Account";
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := GLAcc;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := LicenseCateg."Application fees(Ksh)";
                        SalesLines.validate("Unit Price");
                        SalesLines.insert;
                    end;
                    Codeunit.RUN(Codeunit::"Sales-Post", SalesHeader);
                    EmailLicenseApplicant(License."Application no");
                    SalesPostedInv.reset;
                    SalesPostedInv.SetRange("Pre-Assigned No.", SalesHeader."No.");
                    if SalesPostedInv.FindFirst() then begin
                        SalesPostedInv.CalcFields("Remaining Amount");
                        LicenseApp."Invoice No." := SalesPostedInv."No.";
                        LicenseApp.Amount := SalesPostedInv."Remaining Amount";
                    end;
                    LicenseApp.Submitted := TRUE;
                    //LicenseApp.Status := LicenseApp.Status::"Pending inspection";
                    LicenseApp.Modify();
                end;
            end;
        end;
    end;

    procedure InvoiceLicenseRenewal(AppNo: code[20]; RefNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPostedInv: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        LicenseCateg: record "License and Permit Category";
        GLAcc: code[20];
        License: Record "Licensing dairy Enterprise";
        LicenseApp: Record "License Applications";
        CustomerBranches: Record "Customer Branches";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst() then begin
            if LicenseApp."Invoice No." = '' then begin
                License.SetRange("Application no", AppNo);
                if License.FindFirst() then begin
                    if License."Customer No." = '' then CreateCustomer(License."Application no");
                    CustomerBranches.Reset();
                    CustomerBranches.SetRange("Customer No.", License."Customer No.");
                    if not CustomerBranches.FindFirst() then begin
                        CustomerBranches.Init();
                        CustomerBranches."Customer No." := LicenseApp."Customer No.";
                        CustomerBranches.Branch := LicenseApp.Outlet;
                        CustomerBranches.Insert();
                    end;
                    SalesSetup.get;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := License."Customer No.";
                    SalesHeader.validate("Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No." := License."Customer No.";
                    SalesHeader."Document Date" := today;
                    SalesHeader.Branch := LicenseApp.Outlet;
                    SalesHeader."Due Date" := today;
                    salesheader."Prices Including VAT" := true;
                    SalesHeader."Sell-to Customer Name" := License."First Name" + ' ' + license."Middle Name" + ' ' + License."Last name";
                    salesheader.insert(true);
                    LicenseCateg.reset;
                    LicenseCateg.setrange("License/Permit Category", LicenseApp.Category);
                    if LicenseCateg.FindFirst() then begin
                        GLAcc := LicenseCateg."Receivables G/L Account";
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := GLAcc;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := LicenseCateg."Annual fees(Ksh)";
                        SalesLines.validate("Unit Price");
                        SalesLines.insert;
                    end;
                    Codeunit.RUN(Codeunit::"Sales-Post", SalesHeader);
                    EmailLicenseApplicant(License."Application no");
                    SalesPostedInv.reset;
                    SalesPostedInv.SetRange("Pre-Assigned No.", SalesHeader."No.");
                    if SalesPostedInv.FindFirst() then begin
                        SalesPostedInv.CalcFields("Remaining Amount");
                        LicenseApp."License fee Invoice No." := SalesPostedInv."No.";
                        LicenseApp."License fee" := SalesPostedInv."Remaining Amount";
                    end;
                    LicenseApp.Submitted := TRUE;
                    LicenseApp.Status := LicenseApp.Status::"Pending permit fee payment";
                    LicenseApp.Modify();
                end;
            end;
        end;
    end;

    procedure InvoiceMonthlyFormOfReturn(RefNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPostedInv: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        GLAcc: code[20];
        License: Record "Licensing dairy Enterprise";
        CessSetup: record "Cess and Levy setup";
        MonthlyReturn: Record "Monthly Form of Return";
        LineNo: Integer;
    begin
        CessSetup.Get();
        //CessSetup.TestField("Cess Receivables");
        // CessSetup.TestField("Cess Penalty Receivables");
        CessSetup.TestField("Levy Receivables");
        CessSetup.TestField("Levy Penalty Receivables");
        LineNo := 0;
        MonthlyReturn.SetRange("No.", RefNo);
        if MonthlyReturn.FindFirst() then begin
            if MonthlyReturn."Invoice No." = '' then begin
                License.SetRange("Application no", MonthlyReturn."Applicant No.");
                if License.FindFirst() then begin
                    SalesSetup.get;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := License."Customer No.";
                    SalesHeader.validate("Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No." := License."Customer No.";
                    SalesHeader."Document Date" := today;
                    SalesHeader."Due Date" := today;
                    salesheader."Prices Including VAT" := true;
                    SalesHeader."Sell-to Customer Name" := License."First Name" + ' ' + license."Middle Name" + ' ' + License."Last name";
                    salesheader.insert(true);
                    //insert Cess Receivable
                    //GLAcc := LicenseCateg."Receivables G/L Account";
                    // if MonthlyReturn."Cess Amount" > 0 then begin
                    //     SalesLines.init;
                    //     SalesLines."Document No." := SalesHeader."No.";
                    //     SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                    //     SalesLines.Type := SalesLines.Type::"G/L Account";
                    //     SalesLines."No." := CessSetup."Cess Receivables";
                    //     SalesLines."Line No." := 1;
                    //     SalesLines.validate("No.");
                    //     SalesLines.Quantity := 1;
                    //     SalesLines.validate(Quantity);
                    //     SalesLines."Unit Price" := MonthlyReturn."Cess Amount";
                    //     SalesLines.validate("Unit Price");
                    //     SalesLines.insert(true);
                    // end;
                    //Cess penalties
                    // if MonthlyReturn."Cess Penalty" > 0 then begin
                    //     SalesLines.init;
                    //     SalesLines."Document No." := SalesHeader."No.";
                    //     SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                    //     SalesLines.Type := SalesLines.Type::"G/L Account";
                    //     SalesLines."No." := CessSetup."Cess Penalty Receivables";
                    //     SalesLines."Line No." := 2;
                    //     SalesLines.validate("No.");
                    //     SalesLines.Quantity := 1;
                    //     SalesLines.validate(Quantity);
                    //     SalesLines."Unit Price" := MonthlyReturn."Cess Penalty";
                    //     SalesLines.validate("Unit Price");
                    //     SalesLines.insert(true);
                    // end;
                    //Levy Receivable
                    if MonthlyReturn."Levy Amount" > 0 then begin
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := CessSetup."Levy Receivables";
                        SalesLines."Line No." := 3;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := MonthlyReturn."Levy Amount";
                        SalesLines.validate("Unit Price");
                        SalesLines.insert(true);
                    end;
                    //Levy Penalty
                    if MonthlyReturn."Levy Penalty" > 0 then begin
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := CessSetup."Levy Penalty Receivables";
                        SalesLines."Line No." := 4;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := MonthlyReturn."Levy Penalty";
                        SalesLines.validate("Unit Price");
                        SalesLines.insert(true);
                    end;
                    Codeunit.RUN(Codeunit::"Sales-Post", SalesHeader);
                    MonthlyReturn.Invoiced := TRUE;
                    SalesPostedInv.reset;
                    SalesPostedInv.SetRange("Pre-Assigned No.", SalesHeader."No.");
                    if SalesPostedInv.FindFirst() then begin
                        SalesPostedInv.CalcFields("Remaining Amount");
                        MonthlyReturn."Invoice No." := SalesPostedInv."No.";
                        MonthlyReturn."Total Amount" := SalesPostedInv."Remaining Amount";
                    end;
                    MonthlyReturn.Modify();
                end;
            end;
        end;
    end;

    procedure InvoiceLicenseAnnualFee(AppNo: code[20]; RefNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPostedInv: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        LicenseCateg: record "License and Permit Category";
        GLAcc: code[20];
        License: Record "Licensing dairy Enterprise";
        LicenseApp: Record "License Applications";
        CustomerBranches: Record "Customer Branches";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst() then begin
            if LicenseApp."License fee Invoice No." = '' then begin
                License.SetRange("Application no", AppNo);
                if License.FindFirst() then begin
                    if License."Customer No." = '' then CreateCustomer(License."Application no");
                    CustomerBranches.Reset();
                    CustomerBranches.SetRange("Customer No.", License."Customer No.");
                    if not CustomerBranches.FindFirst() then begin
                        CustomerBranches.Init();
                        CustomerBranches."Customer No." := LicenseApp."Customer No.";
                        CustomerBranches.Branch := LicenseApp.Outlet;
                        CustomerBranches.Insert();
                    end;
                    SalesSetup.get;
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."Sell-to Customer No." := License."Customer No.";
                    SalesHeader.validate("Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No." := License."Customer No.";
                    SalesHeader."Document Date" := today;
                    SalesHeader.Branch := LicenseApp.Outlet;
                    SalesHeader."Due Date" := today;
                    salesheader."Prices Including VAT" := true;
                    SalesHeader."Sell-to Customer Name" := License."First Name" + ' ' + license."Middle Name" + ' ' + License."Last name";
                    salesheader.insert(true);
                    LicenseCateg.reset;
                    LicenseCateg.setrange("License/Permit Category", LicenseApp.Category);
                    if LicenseCateg.FindFirst() then begin
                        GLAcc := LicenseCateg."Receivables G/L Account";
                        SalesLines.init;
                        SalesLines."Document No." := SalesHeader."No.";
                        SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                        SalesLines.Type := SalesLines.Type::"G/L Account";
                        SalesLines."No." := GLAcc;
                        SalesLines.validate("No.");
                        SalesLines.Quantity := 1;
                        SalesLines.validate(Quantity);
                        SalesLines."Unit Price" := LicenseCateg."Annual fees(Ksh)";
                        SalesLines.validate("Unit Price");
                        SalesLines.insert;
                    end;
                    Codeunit.RUN(Codeunit::"Sales-Post", SalesHeader);
                    EmailLicenseApplicant(License."Application no");
                    SalesPostedInv.reset;
                    SalesPostedInv.SetRange("Pre-Assigned No.", SalesHeader."No.");
                    if SalesPostedInv.FindFirst() then begin
                        SalesPostedInv.CalcFields("Remaining Amount");
                        LicenseApp."License fee Invoice No." := SalesPostedInv."No.";
                        LicenseApp."License fee" := SalesPostedInv."Remaining Amount";
                    end;
                    LicenseApp.Submitted := TRUE;
                    LicenseApp.Status := LicenseApp.Status::"Pending permit fee payment";
                    LicenseApp.Modify();
                end;
            end;
        end;
    end;

    procedure EmailLicenseApplicant(AppNo: Code[10])
    var
        Applicants: Record "Licensing dairy Enterprise";
        CompanyInfo: Record "Company Information";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        // SMTP: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        Attachment: Text;
        ErrorMsg: Text;
        NewBody: Label 'Dear %1, <br><br> This is to Confirm receipt of your application for License <Strong>%2 </Strong>.<br> <br> <br>Please pay the application fee<br><br>';
        Instr: InStream;
        EMAIL: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        EmailSignText: Text;
        EmailSignBigText: BigText;
        TempBlobNew: Codeunit "Temp Blob";
        //TempBlob: Record TempBlob;
        SalesHeader: Record "Sales Invoice Header";
        ComplianceSetup: Record "Compliance Setup";
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture, "E-Mail Signature");
        ComplianceSetup.Get();
        ComplianceSetup.TestField("Attachments Path");
        CompanyInfo."E-Mail Signature".CreateInStream(Instr);
        EmailSignBigText.Read(Instr);
        EmailSignText := Format(EmailSignBigText);
        Applicants.Reset();
        Applicants.SetFilter("Application No", AppNo);
        if Applicants.FindFirst() then begin
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName := CompanyInfo.Name;
            SenderAddress := CompanyInfo."E-Mail";
            Receipient.Add(Applicants."E-Mail");
            Subject := 'Application fee';
            TimeNow := (Format(Time));
            //eddie Emailmessage.Create(Recipient, Subject, '',true);
            Emailmessage.AppendToBody(StrSubstNo(NewBody, (Applicants."First Name" + Applicants."Business Name"), Applicants."License Type"));
            Emailmessage.AppendToBody(EmailSignText);
            EMAIL.Send(Emailmessage);
        end;
    end;

    procedure LookupETFDocs(PRec: Record Payments)
    var
        PayeeCode: Code[50];
        LineNo: Integer;
        PaymentsListAll: Page "Payments List - All";
        EFTLines: Record "EFT Lines New";
        PaymentLines: record "Payment Lines";
        PayRec: Record Payments;
        PayLines: Record "Payment Lines";
        PayeeRec: Record Vendor;
        CustBank: Record "Customer Bank Account";
        PayModes: Record "Payment Method";
        Banks: Record Banks;
    begin
        PRec.TestField("Responsibility Center");
        PaymentsRec.Reset;
        PaymentsRec.FilterGroup(2);
        PaymentsRec.SetFilter("Payment Type", '%1|%2|%3|%4|%5', PaymentsRec."Payment Type"::"Payment Voucher", PaymentsRec."Payment Type"::"Bank Transfer", PaymentsRec."Payment Type"::"Staff Claim", PaymentsRec."Payment Type"::Imprest, PaymentsRec."Payment Type"::"Travel Request");
        //PaymentsRec.SetRange("Pay Mode Type", PaymentsRec."Pay Mode Type"::EFT);
        PaymentsRec.SetFilter(Status, '%1|%2', PaymentsRec.Status::Released, PaymentsRec.Status::"Finance Approved");
        // if PaymentsRec."Payment Type" = PaymentsRec."Payment Type"::"Payment Voucher" then
        //     PaymentsRec.SetRange(Status, PaymentsRec.Status::"Finance Approved");
        PaymentsRec.SetRange("EFT File Generated", false);
        PaymentsRec.SetRange(Posted, true);
        if PRec."Payment Type" = PRec."Payment Type"::"EFT File Gen" then PaymentsRec.SetFilter("PV Type", '<>%1', PaymentsRec."PV Type"::Payroll);
        if PRec."Payment Type" = PRec."Payment Type"::"Payroll EFT File Gen" then begin
            PaymentsRec.SetFilter("PV Type", '=%1', PaymentsRec."PV Type"::Payroll);
            PaymentsRec.SetRange("Payment Type", PaymentsRec."Payment Type"::"Payment Voucher");
        end;
        PaymentsListAll.SetTableView(PaymentsRec);
        PaymentsListAll.LookupMode(true);
        if PaymentsListAll.RunModal = ACTION::LookupOK then begin
            PayRec.Copy(PaymentsRec);
            PayRec.SetRange(Select, true);
            PayRec.SetRange("Selected By", UserId);
            if (PayRec.FindSet(true) and (PayRec.Count > 0)) then begin
                EFTLines.SetRange("Document No.", PRec."No.");
                if EFTLines.FindLast then
                    LineNo := EFTLines."Line No."
                else
                    LineNo := 0;
                repeat
                    if PayRec."Payment Type" <> PayRec."Payment Type"::"Bank Transfer" then begin
                        PayRec.TestField("Paying Bank Account");
                        PayRec.TestField("Payment Narration");
                        PaymentLines.reset;
                        PaymentLines.SetRange("No", PayRec."No.");
                        PaymentLines.SetFilter("Net Amount", '>%1', 0);
                        if PaymentLines.Find('-') then
                            repeat
                                PaymentLines.TestField("POP Code");
                                PaymentLines.TestField("Pay Mode");
                                if Banks.Get(PaymentLines."Payee Bank Code") then Banks.TestField("Swift Code");
                                EFTLines.Init;
                                EFTLines."Document No." := PRec."No.";
                                EFTLines."No." := PayRec."No.";
                                if PayModes.Get(PaymentLines."Pay Mode") then begin
                                    PayModes.TestField("Document Path");
                                end;
                                EFTLines."Pay Mode" := PaymentLines."Pay Mode";
                                EFTLines.Payee := PaymentLines.Payee;
                                EFTLines."Total Net Amount" := PaymentLines."Net Amount";
                                EFTLines."Total VAT Amount" := PaymentLines."VAT Amount";
                                EFTLines."Total Witholding Tax Amount" := PaymentLines."W/T VAT Amount";
                                EFTLines."Total Amount" := PaymentLines.Amount;
                                EFTLines."Line No." := PaymentLines."Line No";
                                PayeeRec.Get(PaymentLines."Account No");
                                if PayeeRec.Find('-') then begin
                                    EFTLines."Payee Bank Account No" := PayeeRec."Vendor Bank Account No";
                                    EFTLines."Payee Bank Branch Code" := PayeeRec."Vendor Bank Branch Code";
                                    EFTLines."Payee Bank Branch Name" := PayeeRec."Vendor Bank Branch Name";
                                    EFTLines."Payee Bank Code" := PayeeRec."Vendor Bank Code";
                                    EFTLines."Payee Bank Code Name" := PayeeRec."Vendor Bank Code Name";
                                    EFTLines."Payee Swift Code" := PayeeRec."Vendor Swift Code";
                                end;
                                EFTLines.Insert(true);
                                EFTLines.Validate("No.");
                                EFTLines.Modify();
                            until PaymentLines.Next = 0;
                    end;
                    if PayRec."Payment Type" = PayRec."Payment Type"::"Bank Transfer" then begin
                        PaymentLines.reset;
                        PaymentLines.SetRange("No", PayRec."No.");
                        if PaymentLines.Find('-') then
                            repeat
                                if Banks.Get(PaymentLines."Payee Bank Code") then Banks.TestField("Swift Code");
                                EFTLines.Init;
                                EFTLines."Document No." := PRec."No.";
                                EFTLines."No." := PayRec."No.";
                                if PayModes.Get(PaymentLines."Pay Mode") then begin
                                    PayModes.TestField("Document Path");
                                    //EFTLines."Document Path" := PayModes."Document Path";
                                end;
                                EFTLines."Payment Type" := EFTLines."Payment Type"::"Bank Transfer";
                                EFTLines.Payee := PaymentLines.Payee;
                                EFTLines."Payment Narration" := PayRec."Payment Narration";
                                EFTLines."Total Net Amount" := PaymentLines."Net Amount";
                                EFTLines."Total VAT Amount" := PaymentLines."VAT Amount";
                                EFTLines."Total Witholding Tax Amount" := PaymentLines."W/T VAT Amount";
                                EFTLines."Total Amount" := PaymentLines.Amount;
                                EFTLines."Line No." := PaymentLines."Line No";
                                EFTLines."Payee Bank Account No" := PaymentLines."Payee Bank Account No";
                                EFTLines."Payee Bank Branch Code" := PaymentLines."Payee Bank Branch Code";
                                EFTLines."Payee Bank Branch Name" := PaymentLines."Payee Bank Branch Name";
                                EFTLines."Payee Bank Code" := PaymentLines."Payee Bank Code";
                                EFTLines."Payee Bank Code Name" := PaymentLines."Payee Bank Code Name";
                                EFTLines."Payee Swift Code" := PaymentLines."Payee Swift Code";
                                EFTLines."Payee Bank Account Name" := PaymentLines."Payee Account Name";
                                if not EFTLines.Get(PRec."No.", PayRec."No.", PaymentLines."Line No") then begin
                                    EFTLines.Insert(true);
                                    EFTLines.Validate("No.");
                                    EFTLines.Modify();
                                end;
                            until PaymentLines.Next = 0;
                    end;
                    PayRec."EFT Reference" := PRec."No.";
                    PayRec."EFT File Generated" := true;
                    PayRec."EFT Date" := today;
                    PayRec.modify;
                until PayRec.Next = 0;
            end
            else
                Error('Please select at least one Payment');
        end;
    end;

    procedure LookupETFDocsT(PRec: Record Payments)
    var
        PayeeCode: Code[50];
        LineNo: Integer;
        PaymentsListAll: Page "Payments List - All";
        EFTLines: Record "EFT Lines New";
        PaymentLines: record "Payment Lines";
        PayRec: Record Payments;
        PayLines: Record "Payment Lines";
        PayeeRec: Record Vendor;
        Customer: Record Customer;
        CustBank: Record "Customer Bank Account";
        PayModes: Record "Payment Method";
        Banks: Record Banks;
        CashSetup: Record "Cash Management Setups";
    begin
        CashSetup.Get();
        PRec.TestField("Responsibility Center");
        PaymentsRec.Reset;
        PaymentsRec.FilterGroup(2);
        PaymentsRec.SetFilter("Payment Type", '%1|%2|%3|%4|%5', PaymentsRec."Payment Type"::"Payment Voucher", PaymentsRec."Payment Type"::"Bank Transfer", PaymentsRec."Payment Type"::"Staff Claim", PaymentsRec."Payment Type"::Imprest, PaymentsRec."Payment Type"::"Travel Request");
        PaymentsRec.SetFilter(Status, '%1|%2', PaymentsRec.Status::Released, PaymentsRec.Status::"Finance Approved");
        PaymentsRec.SetRange("EFT File Generated", false);
        PaymentsRec.SetRange(Posted, true);
        if PRec."Payment Type" = PRec."Payment Type"::"EFT File Gen" then PaymentsRec.SetFilter("PV Type", '<>%1', PaymentsRec."PV Type"::Payroll);
        if PRec."Payment Type" = PRec."Payment Type"::"Payroll EFT File Gen" then begin
            PaymentsRec.SetFilter("PV Type", '=%1', PaymentsRec."PV Type"::Payroll);
            PaymentsRec.SetRange("Payment Type", PaymentsRec."Payment Type"::"Payment Voucher");
        end;
        PaymentsListAll.SetTableView(PaymentsRec);
        PaymentsListAll.LookupMode(true);
        if PaymentsListAll.RunModal = ACTION::LookupOK then begin
            PayRec.Copy(PaymentsRec);
            PayRec.SetRange(Select, true);
            PayRec.SetRange("Selected By", UserId);
            if (PayRec.FindSet(true) and (PayRec.Count > 0)) then begin
                EFTLines.SetRange("Document No.", PRec."No.");
                if EFTLines.FindLast then
                    LineNo := EFTLines."Line No."
                else
                    LineNo := 0;
                repeat
                    if PayRec."Payment Type" <> PayRec."Payment Type"::"Bank Transfer" then begin
                        // PayRec.TestField("Paying Bank Account");
                        //   PayRec.TestField("Payment Narration");
                        PaymentLines.reset;
                        PaymentLines.SetRange("No", PayRec."No.");
                        PaymentLines.SetFilter("Net Amount", '>%1', 0);
                        if PaymentLines.Find('-') then
                            repeat //   PaymentLines.TestField("POP Code");
                                //  PaymentLines.TestField("Pay Mode");
                                // if Banks.Get(PaymentLines."Payee Bank Code") then
                                // Banks.TestField("Swift Code");
                                EFTLines.Init;
                                EFTLines."Document No." := PRec."No.";
                                EFTLines."No." := PayRec."No.";
                                if PayModes.Get(PaymentLines."Pay Mode") then begin
                                    // PayModes.TestField("Document Path");
                                end;
                                if PaymentLines."Pay Mode" = '' then EFTLines."Pay Mode" := CashSetup."Pay Mode";
                                EFTLines."Pay Mode" := PaymentLines."Pay Mode";
                                EFTLines.Payee := PaymentLines.Payee;
                                EFTLines."Total Net Amount" := PaymentLines."Net Amount";
                                EFTLines."Total VAT Amount" := PaymentLines."VAT Amount";
                                EFTLines."Total Witholding Tax Amount" := PaymentLines."W/T VAT Amount";
                                EFTLines."Total Amount" := PaymentLines.Amount;
                                EFTLines."Line No." := PaymentLines."Line No";
                                if Customer.Get(PaymentLines."Account No") then begin
                                    EFTLines."Payee Email" := Customer."E-Mail";
                                    EFTLines."Payee Bank Code" := Customer."Bank Code";
                                    EFTLines."Payee Bank Branch Code" := Customer."Bank Branch Code";
                                    EFTLines."Payee Bank Account No" := Customer."Bank Account No";
                                    EFTLines."Payee Bank Account Name" := Customer."Bank Code Name";
                                end;
                                if PayeeRec.get(PaymentLines."Account No") then begin
                                    EFTLines."Payee Email" := PayeeRec."E-Mail";
                                    EFTLines."Payee Bank Code" := PayeeRec."Vendor Bank Code";
                                    EFTLines."Payee Bank Branch Code" := PayeeRec."Vendor Bank Branch Code";
                                    EFTLines."Payee Bank Account No" := PayeeRec."Vendor Bank Account No";
                                    EFTLines."Payee Bank Account Name" := PayeeRec."Bank Account Name";
                                end;
                                EFTLines."Payee Swift Code" := PaymentLines."Payee Swift Code";
                                EFTLines."Payee Bank Account Name" := PaymentLines."Payee Account Name";
                                EFTLines.Insert(true);
                                EFTLines.Validate("No.");
                                EFTLines.Modify();
                            until PaymentLines.Next = 0;
                    end;
                    if PayRec."Payment Type" = PayRec."Payment Type"::"Bank Transfer" then begin
                        PaymentLines.reset;
                        PaymentLines.SetRange("No", PayRec."No.");
                        if PaymentLines.Find('-') then
                            repeat
                                if Banks.Get(PaymentLines."Payee Bank Code") then Banks.TestField("Swift Code");
                                EFTLines.Init;
                                EFTLines."Document No." := PRec."No.";
                                EFTLines."No." := PayRec."No.";
                                //EFTLines.TransferFields(PayRec);
                                if PayModes.Get(PaymentLines."Pay Mode") then begin
                                    PayModes.TestField("Document Path");
                                    //EFTLines."Document Path" := PayModes."Document Path";
                                end;
                                EFTLines."Payment Type" := EFTLines."Payment Type"::"Bank Transfer";
                                EFTLines.Payee := PaymentLines.Payee;
                                EFTLines."Payment Narration" := PayRec."Payment Narration";
                                EFTLines."Total Net Amount" := PaymentLines."Net Amount";
                                EFTLines."Total VAT Amount" := PaymentLines."VAT Amount";
                                EFTLines."Total Witholding Tax Amount" := PaymentLines."W/T VAT Amount";
                                EFTLines."Total Amount" := PaymentLines.Amount;
                                EFTLines."Line No." := PaymentLines."Line No";
                                if Customer.Get(PaymentLines."Account No") then begin
                                    EFTLines."Payee Email" := Customer."E-Mail";
                                    EFTLines."Payee Bank Code" := Customer."Bank Code";
                                    EFTLines."Payee Bank Branch Code" := Customer."Bank Branch Code";
                                    EFTLines."Payee Bank Account No" := Customer."Bank Account No";
                                    EFTLines."Payee Bank Account Name" := Customer."Bank Code Name";
                                end;
                                if PayeeRec.get(PaymentLines."Account No") then begin
                                    EFTLines."Payee Email" := PayeeRec."E-Mail";
                                    EFTLines."Payee Bank Code" := PayeeRec."Vendor Bank Code";
                                    EFTLines."Payee Bank Branch Code" := PayeeRec."Vendor Bank Branch Code";
                                    EFTLines."Payee Bank Account No" := PayeeRec."Vendor Bank Account No";
                                    EFTLines."Payee Bank Account Name" := PayeeRec."Bank Account Name";
                                end;
                                //   EFTLines."Payee Bank Account No" := PaymentLines."Payee Bank Account No";
                                //   EFTLines."Payee Bank Branch Code" := PaymentLines."Payee Bank Branch Code";
                                ////  EFTLines."Payee Bank Branch Name" := PaymentLines."Payee Bank Branch Name";
                                //   EFTLines."Payee Bank Code" := PaymentLines."Payee Bank Code";
                                // EFTLines."Payee Bank Code Name" := PaymentLines."Payee Bank Code Name";
                                //    EFTLines."Payee Swift Code" := PaymentLines."Payee Swift Code";
                                EFTLines."Payee Bank Account Name" := PaymentLines."Payee Account Name";
                                if not EFTLines.Get(PRec."No.", PayRec."No.", PaymentLines."Line No") then begin
                                    EFTLines.Insert(true);
                                    EFTLines.Validate("No.");
                                    EFTLines.Modify();
                                end;
                            until PaymentLines.Next = 0;
                    end;
                    PayRec."EFT Reference" := PRec."No.";
                    PayRec."EFT File Generated" := true;
                    PayRec."EFT Date" := today;
                    PayRec.modify;
                until PayRec.Next = 0;
            end
            else
                Error('Please select at least one Payment');
        end;
    end;

    procedure GenerateMultipleEFTs(PRec: Record Payments)
    var
        i: Integer;
        EFTLines: Record "EFT Lines New";
        EFTMultiple: Report "Generate EFT Multiple";
        EFTFilter: Text;
    begin
        ///PRec.TESTFIELD("EFT File Generated",FALSE);
        PRec.TestField("EFT Date");
        PRec.TestField("EFT Reference");
        PaymentsRec.Reset;
        PaymentsRec.SetFilter("No.", PRec."No.");
        EFTMultiple.SetTableView(PaymentsRec);
        EFTMultiple.Run;
    end;

    procedure GenerateMultipleEFTTs(PRec: Record Payments)
    var
        i: Integer;
        EFTLines: Record "EFT Lines New";
        EFTMultiple: Report "Generate Vendor EFTFile";
        EFTFilter: Text;
    begin
        PRec.TestField("EFT Date");
        PRec.TestField("EFT Reference");
        PaymentsRec.Reset;
        PaymentsRec.SetFilter("No.", PRec."No.");
        EFTMultiple.SetTableView(PaymentsRec);
        EFTMultiple.Run;
    end;

    procedure GenerateTaxEFTs(PRec: Record Payments)
    var
        i: Integer;
        EFTLines: Record "EFT Lines New";
        EFTMultiple: Report "Generate EFT Multiple Tax";
        EFTFilter: Text;
    begin
        ///PRec.TESTFIELD("EFT File Generated",FALSE);
        PRec.TestField("EFT Date");
        PRec.TestField("EFT Reference");
        PaymentsRec.Reset;
        PaymentsRec.SetFilter("No.", PRec."No.");
        EFTMultiple.SetTableView(PaymentsRec);
        EFTMultiple.Run;
        //Commit;
    end;
    //Forex
    procedure GenerateMultipleEFTs2(PRec: Record Payments)
    var
        i: Integer;
        EFTLines: Record "EFT Lines New";
        EFTMultiple: Report "Generate EFT Multiple2";
        EFTFilter: Text;
    begin
        ///PRec.TESTFIELD("EFT File Generated",FALSE);
        PRec.TestField("EFT Date");
        PRec.TestField("EFT Reference");
        PaymentsRec.Reset;
        PaymentsRec.SetFilter("No.", PRec."No.");
        EFTMultiple.SetTableView(PaymentsRec);
        EFTMultiple.Run;
        //Commit;
    end;

    procedure PostMultipleEFTs(PRec: Record Payments)
    var
        i: Integer;
        EFTLines: Record "EFT Lines New";
        EFTFilter: Text;
        Text001: Label 'The EFT No %1 has not been fully approved';
    begin
        PRec.TestField("EFT File Generated", true);
        PRec.TestField("EFT Date");
        PRec.TestField("EFT Reference");
        if PRec.Status <> PRec.Status::Released then Error(Text001, PRec."No.");
        EFTLines.Reset;
        EFTLines.SetRange("Document No.", PRec."No.");
        EFTLines.SetRange("PV Posted", false);
        if EFTLines.FindFirst then begin
            repeat
                if PaymentsRec.Get(EFTLines."No.") then begin
                    case PaymentsRec."Payment Type" of
                        PaymentsRec."Payment Type"::"Payment Voucher":
                            begin
                                // PostPaymentVoucher(PaymentsRec, true);
                            end;
                        PaymentsRec."Payment Type"::"Petty Cash":
                            begin
                                //   PostPettyCash(PaymentsRec, true);
                            end;
                        PaymentsRec."Payment Type"::Imprest:
                            begin
                                //  PostImprest(PaymentsRec, true);
                            end;
                        PaymentsRec."Payment Type"::"Staff Claim":
                            begin
                                //   PostStaffClaim(PaymentsRec, true);
                            end;
                    end;
                end;
                EFTLines."PV Posted" := true;
                EFTLines.Modify;
                Commit;
            until EFTLines.Next = 0;
        end;
        PRec.Posted := true;
        PRec."Posted By" := UserId;
        PRec."Posted Date" := Today;
        PRec.Modify;
    end;

    procedure CreatePVPayrollransfer2(EmpPayApproval: Record "Payroll Approval")
    var
        Pmt: Record Payments;
        PmtCopy: Record Payments;
        PmtLines: Record "Payment Lines";
        PmtTypes: Record "Receipts and Payment Types";
        PayrollType: Code[20];
        TextPos: Integer;
        DescriptionText: Text[1000];
        Deductions: Record DeductionsX;
        Deductions2: Record DeductionsX;
        NetPay: Decimal;
        GrossPay: Decimal;
        BankCharges: Decimal;
        Employee: Record Employee;
        EmployeePostingGroup: Record "Employee Posting GroupX";
        EmployeePo: code[50];
        Employee2: Record Employee;
        Employee3: Record Employee;
        AccNo: Code[20];
        PVAmount: Decimal;
        PayrollPeriod: Record "Payroll PeriodX";
    begin
        EmpPayApproval.testfield("Estimated Charges");
        GrossPay := 0;
        HRSetup.get;
        PmtTypes.RESET;
        PmtTypes.SetRange(Type, PmtTypes.Type::"Payment");
        PmtTypes.SETRANGE("Payroll Liabilities", TRUE);
        IF PmtTypes.FINDFIRST THEN PayrollType := PmtTypes.Code;
        Deductions2.Reset();
        Deductions2.setrange("Pay Period Filter", EmpPayApproval."Payroll Period");
        Deductions2.SETRANGE("Auto Create PV", TRUE);
        Deductions2.SetFilter("Account No.", '<>%1', '');
        Deductions2.SetFilter("PV Period", '<>%1', EmpPayApproval."Payroll Period");
        if Deductions2.Find('-') then
            repeat
                Deductions.RESET;
                Deductions.setrange("Pay Period Filter", EmpPayApproval."Payroll Period");
                Deductions.SETRANGE("Auto Create PV", TRUE);
                Deductions.SetFilter("PV Period", '<>%1', EmpPayApproval."Payroll Period");
                Deductions.SetRange("Account Type", Deductions2."Account Type");
                Deductions.SetRange("Account No.", Deductions2."Account No.");
                IF Deductions.FIND('-') THEN begin
                    PVAmount := 0;
                    REPEAT
                        Deductions.CalcFields("Total Amount", "Total Amount Employer");
                        PVAmount += ABS(Deductions."Total Amount") + Abs(Deductions."Total Amount Employer");
                        Deductions."PV Period" := EmpPayApproval."Payroll Period";
                        Deductions."PV created" := true;
                        Deductions.Modify();
                    UNTIL Deductions.NEXT() = 0;
                    if PVAmount > 0 then begin
                    end;
                    Pmt.INIT;
                    Pmt."Payment Type" := Pmt."Payment Type"::"Payment Voucher";
                    Pmt."No." := '';
                    Pmt."Payment Narration" := Deductions.Description;
                    Pmt.Date := TODAY;
                    if Deductions2."PAYE Code" = true then Pmt."Payment File" := Pmt."Payment File"::Tax;
                    Pmt."Paying Bank Account" := HRSetup."Default Bank";
                    Pmt.Payee := Deductions."Account No.";
                    Pmt.Status := Pmt.Status::Released;
                    Pmt."Source Table No" := 51520210;
                    Pmt."Source Document No." := EmpPayApproval."No.";
                    Pmt."Payroll Approval No." := EmpPayApproval."No.";
                    Pmt."Payroll Period" := EmpPayApproval."Payroll Period";
                    Pmt."Source RECORDID" := EmpPayApproval.RecordId;
                    Pmt."PV Type" := Pmt."PV Type"::Payroll;
                    Pmt.INSERT(TRUE);
                    PmtLines.INIT;
                    PmtLines.No := Pmt."No.";
                    PmtLines."Line No" := GetNextLineNo(PmtLines.No);
                    PmtLines."Payment Type" := PmtLines."Payment Type"::"Payment Voucher";
                    PmtLines."Expenditure Type" := PayrollType;
                    PmtLines."Account Type" := Deductions2."Account Type";
                    if Deductions2."PAYE Code" = true then PmtLines."System Amount" := PVAmount;
                    PmtLines.Amount := PVAmount;
                    PmtLines."POP Code" := Deductions2."POP Code";
                    PmtLines."Account No" := Deductions2."Account No.";
                    PmtLines.Description := 'Payments to ' + Deductions2."Account No." + ' for the month of ' + format(EmpPayApproval."Payroll Period");
                    PmtLines.VALIDATE("Account No");
                    PmtLines.VALIDATE(Amount);
                    PmtLines.INSERT(TRUE);
                END;
            until Deductions2.Next = 0;
        PmtCopy.reset;
        PmtCopy.SetRange("Net Pay", true);
        PmtCopy.SetRange("Payroll Period", EmpPayApproval."Payroll Period");
        PmtCopy.SetRange("Payroll Approval No.", EmpPayApproval."No.");
        PmtCopy.setrange("Payment Type", PmtCopy."Payment Type"::"Payment Voucher");
        if not PmtCopy.FindFirst() then begin
            Pmt.INIT;
            Pmt."Payment Type" := Pmt."Payment Type"::"Payment Voucher";
            Pmt."No." := '';
            Pmt."Payment Narration" := 'Net Pay for' + ' ' + format(EmpPayApproval."Payroll Period");
            Pmt.Date := TODAY;
            Pmt."Paying Bank Account" := HRSetup."Default Bank";
            Pmt."Source Table No" := 51520210;
            Pmt."Source Document No." := EmpPayApproval."No.";
            BankCharges := EmpPayApproval."Estimated Charges";
            Pmt."Payroll Approval No." := EmpPayApproval."No.";
            Pmt.Status := Pmt.Status::Released;
            Pmt."Source RECORDID" := EmpPayApproval.RecordId;
            Pmt."Deduction Code." := 'NET PAY';
            Pmt."Net Pay" := true;
            Pmt."Payroll Period" := EmpPayApproval."Payroll Period";
            Pmt."PV Type" := Pmt."PV Type"::Payroll;
            Pmt.INSERT(TRUE);
            PmtTypes.RESET;
            PmtTypes.SetRange(Type, PmtTypes.Type::"Payment");
            PmtTypes.SETRANGE("Payroll Liabilities", true);
            IF PmtTypes.FINDFIRST THEN
                PayrollType := PmtTypes.Code
            else
                Error('Please setup payroll liabilities PV type');
            NetPay := 0;
            Employee2.Reset();
            Employee2.SetFilter("Posting Group", '<>%1', '');
            if Employee2.FindFirst() then EmployeePo := Employee2."Posting Group";
            Employee2.Reset();
            Employee2.SetRange("Pay Period Filter", EmpPayApproval."Payroll Period");
            if Employee2.Find('-') then begin
                repeat
                    Employee2.CalcFields("Total Allowances", "Total Deductions", "Loan Interest");
                    NetPay += Employee2."Total Allowances" + Employee2."Total Deductions" + Employee2."Loan Interest";
                until Employee2.Next() = 0;
                PmtLines.INIT;
                PmtLines.No := Pmt."No.";
                PmtLines."Line No" := GetNextLineNo(PmtLines.No);
                PmtLines."Payment Type" := PmtLines."Payment Type"::"Payment Voucher";
                PmtLines."Expenditure Type" := PayrollType;
                PmtLines.Amount := abs(NetPay);
                PmtLines.Description := Deductions.Description;
                PmtLines."POP Code" := HRSetup."Net pay POP Code";
                if NetPay <> 0 then begin
                    PmtLines.VALIDATE("Expenditure Type");
                    EmployeePostingGroup.get(EmployeePo);
                    PmtLines."Account Type" := EmployeePostingGroup."Net Salary Account Type";
                    PmtLines."Account No" := EmployeePostingGroup."Net Salary Payable";
                    PmtLines.Validate("Account No");
                    PmtLines.VALIDATE(Amount);
                    PmtLines.Insert();
                end;
            end;
        end;
        PmtCopy.reset;
        PmtCopy.SetRange("Net Pay", true);
        PmtCopy.SetRange("Payroll Period", EmpPayApproval."Payroll Period");
        PmtCopy.setrange("Payment Type", PmtCopy."Payment Type"::"Bank Transfer");
        if not PmtCopy.FindFirst() then begin
            //Generate Interbank
            PayrollPeriod.Reset();
            PayrollPeriod.SetRange("Starting Date", EmpPayApproval."Payroll Period");
            if PayrollPeriod.FindFirst() then begin
                PayrollPeriod.CalcFields("Gross Pay");
                GrossPay := PayrollPeriod."Gross Pay";
            end;
            Deductions.reset;
            Deductions.SetRange("Pay Period Filter", EmpPayApproval."Payroll Period");
            if Deductions.Find('-') then
                repeat
                    Deductions.CalcFields("Total Amount Employer");
                    GrossPay += Round(Abs(Deductions."Total Amount Employer"), 0.05, '>');
                until Deductions.Next() = 0;
            Pmt.INIT;
            Pmt."Payment Type" := Pmt."Payment Type"::"Bank Transfer";
            Pmt."No." := '';
            Pmt."Payment Narration" := 'Bank transfer for' + ' ' + format(EmpPayApproval."Payroll Period");
            Pmt.Date := TODAY;
            Pmt."Source Bank" := HRSetup."Current Bank Account";
            Pmt."Payroll Approval No." := EmpPayApproval."No.";
            Pmt."PV Type" := Pmt."PV Type"::Payroll;
            Pmt."Net Pay" := true;
            Pmt."Source Bank Amount" := GrossPay + BankCharges;
            Pmt.Status := Pmt.Status::Released;
            Pmt."Payroll Period" := EmpPayApproval."Payroll Period";
            Pmt."PV Type" := Pmt."PV Type"::Payroll;
            Pmt."Source Table No" := 51520210;
            Pmt."Source Document No." := EmpPayApproval."No.";
            Pmt."Deduction Code." := 'NET PAY';
            Pmt."Source RECORDID" := EmpPayApproval.RecordId;
            Pmt.INSERT(TRUE);
            PmtLines.INIT;
            PmtLines.No := Pmt."No.";
            PmtLines."Line No" := GetNextLineNo(PmtLines.No);
            PmtLines."Account Type" := PmtLines."Account Type"::"Bank Account";
            PmtLines."Account No" := HRSetup."Default Bank";
            PmtLines.Amount := GrossPay + BankCharges;
            PmtLines.Description := Deductions.Description;
            PmtLines."POP Code" := HRSetup."Net pay POP Code";
            PmtLines.Insert();
        end;
    end;

    procedure GetNextLineNo(DocNo: Code[10]): Integer
    var
        PmtLines: Record "Payment Lines";
    begin
        PmtLines.RESET;
        PmtLines.SETRANGE(No, DocNo);
        IF PmtLines.FINDLAST THEN
            EXIT(PmtLines."Line No" + 1)
        ELSE
            EXIT(1);
    end;

    var
        EMAIL: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
}
