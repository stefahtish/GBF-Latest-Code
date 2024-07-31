report 50327 "Generate Employee Paye"
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
                    MakeExcelDataHeader();
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
        //eddieFileName := FileMgt.ServerTempFileName('xlsx');
        //eddie FileName2 := FileMgt.ServerTempFileName('csv');
        //FileName2 := '\Downloads' + '\' + 'PAYE ' + format(PayrollApprovalHeader."Payroll Period", 0, '<Month Text,3>') + ' ' + format(PayrollApprovalHeader."Payroll Period", 0, '<Year4>') + '.csv';
        //eddie ExcelBuffer.CreateBook(FileName, Format(PayrollApproval."No."));
        ExcelBuffer.WriteSheet(Format(PayrollApproval."No."), CompanyName, ' ');
        ExcelBuffer.CloseBook;
        ExcelBuffer.OpenExcel;
        ExcelBuffer.DeleteAll();
        Clear(ExcelBuffer);
        // Rename(FileName, FileName2);
        Error('');
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.AddColumn('PIN', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Employee Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Residential Status', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Type of Employee', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Basic salary', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Housing Allowance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transport Allowance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Leave Pay', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Over Time Allowance', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Director''s fee', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PLump Sum Payment', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Other Allowance', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Cash Pay (A)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value of Car Benefit (B)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Other Non Cash Benefits (C)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total on cash Pay (D) = (B + C)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Global Income (E)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Type of Housing', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rent of House/market Value', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Computed Rent of House (F)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Rent Recovered from Employee (G)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Net Value of Housing (H) = (F-G)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Gross Pay (I)  = (A + D + E + H)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('30% of Cash Pay (J) = (A)*30%', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Actual Contribution (K)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Permissible Limit (L)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Mortgage Interest (Max 25000 a Month)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Deposit on Home Owner Savings Plan (Max 96,000 KSh or 8,000)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount of Benefit (O) = (Lower of J,K,L + M or N whichever is higher', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Taxable Pay (P)  = (I - O)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Tax Payable (Q) = (P*)* Slab Rate', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Monthly Personal Relief (R)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount of Insurance Relief (S)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PAYE Tax (T) = (Q - R - S)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Self Assessed PAYE Tax', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(PayrollApprovalHeader: record "Payroll Approval")
    var
        Employees: Record Employee;
        PayApproval: record "Payroll Approval Lines";
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
        PayApproval.Reset();
        PayApproval.SetRange("Document No.", PayrollApprovalHeader."No.");
        PayApproval.setfilter("Net Amount", '>%1', 0);
        if PayApproval.find('-') then begin
            repeat
                Employees.Reset();
                Employees.SetRange("No.", PayApproval."Payee No");
                Employees.SetFilter("Pay Period Filter", format(PayrollApprovalHeader."Payroll Period"));
                if Employees.FindFirst() then begin
                    Employees.CalcFields("Taxable Allowance", "Cumm. PAYE", "Owner Occupier", "Relief Amount");
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumn(Employees."PIN Number", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Resident', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('Primary Employee', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(round(Employees."Taxable Allowance", 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('Benefit not given', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    //   ExcelBuffer.AddColumn(Round(Abs(Employees."Pension Amount"), 0.01, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);//Y
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //Z
                    if Employees."Owner Occupier" >= 25000 then
                        ExcelBuffer.AddColumn(25000, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number) //AA
                    else
                        ExcelBuffer.AddColumn(0, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //AA   
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //AB
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //AC
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //AD
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number); //AE
                    ExcelBuffer.AddColumn(Round(Abs(Employees."Relief Amount"), 0.01, '='), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number); //AF
                    //  ExcelBuffer.AddColumn(Round(Abs(Employees."Insurance Relief Amount"), 0.01, '='), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);//AG
                    ExcelBuffer.AddColumn(' ', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(Round(Abs(Employees."Cumm. PAYE"), 0.01, '>'), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                end;
            until PayApproval.Next = 0;
        end;
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
