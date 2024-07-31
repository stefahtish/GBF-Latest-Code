codeunit 50117 PaymentsPostingCUExt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-SetAppl.ID", 'OnAfterUpdateVendLedgerEntry', '', false, false)]
    local procedure ValidateAppliesToID(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var TempVendLedgEntry: Record "Vendor Ledger Entry" temporary; ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; AppliesToID: Code[50])
    begin
        VendorLedgerEntry.Validate("Applies-to ID");
        VendorLedgerEntry.Modify();
    end;
}
