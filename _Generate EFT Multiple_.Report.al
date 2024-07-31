report 50321 "Generate EFT Multiple"
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
                EFTNewCopy: Record "EFT Lines New";
                TotalAmount: Decimal;
            begin
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
                //Loop through EFT Lines and create excel per document path
                if PrintToExcel and not BankTransfer then begin
                    "EFT Lines New".Reset();
                    "EFT Lines New".SetRange("Document No.", "No.");
                    if "EFT Lines New".Find('-') then
                        repeat
                            "EFT Lines New".CalcFields("Pmt Document Path");
                            MakeExcelDataHeader;
                            EFTLines2.Reset();
                            EFTLines2.SetRange("Document No.", "EFT Lines New"."Document No.");
                            EFTLines2.SetRange(Created, false);
                            EFTLines2.CalcFields("Pmt Document Path");
                            EFTLines2.SetRange("Pmt Document Path", "EFT Lines New"."Pmt Document Path");
                            if EFTLines2.Find('-') then begin
                                repeat
                                    TotalAmount := 0;
                                    //EFTLines2
                                    EFTNewCopy.Reset();
                                    EFTNewCopy.SetRange("Document No.", "EFT Lines New"."Document No.");
                                    EFTNewCopy.SetRange(Created, false);
                                    EFTNewCopy.CalcFields("Pmt Document Path");
                                    EFTNewCopy.SetRange("Payee Bank Code", EFTLines2."Payee Bank Code");
                                    EFTNewCopy.SetRange("Payee Bank Account No", EFTLines2."Payee Bank Account No");
                                    EFTNewCopy.SetRange("Pmt Document Path", "EFT Lines New"."Pmt Document Path");
                                    if EFTNewCopy.Find('-') then
                                        repeat
                                            TotalAmount += EFTNewCopy."Total Net Amount";
                                            EFTNewCopy.Created := true;
                                            EFTNewCopy."S2B Customer Ref" := EFTLines2."Customer Ref";
                                            EFTNewCopy.Modify();
                                        until EFTNewCopy.Next() = 0;
                                    MakeExcelDataBody(EFTLines2, EFTLines2."No.", EFTLines2."Line No.", TotalAmount);
                                    if PaymentRec.Get(EFTLines2."No.") then begin
                                        PaymentRec."EFT Date" := Payments."EFT Date";
                                        PaymentRec."EFT Reference" := Payments."EFT Reference";
                                        PaymentRec."EFT File Generated" := true;
                                        PaymentRec.Modify;
                                    end;
                                until EFTLines2.Next() = 0;
                                CreateExcelBook("EFT Lines New"."Pmt Document Path", Payments);
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
        CashMgmt: Record "Cash Management Setups";
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

    procedure CreateExcelBook(DocPath: text; Pmts: record Payments)
    var
        FileName: text;
        FileName2: Text;
        FileName3: Text;
        FileName4: Text;
        DateTime1: Code[50];
        CashMgmt: Record "Cash Management Setups";
    begin
        if Pmts.Preview = false then begin
            DateTime1 := 'Payments_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>'); //CreateDateTime(Today, Time);
            FileName := DocPath + DateTime1 + '.xlsx';
            FileName2 := DocPath + DateTime1 + '.xls';
            CashMgmt.Get;
            CashMgmt.TestField("Payment Files Archive Path");
            FileName3 := CashMgmt."Payment Files Archive Path" + DateTime1 + '.xlsx';
            FileName4 := CashMgmt."Payment Files Archive Path" + DateTime1 + '.xls';
            //eddie  ExcelBuffer.Create(FileName, Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, '');
            //eddie ExcelBuffer.CreateBook(FileName3, Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, '');
            ExcelBuffer.CloseBook;
            ExcelBuffer.DeleteAll();
            Clear(ExcelBuffer);
            //eddie Rename(FileName, FileName2);
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
        ExcelBuffer.AddColumn('Debit Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Account Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Reference', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bank Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Local Bank Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Branch Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Email address', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('POP', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(EFTNew: record "EFT Lines New"; DocNo: Code[20]; LineNo: Integer; Amount: Decimal)
    var
        PaymentLines: Record "Payment Lines";
        PmtRec: record payments;
        Email: Text[303];
        PayeeMail: text[100];
        FinEmail: Text[100];
        SourceEmail: text[100];
        AccNo: Code[100];
        Vendor: Record Vendor;
        Customer: Record Customer;
        BankAcc: Record "Bank Account";
        AppliedAmt: Decimal;
        AppliedRate: Decimal;
        DimValues: Record "Dimension Value";
        Banks2: Record "Bank Account";
        Banks3: Record Banks;
        AccName: Text[100];
        SwiftCode: Code[100];
        Banks: Record Banks;
    begin
        if PmtRec.get(DocNo) then;
        if PaymentLines.get(DocNo, LineNo) then;
        PaymentLines.calcfields("Pay Mode Type");
        if PmtRec."Payment Type" <> PmtRec."Payment Type"::"Bank Transfer" then if Banks2.get(PmtRec."Paying Bank Account") then;
        if PmtRec."Payment Type" = PmtRec."Payment Type"::"Bank Transfer" then if Banks2.get(PmtRec."Source Bank") then;
        //get Emails
        DimValues.Reset();
        DimValues.SetRange("Global Dimension No.", 3);
        DimValues.SetRange(Accounts, true);
        if DimValues.FindFirst() then FinEmail := DimValues.Email;
        //  EFTNew.calcfields("Total Amount", "Total Net Amount");
        DimValues.Reset();
        DimValues.SetRange(Code, PmtRec."Shortcut Dimension 3 Code");
        if DimValues.FindFirst() then SourceEmail := DimValues.Email;
        PayeeMail := EFTNew."Payee Email";
        if PayeeMail = '' then begin
        end;
        if PaymentLines."Account Type" = PaymentLines."Account Type"::Customer then begin
            customer.reset;
            customer.SetRange("No.", PaymentLines."Account No");
            if customer.FindFirst() then begin
                AccName := PaymentLines."Payee Account Name";
            end;
        end;
        if PaymentLines."Account Type" = PaymentLines."Account Type"::Vendor then begin
            Vendor.reset;
            Vendor.SetRange("No.", PaymentLines."Account No");
            if Vendor.FindFirst() then begin
                PayeeMail := Vendor."E-Mail";
            end;
        end;
        if PaymentLines."Account Type" = PaymentLines."Account Type"::"Bank Account" then begin
            BankAcc.reset;
            BankAcc.SetRange("No.", PaymentLines."Account No");
            if BankAcc.FindFirst() then begin
                PayeeMail := BankAcc."E-Mail";
            end;
        end;
        if Banks3.Get(PaymentLines."Payee Bank Code") then;
        Banks3.TestField("Swift Code");
        SwiftCode := Banks3."Swift Code";
        AccName := PaymentLines."Payee Account Name";
        Email := PayeeMail;
        if FinEmail <> '' then begin
            if Email = '' then
                Email := FinEmail
            else
                Email := Email + ',' + FinEmail;
        end;
        if (SourceEmail <> '') and (FinEmail <> '') then begin
            if (SourceEmail = FinEmail) or (Email = '') then
                Email := SourceEmail
            else
                Email := Email + ',' + SourceEmail;
        end;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(Banks2."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AccName, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EFTNew."Customer Ref", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PaymentLines."Payee Bank Account No", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        if (PaymentLines."Pay Mode Type" = PaymentLines."Pay Mode Type"::EFT) or (PaymentLines."Pay Mode Type" = PaymentLines."Pay Mode Type"::ACH) then begin
            ExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(EFTNew."Payee Bank Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(EFTNew."Payee Bank Branch Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        end
        else begin
            ExcelBuffer.AddColumn(SwiftCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        end;
        ExcelBuffer.AddColumn(round(Amount, 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(format(EFTNew."Payment Narration", 29), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Email, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PaymentLines."Pay Mode", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PaymentLines."POP Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;

    procedure GetfileName()
    var
        myInt: Integer;
    begin
    end;

    procedure RenameFile(Path: Text[200])
    var
        myInt: Integer;
    begin
    end;
}
