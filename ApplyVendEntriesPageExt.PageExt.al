pageextension 50126 ApplyVendEntriesPageExt extends "Apply Vendor Entries"
{
    procedure SetPaymentLine(NewPaymentLine: Record "Payment Lines"; ApplnTypeSelect: Integer)
    var
        PaymentRec: Record Payments;
        PaymentLine: Record "Payment Lines";
        PaymentLineApply: Boolean;
        ApplyingAmount: Decimal;
        ApplnDate: Date;
        ApplnCurrencyCode: Code[20];
        CalcType: Option Direct, GenJnlLine, SalesHeader, ServHeader, Payments;
        ApplnType: Option " ", "Applies-to Doc. No.", "Applies-to ID";
    begin
        PaymentLine:=NewPaymentLine;
        PaymentLineApply:=TRUE;
        PaymentRec.GET(PaymentLine.No);
        IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN ApplyingAmount:=PaymentLine.Amount;
        ApplnDate:=PaymentRec.Date;
        ApplnCurrencyCode:=PaymentRec.Currency;
        CalcType:=CalcType::Payments;
        CASE ApplnTypeSelect OF PaymentLine.FIELDNO("Applies-to Doc. No."): ApplnType:=ApplnType::"Applies-to Doc. No.";
        PaymentLine.FIELDNO("Applies-to ID"): ApplnType:=ApplnType::"Applies-to ID";
        END;
        SetApplyingVendLedgEntry;
    end;
}
