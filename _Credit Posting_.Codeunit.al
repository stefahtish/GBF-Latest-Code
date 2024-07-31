codeunit 50141 "Credit Posting"
{
    var InvstBalancing: Boolean;
    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure PostOnAfterCopyFromGenJnlLine(var DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line")
    begin
        /*
                DtldCVLedgEntryBuffer.lo := GenJnlLine."Loan No";
                DtldCVLedgEntryBuffer."Loan Transaction Type" := GenJnlLine."Loan Transaction Type";
                DtldCVLedgEntryBuffer."Period Reference" := GenJnlLine."Period Reference";*/
        DtldCVLedgEntryBuffer."Customer Transaction Type":=GenJnlLine."Customer Transaction Type";
        DtldCVLedgEntryBuffer."Loan No":=GenJnlLine."Loan No";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeProcessBalanceOfLines', '', false, false)]
    local procedure UpdateCurrentKey(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalBatch: Record "Gen. Journal Batch"; var GenJournalTemplate: Record "Gen. Journal Template"; var IsKeySet: Boolean)
    begin
        //Modified to allow posting of a batch with different posting dates
        GenJournalLine.SETCURRENTKEY("Document No.", "Posting Date");
        IsKeySet:=true;
    end;
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Loan No":=GenJournalLine."Loan No";
        GLEntry."Loan Transaction Type":=GenJournalLine."Loan Transaction Type";
        GLEntry."Period Reference":=GenJournalLine."Period Reference";
    end;
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Loan Transaction Type":=GenJournalLine."Loan Transaction Type";
        CustLedgerEntry."Period Reference":=GenJournalLine."Period Reference";
        CustLedgerEntry."Transaction Priority":=GenJournalLine."Transaction Priority";
        CustLedgerEntry."Customer Transaction Type":=GenJournalLine."Customer Transaction Type";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseVendLedgEntryOnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure ReverseVendLedgerEntry(var NewDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
    /*//Modified for Reversal of Vendor Ledger Entries By Eddie BPIT
        NewDtldVendLedgEntry.VendNoExt := DtldVendLedgEntry."Vendor No.";
        NewDtldVendLedgEntry.PDateExt := NewDtldVendLedgEntry."Posting Date";
        NewDtldVendLedgEntry.Dim1Ext := NewDtldVendLedgEntry."Initial Entry Global Dim. 1";
        NewDtldVendLedgEntry.Dim2Ext := NewDtldVendLedgEntry."Initial Entry Global Dim. 2";
        NewDtldVendLedgEntry.DocNoExt := NewDtldVendLedgEntry."Document No.";
        NewDtldVendLedgEntry.AmtExt := NewDtldVendLedgEntry.Amount;
        NewDtldVendLedgEntry.AmtLCYExt := NewDtldVendLedgEntry."Amount (LCY)";
        NewDtldVendLedgEntry."No. Of Units" := -NewDtldVendLedgEntry."No. Of Units";
        if NewDtldVendLedgEntry.Amount > 0 then
            NewDtldVendLedgEntry.Salary := -NewDtldVendLedgEntry.Salary;*/
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnApplyVendLedgEntryByReversalOnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure AfterApplyVendorLedgerReversal(var NewDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
    /*//Modified for Reversal of Vendor Ledger Entries By Eddie BPIT
        NewDtldVendLedgEntry.VendLedgEntryNoExt := NewDtldVendLedgEntry."Vendor Ledger Entry No.";
        NewDtldVendLedgEntry.EntryTypeExt := NewDtldVendLedgEntry."Entry Type";*/
    end;
    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnInsertDtldCVLedgEntryOnBeforeInsert', '', false, false)]
    local procedure OnBeforeInsertDtldCVLedgEntry(var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
    /*//Modified for Entry of Extra Fields into Dtld Vendor Ledger Entry Extension
        DetailedCVLedgEntryBuffer.VendLedgEntryNoExt := DetailedCVLedgEntryBuffer."CV Ledger Entry No.";
        DetailedCVLedgEntryBuffer.EntryTypeExt := DetailedCVLedgEntryBuffer."Entry Type";
        DetailedCVLedgEntryBuffer.AmtExt := DetailedCVLedgEntryBuffer.Amount;
        DetailedCVLedgEntryBuffer.AmtLCYExt := DetailedCVLedgEntryBuffer."Amount (LCY)";*/
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseGLEntryOnBeforeInsertGLEntry', '', false, false)]
    local procedure AfterGLEntryReversal(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry")
    begin
        GLEntry."No. Of Units":=-GLEntry2."No. Of Units";
        GLEntry."Nominal Value":=-GLEntry2."Nominal Value";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseCustLedgEntryOnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure AfterCustLedgerEntryReversal(var NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
    //Modified for Reversal of Vendor Ledger Entries By Eddie BPIT
    /* NewDtldCustLedgEntry.CustNoExt := DtldCustLedgEntry."Customer No.";
         NewDtldCustLedgEntry.PDateExt := DtldCustLedgEntry."Posting Date";
         NewDtldCustLedgEntry.Dim1Ext := DtldCustLedgEntry."Initial Entry Global Dim. 1";
         NewDtldCustLedgEntry.Dim2Ext := DtldCustLedgEntry."Initial Entry Global Dim. 2";
         NewDtldCustLedgEntry.DocNoExt := DtldCustLedgEntry."Document No.";
         NewDtldCustLedgEntry.AmtExt := DtldCustLedgEntry.Amount;
         NewDtldCustLedgEntry.AmtLCYExt := DtldCustLedgEntry."Amount (LCY)";*/
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnApplyCustLedgEntryByReversalOnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure AfterApplyCustLedgerReversal(var NewDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
    //Modified for Reversal of Customer Ledger Entries By Eddie BPIT
    /*NewDtldCustLedgEntry.CustLedgEntryNoExt := NewDtldCustLedgEntry."Cust. Ledger Entry No.";
        NewDtldCustLedgEntry.EntryTypeExt := NewDtldCustLedgEntry."Entry Type";*/
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforeBeforePostGenJnlLine(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        GenJournalLine."Investment Posting":=Balancing;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeInitBankAccLedgEntry', '', false, false)]
    local procedure OnPostBankAccOnBeforeInitBankAccLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; CurrencyFactor: Decimal; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        BankAcc: Record "Bank Account";
        AmountGreaterThanBankLimitErr: Label 'You have exceed bank limit for %1 by %2';
    begin
        BankAcc.get(GenJournalLine."Account No.");
        if BankAcc."Check Bank Limit" then begin
            BankAcc.TestField("Bank Limit (LCY)");
            BankAcc.CalcFields("Balance (LCY)");
            if GenJournalLine."Amount (LCY)" < 0 then begin
                if(BankAcc."Balance (LCY)" - Abs(GenJournalLine."Amount (LCY)")) < BankAcc."Bank Limit (LCY)" then Error(AmountGreaterThanBankLimitErr, BankAcc.Name, (BankAcc."Bank Limit (LCY)" - (BankAcc."Balance (LCY)" - Abs(GenJournalLine."Amount (LCY)"))));
            end;
        end;
    end;
}
