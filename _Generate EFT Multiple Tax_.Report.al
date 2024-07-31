report 50323 "Generate EFT Multiple Tax"
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
            begin
                CMSetup.Get;
                CMSetup.testfield("Tax Files Path");
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
                //Loop through EFT Lines and create excel per Pmt Document Path
                if PrintToExcel and not BankTransfer then begin
                    "EFT Lines New".Reset();
                    "EFT Lines New".SetRange("Document No.", "No.");
                    if "EFT Lines New".Find('-') then
                        repeat
                            MakeExcelDataHeader;
                            "EFT Lines New".CalcFields("Pmt Document Path");
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
                                CreateExcelBook(CMSetup."Tax Files Path", Payments);
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
        EFTLines: Record "EFT Lines New";
        EFTLines2: Record "EFT Lines New";
        CMSetup: Record "Cash Management Setups";

    procedure CreateExcelBook(DocPath: text; Pmts: record Payments)
    var
        FileName: text;
        FileName2: text;
        DateTime1: Code[50];
        FileName3: Text;
        FileName4: Text;
    begin
        CMSetup.Get;
        CMSetup.testfield("Payment Files Archive Path");
        if Pmts.Preview = False then begin
            DateTime1 := 'Tax_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>'); //CreateDateTime(Today, Time);
            FileName := DocPath + DateTime1 + '.xlsx';
            FileName2 := DocPath + DateTime1 + '.xls';
            FileName3 := CMSetup."Payment Files Archive Path" + DateTime1 + '.xlsx';
            FileName4 := CMSetup."Payment Files Archive Path" + DateTime1 + '.xls';
            ///eddie ExcelBuffer.CreateBook(FileName, Format(Payments."No."));
            ExcelBuffer.WriteSheet(Format(Payments."No."), CompanyName, DocPath);
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
        ExcelBuffer.AddColumn('PRN', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Customer Reference', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(EFTNew: record "EFT Lines New"; DocNo: Code[20]; LineNo: Integer)
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
        AppliedAmt: Decimal;
        AppliedRate: Decimal;
        DimValues: Record "Dimension Value";
        BankRec: Record "Bank Account";
        AccName: text[100];
        Description: text[100];
    begin
        //EFTNew.CalcFields("Total Net Amount", PRN);
        if PmtRec.get(DocNo) then;
        PmtRec.TestField(PRN);
        BankRec.Reset();
        BankRec.SetRange("No.", PmtRec."Paying Bank Account");
        if BankRec.FindFirst() then begin
            AccNo := BankRec."Bank Account No.";
            AccName := BankRec.Name;
        end;
        if PaymentLines.get(DocNo, LineNo) then;
        PaymentLines.calcfields("Pay Mode Type");
        //get Emails
        DimValues.Reset();
        DimValues.SetRange("Global Dimension No.", 3);
        DimValues.SetRange(Accounts);
        if DimValues.FindFirst() then FinEmail := DimValues.Email;
        DimValues.Reset();
        DimValues.SetRange(Code, PmtRec."Shortcut Dimension 3 Code");
        if DimValues.FindFirst() then SourceEmail := DimValues.Email;
        PayeeMail := EFTNew."Payee Email";
        if PayeeMail = '' then begin
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
        end;
        Email := PayeeMail;
        if FinEmail <> '' then begin
            if Email = '' then
                Email := FinEmail
            else
                Email := Email + ',' + FinEmail;
        end;
        if SourceEmail <> '' then begin
            if Email = '' then
                Email := SourceEmail
            else
                Email := Email + ',' + SourceEmail;
        end;
        Description := format(PaymentLines."Pay Mode Type") + ' Payment';
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(AccNo, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(PmtRec.PRN, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(round(EFTNew."Total Net Amount", 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(EFTNew."Customer Ref", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
