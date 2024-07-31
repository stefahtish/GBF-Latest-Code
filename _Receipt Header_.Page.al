page 50836 "Receipt Header"
{
    PageType = Document;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE("Receipt Type" = CONST(Bank));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;

                    trigger OnValidate()
                    begin
                        FunctionName := '';
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 1);
                        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
                        if DimVal.Find('-') then begin
                            FunctionName := DimVal.Name;
                        end;
                    end;
                }
                field(Description1; Rec."Dim 1 Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        BudgetCenterName := '';
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 2);
                        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
                        if DimVal.Find('-') then begin
                            BudgetCenterName := DimVal.Name;
                        end;
                    end;
                }
                field(Description2; Rec."Dim 2 Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field(Description3; Rec.Dim3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                    Visible = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
            }
            group(Control10)
            {
                ShowCaption = false;

                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = statuseditable;
                }
                field("Receipt Narration"; Rec."Receipt Narration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Date"; Rec."Cheque Date")
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
                    Editable = false;
                }
                field("Net Amount LCY"; Rec."Net Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Officer Name';
                    Editable = false;
                }
            }
            part(Control1000000000; "Receipts Line")
            {
                ApplicationArea = Basic, Suite;
                Editable = statuseditable;
                SubPageLink = No = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*IF Posted=FALSE THEN ERROR('Post the receipt before printing.');*/
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
    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
        CurrPageUpdate;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //********************************JACK**********************************//
        /*
              Rcpt.RESET;
              Rcpt.SETRANGE(Rcpt.Posted,FALSE);
              Rcpt.SETRANGE(Rcpt."Created By",USERID);
              IF Rcpt.COUNT >0 THEN
                BEGIN
                  IF CONFIRM('There are still some unposted receipts. Continue?',FALSE)=FALSE THEN
                    BEGIN
                      ERROR('There are still some unposted receipts. Please utilise them first');
                    END;
                END;
                */
        //********************************END **********************************//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec.Validate("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec.Validate("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        Rec.Status := Rec.Status::" ";
        Rec."Receipt Type" := Rec."Receipt Type"::Bank;
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        //  SETRANGE("Created By",USERID);
        /*IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
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
        GenJnlBatch: Record "Gen. Journal Batch";
        FunctionName: Text[100];
        BudgetCenterName: Text[100];
        BankName: Text[100];
        Rcpt: Record "Receipts Header";
        RcptNo: Code[20];
        DimVal: Record "Dimension Value";
        BankAcc: Record "Bank Account";
        UserSetup: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
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
        StatusEditable: Boolean;
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
        IsCashAccount := false;
        BankAcc.Reset;
        // if BankAcc.Get("Bank Code") then begin
        //    if BankAcc."Bank Type" = BankAcc."Bank Type"::Cash then
        IsCashAccount := true;
        // end;
        if IsCashAccount then Rec.TestField(Date, WorkDate);
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
           { ApplicationArea = Basic, Suite; IF USetup."Default Receipts Bank"='' THEN
              BEGIN
                ERROR('Please ensure that the Administrator sets you up as a cashier');
              END; }
          END
        ELSE
          BEGIN
            ERROR('Please ensure that the Administrator sets you up as a cashier');
          END;
        */
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
        //Check Bank
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");
        //Validations
        if Rec."Pay Mode" = Rec."Pay Mode"::" " then Error('Paymode is Mandatory');
        if Rec."Pay Mode" = Rec."Pay Mode"::"Deposit Slip" then begin
            if Rec."Cheque No." = '' then Error('The Cheque/Deposit Slip No must be inserted');
            if Rec."Cheque Date" = 0D then Error('The Cheque/Deposit Date must be inserted');
        end;
        if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then begin
            if Rec."Cheque No." = '' then Error('The Cheque/Deposit Slip No must be inserted');
            if Rec."Cheque Date" = 0D then Error('The Cheque/Deposit Date must be inserted');
        end;
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine.Type = '' then Error('Please ensure that the Receipt Type is inserted');
            until ReceiptLine.Next = 0;
        end;
        //GET USER BATCH FROM CASH OFFICE SETUP
        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            JTemplate := UserSetup."Receipt Journal Template";
            JBatch := UserSetup."Receipt Journal Batch";
        end;
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.FindLast then LineNo := GenJnlLine."Line No.";
        //Insert the bank transaction******************************************
        GenJnlLine.Init;
        LineNo := LineNo + 1000;
        GenJnlLine."Line No." := LineNo;
        Rec.CalcFields("Net Amount");
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Source Code" := 'CASHRECJNL';
        GenJnlLine."Posting Date" := Rec.Date;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Document Date" := Rec."Document Date";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Bank Code"; //USetup."Default Receipts Bank";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := Rec."Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
        GenJnlLine.Description := Rec."Received From";
        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
        //insert the transaction lines into the database
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetRange(ReceiptLine.Posted, false);
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine.Amount = 0 then Error('Please enter amount.');
                ReceiptLine.TestField(ReceiptLine."Global Dimension 1 Code");
                ReceiptLine.TestField(ReceiptLine."Shortcut Dimension 2 Code");
                GenJnlLine.Init;
                LineNo := LineNo + 1000;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Posting Date" := Rec.Date;
                GenJnlLine."Document No." := ReceiptLine.No;
                GenJnlLine."Document Date" := Rec."Document Date";
                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                GenJnlLine."Account No." := ReceiptLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Rec."Cheque No.";
                GenJnlLine."Currency Code" := Rec."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine.Amount := -ReceiptLine.Amount;
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine.Description := Rec."Received From";
                if ReceiptLine."Customer Payment On Account" = false then begin
                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                    GenJnlLine.Validate("Applies-to Doc. No.");
                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                    GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                end;
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                //POST CARD COMMISSION
                if ReceiptLine."WHT Code" <> '' then begin
                    TarriffCodes.Reset;
                    TarriffCodes.SetRange(TarriffCodes.Code, ReceiptLine."WHT Code");
                    if TarriffCodes.Find('-') then begin
                        TarriffCodes.TestField(TarriffCodes."Account No.");
                        GenJnlLine.Init;
                        LineNo := LineNo + 1000;
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Posting Date" := Rec.Date;
                        GenJnlLine."Document No." := ReceiptLine.No;
                        GenJnlLine."External Document No." := Rec."Cheque No.";
                        GenJnlLine."Document Date" := Rec."Document Date";
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := TarriffCodes."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := ReceiptLine."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := ReceiptLine."WHT Amount";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine.Description := ('Card Commission:' + Format(Rec."Received From"));
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
        //Post the transactions
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
        /*BankAcct.RESET;
            BankAcct.SETRANGE(BankAcct."No.",BankAcc);
            IF BankAcct.FIND('-') THEN BEGIN
               IF BankAcct."Currency Code"<>CurrCode THEN BEGIN
                IF BankAcct."Currency Code"='' THEN
                  ERROR('This bank [%1:- %2] can only transact in LOCAL Currency',BankAcct."No.",BankAcct.Name)
                  ELSE
                    ERROR('This bank [%1:- %2] can only transact in %3',BankAcct."No.",BankAcct.Name,BankAcct."Currency Code");
               END;
            END;*/
    end;

    local procedure OnAfterGetCurRecord()
    begin
        //xRec := Rec;
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

    procedure UpdateControls()
    begin
        if Rec.Posted = false then
            StatusEditable := true
        else
            StatusEditable := false;
    end;

    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        //OnAfterGetCurrRecord;
        CurrPage.Update;
    end;
}
