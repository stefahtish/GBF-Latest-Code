codeunit 50140 "Gen Jnl Post Line Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]
    local procedure CommitOnPostInvoice(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10]; xPurchaseLine: Record "Purchase Line")
    var
        Commitment: Codeunit Committment;
    begin
        //Commitments
        if PurchaseHeader.Invoice then Commitment.ReversePostedLPOEntries(PurchInvHeader);
        if PurchaseHeader.Invoice then Commitment.ReversePostedPurchInvEntries(PurchInvHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure ApportionInvoiceOnPost(VAR PurchaseHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        Apportionment: Codeunit Apportionment;
        PurchInvHdr: Record "Purch. Inv. Header";
    begin
        PurchInvHdr.get(PurchInvHdrNo);
        if(PurchaseHeader.Invoice) and (PurchaseHeader.Apportion)then Apportionment.CreatePurchInvApportionEntry(PurchInvHdr);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure UpdateRentEscalation(VAR SalesHeader: Record "Sales Header"; VAR SalesShipmentHeader: Record "Sales Shipment Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"; VAR ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; VAR SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean)
    var
    //InvestmentManagement: Codeunit "Investment Property Mgt";
    begin
    //update rent escalation lines - Agile
    //InvestmentManagement.UpdateRentEscalation(SalesHeader."No.");
    //Create TPS Deposit Receipt -Agile
    /* if SalesHeader.TPS then
            InvestmentManagement.CreateTPSDepositReceiptOld(SalesHeader); */
    //Update TPS Schedule lines - Agile
    /* if   SalesHeader.TPS then
        InvestmentManagement.UpdateTPSSchedule(SalesHeader."No."); */
    end;
}
