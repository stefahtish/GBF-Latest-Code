report 50113 "Generate EFT"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where("Employment type" = filter(<> trustee));
            RequestFilterFields = "Pay Period Filter";

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(BalanceArray_1_Number_; BalanceArray[1, Number])
                {
                }
                column(ArrEarnings_1_Number_; ArrEarnings[1, Number])
                {
                }
                column(ArrEarningsAmt_1_Number_; ArrEarningsAmt[1, Number])
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    Integer.SetRange(Number, 1, i);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CreateTextFile();
                // if PrintToExcel then
            end;

            trigger OnPostDataItem()
            begin
                // if PrintToExcel then
                // CreateExcelBook;
                //CreateTextFile;
            end;

            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number, 1, i);
                // MakeExcelDataHeader;
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
        // PrintToExcel := true;
    end;

    trigger OnPreReport()
    begin
        PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText := Format(PayrollMonth, 1, 4);
        if PayPeriodtext = '' then Error('Pay period must be specified for this report');
        CoRec.Get;
        CoName := CoRec.Name;
        Evaluate(DateSpecified, Format(PayPeriodtext));
        HRSetup.Get;
    end;
    // procedure CreateExcelBook()
    // begin
    //     ExcelBuffer.CreateBook(PaymentsManagement.GetEFTName, Format(Employee."No."));
    //     ExcelBuffer.WriteSheet(Format(Employee."No."),
    //       CompanyName,
    //       UserId);
    //     ExcelBuffer.CloseBook;
    //     ExcelBuffer.OpenExcel;
    //     //ExcelBuffer.GiveUserControl;
    //     Error('');
    // end;
    // procedure MakeExcelDataHeader()
    // begin
    //     ExcelBuffer.AddColumn(UpperCase('Netpay and Employer bank acc'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(UpperCase('Employee Dtls'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(UpperCase('Paying Bank Dtls'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(UpperCase('Net Pay'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
    //     //employer bank account no
    //     // ExcelBuffer.AddColumn(UpperCase('Employer Account No.'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(UpperCase('Sort Code'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // Employee bank account
    //     // ExcelBuffer.AddColumn(UpperCase('Employee Account No'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     //bank code
    //     // ExcelBuffer.AddColumn(UpperCase('Bank Code'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     //branch code
    //     // ExcelBuffer.AddColumn(UpperCase('Branch Code'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     //employee name
    //     ExcelBuffer.AddColumn(UpperCase('Employee Name'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(UpperCase('EFI Code'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    // end;
    // procedure MakeExcelDataBody()
    // begin
    //     //
    //     ExcelBuffer.NewRow;
    //     // ExcelBuffer.AddColumn(TransactionCode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(EFIValue1, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(EFIValue2, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(EFIValue3, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(NewnetPaytxt, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(CompanyInformation."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(Employee."Employee Bank Sort Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(Employee."Bank Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(Employee."Employee's Bank", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     // ExcelBuffer.AddColumn(Employee."Bank Branch", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(EmployeeName, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(EFICode, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    // end;
    procedure GetSortCode(No: Code[50]): Code[50]
    begin
        if Employee.Get(No) then exit(Employee."Employee Bank Sort Code");
    end;

    procedure CreateTextFile()
    var
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        FileName := 'EFT_File.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        Employee.Reset();
        Employee.SetRange("Employment Status", Employee."Employment Status"::Active);
        if Employee.Find('-') then begin
            repeat
                if Employee."Employee Bank Name" <> 'UKULIMA' then begin
                    BankName := '';
                    BankBranch := '';
                    CompanyInformation.Get();
                    if EmpBank.Get(Employee."Employee's Bank") then begin
                        BankName := EmpBank.Name;
                    end;
                    if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then;
                    BankBranch := EmpBankBranch."Branch Name";
                    // if (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest") = 0 then
                    //     CurrReport.Skip;
                    counter := counter + 1;
                    Clear(Addr);
                    Clear(DeptArr);
                    Clear(BasicPay);
                    Clear(EmpArray);
                    Clear(ArrEarnings);
                    Clear(ArrEarningsAmt);
                    Clear(BalanceArray);
                    Clear(ArrHeadings);
                    Clear(BalanceArrayAmt);
                    GrossPay := 0;
                    TotalDeduction := 0;
                    Totalcoopshares := 0;
                    Totalnssf := 0;
                    NetPay := 0;
                    i := 1;
                    j := 1;
                    // CalcFields("Total Allowances", "Total Deductions");
                    Employee.CalcFields("Total Allowances", "Total Deductions");
                    if Employee."Total Allowances" = 0 then CurrReport.Skip;
                    Addr[1] [1] := Employee."No.";
                    Addr[1] [2] := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    //MESSAGE(Addr[1][2]);
                    Addr[1] [3] := Employee."Date of Birth - Age";
                    Addr[1] [4] := Format(Employee."Birth Date");
                    Addr[1] [5] := Format(Employee."Salary Scale");
                    Addr[1] [6] := Format(Employee."Job Position Title");
                    // get Department Name
                    DimVal.Reset;
                    DimVal.SetRange(DimVal.Code, Employee."Global Dimension 2 Code");
                    if DimVal.Find('-') then DeptArr[1, 1] := DimVal.Name;
                    /*// Earnings
                    ArrEarnings[1,i]:='EARNINGS';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    i:=i+1;*/
                    //Get Basic Pay
                    Earn.Reset;
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                    Earn.SetRange(Earn."Non-Cash Benefit", false);
                    Earn.SetRange(Earn."Basic Salary Code", true);
                    if Earn.Find('-') then begin
                        repeat
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-') then begin
                                repeat
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                    GrossPay := GrossPay + AssignMatrix.Amount;
                                    i := i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    // Get Other Earnings
                    Earn.Reset;
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                    Earn.SetRange(Earn."Non-Cash Benefit", false);
                    Earn.SetRange(Earn."Basic Salary Code", false);
                    Earn.SetRange(Gratuity, false);
                    if Earn.Find('-') then begin
                        repeat
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-') then begin
                                repeat
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                    GrossPay := GrossPay + AssignMatrix.Amount;
                                    i := i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    // Gross Pay
                    ArrEarnings[1, i] := 'GROSS PAY';
                    j := j + 1;
                    ArrHeadings[i] := j;
                    i := i + 1;
                    ArrEarnings[1, i] := 'Gross Pay';
                    Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                    j := j + 1;
                    ArrHeadings[i] := j;
                    i := i + 1;
                    // taxations
                    ArrEarnings[1, i] := 'TAX CALCULATIONS';
                    j := j + 1;
                    ArrHeadings[i] := j;
                    /*
                    i:=i+1;

                    ArrEarnings[1,i]:=' ';
                    ArrEarningsAmt[1,i]:=' ';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    */
                    i := i + 1;
                    // Non Cash Benefits
                    Earn.Reset;
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                    Earn.SetRange(Earn."Non-Cash Benefit", true);
                    if Earn.Find('-') then begin
                        repeat
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-') then begin
                                repeat
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                    i := i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    // end of non cash
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                    AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SetRange(AssignMatrix.Paye, true);
                    if AssignMatrix.Find('-') then begin
                        ArrEarnings[1, i] := 'Pension contribution benefit';
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Less Pension Contribution")));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        TaxableAmt := 0;
                        PAYE := 0;
                        TaxableAmt := AssignMatrix."Taxable amount";
                        PAYE := AssignMatrix.Amount;
                    end;
                    i := i + 1;
                    // Taxable amount-KPC
                    ArrEarnings[1, i] := 'Taxable Pay';
                    if Employee."Secondary Employee" then
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(GrossPay)))
                    else
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(TaxableAmt)));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                    if PAYE > 0 then begin
                        i := i + 1;
                        ArrEarnings[1, i] := 'Tax Charged';
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(PAYE) + GetTaxRelief));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                    end;
                    i := i + 1;
                    // Relief
                    Earn.Reset;
                    Earn.SetFilter(Earn."Earning Type", '%1|%2|%3', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief", Earn."Earning Type"::"Owner Occupier");
                    if Earn.Find('-') then begin
                        repeat
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-') then begin
                                repeat
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                    i := i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    /*// Statutories
                    ArrEarnings[1,i]:='STATUTORIES';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    i:=i+1;

                    DeductsRec.RESET;
                    DeductsRec.SETRANGE(DeductsRec.Statutories,TRUE);
                    IF DeductsRec.FIND('-') THEN BEGIN
                      REPEAT
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                        AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Code,DeductsRec.Code);
                        IF AssignMatrix.FIND('-') THEN BEGIN
                          REPEAT
                            ArrEarnings[1,i]:=AssignMatrix.Description;
                            EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                            ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                            TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                            i:=i+1;
                          UNTIL AssignMatrix.NEXT=0;
                        END;
                      UNTIL DeductsRec.NEXT=0;
                    END;*/
                    // Deductions
                    ArrEarnings[1, i] := 'DEDUCTIONS';
                    j := j + 1;
                    ArrHeadings[i] := j;
                    i := i + 1;
                    DeductsRec.Reset;
                    //DeductsRec.SETRANGE(Statutories,FALSE);
                    if DeductsRec.Find('-') then begin
                        repeat //Loans
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetFilter(Type, '%1', AssignMatrix.Type::Deduction);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                            if AssignMatrix.Find('-') then begin
                                repeat
                                    LoanBalances.Reset;
                                    LoanBalances.SetRange("Loan No", AssignMatrix."Reference No");
                                    LoanBalances.SetRange("Deduction Code", AssignMatrix.Code);
                                    if LoanBalances.Find('-') then begin
                                        case LoanBalances."Interest Calculation Method" of
                                            LoanBalances."Interest Calculation Method"::"Reducing Balance", LoanBalances."Interest Calculation Method"::"Flat Rate", LoanBalances."Interest Calculation Method"::Amortised:
                                                begin
                                                    if Deduct.Get(AssignMatrix.Code) then
                                                        if Deduct."Show Balance" then begin
                                                            LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                                            LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                            BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                        end;
                                                    //For Each Loan Show the interest amount separately:
                                                    //Principal:
                                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                                    //Interest:
                                                    i := i + 1;
                                                    ArrEarnings[1, i] := AssignMatrix.Description + '-Interest';
                                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Loan Interest")));
                                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                                    BalanceArray[1, i] := 0;
                                                    //Don't show interest if it's zero
                                                    if AssignMatrix."Loan Interest" = 0 then i := i - 1;
                                                end;
                                            else begin
                                                if Deduct.Get(AssignMatrix.Code) then
                                                    if Deduct."Show Balance" then begin
                                                        LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                                        LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                        BalanceArray[1, i] := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                    end;
                                                //Show Principal only:
                                                ArrEarnings[1, i] := AssignMatrix.Description;
                                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                            end;
                                        end;
                                    end
                                    else begin
                                        ArrEarnings[1, i] := AssignMatrix.Description + ' ' + AssignMatrix."Insurance No";
                                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                    end;
                                    TotalDeduction := TotalDeduction + Abs(AssignMatrix.Amount) + Abs(AssignMatrix."Loan Interest");
                                    if Deduct.Get(AssignMatrix.Code) then begin
                                        if Deduct."Show Balance" then begin
                                            LoanBalances.Reset;
                                            LoanBalances.SetRange(LoanBalances."Loan No", AssignMatrix."Reference No");
                                            LoanBalances.SetRange(LoanBalances."Deduction Code", AssignMatrix.Code);
                                            if not LoanBalances.Find('-') then begin
                                                Deduct.SetRange(Deduct."Employee Filter", Employee."No.");
                                                if (Deduct."Start date" <> 0D) and (Deduct."Start date" <= DateSpecified) then
                                                    Deduct.SetRange(Deduct."Pay Period Filter", Deduct."Start date", DateSpecified)
                                                else
                                                    Deduct.SetRange(Deduct."Pay Period Filter", 0D, DateSpecified); //Share Top Up Added Below
                                                Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer", Deduct."Share Top Up");
                                                DeductionBalances.Reset;
                                                DeductionBalances.SetRange("Deduction Code", Deduct.Code);
                                                DeductionBalances.SetRange("Employee No", Employee."No.");
                                                if DeductionBalances.Find('-') then begin
                                                    case Deduct."Balance Type" of
                                                        Deduct."Balance Type"::Increasing:
                                                            begin
                                                                if Deduct."Exclude Employer Balance" then
                                                                    BalanceArray[1, i] := (DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Share Top Up"))
                                                                else
                                                                    BalanceArray[1, i] := (DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Total Amount Employer") + Abs(Deduct."Share Top Up"));
                                                            end;
                                                        Deduct."Balance Type"::Decreasing:
                                                            begin
                                                                if Deduct."Exclude Employer Balance" then
                                                                    BalanceArray[1, i] := DeductionBalances.Amount + Deduct."Total Amount" + Abs(Deduct."Share Top Up")
                                                                else
                                                                    BalanceArray[1, i] := DeductionBalances.Amount + Deduct."Total Amount" + Deduct."Total Amount Employer" + Abs(Deduct."Share Top Up");
                                                            end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    i := i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until DeductsRec.Next = 0;
                    end;
                    ArrEarnings[1, i] := 'TOTAL DEDUCTIONS';
                    Evaluate(ArrEarningsAmt[1, i], Format(TotalDeduction));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                    j := j + 1;
                    ArrHeadings[i] := j;
                    /*
                    i:=i+1;

                    ArrEarnings[1,i]:=' ';
                    ArrEarningsAmt[1,i]:=' ';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    */
                    i := i + 1;
                    // Net Pay
                    ArrEarnings[1, i] := 'NET PAY';
                    j := j + 1;
                    ArrHeadings[i] := j;
                    i := i + 1;
                    ArrEarnings[1, i] := 'Net Pay';
                    TotalDeduction := Round(TotalDeduction, 1);
                    GrossPay := Round(GrossPay, 1);
                    NetPay := PayrollRounding(GrossPay - TotalDeduction);
                    Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                    // NetPay := Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest";
                    //
                    NewnetPaytxt := DelChr(ArrEarningsAmt[1, i], '=', ',.');
                    NewnetPaytxt := PADSTR('', 7 - strlen(NewnetPaytxt), '0') + NewnetPaytxt;
                    // NewnetPaytxt := ArrEarningsAmt[1, i];
                    //
                    EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    TransactionCode := '00580000';
                    EFICode := '0000000000';
                    AmountDecimalVal := '0000';
                    EFIValue1 := TransactionCode + NewnetPaytxt + AmountDecimalVal + CompanyInformation."Bank Account No.";
                    EFIValue2 := Employee."Employee's Bank" + Employee."Bank Branch" + Employee."Bank Account Number";
                    EFIValue3 := CompanyInformation."Bank Name" + CompanyInformation."Bank Branch No.";
                    // add spaces
                    EFIValue1 := PadStr(EFIValue1, 39, ' ');
                    EFIValue2 := PadStr(EFIValue2, 25, ' ');
                    EFIValue3 := PadStr(EFIValue3, 20, ' ');
                    EmployeeName := PadStr(EmployeeName, 70, ' ');
                    //write text
                    OutStr.WriteText(EFIValue1);
                    OutStr.WriteText(EFIValue2);
                    OutStr.WriteText(EFIValue3);
                    OutStr.WriteText(EmployeeName);
                    OutStr.WriteText(EFICode);
                    OutStr.WriteText();
                end;
            until Employee.Next() = 0;
        end;
        TempBlob.CreateInStream(Instr, TextEncoding::Windows);
        DownloadFromStream(Instr, '', '', '', FileName);
    end;

    var
        CompanyInformation: Record "Company Information";
        PaymentRec: Record Payments;
        MyName: Text;
        Allowances: array[100] of Decimal;
        Deductions: array[100] of Decimal;
        EarnRec: Record EarningsX;
        DedRec: Record DeductionsX;
        Earncode: array[100] of Code[10];
        deductcode: array[100] of Code[10];
        EarnDesc: array[30] of Text[150];
        DedDesc: array[30] of Text[150];
        i: Integer;
        j: Integer;
        Assignmat: Record "Assignment Matrix-X";
        DateSpecified: Date;
        Totallowances: Decimal;
        TotalDeductions: Decimal;
        OtherEarn: Decimal;
        OtherDeduct: Decimal;
        counter: Integer;
        HRSetup: Record "Human Resources Setup";
        NetPay: Decimal;
        // Payroll: Codeunit Payroll;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text002: Label 'MASTER ROLL';
        Text001: Label 'BRAND KENYA BOARD';
        NoOfEarnings: Integer;
        NoOfDeductions: Integer;
        PG: Code[20];
        Dpt: Code[20];
        Emp: Code[20];
        AmountDecimalVal: Text;
        EmpBank: Record Banks;
        EmpBankBranch: Record "Bank Branches";
        EmpNo: Code[10];
        BankName: Text[100];
        BankBranch: Text[100];
        NET_PAY_TO_BANKCaptionLbl: Label 'NET PAY TO BANK';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ID_NumberCaptionLbl: Label 'ID Number';
        BankCaptionLbl: Label 'Bank';
        BranchCaptionLbl: Label 'Branch';
        Account_NumberCaptionLbl: Label 'Account Number';
        RoundPrecision: Decimal;
        RoundDirection: Text;
        TransactionCode: Text;
        EFICode: Text[50];
        Bank: Record Banks;
        BankBranches: Record "Bank Branches";
        EmployeeName: Text;
        NewnetPaytxt: Text;
        EFIValue1: Text;
        EFIValue2: Text;
        EFIValue3: Text;
        Addr: array[10, 100] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        TaxableAmt: Decimal;
        RightBracket: Boolean;
        PayPeriodRec: Record "Payroll PeriodX";
        PayDeduct: Record "Assignment Matrix-X";
        EmpRec: Record Employee;
        TaxableAmount: Decimal;
        PAYE: Decimal;
        ArrEarnings: array[3, 100] of Text[250];
        ArrDeductions: array[3, 100] of Text[250];
        Index: Integer;
        Index1: Integer;
        ArrEarningsAmt: array[3, 100] of Text[250];
        ArrDeductionsAmt: array[3, 100] of Decimal;
        Year: Integer;
        EmpArray: array[10, 15] of Decimal;
        HoldDate: Date;
        DenomArray: array[3, 12] of Text[50];
        NoOfUnitsArray: array[3, 12] of Integer;
        AmountArray: array[3, 12] of Decimal;
        PayModeArray: array[3] of Text[30];
        HoursArray: array[3, 60] of Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        TaxCode: Code[10];
        HoursBal: Decimal;
        Pay: Record EarningsX;
        Ded: Record DeductionsX;
        HoursArrayD: array[3, 60] of Decimal;
        CoName: Text[250];
        retirecontribution: Decimal;
        EarngingCount: Integer;
        DeductionCount: Integer;
        EarnAmount: Decimal;
        GrossTaxCharged: Decimal;
        DimVal: Record "Dimension Value";
        Department: Text[60];
        LowInterestBenefits: Decimal;
        SpacePos: Integer;
        NetPayLength: Integer;
        AmountText: Text[30];
        DecimalText: Text[30];
        DecimalAMT: Decimal;
        InsuranceRelief: Decimal;
        InsuranceReliefText: Text[30];
        //    PayrollCodeunit: Codeunit Payroll;
        IncometaxNew: Decimal;
        NewRelief: Decimal;
        TaxablePayNew: Decimal;
        InsuranceReliefNew: Decimal;
        TaxChargedNew: Decimal;
        finalTax: Decimal;
        TotalBenefits: Decimal;
        RetireCont: Decimal;
        TotalQuarters: Decimal;
        "Employee Payroll": Record Employee;
        PayMode: Text[30];
        Intex: Integer;
        NetPay1: Decimal;
        Principal: Decimal;
        Interest: Decimal;
        Desc: Text[50];
        RoundedNetPay: Decimal;
        diff: Decimal;
        CFWD: Decimal;
        Nssfcomptext: Text[30];
        Nssfcomp: Decimal;
        LoanDesc: Text[60];
        LoanDesc1: Text[60];
        Deduct: Record DeductionsX;
        OriginalLoan: Decimal;
        LoanBalance: Decimal;
        Message1: Text[250];
        Message2: array[3, 1] of Text[250];
        DeptArr: array[3, 1] of Text[60];
        BasicPay: array[3, 1] of Text[250];
        InsurEARN: Decimal;
        HasInsurance: Boolean;
        RoundedAmt: Decimal;
        TerminalDues: Decimal;
        Earn: Record EarningsX;
        AssignMatrix: Record "Assignment Matrix-X";
        RoundingDesc: Text[60];
        BasicChecker: Decimal;
        CoRec: Record "Company Information";
        GrossPay: Decimal;
        DeductionBalances: Record "Deduction Balances";
        TotalDeduction: Decimal;
        PayrollMonth: Date;
        PayrollMonthText: Text[30];
        //  GetPaye: Codeunit Payroll;
        PayeeTest: Decimal;
        //   GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        Totalcoopshares: Decimal;
        LoanBal: Decimal;
        LoanBalances: Record "Loan Application";
        TotalRepayment: Decimal;
        Totalnssf: Decimal;
        Totalpension: Decimal;
        Totalprovid: Decimal;
        BalanceArray: array[3, 100] of Decimal;
        PensionContribution: Decimal;
        ArrHeadings: array[100] of Integer;
        CompInfo: Record "Company Information";
        EarningsCaptionLbl: Label 'EARNINGS';
        Employee_No_CaptionLbl: Label 'Employee No:';
        Name_CaptionLbl: Label 'Name:';
        Dept_CaptionLbl: Label 'Department:';
        AmountCaptionLbl: Label 'AMOUNT';
        Pay_slipCaptionLbl: Label 'PAYSLIP';
        AssignMatrix2: Record "Assignment Matrix-X";
        BalanceArrayAmt: array[3, 100] of Decimal;
        DeductionEmployer: Integer;
        BPayCaptionLbl: Label 'BASIC SALARY';
        DeductsRec: Record DeductionsX;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
    end;

    procedure GetPayPeriod()
    begin
    end;

    procedure GetTaxBracket1(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
    end;

    procedure CoinageAnalysis(var NetPay: Decimal; var ColNo: Integer)
    var
        Index: Integer;
        Intex: Integer;
    begin
    end;

    procedure PayrollRounding(Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure ChckRound(var AmtText: Text[30]) ChckRound: Text[30]
    var
        LenthOfText: Integer;
        DecimalPos: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
        Decimalstrlen: Integer;
    begin
        LenthOfText := StrLen(AmtText);
        DecimalPos := StrPos(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec := AmtText;
            DecimalAmt := '.00';
        end
        else begin
            AmtWithoutDec := CopyStr(AmtText, 1, DecimalPos - 1);
            DecimalAmt := CopyStr(AmtText, DecimalPos + 1, 2);
            Decimalstrlen := StrLen(DecimalAmt);
            if Decimalstrlen < 2 then begin
                DecimalAmt := '.' + DecimalAmt + '0';
            end
            else
                DecimalAmt := '.' + DecimalAmt
        end;
        ChckRound := AmtWithoutDec + DecimalAmt;
    end;

    local procedure GetTaxRelief(): Decimal
    var
        EarningRec: Record EarningsX;
    begin
        EarningRec.Reset;
        EarningRec.SetRange("Earning Type", EarningRec."Earning Type"::"Tax Relief");
        EarningRec.SetFilter("Flat Amount", '<>%1', 0);
        if EarningRec.FindFirst then
            exit(EarningRec."Flat Amount")
        else
            exit(0);
    end;
}
