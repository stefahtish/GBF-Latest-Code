codeunit 50112 PaymentToleranceCUExtension
{
    procedure CheckCalcPmtDiscPaymentsCust(PaymentLine: Record "Payment Lines"; OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        PaymentRec: Record Payments;
        PaymentTolerance: Codeunit "Payment Tolerance Management";
    begin
        //Modified by Eddie BPIT Ltd on 25/03/2017
        PaymentRec.GET(PaymentLine.No);
        NewCVLedgEntryBuf."Document Type":=NewCVLedgEntryBuf."Document Type"::" ";
        NewCVLedgEntryBuf."Posting Date":=PaymentRec.Date;
        NewCVLedgEntryBuf."Remaining Amount":=PaymentLine.Amount;
        OldCVLedgEntryBuf2.CopyFromCustLedgEntry(OldCustLedgEntry2);
        EXIT(PaymentTolerance.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, FALSE, CheckAmount));
    end;
    procedure DelPmtTolApllnDocNoPayments(PaymentLine: Record "Payment Lines"; DocumentNo: Code[20])
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        PaymentTolerance: Codeunit "Payment Tolerance Management";
    begin
        IF PaymentLine."Account Type" = PaymentLine."Account Type"::Customer THEN BEGIN
            AppliedCustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
            AppliedCustLedgEntry.SETRANGE("Customer No.", PaymentLine."Account No");
            AppliedCustLedgEntry.SETRANGE(Open, TRUE);
            AppliedCustLedgEntry.SETRANGE("Document No.", DocumentNo);
            AppliedCustLedgEntry.LOCKTABLE;
            IF AppliedCustLedgEntry.FINDSET THEN BEGIN
                REPEAT AppliedCustLedgEntry."Accepted Payment Tolerance":=0;
                    AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance":=FALSE;
                    AppliedCustLedgEntry.MODIFY;
                UNTIL AppliedCustLedgEntry.NEXT = 0;
                COMMIT;
            END;
        END
        ELSE IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN BEGIN
                AppliedVendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                AppliedVendLedgEntry.SETRANGE("Vendor No.", PaymentLine."Account No");
                AppliedVendLedgEntry.SETRANGE(Open, TRUE);
                AppliedVendLedgEntry.SETRANGE("Document No.", DocumentNo);
                AppliedVendLedgEntry.LOCKTABLE;
                IF AppliedVendLedgEntry.FINDSET THEN BEGIN
                    REPEAT AppliedVendLedgEntry."Accepted Payment Tolerance":=0;
                        AppliedVendLedgEntry."Accepted Pmt. Disc. Tolerance":=FALSE;
                        AppliedVendLedgEntry.MODIFY;
                    UNTIL AppliedVendLedgEntry.NEXT = 0;
                    COMMIT;
                END;
            END;
    end;
    procedure CheckCalcPmtDiscPaymentsVend(PaymentLine: Record "Payment Lines"; OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        PaymentRec: Record Payments;
        PaymentTolerance: Codeunit "Payment Tolerance Management";
    begin
        PaymentRec.GET(PaymentLine.No);
        NewCVLedgEntryBuf."Document Type":=NewCVLedgEntryBuf."Document Type"::" ";
        NewCVLedgEntryBuf."Posting Date":=PaymentRec.Date;
        NewCVLedgEntryBuf."Remaining Amount":=PaymentLine.Amount;
        OldCVLedgEntryBuf2.CopyFromVendLedgEntry(OldVendLedgEntry2);
        EXIT(PaymentTolerance.CheckCalcPmtDisc(NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, FALSE, CheckAmount));
    end;
}
