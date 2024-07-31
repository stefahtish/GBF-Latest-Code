codeunit 50109 Apportionment
{
    trigger OnRun()
    begin
    //CheckIfInvoiceApportioned('PV000142');
    end;
    var PercError: Label 'Total percentage allocation must be equal to 100% in the Apportionment Lines';
    AppEntry: Record "Apportionment Entry";
    AppAllocation: Record "Apportionment Allocation";
    Payments: Record Payments;
    ExistError: Label 'Kindly specify apportionment allocation percentages';
    CashSetup: Record "Cash Management Setups";
    procedure CheckApportionment(DocNo: Code[50])
    begin
        CashSetup.Get;
        CashSetup.TestField("Apportionment Nos");
        AppAllocation.Reset;
        AppAllocation.SetRange("Document No.", DocNo);
        if AppAllocation.Find('-')then begin
            AppAllocation.CalcSums(Allocation);
            if AppAllocation.Allocation <> 100 then Error(PercError);
        end
        else
            Error(ExistError);
    end;
    procedure ClearApportiontEntries(DocNo: Code[50])
    begin
        AppAllocation.SetRange("Document No.", DocNo);
        AppAllocation.DeleteAll;
    end;
    procedure PurchInvoiceApportionEntry(PurchInvHeader: Record "Purch. Inv. Header")
    var
        LineNo: Integer;
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-')then begin
            repeat AppAllocation.Reset;
                AppAllocation.SetRange("Document No.", PurchInvHeader."Pre-Assigned No.");
                if AppAllocation.Find('-')then begin
                    AppEntry.SetRange("Document No.", PurchInvHeader."No.");
                    if AppEntry.FindLast then LineNo:=AppEntry."Line No"
                    else
                        LineNo:=0;
                    repeat AppEntry.Init;
                        AppEntry."Document No.":=PurchInvHeader."No.";
                        AppEntry.Company:=AppAllocation.Company;
                        AppEntry."Line No":=LineNo + 10000;
                        AppEntry."Expense Account":=PurchInvLine."No.";
                        AppEntry.Allocation:=AppAllocation.Allocation;
                        AppEntry.Amount:=PurchInvLine.Amount;
                        AppEntry.Description:=PurchInvLine.Description;
                        AppEntry."Posted Doc No.":=PurchInvHeader."No.";
                        AppEntry."Apportioned Amount":=((PurchInvLine.Amount) * (AppEntry.Allocation / 100));
                        AppEntry.Processed:=false;
                        AppEntry."Global Dimension 1 Code":=PurchInvLine."Shortcut Dimension 1 Code";
                        AppEntry."Global Dimension 2 Code":=PurchInvLine."Shortcut Dimension 2 Code";
                        AppEntry."Posting Date":=PurchInvHeader."Posting Date";
                        AppEntry."Document Date":=PurchInvHeader."Document Date";
                        AppEntry."External Document No.":=PurchInvHeader."Vendor Invoice No.";
                        AppEntry."Dimension Set ID":=PurchInvLine."Dimension Set ID";
                        if AppEntry.Company = CompanyName then AppEntry."Amount To Post":=-(PurchInvLine.Amount - AppEntry."Apportioned Amount")
                        else
                            AppEntry."Amount To Post":=AppEntry."Apportioned Amount";
                        AppEntry."Prepared Date-Time":=CurrentDateTime;
                        AppEntry."From Company":=CompanyName;
                        if AppEntry.Amount <> 0 then AppEntry.Insert;
                    until AppAllocation.Next = 0;
                end;
            until PurchInvLine.Next = 0;
        end;
        PostICApportionEntryDocNo(PurchInvHeader."No.");
    end;
    procedure PostApportion(AppHeader: Record "Apportion Header")
    var
        Jtemplate: Code[20];
        Jbatch: Code[20];
        Jtemplate2: Code[20];
        Jbatch2: Code[20];
        LineNo: Integer;
        CompanyRec: Record Company;
        GenJnLine: Record "Gen. Journal Line";
        CashSetups: Record "Cash Management Setups";
        ApportionmentEntry: Record "Apportionment Entry";
        AppEntry2: Record "Apportionment Entry";
        GLEntry: Record "G/L Entry";
    begin
        //Post Main Company
        AppEntry.Reset;
        AppEntry.SetCurrentKey("Document No.", Company, "Line No");
        AppEntry.SetRange(Company, CompanyName);
        AppEntry.SetRange(Processed, false);
        AppEntry.SetRange("Apportion Doc No.", AppHeader."No.");
        if AppEntry.Find('-')then begin
            LineNo:=0;
            CashSetups.Get;
            CashSetups.TestField("Apportion Template");
            CashSetups.TestField("Apportion Batch");
            Jtemplate:=CashSetups."Apportion Template";
            Jbatch:=CashSetups."Apportion Batch";
            GenJnLine.SetRange("Journal Template Name", Jtemplate);
            GenJnLine.SetRange("Journal Batch Name", Jbatch);
            GenJnLine.DeleteAll;
            repeat CashSetups.Get;
                CashSetups.TestField("Approtionment Account");
                LineNo:=LineNo + 10000;
                GenJnLine."Journal Template Name":=Jtemplate;
                GenJnLine."Journal Batch Name":=Jbatch;
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                GenJnLine."Account No.":=AppEntry."Expense Account";
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date":=AppEntry."Posting Date";
                GenJnLine."Document No.":=AppEntry."Document No.";
                GenJnLine.Description:=CopyStr(AppEntry.Description + '-Apportioned', 1, 100);
                GenJnLine.Amount:=AppEntry."Amount To Post";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Document Date":=AppEntry."Document Date";
                GenJnLine."External Document No.":=AppEntry."External Document No.";
                GenJnLine."Shortcut Dimension 1 Code":=AppEntry."Global Dimension 1 Code";
                GenJnLine."Shortcut Dimension 2 Code":=AppEntry."Global Dimension 2 Code";
                GenJnLine."Dimension Set ID":=AppEntry."Dimension Set ID";
                GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Bal. Account No.":=CashSetups."Approtionment Account";
                GenJnLine.Apportioned:=true;
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post-No Confirm2", GenJnLine);
                AppEntry.Processed:=true;
                AppEntry."Processed Date-Time":=CurrentDateTime;
                AppEntry.Modify(true);
                //Modify G/L Entry as apportioned
                if GLEntry.Get(AppEntry."G/L Entry No")then begin
                    GLEntry.Apportioned:=true;
                    GLEntry.Modify;
                end;
                Commit;
            until AppEntry.Next = 0;
            AppHeader.Posted:=true;
            AppHeader.Modify;
            Message('Processed Successfully');
        end;
        //Insert IC Apportion Entry
        AppEntry2.Reset;
        AppEntry2.SetCurrentKey("Document No.", Company, "Line No");
        AppEntry2.SetRange("Apportion Doc No.", AppHeader."No.");
        AppEntry2.SetFilter(Company, '<>%1', CompanyName);
        AppEntry2.SetRange(Processed, false);
        if AppEntry2.Find('-')then begin
            repeat ApportionmentEntry.ChangeCompany(AppEntry2.Company);
                ApportionmentEntry.TransferFields(AppEntry2);
                ApportionmentEntry.Processed:=false;
                if not ApportionmentEntry.Get(AppEntry2."Document No.", AppEntry2.Company, AppEntry2."G/L Entry No", AppEntry2."Apportion Doc No.")then ApportionmentEntry.Insert;
                AppEntry2.Processed:=true;
                AppEntry2.Modify(true);
            until AppEntry2.Next = 0;
        end;
    end;
    procedure ProcessApportion(AppHeader: Record "Apportion Header")
    var
        LineNo: Integer;
        AppLines: Record "Apportion Lines";
        AppAllocation2: Record "Apportionment Allocation";
    begin
        AppLines.Reset;
        AppLines.SetRange("No.", AppHeader."No.");
        if AppLines.Find('-')then begin
            //delete first
            AppEntry.Reset;
            AppEntry.SetRange("Apportion Doc No.", AppHeader."No.");
            AppEntry.DeleteAll;
            repeat AppAllocation.Reset;
                AppAllocation.SetRange("Document No.", AppHeader."No.");
                if AppAllocation.Find('-')then begin
                    AppAllocation2.Copy(AppAllocation);
                    AppAllocation2.CalcSums(Allocation);
                    if AppAllocation2.Allocation <> 100 then Error('Allocation percentage must total up to 100%');
                    repeat LineNo:=LineNo + 10000;
                        AppEntry.Init;
                        AppEntry."Document No.":=AppLines."Document No.";
                        AppEntry.Company:=AppAllocation.Company;
                        AppEntry."Line No":=LineNo;
                        AppEntry."G/L Entry No":=AppLines."G/L Entry No.";
                        AppEntry."Apportion Doc No.":=AppHeader."No.";
                        AppEntry."Expense Account":=AppLines."G/L Account No.";
                        AppEntry.Allocation:=AppAllocation.Allocation;
                        AppEntry.Amount:=AppLines.Amount;
                        AppEntry."Posting Date":=AppLines."Posting Date";
                        AppEntry.Description:=AppLines.Description;
                        AppEntry."Posted Doc No.":=AppLines."Document No.";
                        AppEntry."Apportioned Amount":=((AppLines.Amount) * (AppEntry.Allocation / 100));
                        AppEntry.Processed:=false;
                        AppEntry."Global Dimension 1 Code":=AppLines."Global Dimension 1 Code";
                        AppEntry."Global Dimension 2 Code":=AppLines."Global Dimension 2 Code";
                        AppEntry."Document Date":=AppLines."Document Date";
                        AppEntry."External Document No.":=AppLines."External Document No.";
                        AppEntry."Dimension Set ID":=AppLines."Dimension Set ID";
                        AppEntry."Prepared Date-Time":=CurrentDateTime;
                        if AppEntry.Company = CompanyName then AppEntry."Amount To Post":=-(AppLines.Amount - AppEntry."Apportioned Amount")
                        else
                            AppEntry."Amount To Post":=AppEntry."Apportioned Amount";
                        AppEntry."From Company":=CompanyName;
                        if AppEntry.Amount <> 0 then begin
                            if not AppEntry.Get(AppLines."Document No.", AppAllocation.Company, AppLines."G/L Entry No.", AppHeader."No.")then AppEntry.Insert;
                        end;
                    until AppAllocation.Next = 0;
                end
                else
                    Error('Kindly specify apportionment percentages');
            until AppLines.Next = 0;
        end;
        PostApportion(AppHeader);
    end;
    procedure PostICApportionEntry()
    var
        Jtemplate: Code[20];
        Jbatch: Code[20];
        Jtemplate2: Code[20];
        Jbatch2: Code[20];
        LineNo: Integer;
        CompanyRec: Record Company;
        GenJnLine: Record "Gen. Journal Line";
        CashSetups: Record "Cash Management Setups";
        ApportionmentEntry: Record "Apportionment Entry";
        AppEntry2: Record "Apportionment Entry";
    begin
        //Post Main Company
        AppEntry.Reset;
        AppEntry.SetCurrentKey("Document No.", Company, "Line No");
        AppEntry.SetRange(Company, CompanyName);
        AppEntry.SetRange(Processed, false);
        if AppEntry.Find('-')then begin
            if CompanyRec.Get(AppEntry.Company)then;
            LineNo:=0;
            CashSetups.Get;
            CashSetups.TestField("Apportion Template");
            CashSetups.TestField("Apportion Batch");
            Jtemplate:=CashSetups."Apportion Template";
            Jbatch:=CashSetups."Apportion Batch";
            GenJnLine.SetRange("Journal Template Name", Jtemplate);
            GenJnLine.SetRange("Journal Batch Name", Jbatch);
            GenJnLine.DeleteAll;
            repeat CashSetups.Get;
                CashSetups.TestField("Approtionment Account");
                LineNo:=LineNo + 10000;
                GenJnLine."Journal Template Name":=Jtemplate;
                GenJnLine."Journal Batch Name":=Jbatch;
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                GenJnLine."Account No.":=AppEntry."Expense Account";
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date":=AppEntry."Posting Date";
                GenJnLine."Document No.":=AppEntry."Document No.";
                GenJnLine.Description:=AppEntry.Description + ' Apportioned';
                GenJnLine.Amount:=AppEntry."Amount To Post";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Document Date":=AppEntry."Document Date";
                GenJnLine."External Document No.":=AppEntry."External Document No.";
                GenJnLine."Shortcut Dimension 1 Code":=AppEntry."Global Dimension 1 Code";
                GenJnLine."Shortcut Dimension 2 Code":=AppEntry."Global Dimension 2 Code";
                GenJnLine."Dimension Set ID":=AppEntry."Dimension Set ID";
                GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Bal. Account No.":=CashSetups."Approtionment Account";
                GenJnLine.Apportioned:=true;
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post-No Confirm2", GenJnLine);
                AppEntry.Processed:=true;
                AppEntry."Processed Date-Time":=CurrentDateTime;
                AppEntry.Modify(true);
            until AppEntry.Next = 0;
        end;
    end;
    procedure LookupDocuments(AppTotals: Record "Apportionment Totals")
    var
        GLFilters: Text;
        ViewString: Text;
        GLEntries: Page "Apportion G/L Entries";
        GLEntry: Record "G/L Entry";
        GLEntryCopy: Record "G/L Entry";
        TotalAmt: Decimal;
    begin
        TotalAmt:=0;
        AppTotals.TestField("G/L Account No.");
        GLEntry.SetRange(GLEntry."G/L Account No.", AppTotals."G/L Account No.");
        GLEntry.SetRange(GLEntry.Apportioned, false);
        GLEntry.SetFilter(GLEntry.Amount, '>%1', 0);
        GLEntries.SetTableView(GLEntry);
        GLEntries.LookupMode(true);
        if GLEntries.RunModal = ACTION::LookupOK then begin
            GLEntryCopy.Copy(GLEntry);
            GLFilters:=GLEntries.GetSelectionFilter(AppTotals."No.", AppTotals."G/L Account No.", TotalAmt);
        end;
    end;
    procedure InsertApportionLines(var GLEntry: Record "G/L Entry"; DocNo: Code[50]; GLAccNo: Code[50])
    var
        AppLines: Record "Apportion Lines";
    begin
        if GLEntry.FindSet(true)then repeat AppLines.Init;
                AppLines."No.":=DocNo;
                AppLines."G/L Account No.":=GLAccNo;
                AppLines."G/L Entry No.":=GLEntry."Entry No.";
                AppLines.Validate("G/L Entry No.");
                if not AppLines.Get(DocNo, GLAccNo, GLEntry."Entry No.")then AppLines.Insert;
            until GLEntry.Next = 0;
    end;
    procedure PostICApportionEntryDocNo(DocNo: Code[70])
    var
        Jtemplate: Code[20];
        Jbatch: Code[20];
        Jtemplate2: Code[20];
        Jbatch2: Code[20];
        LineNo: Integer;
        CompanyRec: Record Company;
        GenJnLine: Record "Gen. Journal Line";
        CashSetups: Record "Cash Management Setups";
        ApportionmentEntry: Record "Apportionment Entry";
        AppEntry2: Record "Apportionment Entry";
        GLEntry: Record "G/L Entry";
    begin
        //Post Main Company
        AppEntry.Reset;
        AppEntry.SetCurrentKey("Document No.", Company, "Line No");
        AppEntry.SetRange(Company, CompanyName);
        AppEntry.SetRange(Processed, false);
        AppEntry.SetRange("Document No.", DocNo);
        if AppEntry.Find('-')then begin
            LineNo:=0;
            CashSetups.Get;
            CashSetups.TestField("Apportion Template");
            CashSetups.TestField("Apportion Batch");
            Jtemplate:=CashSetups."Apportion Template";
            Jbatch:=CashSetups."Apportion Batch";
            GenJnLine.SetRange("Journal Template Name", Jtemplate);
            GenJnLine.SetRange("Journal Batch Name", Jbatch);
            GenJnLine.DeleteAll;
            repeat CashSetups.Get;
                CashSetups.TestField("Approtionment Account");
                LineNo:=LineNo + 10000;
                GenJnLine."Journal Template Name":=Jtemplate;
                GenJnLine."Journal Batch Name":=Jbatch;
                GenJnLine."Line No.":=LineNo;
                GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                GenJnLine."Account No.":=AppEntry."Expense Account";
                GenJnLine.Validate(GenJnLine."Account No.");
                GenJnLine."Posting Date":=AppEntry."Posting Date";
                GenJnLine."Document No.":=AppEntry."Document No.";
                GenJnLine.Description:=AppEntry.Description + ' Apportioned';
                GenJnLine.Amount:=AppEntry."Amount To Post";
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Document Date":=AppEntry."Document Date";
                GenJnLine."External Document No.":=AppEntry."External Document No.";
                GenJnLine."Shortcut Dimension 1 Code":=AppEntry."Global Dimension 1 Code";
                GenJnLine."Shortcut Dimension 2 Code":=AppEntry."Global Dimension 2 Code";
                GenJnLine."Dimension Set ID":=AppEntry."Dimension Set ID";
                GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Bal. Account No.":=CashSetups."Approtionment Account";
                GenJnLine.Apportioned:=true;
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post-No Confirm2", GenJnLine);
                AppEntry.Processed:=true;
                AppEntry."Processed Date-Time":=CurrentDateTime;
                AppEntry.Modify(true);
                //Modify G/L Entry as apportioned
                if GLEntry.Get(AppEntry."G/L Entry No")then begin
                    GLEntry.Apportioned:=true;
                    GLEntry.Modify;
                end;
                Commit;
            until AppEntry.Next = 0;
        end;
        //Insert IC Apportion Entry
        AppEntry2.Reset;
        AppEntry2.SetCurrentKey("Document No.", Company, "Line No");
        AppEntry2.SetRange("Document No.", DocNo);
        AppEntry2.SetFilter(Company, '<>%1', CompanyName);
        AppEntry2.SetRange(Processed, false);
        if AppEntry2.Find('-')then begin
            repeat ApportionmentEntry.ChangeCompany(AppEntry2.Company);
                ApportionmentEntry.TransferFields(AppEntry2);
                ApportionmentEntry.Processed:=false;
                if not ApportionmentEntry.Get(AppEntry2."Document No.", AppEntry2.Company, AppEntry2."G/L Entry No", AppEntry2."Apportion Doc No.")then ApportionmentEntry.Insert;
                AppEntry2.Processed:=true;
                AppEntry2.Modify(true);
            until AppEntry2.Next = 0;
        end;
    end;
    procedure CreatePaymentApportionEntry(PaymentRec: Record Payments)
    var
        DocNo: Code[50];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApportionCard: Page "Apportion Card";
        LineNo: Integer;
        AppHeader: Record "Apportion Header";
        AppTotals: Record "Apportionment Totals";
        AppLines: Record "Apportion Lines";
        CashSetup: Record "Cash Management Setups";
        PLines: Record "Payment Lines";
        AppAllocLines: Record "Apportionment Allocation";
        AppAllocLinesCopy: Record "Apportionment Allocation";
    begin
        if PaymentRec.Apportion then begin
            CashSetup.Get;
            DocNo:=NoSeriesMgt.GetNextNo(CashSetup."Apportionment Nos", 0D, true);
            //Insert Apportion header
            AppHeader.Init;
            AppHeader."No.":=DocNo;
            AppHeader.Validate("No.");
            AppHeader.Type:=AppHeader.Type::"By Document No";
            if not AppHeader.Get(DocNo)then AppHeader.Insert(true);
            //App Allocation
            AppAllocation.Reset;
            AppAllocation.SetRange("Document No.", PaymentRec."No.");
            if AppAllocation.FindFirst then begin
                repeat AppAllocLinesCopy.TransferFields(AppAllocation);
                    AppAllocLinesCopy."Document No.":=DocNo;
                    AppAllocLinesCopy.Insert;
                until AppAllocation.Next = 0;
            end;
            PLines.Reset;
            PLines.SetRange(No, PaymentRec."No.");
            PLines.SetRange("Account Type", PLines."Account Type"::"G/L Account");
            if PLines.Find('-')then begin
                LineNo:=0;
                repeat //Apportion Totals
                    LineNo:=LineNo + 10000;
                    AppTotals.Init;
                    AppTotals."No.":=DocNo;
                    AppTotals."G/L Account No.":=PLines."Account No";
                    AppTotals."Line No.":=LineNo;
                    AppTotals.Insert;
                    //Apportion Entries
                    AppLines.Init;
                    AppLines."No.":=DocNo;
                    AppLines."G/L Account No.":=PLines."Account No";
                    if PLines."Payment Type" in[PLines."Payment Type"::"Imprest Surrender", PLines."Payment Type"::"Petty Cash Surrender"]then AppLines."G/L Entry No.":=GetGLEntryNo(PLines.No, PLines."Actual Spent")
                    else
                        AppLines."G/L Entry No.":=GetGLEntryNo(PLines.No, PLines.Amount);
                    AppLines.Validate("G/L Entry No.");
                    if not AppLines.Get(DocNo, PLines."Account No", AppLines."G/L Entry No.")then AppLines.Insert;
                until PLines.Next = 0;
            end;
            Commit;
            //Open Apportion Page
            AppHeader.Reset;
            AppHeader.SetRange("No.", DocNo);
            ApportionCard.SetTableView(AppHeader);
            ApportionCard.RunModal;
        end;
    end;
    local procedure GetGLEntryNo(DocNo: Code[50]; Amt: Decimal): Integer var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.Reset;
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetRange(Amount, Amt);
        if GLEntry.FindFirst then exit(GLEntry."Entry No.");
    end;
    procedure CreatePurchInvApportionEntry(PurchInvHeader: Record "Purch. Inv. Header")
    var
        DocNo: Code[50];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApportionCard: Page "Apportion Card";
        AppHeader: Record "Apportion Header";
        AppTotals: Record "Apportionment Totals";
        AppLines: Record "Apportion Lines";
        PLines: Record "Payment Lines";
        AppAllocLines: Record "Apportionment Allocation";
        AppAllocLinesCopy: Record "Apportionment Allocation";
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        if PurchInvHeader.Apportion then begin
            CashSetup.Get;
            DocNo:=NoSeriesMgt.GetNextNo(CashSetup."Apportionment Nos", 0D, true);
            //Insert Apportion header
            AppHeader.Init;
            AppHeader."No.":=DocNo;
            AppHeader.Validate("No.");
            AppHeader.Type:=AppHeader.Type::"By Document No";
            if not AppHeader.Get(DocNo)then AppHeader.Insert(true);
            //App Allocation
            AppAllocation.Reset;
            AppAllocation.SetRange("Document No.", PurchInvHeader."Pre-Assigned No.");
            if AppAllocation.FindFirst then begin
                repeat AppAllocLinesCopy.TransferFields(AppAllocation);
                    AppAllocLinesCopy."Document No.":=DocNo;
                    AppAllocLinesCopy.Insert;
                until AppAllocation.Next = 0;
            end;
            PurchInvLine.Reset;
            PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
            PurchInvLine.SetRange(Type, PurchInvLine.Type::"G/L Account");
            if PurchInvLine.Find('-')then begin
                repeat //Apportion Totals
                    AppTotals.Init;
                    AppTotals."No.":=DocNo;
                    AppTotals."G/L Account No.":=PurchInvLine."No.";
                    AppTotals.Insert;
                    //Apportion Entries
                    AppLines.Init;
                    AppLines."No.":=DocNo;
                    AppLines."G/L Account No.":=PurchInvLine."No.";
                    AppLines."G/L Entry No.":=GetGLEntryNo(PurchInvLine."Document No.", PurchInvLine.Amount);
                    AppLines.Validate("G/L Entry No.");
                    if not AppLines.Get(DocNo, PurchInvLine."No.", AppLines."G/L Entry No.")then AppLines.Insert;
                until PurchInvLine.Next = 0;
            end;
            Commit;
            //Open Apportion Page
            AppHeader.Reset;
            AppHeader.SetRange("No.", DocNo);
            ApportionCard.SetTableView(AppHeader);
            ApportionCard.RunModal;
        end;
    end;
    procedure CheckIfInvoiceApportioned(DocNo: Code[50])
    var
        AppAllocation: Record "Apportionment Allocation";
        PurchInvHeader: Record "Purch. Inv. Header";
        PayRec: Record Payments;
        PayLines: Record "Payment Lines";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if PayRec.Get(DocNo)then begin
            PayLines.Reset;
            PayLines.SetRange(No, PayRec."No.");
            PayLines.SetRange("Account Type", PayLines."Account Type"::Vendor);
            if PayLines.Find('-')then repeat VendorLedgerEntry.Reset;
                    VendorLedgerEntry.SetRange("Vendor No.", PayLines."Account No");
                    VendorLedgerEntry.SetRange("Applies-to ID", PayLines.No);
                    if VendorLedgerEntry.FindFirst then begin
                        PurchInvHeader.Get(VendorLedgerEntry."Document No.");
                        AppAllocation.Reset;
                        AppAllocation.SetRange("Document No.", PurchInvHeader."Pre-Assigned No.");
                        if AppAllocation.FindFirst then Error('Applied Invoice %1 has already been apportioned', PurchInvHeader."No.")end;
                until PayLines.Next = 0;
        end;
    end;
}
