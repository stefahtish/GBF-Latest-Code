report 50322 "Generate EFT Multiple2"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            trigger OnAfterGetRecord()
            var
                "EFT Lines New": record "EFT Lines New";
                CashMgmtSetup: Record "Cash Management Setups";
            begin
                CashMgmtSetup.get;
                CashMgmtSetup.TestField("Forex Path");
                Payments.CalcFields("Total Amount", "Total Net Amount");
                if Payments."Payment Type" = Payments."Payment Type"::"Bank Transfer" then BankTransfer := true;
                Payments."EFT File Generated" := true;
                Payments.Modify;
                //Mark all as uncreated
                EFTLines.Reset();
                EFTLines.SetRange("Document No.", "No.");
                if EFTLines.Find('-') then
                    repeat
                        EFTLines.Created := false;
                        EFTLines.Modify();
                    until EFTLines.Next() = 0;
                //Loop through EFT Lines and create excel per Pmt Document path
                if PrintToExcel and not BankTransfer then begin
                    "EFT Lines New".Reset();
                    "EFT Lines New".SetRange("Document No.", "No.");
                    if "EFT Lines New".Find('-') then
                        repeat
                            "EFT Lines New".CalcFields("Pmt Document Path");
                            ExcelBuffer.DeleteAll();
                            MakeExcelDataHeader;
                            EFTLines2.Reset();
                            EFTLines2.SetRange("Document No.", "EFT Lines New"."Document No.");
                            EFTLines2.SetRange(Created, false);
                            EFTLines2.CalcFields("Pmt Document Path");
                            EFTLines2.SetRange("Pmt Document Path", "EFT Lines New"."Pmt Document Path");
                            if EFTLines2.Find('-') then begin
                                repeat
                                    MakeExcelDataBody(EFTLines2, EFTLines2."No.", EFTLines2."Line No.");
                                    EFTLines2.Created := true;
                                    EFTLines2.Modify();
                                    if PaymentRec.Get(EFTLines2."No.") then begin
                                        PaymentRec."EFT Date" := Payments."EFT Date";
                                        PaymentRec."EFT Reference" := Payments."EFT Reference";
                                        PaymentRec."EFT File Generated" := true;
                                        PaymentRec.Modify;
                                    end;
                                until EFTLines2.Next() = 0;
                                //CreateExcelBook(Payments, CashMgmtSetup."Forex Path");
                            end;
                        until "EFT Lines New".Next = 0;
                end;
                Commit;
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
    labels
    {
    }
    trigger OnInitReport()
    begin
        PrintToExcel := true;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        ExcelBuffer.DeleteAll;
        BankTransfer := false;
    end;

    var
        PrintToExcel: Boolean;
        PaymentsManagement: Codeunit "Payments Management";
        CompanyInformation: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        PaymentRec: Record Payments;
        ServerFileName: Text;
        MyName: Text;
        BankTransfer: Boolean;
        EFTLines2: Record "EFT Lines New";
        EFTLines: Record "EFT Lines New";

    procedure CreateExcelBook(Pmts: record Payments; DocPath: text)
    var
        FileName: text;
        FileName2: text;
        DateTime1: Code[50];
        FileName3: Text;
        FileName4: Text;
        CashMgmt: Record "Cash Management Setups";
    begin
        if Pmts.Preview = false then begin
            DateTime1 := 'Forex_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>'); //CreateDateTime(Today, Time);
            FileName := DocPath + DateTime1 + '.xlsx';
            FileName2 := DocPath + DateTime1 + '.xls';
            CashMgmt.get;
            FileName3 := CashMgmt."Payment Files Archive Path" + DateTime1 + '.xlsx';
            FileName4 := CashMgmt."Payment Files Archive Path" + DateTime1 + '.xls';
            //eddie ExcelBuffer.CreateBook(FileName, Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, DocPath);
            //eddie ExcelBuffer.CreateBook(FileName3, Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, '');
            ExcelBuffer.CloseBook;
            ExcelBuffer.DeleteAll();
            Clear(ExcelBuffer);
            //eddieRename(FileName, FileName2);
            //eddie Rename(FileName3, FileName4);
        end;
        if Pmts.Preview = true then begin
            //eddie ExcelBuffer.CreateBook('', Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, '');
            ExcelBuffer.CloseBook;
            ExcelBuffer.OpenExcel;
            //ExcelBuffer.GiveUserControl;
            Error('');
        end;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.DeleteAll();
        // if not BankTransfer then begin
        // ExcelBuffer.AddColumn('Debit Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Account Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Ref', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bank Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Branch Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Payment type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment Details', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment Currency', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Debit Account Number', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Email Address', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FX Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Applied Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Rate', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Deal Number', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dealer Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Direct/Inverse', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Maturity Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Intermediary Bank Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(EFTNew: record "EFT Lines New"; DocNo: Code[20]; LineNo: Integer)
    var
        PaymentLines: Record "Payment Lines";
        PmtRec: record payments;
        Email: Text[100];
        PayeeMail: text[100];
        FinEmail: Text[100];
        SourceEmail: text[100];
        DimValues: Record "Dimension Value";
        AccNo: Code[100];
        Vendor: Record Vendor;
        Customer: Record Customer;
        AppliedAmt: Decimal;
        AppliedRate: Decimal;
        Dealers: Record "Forex Dealers";
        MaturityDate: date;
        MaturityDate2: Text[50];
        Payments2: Record Payments;
        AccName: Text[100];
        Banks2: Record "Bank Account";
    begin
        if Payments2.get(DocNo) then;
        if Banks2.get(Payments2."Paying Bank Account") then;
        if PaymentLines."Account Type" = PaymentLines."Account Type"::Customer then begin
            customer.reset;
            customer.SetRange("No.", PaymentLines."Account No");
            if customer.FindFirst() then PayeeMail := customer."E-Mail";
        end;
        if PaymentLines."Account Type" = PaymentLines."Account Type"::Vendor then begin
            Vendor.reset;
            Vendor.SetRange("No.", PaymentLines."Account No");
            if Vendor.FindFirst() then PayeeMail := Vendor."E-Mail";
        end;
        Email := PayeeMail;
        DimValues.Reset();
        DimValues.SetRange("Global Dimension No.", 3);
        DimValues.SetRange(Accounts, true);
        if DimValues.FindFirst() then FinEmail := DimValues.Email;
        //  EFTNew.calcfields("Total Amount", "Total Net Amount");
        DimValues.Reset();
        DimValues.SetRange(Code, PmtRec."Shortcut Dimension 3 Code");
        if DimValues.FindFirst() then SourceEmail := DimValues.Email;
        if FinEmail <> '' then begin
            if Email = '' then
                Email := FinEmail
            else
                Email := Email + ',' + FinEmail;
        end;
        if SourceEmail <> '' then begin
            if (SourceEmail = FinEmail) or (Email = '') then
                Email := Email
            else
                Email := Email + ',' + SourceEmail;
        end;
        PaymentLines.Reset();
        PaymentLines.setrange("Payment Type", PaymentLines."Payment Type"::"Payment Voucher");
        PaymentLines.SetRange(No, DocNo);
        PaymentLines.SetRange("Line No", LineNo);
        if PaymentLines.FindFirst() then;
        AccNo := PaymentLines."Account No";
        AppliedAmt := PaymentLines."Amount (LCY)";
        //  AppliedRate := Payments2."Conversion rate";
        //  IF Payments2."Dirext/inverse" = Payments2."Dirext/inverse"::I then
        //   AppliedRate := Round(1 / Payments2."Conversion rate", 0.0000000001, '=');
        ExcelBuffer.NewRow;
        // ExcelBuffer.AddColumn(Banks2."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(AccName, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EFTNew."Customer Ref", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EFTNew."Payee Bank Account Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PaymentLines."Payee Bank Account No", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EFTNew."Payee Bank Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EFTNew."Payee Bank Branch Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(StrSubstNo(EFTNew."Payee Bank Code" + EFTNew."Payee Bank Branch Code"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(round(EFTNew."Total Net Amount", 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.AddColumn(Payments."Payee Bank Account No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PaymentLines."Pay Mode", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(format(PaymentLines.Description, 29), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Payments2.Currency, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Banks2."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Email, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //  ExcelBuffer.AddColumn(Payments2."Forex Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AppliedRate, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        //   ExcelBuffer.AddColumn(Payments2."Forex deal no", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn(Payments2."Forex dealer name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        //   ExcelBuffer.AddColumn(Payments2."Dirext/inverse", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        Dealers.reset;
        Dealers.setrange(No, Payments2."Forex dealer");
        if Dealers.FindFirst() then begin
            MaturityDate := CalcDate(Dealers."Maturity Period", EFTNew.Date);
            MaturityDate2 := format(MaturityDate, 0, '<Day,2>/<Month,2>/<Year4>');
            ExcelBuffer.AddColumn(MaturityDate2, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(Dealers."Bank Swift Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        end;
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
