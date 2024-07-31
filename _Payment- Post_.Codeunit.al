codeunit 50156 "Payment- Post"
{
    trigger OnRun()
    begin
    end;
    var Batch: Record "Gen. Journal Batch";
    CMSetup: Record "Cash Management Setups";
    Text000: Label 'You cannot refund an amount that is greater than the what has been overpaid.\';
    Text001: Label 'The refund should be %1 and not %2 as the overpayment is %3';
    Text002: Label '%1 of %2 does''''nt exist on the Levy Types';
    //Cashmngt: Record "Cash Management Setups";
    GLSetup: Record "General Ledger Setup";
    //Commitment: Codeunit Committment;
    TaxTarriffCode: Record "Tax Tarriff Code";
    FixedAsset: Record "Fixed Asset";
    ExchangeRate: Decimal;
    BankAccount: Record "Bank Account";
    Post: Boolean;
    procedure PostBatch(PV: Record "GBF Payments")
    var
        Batch: Record "Gen. Journal Batch";
        PVLines: Record "PV Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        // LevyRec: Record Levy;
        // LastLevy: Record Levy;
        EntryNo: Integer;
    // LevyTypeRec: Record "Levy Types";
    begin
        // /*
        IF PV.Status <> PV.Status::Released THEN ERROR('The Payment Voucher No %1 cannot be posted before it is fully approved', PV.No);
        // */
        IF PV.Posted THEN ERROR('Payment Voucher %1 has been posted', PV.No);
        PV.TESTFIELD(Date);
        PV.TESTFIELD("Paying Bank Account");
        PV.TESTFIELD(PV.Payee);
        //PV.TESTFIELD(Remarks);
        //Get Exchange Rate To apply
        IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN ExchangeRate:=PV."Exchange Rate"
        ELSE
            ExchangeRate:=1;
        //Get Exchange Rate To apply
        IF PV."Pay Mode" = 'CHEQUE' THEN BEGIN
            PV.TESTFIELD(PV."Cheque No");
            PV.TESTFIELD(PV."Cheque Date");
        END;
        //Check Lines
        PV.CALCFIELDS("Total Amount", "Net Amount", "Amount (LCY)", "Net Amount (LCY)");
        IF PV."Total Amount" = 0 THEN ERROR('Amount is cannot be zero');
        PVLines.RESET;
        PVLines.SETRANGE(PVLines."PV No", PV.No);
        IF NOT PVLines.FINDLAST THEN ERROR('Payment voucher Lines cannot be empty');
        CMSetup.GET();
        // Delete Lines Present on the General Journal Line
        GenJnLine.RESET;
        GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Payment Voucher Template");
        GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", PV.No);
        GenJnLine.DELETEALL;
        Batch.INIT;
        IF CMSetup.GET()THEN Batch."Journal Template Name":=CMSetup."Payment Voucher Template";
        Batch.Name:=PV.No;
        IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name)THEN Batch.INSERT;
        //Bank Entries
        LineNo:=LineNo + 10000;
        PV.CALCFIELDS(PV."Total Amount", "Net Amount", "Amount (LCY)", "Net Amount (LCY)");
        GenJnLine.INIT;
        IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
        GenJnLine."Journal Batch Name":=PV.No;
        GenJnLine."Line No.":=LineNo;
        GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
        GenJnLine."Account No.":=PV."Paying Bank Account";
        GenJnLine.VALIDATE(GenJnLine."Account No.");
        IF PV.Date = 0D THEN ERROR('You must specify the PV date');
        GenJnLine."Posting Date":=PV.Date;
        GenJnLine."Document No.":=PV.No;
        GenJnLine."External Document No.":=PV."Cheque No";
        GenJnLine.Description:=COPYSTR(PV.Payee + '-' + PV.Remarks, 1, 100);
        // Check whether Foreign Currency Account
        BankAccount.RESET;
        BankAccount.SETRANGE(BankAccount."No.", PV."Paying Bank Account");
        IF BankAccount.FIND('-')THEN BEGIN
            IF BankAccount."Currency Code" <> '' THEN BEGIN // "GBF Payments" from USD Account
                GenJnLine."Currency Code":=BankAccount."Currency Code";
                GenJnLine.Amount:=-PV."Net Amount";
                GenJnLine."Amount (LCY)":=-ROUND((PV."Net Amount" * ExchangeRate), 0.1, '='); // Sammy Request 2/5/2021
                GenJnLine.VALIDATE(GenJnLine."Amount (LCY)");
            END
            ELSE
            BEGIN // "GBF Payments" from Kes Account but negotiated Dollars
                IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                    GenJnLine.Amount:=-ROUND(PV."Net Amount (LCY)", 0.1, '=');
                    GenJnLine."Amount (LCY)":=-ROUND(PV."Net Amount (LCY)", 0.1, '=');
                    GenJnLine.VALIDATE(GenJnLine."Amount (LCY)");
                END
                ELSE
                BEGIN // Payment in Kes
                    GenJnLine.Amount:=-ROUND(PV."Net Amount", 0.1, '=');
                    GenJnLine.VALIDATE(GenJnLine.Amount);
                END END;
        END;
        //GenJnLine."Currency Code":=PV.Currency;
        //GenJnLine.VALIDATE(GenJnLine."Currency Code");
        // GenJnLine."Pay Mode" := PV."Pay Mode";
        GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
        GenJnLine."Shortcut Dimension 1 Code":=PV."Global Dimension 1 Code";
        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
        GenJnLine."Shortcut Dimension 2 Code":=PV."Global Dimension 2 Code";
        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
        IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
        //PV Lines Entries
        PVLines.RESET;
        PVLines.SETRANGE(PVLines."PV No", PV.No);
        IF PVLines.FINDFIRST THEN BEGIN
            REPEAT LineNo:=LineNo + 10000;
                GenJnLine.INIT;
                IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                GenJnLine."Journal Batch Name":=PV.No;
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=PVLines."Account Type";
                GenJnLine."Account No.":=PVLines."Account No";
                GenJnLine.VALIDATE(GenJnLine."Account No.");
                IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                GenJnLine."Posting Date":=PV.Date;
                GenJnLine."Document No.":=PV.No;
                GenJnLine."External Document No.":=PV."Cheque No";
                GenJnLine.Description:=CopyStr(PV.Payee + '-' + PVLines.Description, 1, 100);
                GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                //  // GenJnLine."Insured ID" := PVLines."Shortcut Dimension 3 Code";
                IF PVLines."Applies to Doc. No" <> '' THEN BEGIN
                    GenJnLine."Applies-to Doc. Type":=PVLines."Applies-to Doc. Type";
                    GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                END;
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
                // Check whether Foreign Currency Account
                BankAccount.RESET;
                BankAccount.SETRANGE(BankAccount."No.", PV."Paying Bank Account");
                IF BankAccount.FIND('-')THEN BEGIN
                    IF BankAccount."Currency Code" <> '' THEN BEGIN
                        GenJnLine."Currency Code":=BankAccount."Currency Code";
                        GenJnLine.Amount:=PVLines."Net Amount";
                        GenJnLine."Amount (LCY)":=ROUND((PVLines."Net Amount" * ExchangeRate), 0.1, '=');
                        GenJnLine.VALIDATE(GenJnLine."Amount (LCY)");
                    END
                    ELSE
                    BEGIN
                        IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                            GenJnLine."Currency Code":=PV.Currency;
                            GenJnLine.VALIDATE(GenJnLine."Currency Code");
                            GenJnLine.Amount:=ROUND(PVLines."Net Amount", 0.1, '=');
                            GenJnLine."Amount (LCY)":=ROUND(PVLines."Net Amount (LCY)", 0.1, '=');
                            GenJnLine.VALIDATE(GenJnLine."Amount (LCY)");
                        END
                        ELSE
                        BEGIN
                            GenJnLine.Amount:=ROUND(PVLines."Net Amount", 0.1, '=');
                            GenJnLine.VALIDATE(GenJnLine.Amount);
                        END;
                    END;
                END;
                IF PV."Pay Mode" = 'CHEQUE' THEN GenJnLine."Payment Method Code":=PV."Pay Mode";
                //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                //Post VAT
                IF CMSetup."Post VAT" THEN BEGIN
                    IF PV."VAT Code" <> '' THEN BEGIN
                        LineNo:=LineNo + 10000;
                        GenJnLine.INIT;
                        IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV.No;
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=PVLines."Account Type";
                        GenJnLine."Account No.":=PVLines."Account No";
                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                        IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV.No;
                        GenJnLine."External Document No.":=PV."Cheque No";
                        GenJnLine.Description:=CopyStr(PVLines.Description + '-VAT', 1, 100);
                        IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                            GenJnLine.Amount:=PVLines."VAT Amount";
                            GenJnLine."Amount (LCY)":=ROUND((PVLines."VAT Amount" * ExchangeRate), 0.1, '=');
                            GenJnLine."Currency Code":=PV.Currency;
                            GenJnLine.VALIDATE("Amount (LCY)");
                        END
                        ELSE
                        BEGIN
                            GenJnLine.Amount:=PVLines."VAT Amount";
                            GenJnLine.VALIDATE(GenJnLine.Amount);
                        END;
                        GenJnLine.VALIDATE("Amount (LCY)");
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
                        // IF PV."Pay Mode" = 'CHEQUE' THEN
                        //     GenJnLine."Pay Mode" := PV."Pay Mode";
                        //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Currency Code":=BankAccount."Currency Code";
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                        //// //GenJnLine."Insured ID" := PVLines."Shortcut Dimension 3 Code";
                        IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                        LineNo:=LineNo + 10000;
                        GenJnLine.INIT;
                        IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV.No;
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                        CASE PVLines."Account Type" OF PVLines."Account Type"::"G/L Account": BEGIN
                            GLAccount.GET(PVLines."Line No");
                            GLAccount.TESTFIELD("VAT Bus. Posting Group");
                            IF VATSetup.GET(GLAccount."VAT Bus. Posting Group", PV."VAT Code")THEN GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                        END;
                        PVLines."Account Type"::Vendor: BEGIN
                            Vendor.GET(PVLines."Account No");
                            Vendor.TESTFIELD("VAT Bus. Posting Group");
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group", PV."VAT Code")THEN GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                        END;
                        PVLines."Account Type"::Customer: BEGIN
                            Customer.GET(PVLines."Account No");
                            Customer.TESTFIELD("VAT Bus. Posting Group");
                            IF VATSetup.GET(Customer."VAT Bus. Posting Group", PV."VAT Code")THEN GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                        END;
                        END;
                        IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV.No;
                        GenJnLine."External Document No.":=PV."Cheque No";
                        GenJnLine.Description:=CopyStr(PVLines.Description + '-VAT', 1, 100);
                        IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                            GenJnLine.Amount:=-PVLines."VAT Amount";
                            GenJnLine."Amount (LCY)":=-(PVLines."VAT Amount" * ExchangeRate);
                            GenJnLine."Currency Code":=PV.Currency;
                        END
                        ELSE
                        BEGIN
                            GenJnLine.Amount:=-PVLines."VAT Amount";
                            GenJnLine.VALIDATE(GenJnLine.Amount);
                        END;
                        GenJnLine.VALIDATE("Amount (LCY)");
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
                        // IF PV."Pay Mode" = 'CHEQUE' THEN
                        //     GenJnLine."Pay Mode" := PV."Pay Mode";
                        //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Currency Code":=BankAccount."Currency Code";
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                        //  // GenJnLine."Insured ID" := PVLines."Shortcut Dimension 3 Code";
                        IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                    END;
                //End of Posting VAT
                END;
                //Post Withholding Tax
                IF PVLines."W/VTax Code" <> '' THEN BEGIN
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=PVLines."Account Type";
                    GenJnLine."Account No.":=PVLines."Account No";
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-W/H VAT Tax', 1, 100);
                    //GenJnLine."Currency Code":=PV.Currency;
                    GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    //  // GenJnLine."Insured ID" := PVLines."Shortcut Dimension 3 Code";
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
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=PVLines."W/VTax Amount";
                        GenJnLine."Amount (LCY)":=ROUND((PVLines."W/VTax Amount" * ExchangeRate), 1, '='); //0.01
                        GenJnLine.VALIDATE("Amount (LCY)");
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=PVLines."W/VTax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    IF PVLines."Applies to Doc. No" <> '' THEN BEGIN
                        GenJnLine."Applies-to Doc. Type":=PVLines."Applies-to Doc. Type";
                        GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    END;
                    // IF PV."Pay Mode" = 'CHEQUE' THEN
                    //     GenJnLine."Pay Mode" := PV."Pay Mode";
                    //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                    IF TaxTarriffCode.GET(PVLines."W/VTax Code")THEN BEGIN
                        GenJnLine."Account No.":=TaxTarriffCode."Account No.";
                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                    END;
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-W/H VAT Tax', 1, 100);
                    //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                    GenJnLine."Currency Code":=PV.Currency;
                    GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    //   //GenJnLine."Insured ID" := PVLines."Shortcut Dimension 3 Code";
                    //Set these fields to blanks
                    GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                    GenJnLine.VALIDATE("Gen. Posting Type");
                    GenJnLine."Gen. Bus. Posting Group":='';
                    GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                    GenJnLine."Gen. Prod. Posting Group":='';
                    GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                    //GenJnLine."VAT Bus. Posting Group":='';
                    //GenJnLine.VALIDATE("VAT Bus. Posting Group");
                    //GenJnLine."VAT Prod. Posting Group":='';
                    //GenJnLine.VALIDATE("VAT Prod. Posting Group");
                    //
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=-PVLines."W/VTax Amount";
                        GenJnLine."Amount (LCY)":=-ROUND((PVLines."W/VTax Amount" * ExchangeRate), 1, '=');
                        GenJnLine.VALIDATE("Amount (LCY)");
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=-PVLines."W/VTax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    // IF PV."Pay Mode" = 'CHEQUE' THEN
                    //     GenJnLine."Pay Mode" := PV."Pay Mode";
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                END;
                //End of Posting Withholding Tax
                //Post Withholding Income Tax
                IF PVLines."Income Tax Code" <> '' THEN BEGIN
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=PVLines."Account Type";
                    GenJnLine."Account No.":=PVLines."Account No";
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-W/H Income Tax', 1, 100);
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=PVLines."Income Tax Amount";
                        GenJnLine."Amount (LCY)":=ROUND((PVLines."Income Tax Amount" * ExchangeRate), 1, '=');
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=PVLines."Income Tax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    GenJnLine.VALIDATE("Amount (LCY)");
                    IF PVLines."Applies to Doc. No" <> '' THEN BEGIN
                        GenJnLine."Applies-to Doc. Type":=PVLines."Applies-to Doc. Type";
                        GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    END;
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
                    IF PV."Pay Mode" = 'CHEQUE' THEN //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Currency Code":=BankAccount."Currency Code";
                    GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                    IF TaxTarriffCode.GET(PVLines."Income Tax Code")THEN BEGIN
                        GenJnLine."Account No.":=TaxTarriffCode."Account No.";
                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                    END;
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine."Currency Code":=BankAccount."Currency Code";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-W/H Income Tax', 1, 100);
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=-PVLines."Income Tax Amount";
                        GenJnLine."Amount (LCY)":=-ROUND((PVLines."Income Tax Amount" * ExchangeRate), 1, '=');
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=-PVLines."Income Tax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    GenJnLine.VALIDATE("Amount (LCY)");
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
                    IF PV."Pay Mode" = 'CHEQUE' THEN //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                END;
                //End of Posting Withholding Income Tax
                //Post Advance "GBF Payments"
                IF PVLines."Advance Payment Amount" <> 0 THEN BEGIN
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=PVLines."Account Type";
                    GenJnLine."Account No.":=PVLines."Account No";
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine."Currency Code":=BankAccount."Currency Code";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-Advance Payment', 1, 100);
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=PVLines."Advance Payment Amount";
                        GenJnLine."Amount (LCY)":=ROUND((PVLines."Advance Payment Amount" * ExchangeRate), 0.01, '=');
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=PVLines."Advance Payment Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    GenJnLine.VALIDATE("Amount (LCY)");
                    /*
                    IF PVLines."Applies to Doc. No"<>'' THEN BEGIN
                    GenJnLine."Applies-to Doc. Type":=PVLines."Applies-to Doc. Type";
                    GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    END;
                    */
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
                    IF PV."Pay Mode" = 'CHEQUE' THEN //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                    LineNo:=LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV.No;
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                    GenJnLine."Account No.":=PVLines."Expense G/L Account";
                    IF PVLines."Expense G/L Account" = '' THEN BEGIN
                        GenJnLine."Account Type":=PVLines."Account Type";
                        GenJnLine."Account No.":=PVLines."Account No";
                    END;
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    IF PV.Date = 0D THEN ERROR('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV.No;
                    GenJnLine."External Document No.":=PV."Cheque No";
                    GenJnLine."Currency Code":=BankAccount."Currency Code";
                    GenJnLine.Description:=COPYSTR(PVLines.Description + '-' + PV.Payee + '-Advance Payment', 1, 100);
                    IF(PV.Currency <> '') AND (PV."Exchange Rate" <> 0)THEN BEGIN
                        GenJnLine."Currency Code":=PV.Currency;
                        GenJnLine.Amount:=-PVLines."Advance Payment Amount";
                        GenJnLine."Amount (LCY)":=-ROUND((PVLines."Advance Payment Amount" * ExchangeRate), 0.01, '=');
                    END
                    ELSE
                    BEGIN
                        GenJnLine.Amount:=-PVLines."Advance Payment Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                    END;
                    GenJnLine.VALIDATE("Amount (LCY)");
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
                    IF PV."Pay Mode" = 'CHEQUE' THEN //GenJnLine."Bank Payment Type":=PV."Bank Payment Type";
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    IF GenJnLine.Amount <> 0 THEN GenJnLine.INSERT;
                END;
            //End ofadvance payment
            UNTIL PVLines.NEXT = 0;
        END;
        //
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnLine);
        //Post := FALSE;
        //Post := JournlPosted.PostedSuccessfully();
        //   Post := true;
        //IF Post THEN BEGIN
        // PV.Posted := TRUE;
        // PV."Posted By" := USERID;
        // PV."Date Posted" := TODAY;
        // PV."Time Posted" := TIME;
        // PV.MODIFY;
        IF Batch.GET(CMSetup."Payment Voucher Template", PV.No)THEN Batch.DELETE;
    //}
    end;
}
