page 50829 "Receipt List"
{
    CardPageID = "Receipt Header";
    Editable = false;
    PageType = List;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE("Receipt Type" = CONST(Bank), Posted = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Amount LCY"; Rec."Net Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("<Action1102760016>")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Posted = false then Error('Post the receipt before printing.');
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(51519883, true, true, Rec);
                    Rec.Reset;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Document No.", Rec."No.");
                    if BankLedger.Find('-') = true then begin
                        //Update Header
                        Rec.Posted := true;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                        //Update Lines
                        ReceiptLine.Reset;
                        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                        ReceiptLine.SetRange(ReceiptLine.Posted, false);
                        if ReceiptLine.Find('-') then begin
                            repeat
                                ReceiptLine.Posted := true;
                                ReceiptLine."Date Posted" := Today;
                                ReceiptLine."Time Posted" := Time;
                                ReceiptLine."Posted By" := UserId;
                                ReceiptLine.Modify;
                            until ReceiptLine.Next = 0;
                        end;
                        Message('Transaction posted successfully');
                        Commit;
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51519883, true, true, Rec);
                        Rec.Reset;
                        exit;
                    end;
                    //Check Post Dated
                    if CheckPostDated then Error('One of the Receipt Lines is Post Dated');
                    //Post the transaction into the database
                    PerformPost;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        /*
            IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
              FILTERGROUP(2);
              SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
              FILTERGROUP(0);
            END;
            */
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        ReceiptLine: Record "Receipt Line";
        tAmount: Decimal;
        DefaultBatch: Record "Gen. Journal Batch";
        FunctionName: Text[100];
        BudgetCenterName: Text[100];
        BankName: Text[100];
        Rcpt: Record "Receipts Header";
        RcptNo: Code[20];
        DimVal: Record "Dimension Value";
        BankAcc: Record "Bank Account";
        UserSetup: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        GLine: Record "Gen. Journal Line";
        LineNo: Integer;
        BAmount: Decimal;
        SRSetup: Record "Sales & Receivables Setup";
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        USetup: Record "Cash Office User Template";
        RegMgt: Codeunit "Register Management";
        RegisterNumber: Integer;
        FromNumber: Integer;
        ToNumber: Integer;
        StrInvoices: Text[250];
        Appl: Record "CshMgt Application";
        UserMgt: Codeunit "User Setup Management BR";
        JournalPosted: Codeunit "Journal Post Successful";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        IsCashAccount: Boolean;
        BankLedger: Record "Bank Account Ledger Entry";
        TarriffCodes: Record "Tariff Codes";

    procedure PerformPost()
    begin
        //get all the invoices that have been paid for using the receipt
        StrInvoices := '';
        Appl.Reset;
        Appl.SetRange(Appl."Document Type", Appl."Document Type"::Receipt);
        Appl.SetRange(Appl."Document No.", Rec."No.");
        if Appl.FindFirst then begin
            repeat
                StrInvoices := StrInvoices + ',' + Appl."Appl. Doc. No";
            until Appl.Next = 0;
        end;
        //Cater for Cash Accounts
        IsCashAccount := false;
        BankAcc.Reset;
        if BankAcc.Get(Rec."Bank Code") then begin
            //if BankAcc."Bank Type"=BankAcc."Bank Type"::Cash then
            //IsCashAccount:=true;
        end;
        if IsCashAccount then Rec.TestField(Date, WorkDate);
        //End Cater for Cash Account
        /*
        USetup.RESET;
        USetup.SETRANGE(USetup.UserID,USERID);
        IF USetup.FINDFIRST THEN
          BEGIN
            IF USetup."Receipt Journal Template"='' THEN
              BEGIN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
              END;
            IF USetup."Receipt Journal Batch"='' THEN
              BEGIN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
              END;
            IF USetup."Default Receipts Bank"='' THEN
              BEGIN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
              END;
          END
        ELSE
          BEGIN
            ERROR('Please ensure that the Administrator sets you up as a cashier');
          END;
         */
        //check if the receipt has any post dated cheques.
        //check if the amounts are similar
        Rec.CalcFields("Total Amount");
        if Rec."Total Amount" <> Rec."Amount Received" then begin
            Error('Please note that the Total Amount and the Amount Received Must be the same');
        end;
        //if any then the amount to be posted must be less the post dated amount
        if Rec.Posted = true then begin
            Error('A Transaction Posted cannot be posted again');
        end;
        //check if the person received from has been selected
        Rec.TestField(Date);
        Rec.TestField("Bank Code");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
        Rec.TestField("Received From");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;
        //Check Bank
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::" " then Error('Paymode is Mandatory on the Receipt Line');
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                    if ReceiptLine."Transaction No." = '' then begin
                        Error('Please ensure that the Transaction Number is inserted');
                    end;
                    if ReceiptLine.Type = '' then Error('Please ensure that the Receipt Type is inserted');
                end;
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                    if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                        if StrLen(ReceiptLine."Cheque/Deposit Slip No") <> 6 then begin
                            Error('Invalid Cheque Number inserted');
                        end;
                    end;
                end;
                tAmount := tAmount + ReceiptLine.Amount;
            until ReceiptLine.Next = 0;
        end;
        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;
        if DefaultBatch.Get(JTemplate, JBatch) then DefaultBatch.Delete;
        DefaultBatch.Reset;
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.Insert;
        /*Insert the bank transaction*/
        if BAmount < tAmount then begin
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'CASHRECJNL';
            GenJnlLine."Line No." := 1;
            GenJnlLine."Posting Date" := Rec.Date;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Rec."Bank Code"; //USetup."Default Receipts Bank";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := (tAmount);
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
            GenJnlLine.Description := CopyStr('On Behalf Of:' + Rec."Received From" + 'Invoices:' + StrInvoices, 1, 50);
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
            //insert the transaction lines into the database
            ReceiptLine.Reset;
            ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);
            if ReceiptLine.Find('-') then begin
                repeat
                    if ReceiptLine.Amount = 0 then Error('Please enter amount.');
                    if ReceiptLine.Amount < 0 then Error('Amount cannot be less than zero.');
                    ReceiptLine.TestField(ReceiptLine."Global Dimension 1 Code");
                    ReceiptLine.TestField(ReceiptLine."Shortcut Dimension 2 Code");
                    //get the last line number from the general journal line
                    GLine.Reset;
                    GLine.SetRange(GLine."Journal Template Name", JTemplate);
                    GLine.SetRange(GLine."Journal Batch Name", JBatch);
                    LineNo := 0;
                    if GLine.Find('+') then begin
                        LineNo := GLine."Line No.";
                    end;
                    LineNo := LineNo + 1;
                    if ReceiptLine."Pay Mode" <> ReceiptLine."Pay Mode"::Cheque then begin
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Rec.Date;
                        GenJnlLine."Document No." := ReceiptLine.No;
                        GenJnlLine."Document Date" := Rec."Document Date";
                        /*IF ReceiptLine."Customer Payment On Account" THEN
                          BEGIN
                            {SRSetup.GET();
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";}

                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";

                          END
                        ELSE
                          BEGIN
                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";
                          END;*/
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                        GenJnlLine."Currency Code" := Rec."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := -ReceiptLine.Amount;
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        if ReceiptLine."Customer Payment On Account" = false then begin
                            //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                            GenJnlLine.Validate("Applies-to Doc. No.");
                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                            GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                        end;
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") + ' Invoices:' + StrInvoices, 1, 50);
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                    end
                    else if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                        if ReceiptLine."Cheque/Deposit Slip Date" <= Today then begin
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := JTemplate;
                            GenJnlLine."Journal Batch Name" := JBatch;
                            GenJnlLine."Source Code" := 'CASHRECJNL';
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := Rec.Date;
                            GenJnlLine."Document No." := ReceiptLine.No;
                            GenJnlLine."Document Date" := Rec."Document Date";
                            /*IF ReceiptLine."Customer Payment On Account" THEN
                              BEGIN
                                SRSetup.GET();
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";
                              END
                            ELSE
                              BEGIN
                                GenJnlLine."Account Type":=ReceiptLine."Account Type";
                                GenJnlLine."Account No.":=ReceiptLine."Account No.";
                              END;*/
                            GenJnlLine."Account Type" := ReceiptLine."Account Type";
                            GenJnlLine."Account No." := ReceiptLine."Account No.";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.Validate(GenJnlLine."Currency Code");
                            GenJnlLine.Amount := -ReceiptLine.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            if ReceiptLine."Customer Payment On Account" = false then begin
                                //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                GenJnlLine.Validate("Applies-to Doc. No.");
                                GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                            end;
                            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                            GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") + ' Invoices:' + StrInvoices, 1, 50);
                            GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                        end;
                    end;
                until ReceiptLine.Next = 0;
            end;
            /*Post the transactions*/
            Post := false;
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            if JournalPosted.PostedSuccessfully then begin
                //Update Header
                Rec.Cashier := UserId;
                //"Bank Code":=USetup."Default Receipts Bank";
                Rec.Posted := true;
                Rec."Date Posted" := Today;
                Rec."Time Posted" := Time;
                Rec."Posted By" := UserId;
                Rec.Modify;
                //Update Lines
                ReceiptLine.Reset;
                ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
                ReceiptLine.SetRange(ReceiptLine.Posted, false);
                if ReceiptLine.Find('-') then begin
                    repeat
                        ReceiptLine.Posted := true;
                        ReceiptLine."Date Posted" := Today;
                        ReceiptLine."Time Posted" := Time;
                        ReceiptLine."Posted By" := UserId;
                        ReceiptLine.Modify;
                    until ReceiptLine.Next = 0;
                end;
                Message('Receipt Posted Successfully');
            end;
        end;
    end;

    procedure PerformPostLine()
    begin
    end;

    procedure CheckPostDated() Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetRange(ReceiptLine."Pay Mode", ReceiptLine."Pay Mode"::Cheque);
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine."Cheque/Deposit Slip Date" > Today then begin
                    Exists := true;
                    exit;
                    //cheque is post dated
                    // BAmount:=BAmount + ReceiptLine.Amount;
                end;
            until ReceiptLine.Next = 0;
        end;
    end;

    procedure CheckBnkCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset;
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    local procedure OnAfterGetCurRecord()
    begin
        xRec := Rec;
        FunctionName := '';
        DimVal.Reset;
        DimVal.SetRange(DimVal."Global Dimension No.", 1);
        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
        if DimVal.Find('-') then begin
            FunctionName := DimVal.Name;
        end;
        BudgetCenterName := '';
        DimVal.Reset;
        DimVal.SetRange(DimVal."Global Dimension No.", 2);
        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
        if DimVal.Find('-') then begin
            BudgetCenterName := DimVal.Name;
        end;
        BankName := '';
        BankAcc.Reset;
        BankAcc.SetRange(BankAcc."No.", Rec."Bank Code");
        if BankAcc.Find('-') then begin
            BankName := BankAcc.Name;
        end;
    end;
}
