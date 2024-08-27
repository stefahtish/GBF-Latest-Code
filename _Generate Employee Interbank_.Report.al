report 50325 "Generate Employee Interbank"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(PayrollApproval; "Payroll Approval")
        {
            trigger OnAfterGetRecord()
            var
                PayrollApprovalLines: record "Payroll Approval Lines";
            begin
                HRSetup.get;
                HRSetup.TestField("EFT Document Path");
                HRSetup.TestField("Interbank EFT Path");
                PayrollApprovalLines.Reset();
                PayrollApprovalLines.SetRange("Document No.", "No.");
                if PayrollApprovalLines.Find('-') then begin
                    MakeExcelDataHeader;
                    MakeInterbankExcelDataBody(PayrollApproval);
                    CreateExcelBook2(HRSetup."Interbank EFT Path", PayrollApproval);
                end;
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
        HRSetup: record "Human Resources Setup";
        CompanyInformation: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        PaymentRec: Record Payments;
        ServerFileName: Text;
        MyName: Text;
        BankTransfer: Boolean;
        FileMgt: Codeunit "File Management";
        DateTime1: Code[50];
        DateTime2: Code[50];

    procedure CreateExcelBook2(DocPath: text; PayrollApprovalHeader: record "Payroll Approval")
    var
        FileName: text;
        FileName2: Text;
        PVs: Record Payments;
        PVNo: code[20];
        Time2: Time;
    begin
        PVs.Reset();
        PVs.SetRange("Payment Type", PVs."Payment Type"::"Payment Voucher");
        PVs.SetRange("Net Pay", true);
        PVs.SetRange("Payroll Period", PayrollApprovalHeader."Payroll Period");
        if PVs.FIndlast() then begin
            PVNo := PVs."No.";
        end;
        CashMgmt.Get();
        if PayrollApprovalHeader.Preview = false then begin
            // DateTime1 := Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>');       //CreateDateTime(Today, Time);
            DateTime2 := 'PAY_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>');
            if DateTime2 = DateTime1 then begin
                Time2 := Time + 1;
                DateTime2 := Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time2, 0, '<Hours24,2><Minutes,2><Seconds,2>');
            end;
            // DocPath := '';
            FileName := DocPath + DateTime2 + '.xlsx';
            FileName2 := DocPath + DateTime2 + '.xls';
            //ExcelBuffer.CreateBook(FileName, Format('Interbank'));
            ExcelBuffer.WriteSheet('Interbank', CompanyName, '');
            ExcelBuffer.CloseBook;
            ExcelBuffer.DeleteAll();
            Clear(ExcelBuffer);
            // Rename(FileName, FileName2);
            // if FileMgt.ServerFileExists(FileName) then
            //eddie    FileMgt.DeleteServerFile(FileName);
        end;
        if PayrollApprovalHeader.Preview = true then begin
            //eddieExcelBuffer.CreateBook('', Format(PayrollApprovalHeader."No."));
            ExcelBuffer.WriteSheet(Format(PayrollApprovalHeader."No."), CompanyName, UserId);
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

    procedure MakeInterbankExcelDataBody(PayrollApprovalHeader: record "Payroll Approval")
    var
        Comment: Text[100];
        Employees2: record Employee;
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        HRSetup: Record "Human Resources Setup";
        BankCode: Text[20];
        BankBranch: Text[20];
        PmtMode: Text[20];
        LocBankCode: Text[20];
        PayModes: Record "Payment Method";
        Payeeesc: Code[100];
        CustomerRef: Code[100];
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        GrossAmt: Decimal;
        Deductions: Record DeductionsX;
    begin
        CashMgmt.Get();
        CashMgmt.TestField("EFT Payee Reference Nos");
        HRSetup.get;
        HRSetup.TestField("Default Bank");
        HRSetup.TestField("Net pay POP Code");
        HRSetup.TestField("Pay Mode");
        GrossAmt := PayrollApprovalHeader."Estimated Charges";
        Employees2.reset;
        Employees2.SetRange("Pay Period Filter", PayrollApprovalHeader."Payroll Period");
        if Employees2.Find('-') then
            repeat
                Employees2.CalcFields("Total Allowances");
                GrossAmt += Employees2."Total Allowances";
            until Employees2.Next() = 0;
        if BankAcc.get(HRSetup."Default Bank") then;
        if BankAcc2.get(HRSetup."Current Bank Account") then;
        BankAcc.TestField("SWIFT Code");
        Comment := format(PayrollApprovalHeader."Payroll Period", 0, '<Month Text,3>') + '/' + format(PayrollApprovalHeader."Payroll Period", 0, '<Year4>') + ' PAYROLL';
        Deductions.Reset();
        Deductions.SetRange("Pay Period Filter", PayrollApprovalHeader."Payroll Period");
        repeat
            Deductions.CalcFields("Total Amount Employer");
            GrossAmt += Round(Abs(Deductions."Total Amount Employer"), 0.05, '>');
        until Deductions.Next() = 0;
        if BankAcc."Swift Code" = BankAcc2."SWIFT Code" then begin
            PayModes.Reset();
            PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::BT);
            if PayModes.FindFirst() then PmtMode := PayModes.Code;
            BankCode := BankAcc."SWIFT Code";
            LocBankCode := '';
            BankBranch := '';
        end;
        if BankAcc."Swift Code" <> BankAcc2."SWIFT Code" then begin
            PayModes.Reset();
            PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::EFT);
            if PayModes.FindFirst() then PmtMode := PayModes.Code;
            BankCode := ' ';
            LocBankCode := BankAcc."Bank code2";
            BankBranch := BankAcc."Bank Branch No.";
        end;
        Payeeesc := DELCHR(BankAcc."Bank Account Name", '=', ' ');
        Payeeesc := uppercase(format(Payeeesc, 4));
        CustomerRef := 'P' + Payeeesc + Format(Today, 0, '<Day,2><Month,2><Year4>') + NoSeriesMgmt.GetNextNo(CashMgmt."EFT Payee Reference Nos", 0D, TRUE);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn(BankAcc2."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BankAcc."Bank Account Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustomerRef, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BankAcc."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BankCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LocBankCode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BankBranch, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(round(GrossAmt, 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Comment, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BankAcc."E-Mail", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(PmtMode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(HRSetup."Net pay POP Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure GetAmt(PayrollApprovalHeader: record "Payroll Approval"; BankCode: Code[20]): Decimal
    var
        Employees: Record Employee;
        PayApproval: record "Payroll Approval Lines";
        Banks: Record Banks;
        NetAmt: Decimal;
    begin
        NetAmt := 0;
        Employees.Reset();
        Employees.Setrange("Employee's Bank", BankCode);
        if Employees.find('-') then
            repeat
                PayApproval.Reset();
                PayApproval.SetRange("Document No.", PayrollApprovalHeader."No.");
                PayApproval.SetRange("Payee No", Employees."No.");
                if PayApproval.findfirst then NetAmt += PayApproval."Net Amount";
            until Employees.Next() = 0;
        exit(NetAmt);
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
