report 50324 "Generate Employee Files"
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
                    MakeExcelDataBody(PayrollApproval);
                    CreateExcelBook(HRSetup."EFT Document Path", PayrollApproval);
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

    procedure CreateExcelBook(DocPath: text; PayrollApprovalHeader: record "Payroll Approval")
    var
        FileName: text;
        FileName2: Text;
        PVs: Record Payments;
        PVNo: code[20];
    begin
        PVs.Reset();
        PVs.SetRange("Payment Type", PVs."Payment Type"::"Payment Voucher");
        PVs.SetRange("Net Pay", true);
        PVs.SetRange("Payroll Period", PayrollApprovalHeader."Payroll Period");
        if PVs.FIndlast() then begin
            PVNo := PVs."No.";
        end;
        if PayrollApprovalHeader.Preview = false then begin
            CashMgmt.Get();
            //CreateDateTime(Today, Time);
            DateTime1 := 'PAY_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>');
            // DocPath := '';
            FileName := DocPath + DateTime1 + '.xlsx';
            FileName2 := DocPath + DateTime1 + '.xls';
            //eddie  ExcelBuffer.CreateBook(FileName, Format('NetPay'));
            ExcelBuffer.WriteSheet('NetPay', CompanyName, '');
            ExcelBuffer.CloseBook;
            ExcelBuffer.DeleteAll();
            Clear(ExcelBuffer);
            //eddieRename(FileName, FileName2);
        end;
        if PayrollApprovalHeader.Preview = true then begin
            //eddieExcelBuffer.CreateBook('', Format(PayrollApproval."No."));
            ExcelBuffer.WriteSheet(Format(PayrollApproval."No."), CompanyName, UserId);
            ExcelBuffer.CloseBook;
            ExcelBuffer.OpenExcel;
            //ExcelBuffer.GiveUserControl;
            Error('');
        end;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('POP', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Employee Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Account Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Payment type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Email address', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Reference', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Debit Account No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bank Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Local Bank Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Branch Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(PayrollApprovalHeader: record "Payroll Approval")
    var
        Employees: Record Employee;
        PayrollApprovalLines: record "Payroll Approval Lines";
        Banks: Record Banks;
        Comment: Text[100];
        BankAcc: Record "Bank Account";
        Amt: Decimal;
        HRSetup: Record "Human Resources Setup";
        BankCode: Text[20];
        BankBranch: Text[20];
        PmtMode: Text[20];
        LocBankCode: Text[20];
        PayModes: Record "Payment Method";
        Branches: record "Bank Branches";
        Payeeesc: Code[100];
        CustomerRef: Code[100];
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        PVs: Record Payments;
        PVNo: Code[20];
        Bankref: record "Payroll Approval Bank Ref";
        EndLoop: Boolean;
        Deductions: Record DeductionsX;
        Deductions2: Record DeductionsX;
        vendor: Record Vendor;
        VendorAmt: Decimal;
    begin
        CashMgmt.Get();
        CashMgmt.TestField("EFT Payee Reference Nos");
        HRSetup.get;
        HRSetup.TestField("Default Bank");
        HRSetup.TestField("Net pay POP Code");
        HRSetup.TestField("Pay Mode");
        if BankAcc.get(HRSetup."Default Bank") then;
        BankAcc.TestField("SWIFT Code");
        Comment := format(PayrollApprovalHeader."Payroll Period", 0, '<Month Text,3>') + ' ' + format(PayrollApprovalHeader."Payroll Period", 0, '<Year4>') + ' PAYROLL';
        PayrollApprovalLines.Reset();
        PayrollApprovalLines.SetRange("Document No.", PayrollApprovalHeader."No.");
        PayrollApprovalLines.setrange(Paid, false);
        PayrollApprovalLines.setfilter("Net Amount", '>%1', 0);
        if PayrollApprovalLines.find('-') then begin
            repeat
                EndLoop := false;
                Employees.Reset();
                Employees.SetRange("No.", PayrollApprovalLines."Payee No");
                if Employees.FindFirst() then begin
                    Payeeesc := DELCHR(Employees."Employee Bank Name", '=', ' ');
                    Payeeesc := uppercase(format(Payeeesc, 4));
                    CustomerRef := 'P' + Payeeesc + Format(Today, 0, '<Day,2><Month,2><Year4>') + NoSeriesMgmt.GetNextNo(CashMgmt."EFT Payee Reference Nos", 0D, TRUE);
                    Employees.testfield("Employee's Bank");
                    Employees.testfield("Bank Branch");
                    Employees.TestField("Bank Account Number");
                    Employees.TestField("Employee Bank Name");
                    Banks.Reset();
                    Banks.SetRange(Code, Employees."Employee's Bank");
                    if Banks.FindFirst() then begin
                        if Banks."Non-bank" = false then begin
                            if Banks."Swift Code" = BankAcc."SWIFT Code" then begin
                                PayModes.Reset();
                                PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::BT);
                                if PayModes.FindFirst() then PmtMode := PayModes.Code;
                                BankCode := BankAcc."SWIFT Code";
                                LocBankCode := '';
                                BankBranch := '';
                            end;
                            if Banks."Swift Code" <> BankAcc."SWIFT Code" then begin
                                PmtMode := HRSetup."Pay Mode";
                                PayModes.Reset();
                                PayModes.SetRange(Code, PmtMode);
                                PayModes.SetFilter("Bal. Account Type", '=%1|%2', PayModes."Bal. Account Type"::RTGS, PayModes."Bal. Account Type"::BT);
                                if PayModes.FindFirst() then begin
                                    BankCode := Banks."SWIFT Code";
                                    LocBankCode := '';
                                    BankBranch := '';
                                end
                                else begin
                                    BankCode := ' ';
                                    LocBankCode := Banks."Bank Code";
                                    BankBranch := Banks."Bank Branch Code";
                                end;
                            end;
                        end;
                        //check if pay directly
                        if Banks."Non-bank" = true then begin
                            Bankref.reset;
                            Bankref.SetRange(Bank, Banks.Code);
                            Bankref.SetRange("Document No.", PayrollApprovalHeader."No.");
                            Bankref.setrange("Pay Directly", true);
                            if Bankref.FindFirst() then begin
                                PmtMode := HRSetup."Pay Mode";
                                PayModes.Reset();
                                PayModes.SetRange(Code, PmtMode);
                                PayModes.SetFilter("Bal. Account Type", '=%1|%2', PayModes."Bal. Account Type"::RTGS, PayModes."Bal. Account Type"::BT);
                                if PayModes.FindFirst() then begin
                                    BankCode := Banks."SWIFT Code";
                                    LocBankCode := '';
                                    BankBranch := '';
                                end
                                else begin
                                    BankCode := ' ';
                                    LocBankCode := Banks."Bank Code";
                                    BankBranch := Banks."Bank Branch Code";
                                end;
                            end
                            else
                                EndLoop := true;
                        end;
                        if EndLoop = false then begin
                            ExcelBuffer.NewRow;
                            ExcelBuffer.AddColumn(round(PayrollApprovalLines."Net Amount", 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(HRSetup."Net pay POP Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Employees."First Name" + '' + Employees."Middle Name" + '' + Employees."Last Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Employees."Bank Account Number", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Employees."Employee Bank Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(PmtMode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(Employees."Company E-Mail", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(CustomerRef, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BankAcc."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BankCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(LocBankCode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BankBranch, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Comment, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        end;
                    end;
                end;
            until PayrollApprovalLines.Next = 0;
            Banks.Reset();
            Banks.SetRange("Non-bank", true);
            if Banks.Find('-') then
                repeat
                    Banks.TestField("Swift Code");
                    Amt := GetAmt(PayrollApprovalHeader, Banks.Code);
                    Bankref.reset;
                    Bankref.SetRange(Bank, Banks.Code);
                    Bankref.SetRange("Document No.", PayrollApprovalHeader."No.");
                    Bankref.SetRange("Document No.", PayrollApprovalHeader."No.");
                    Bankref.setrange("Pay Directly", false);
                    if Bankref.FindFirst() then begin
                        if Bankref.Reference <> '' then
                            CustomerRef := Bankref.Reference
                        else begin
                            Payeeesc := DELCHR(Employees."Employee Bank Name", '=', ' ');
                            Payeeesc := uppercase(format(Payeeesc, 4));
                            CustomerRef := 'P' + Payeeesc + Format(Today, 0, '<Day,2><Month,2><Year4>') + NoSeriesMgmt.GetNextNo(CashMgmt."EFT Payee Reference Nos", 0D, TRUE);
                        end;
                        // if Banks."Swift Code" = BankAcc."SWIFT Code" then begin
                        //     PayModes.Reset();
                        //     PayModes.SetRange("Bal. Account Type", PayModes."Bal. Account Type"::BT);
                        //     if PayModes.FindFirst() then
                        //         PmtMode := PayModes.Code;
                        //     BankCode := BankAcc."SWIFT Code";
                        //     LocBankCode := '';
                        //     BankBranch := '';
                        // end else begin
                        PmtMode := HRSetup."Pay Mode";
                        PayModes.Reset();
                        PayModes.SetRange(Code, PmtMode);
                        PayModes.SetFilter("Bal. Account Type", '=%1|%2', PayModes."Bal. Account Type"::RTGS, PayModes."Bal. Account Type"::BT);
                        if PayModes.FindFirst() then begin
                            BankCode := Banks."SWIFT Code";
                            LocBankCode := '';
                            BankBranch := '';
                        end
                        else begin
                            BankCode := ' ';
                            LocBankCode := Banks."Bank Code";
                            BankBranch := Banks."Bank Branch Code";
                        end;
                        //end;
                        if Amt > 0 then begin
                            ExcelBuffer.NewRow;
                            ExcelBuffer.AddColumn(BankAcc."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Banks."Bank Account Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(CustomerRef, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Banks."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BankCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(LocBankCode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BankBranch, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(round(Amt, 0.05, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(Comment, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Banks."E-Mail", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(PmtMode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(HRSetup."Net pay POP Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        end;
                    end;
                until Banks.Next() = 0;
        end;
    end;

    procedure GetAmt(PayrollApprovalHeader: record "Payroll Approval"; BankCode: Code[20]): Decimal
    var
        Employees: Record Employee;
        PayrollApprovalLines: record "Payroll Approval Lines";
        Banks: Record Banks;
        NetAmt: Decimal;
    begin
        NetAmt := 0;
        Employees.Reset();
        Employees.Setrange("Employee's Bank", BankCode);
        if Employees.find('-') then
            repeat
                PayrollApprovalLines.Reset();
                PayrollApprovalLines.SetRange("Document No.", PayrollApprovalHeader."No.");
                PayrollApprovalLines.SetRange("Payee No", Employees."No.");
                if PayrollApprovalLines.findfirst then NetAmt += PayrollApprovalLines."Net Amount";
            until Employees.Next() = 0;
        exit(NetAmt);
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
