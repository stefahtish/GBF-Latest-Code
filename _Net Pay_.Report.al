report 50250 "Net Pay"
{
    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './NetPay.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Pay Period Filter", "No.", "Global Dimension 1 Code";

            column(Addr_1__1_; Addr[1] [1])
            {
            }
            column(Addr_1__2_; Addr[1] [2])
            {
            }
            column(Addr_1__3_; Addr[1] [3])
            {
            }
            column(Addr_1__4_; Addr[1] [4])
            {
            }
            column(DeptArr_1_1_; DeptArr[1, 1])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(CoRec_Picture; CompInfo.Picture)
            {
            }
            column(Message2_1_1_; Message2[1, 1])
            {
            }
            column(Message1; Message1)
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_; StrSubstNo('Date %1 %2', Today, Time))
            {
            }
            column(USERID; UserId)
            {
            }
            /*             column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        } */
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Dept_Caption; Dept_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Pay_slipCaption; Pay_slipCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(NetPay; NetPay)
            {
            }
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
            var
                TotalRelief: Decimal;
            begin
                Gratuity := 0;
                BankName := '';
                BankBranch := '';
                if EmpBank.Get(Employee."Employee's Bank") then begin
                    BankName := EmpBank.Name;
                end;
                //if not EmpBank."Cheque Payments" then
                //CurrReport.Skip();
                if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then;
                BankBranch := EmpBankBranch."Branch Name";
                BankName := '';
                BankBranch := '';
                CompanyInformation.Get();
                if EmpBank.Get(Employee."Employee's Bank") then begin
                    BankName := EmpBank.Name;
                end;
                if EmpBankBranch.Get(Employee."Employee's Bank", Employee."Bank Branch") then;
                BankBranch := EmpBankBranch."Branch Name";
                // relief
                // TotalRelief := 0;
                // Relief
                // Earn.Reset;
                // Earn.SetRange("Pay Period Filter", DateSpecified);
                // Earn.SetRange("Reduces Tax", true);
                // Earn.SetRange("Employee Filter", Employee."No.");
                // if Earn.FindFirst() then begin
                //     Earn.Calcfields("Total Amount");
                //     TotalRelief := Earn."Total Amount";
                // end;
                // Gratuity
                Earn.Reset;
                Earn.SetRange("Pay Period Filter", DateSpecified);
                Earn.SetRange(Gratuity, true);
                Earn.SetRange("Employee Filter", Employee."No.");
                if Earn.FindFirst() then begin
                    Gratuity := Earn."Total Amount";
                end;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", "Loan Interest", "Pension Contribution Benefit");
                if (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest") = 0 then CurrReport.Skip;
                counter := counter + 1;
                NetPay := Round(Abs(Employee."Total Allowances") - Abs(Employee."Total Deductions") + Abs(Employee."Loan Interest") - Abs(Gratuity), RoundPrecision, RoundDirection);
            end;
            // end;
            trigger OnPreDataItem()
            begin
                SetRange("Employment Status", Employee."Employment Status"::Active);
            end;
        }
    }
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

    procedure GetSortCode(No: Code[50]): Code[50]
    begin
        if Employee.Get(No) then exit(Employee."Employee Bank Sort Code");
    end;

    var
        PrintToExcel: Boolean;
        PaymentsManagement: Codeunit "Payments Management";
        CompanyInformation: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        PaymentRec: Record Payments;
        NewNetPay: Decimal;
        Gratuity: Decimal;
        EarnRec: Record EarningsX;
        DedRec: Record DeductionsX;
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
        Payroll: Codeunit Payroll;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text002: Label 'MASTER ROLL';
        Text001: Label 'BRAND KENYA BOARD';
        NoOfEarnings: Integer;
        NoOfDeductions: Integer;
        PG: Code[20];
        Dpt: Code[20];
        Emp: Code[20];
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
        PayrollCodeunit: Codeunit Payroll;
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
        GetPaye: Codeunit Payroll;
        PayeeTest: Decimal;
        GetGroup: Codeunit Payroll;
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
        EmployeeAcc: Code[80];
        AmountSum: Decimal;
        TimeToday: Time;
        PrintToday: Date;
        EmptyStringCaptionLbl: Label '**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************';

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

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
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
