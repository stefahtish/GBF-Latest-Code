report 50394 "Imprest Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            trigger OnAfterGetRecord()
            var
                HRSetup: Record "Human Resources Setup";
                ImprestSurrender: Record Payments;
                DateDue: Date;
                LineNo: Integer;
                SurrenderedAmount: Decimal;
                AmountToTransfer: Decimal;
                Generated: Boolean;
                PayrollPeriod: Date;
                PayrollPeriodX: Record "Payroll PeriodX";
                DeductionsX: Record DeductionsX;
                AssignmentMatrixX: Record "Assignment Matrix-X";
                DeductionCode: code[20];
                Text002: label 'You have to define a Deduction Code for Imprest in the Deductions.';
                Commitment: Codeunit Committment;
                ImprestLines: Record "Payment Lines";
                GenJnLine: Record "Gen. Journal Line";
                GLEntry: Record "G/L Entry";
                ImprestHeader: Record Payments;
                Temp: Record "Cash Office User Template";
                JTemplate: Code[20];
                JBatch: Code[20];
                Batch: Record "Gen. Journal Batch";
                CMSetup: Record "Cash Management Setups";
                SMTP: Codeunit "Email Message";
                //SMTPSetup: Record "SMTP Mail Setup";
                Email: Codeunit Email;
                SenderName: Text;
                SenderAddress: Text;
                Receipient: List of [Text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                CompanyInfo: Record "Company Information";
                RecipientCC: List of [Text];
                RecipientBCC: List of [Text];
                Employees: Record Employee;
                RecipientMail: Text[80];
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your imprest<Strong> %2 </Strong>is due for surrender on <Strong> %3</Strong> Thank you. <br><br> Kind Regards, <br><br>';
            begin
                HRSetup.Get;
                HRSetup.TestField("Imprest Notification Days");
                DateDue := CalcDate(format(HRSetup."Imprest Notification Days"), Today);
                Payments.Reset;
                Payments.SetRange("No.", Payments."No.");
                Payments.SetRange("Payment Type", Payments."Payment Type"::Imprest);
                Payments.SetFilter("Due Date", '=%1', DateDue);
                Payments.SetRange(Surrendered, false);
                if Payments.Find('-') then
                    repeat
                        Employees.Reset();
                        Employees.SetRange("No.", Payments."Staff No.");
                        if Employees.Find('-') then RecipientMail := Employees."Company E-Mail";
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Receipient.Add(RecipientMail);
                        Subject := ('Overdue Imprest - ' + '  ' + Payments."No.");
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', true);
                        SMTP.AppendtoBody(StrSubstNo(NewBody, Payments."Account Name", Payments."No.", Payments."Due Date"));
                        email.Send(SMTP);
                    UNTIL Payments.NEXT = 0;
                Payments.Reset;
                Payments.SetRange("No.", Payments."No.");
                Payments.SetRange("Payment Type", Payments."Payment Type"::Imprest);
                Payments.SetFilter("Due Date", '>%1', DateDue);
                Payments.SetRange(Surrendered, false);
                if Payments.Find('-') then
                    repeat
                        SurrenderedAmount := 0;
                        LineNo := 0;
                        ImprestSurrender.Reset;
                        ImprestSurrender.SetRange("Payment Type", Payments."Payment Type"::"Imprest Surrender");
                        ImprestSurrender.SetRange("Imprest Issue Doc. No", Payments."No.");
                        ImprestSurrender.SetRange(Posted, true);
                        if ImprestSurrender.FindFirst then
                            repeat
                                ImprestSurrender.CalcFields("Actual Amount Spent", "Cash Receipt Amount");
                                SurrenderedAmount += ImprestSurrender."Actual Amount Spent";
                                SurrenderedAmount += ImprestSurrender."Cash Receipt Amount";
                            until ImprestSurrender.Next = 0;
                        Payments.CalcFields("Imprest Amount");
                        AmountToTransfer := Payments."Imprest Amount" - SurrenderedAmount;
                        AssignmentMatrixX.INIT;
                        AssignmentMatrixX.VALIDATE("Employee No", Payments."Staff No.");
                        AssignmentMatrixX.Type := AssignmentMatrixX.Type::Deduction;
                        AssignmentMatrixX.VALIDATE(Code, DeductionCode);
                        AssignmentMatrixX.Amount := -AmountToTransfer;
                        AssignmentMatrixX.Imprest := TRUE;
                        AssignmentMatrixX."Reference No" := Payments."No.";
                        AssignmentMatrixX.INSERT;
                        //Get surrender template
                        Temp.Get(UserId);
                        JTemplate := Temp."Imprest Sur Template";
                        JBatch := Payments."No."; // Temp."Imprest Sur Batch";
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
                        GenJnLine."Account No." := Payments."Account No.";
                        GenJnLine."Posting Date" := Today;
                        GenJnLine."Document No." := Payments."No.";
                        GenJnLine."External Document No." := Payments."Imprest Issue Doc. No";
                        GenJnLine.Description := 'Imprest deducted from payroll for: ' + Payments.Payee;
                        GenJnLine.Amount := -AmountToTransfer;
                        GenJnLine."Currency Code" := Payments.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(Amount);
                        GenJnLine."Shortcut Dimension 1 Code" := Payments."Shortcut Dimension 1 Code";
                        GenJnLine.Validate("Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := Payments."Shortcut Dimension 2 Code";
                        GenJnLine.Validate("Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := Payments."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        //  GenJnLine."VAT Bus. Posting Group":='LOCAL';
                        // GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                        GenJnLine."Applies-to Doc. No." := GetImprestPostedPV(Payments."Imprest Issue Doc. No");
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(Amount);
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        ImprestLines.Reset;
                        ImprestLines.SetRange("Payment Type", Payments."Payment Type");
                        ImprestLines.SetRange(No, Payments."No.");
                        if ImprestLines.Find('-') then begin
                            repeat
                                ImprestLines.Validate(ImprestLines.Amount);
                                ImprestLines.TestField(Description);
                                LineNo := LineNo + 10000;
                                GenJnLine.Init;
                                GenJnLine."Journal Template Name" := JTemplate;
                                GenJnLine."Journal Batch Name" := JBatch;
                                GenJnLine."Line No." := LineNo;
                                GenJnLine."Account Type" := ImprestLines."Account Type";
                                GenJnLine."Account No." := ImprestLines."Account No";
                                GenJnLine.Validate(GenJnLine."Account No.");
                                GenJnLine."Posting Date" := Today;
                                GenJnLine."Document No." := Payments."No.";
                                //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                                GenJnLine.Description := 'Imprest deducted from payroll for: ' + Payments.Payee;
                                GenJnLine.Amount := ImprestLines.Amount;
                                GenJnLine."Currency Code" := Payments.Currency;
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
                                if Payments."Cash Receipt Amount" <> 0 then begin
                                    //Receipt Lines Entries
                                    // if (ImprestLines."Cash Receipt Amount" <> 0) and (ImprestLines."Imprest Receipt No." = '') then begin
                                    //     ImprestLines.TestField("Receiving Bank");
                                    LineNo := LineNo + 10000;
                                    GenJnLine.Init;
                                    GenJnLine."Journal Template Name" := JTemplate;
                                    GenJnLine."Journal Batch Name" := JBatch;
                                    GenJnLine."Line No." := LineNo;
                                    GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                                    GenJnLine."Account No." := Payments."Account No.";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                    GenJnLine."Posting Date" := Today;
                                    GenJnLine."Document No." := Payments."No.";
                                    GenJnLine."External Document No." := Payments."Cheque No";
                                    GenJnLine."Payment Method Code" := Payments."Pay Mode";
                                    GenJnLine.Description := Payments."Account Name";
                                    GenJnLine.Amount := -ImprestLines.Amount;
                                    GenJnLine."Currency Code" := Payments.Currency;
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
                                    GenJnLine."Applies-to Doc. No." := GetImprestPostedPV(Payments."Imprest Issue Doc. No");
                                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                                end;
                            // end;
                            until ImprestLines.Next = 0;
                        end;
                        GenJnLine.Reset;
                        GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
                        GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."Document No.", Payments."No.");
                        GLEntry.SetRange(GLEntry.Reversed, false);
                        if GLEntry.FindFirst then begin
                            //Imprest.MODIFY(TRUE);    //Carol
                            Payments.Posted := true;
                            Payments."Posted By" := UserId;
                            Payments."Posted Date" := Today;
                            Payments."Time Posted" := Time;
                            Payments.Surrendered := true;
                            Payments."Surrender Date" := Today;
                            Payments."Surrendered By" := UserId;
                            Payments.Modify;
                            //Create a Payment Voucher or Petty Cash if there's a receipted amount
                            Payments.CalcFields("Cash Receipt Amount", "Actual Amount Spent", "Imprest Amount");
                            if Payments."Actual Amount Spent" > Payments."Imprest Amount" then begin
                                CreatePVPettyCash(Payments);
                            end;
                            //Uncommit Entries made to the varoius expenses accounts
                            //Commitment.UnencumberImprest(Payments);
                            Commit;
                            ImprestHeader.Reset;
                            ImprestHeader.SetRange(ImprestHeader."No.", Payments."Imprest Issue Doc. No");
                            if ImprestHeader.Find('-') then begin
                                ImprestHeader.Surrendered := true;
                                ImprestHeader."Surrender Date" := Payments."Surrender Date";
                                ImprestHeader."Surrendered By" := Payments."Surrendered By";
                                ImprestHeader.Modify;
                            end;
                        end;
                    UNTIL Payments.NEXT = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    var
        Text021: Label 'Create a Petty Cash Voucher,Create a Payment Voucher, Create a Staff Claim';
        Text022: Label 'Please Choose one of these options';

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

    local procedure CreatePVPettyCash(Imprest: Record Payments)
    var
        PaymentRec: Record Payments;
        PaymentLines: Record "Payment Lines";
        ImprestLines: Record "Payment Lines";
        OptionNumber: Integer;
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
                end;
        end;
        PaymentRec.Status := PaymentRec.Status::Open;
        PaymentRec.Posted := false;
        PaymentRec."Posted By" := '';
        PaymentRec."Posted Date" := 0D;
        PaymentRec."Posting Date" := 0D;
        PaymentRec."Time Posted" := 0T;
        PaymentRec.Insert(true);
        Imprest.CalcFields("Actual Amount Spent", "Imprest Amount");
        //Lines
        PaymentLines.Init;
        PaymentLines.No := PaymentRec."No.";
        PaymentLines."Line No" := 1000;
        PaymentLines."Account Type" := PaymentLines."Account Type"::Customer;
        PaymentLines."Account No" := Imprest."Account No.";
        PaymentLines.Description := 'Refund';
        PaymentLines.Amount := Imprest."Imprest Amount";
        PaymentLines.Validate(Amount);
        case OptionNumber of
            1:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Petty Cash";
            2:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Payment Voucher";
            3:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Staff Claim";
        end;
        if PaymentLines.Amount <> 0 then PaymentLines.Insert(true);
        case OptionNumber of
            1:
                PAGE.Run(Page::"Petty Cash", PaymentRec);
            2:
                PAGE.Run(Page::"Payment Voucher", PaymentRec);
            3:
                PAGE.Run(Page::"Staff Claim", PaymentRec);
        end;
    end;
}
