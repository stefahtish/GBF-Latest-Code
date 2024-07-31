report 50438 "Payroll As Per Station"
{
    ApplicationArea = All;
    Caption = 'Payroll As Per Station';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Payroll As Per Station.rdl';

    dataset
    {
        dataitem("Dimension Values"; "Dimension Value")
        {
            DataItemTableView = where("Dimension Code"=filter('Branch'));

            column(Name_DimensionValues; Name)
            {
            }
            column(DimensionCode_DimensionValues; "Dimension Code")
            {
            }
            column(Code_DimensionValues; "Code")
            {
            }
            dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
            {
                RequestFilterFields = "Payroll Period";

                column(EmployeeNo_AssignmentMatrixX; "Employee No")
                {
                }
                column(Code_AssignmentMatrixX; "Code")
                {
                }
                column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format("Assignment Matrix-X"."Payroll Period", 0, '<month text> <year4>')))
                {
                }
                column(Time_Today; TimeToday)
                {
                }
                column(USERID; UserId)
                {
                }
                column(Print_Today; PrintToday)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TimeToday:=time;
                    PrintToday:=today;
                end;
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = WHERE(Status=CONST(Active));

                column(Employee__No__; "No.")
                {
                }
                column(First_Name_________Middle_Name_______Last_Name_; EmployeeName)
                {
                }
                column(BasicSalary; BasicSalary)
                {
                }
                column(Net_pay; Netpay)
                {
                }
                column(GlobalDimension1Code_Employee; "Global Dimension 1 Code")
                {
                }
                dataitem("Assignment Matrix-X Earn"; "Assignment Matrix-X")
                {
                    DataItemLink = "Employee No"=field("No.");
                    DataItemTableView = SORTING(Type, Code, "Payroll Period", "Reference No")WHERE(Type=CONST(Payment));

                    column(Code_AssignmentMatrixX__Earn; "Code")
                    {
                    }
                    column(Earnings_Description; Description)
                    {
                    }
                    column(Earnings_amnt; Amount)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    end;
                }
                dataitem("Assignment Matrix-X Deds"; "Assignment Matrix-X")
                {
                    DataItemLink = "Employee No"=field("No.");
                    DataItemTableView = SORTING(Type, Code, "Payroll Period", "Reference No")WHERE(Type=filter(deduction|loan));

                    column(Code_AssignmentMatrixX__Deds; "Code")
                    {
                    }
                    column(Deductions_Description; Description)
                    {
                    }
                    column(Deds_Amnt; Amount)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(Addr);
                    Clear(DeptArr);
                    Clear(BasicPay);
                    Clear(EmpArray);
                    Clear(ArrEarnings);
                    Clear(ArrEarningsAmt);
                    Clear(BalanceArray);
                    Clear(ArrHeadings);
                    Clear(BalanceArrayAmt);
                    GrossPay:=0;
                    TotalDeduction:=0;
                    Totalcoopshares:=0;
                    Totalnssf:=0;
                    NetPay:=0;
                    i:=1;
                    j:=1;
                    SumNetPay:=0;
                    // Error('%1', SumNetPay);
                    // CalcFields("Total Allowances", "Total Deductions");
                    Employee.CalcFields("Total Allowances", "Total Deductions");
                    if Employee."Total Allowances" = 0 then CurrReport.Skip;
                    Addr[1][1]:=Employee."No.";
                    Addr[1][2]:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    //MESSAGE(Addr[1][2]);
                    Addr[1][3]:=Employee."Date of Birth - Age";
                    Addr[1][4]:=Format(Employee."Birth Date");
                    Addr[1][5]:=Format(Employee."Salary Scale");
                    Addr[1][6]:=Format(Employee."Job Position Title");
                    // get Department Name
                    DimVal.Reset;
                    DimVal.SetRange(DimVal.Code, Employee."Global Dimension 2 Code");
                    if DimVal.Find('-')then DeptArr[1, 1]:=DimVal.Name;
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
                    if Earn.Find('-')then begin
                        repeat AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-')then begin
                                repeat ArrEarnings[1, i]:=AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                    GrossPay:=GrossPay + AssignMatrix.Amount;
                                    i:=i + 1;
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
                    if Earn.Find('-')then begin
                        repeat AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-')then begin
                                repeat ArrEarnings[1, i]:=AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                    GrossPay:=GrossPay + AssignMatrix.Amount;
                                    i:=i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    // Gross Pay
                    ArrEarnings[1, i]:='GROSS PAY';
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    i:=i + 1;
                    ArrEarnings[1, i]:='Gross Pay';
                    Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    i:=i + 1;
                    // taxations
                    ArrEarnings[1, i]:='TAX CALCULATIONS';
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    /*
                    i:=i+1;

                    ArrEarnings[1,i]:=' ';
                    ArrEarningsAmt[1,i]:=' ';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    */
                    i:=i + 1;
                    // Non Cash Benefits
                    Earn.Reset;
                    Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                    Earn.SetRange(Earn."Non-Cash Benefit", true);
                    if Earn.Find('-')then begin
                        repeat AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-')then begin
                                repeat ArrEarnings[1, i]:=AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                    i:=i + 1;
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
                    if AssignMatrix.Find('-')then begin
                        ArrEarnings[1, i]:='Pension contribution benefit';
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Less Pension Contribution")));
                        ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                        TaxableAmt:=0;
                        PAYE1:=0;
                        TaxableAmt:=AssignMatrix."Taxable amount";
                        PAYE1:=AssignMatrix.Amount;
                    end;
                    i:=i + 1;
                    // Taxable amount-KPC
                    ArrEarnings[1, i]:='Taxable Pay';
                    if Employee."Secondary Employee" then Evaluate(ArrEarningsAmt[1, i], Format(Abs(GrossPay)))
                    else
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(TaxableAmt)));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    if PAYE1 > 0 then begin
                        i:=i + 1;
                        ArrEarnings[1, i]:='Tax Charged';
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(PAYE1) + GetTaxRelief));
                        ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    end;
                    i:=i + 1;
                    // Relief
                    Earn.Reset;
                    Earn.SetFilter(Earn."Earning Type", '%1|%2|%3', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief", Earn."Earning Type"::"Owner Occupier");
                    if Earn.Find('-')then begin
                        repeat AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix."Basic Salary Code", false);
                            AssignMatrix.SetRange(Code, Earn.Code);
                            if AssignMatrix.Find('-')then begin
                                repeat ArrEarnings[1, i]:=AssignMatrix.Description;
                                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                    i:=i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until Earn.Next = 0;
                    end;
                    // Deductions
                    ArrEarnings[1, i]:='DEDUCTIONS';
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    i:=i + 1;
                    DeductsRec.Reset;
                    //DeductsRec.SETRANGE(Statutories,FALSE);
                    if DeductsRec.Find('-')then begin
                        repeat //Loans
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(AssignMatrix."Payroll Period", DateSpecified);
                            AssignMatrix.SetFilter(Type, '%1', AssignMatrix.Type::Deduction);
                            AssignMatrix.SetRange(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SetRange(AssignMatrix.Code, DeductsRec.Code);
                            if AssignMatrix.Find('-')then begin
                                repeat LoanBalances.Reset;
                                    LoanBalances.SetRange("Loan No", AssignMatrix."Reference No");
                                    LoanBalances.SetRange("Deduction Code", AssignMatrix.Code);
                                    if LoanBalances.Find('-')then begin
                                        case LoanBalances."Interest Calculation Method" of LoanBalances."Interest Calculation Method"::"Reducing Balance", LoanBalances."Interest Calculation Method"::"Flat Rate", LoanBalances."Interest Calculation Method"::Amortised: begin
                                            if Deduct.Get(AssignMatrix.Code)then if Deduct."Show Balance" then begin
                                                    LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                                    LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                    BalanceArray[1, i]:=(LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                end;
                                            //For Each Loan Show the interest amount separately:
                                            //Principal:
                                            ArrEarnings[1, i]:=AssignMatrix.Description;
                                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                            //Interest:
                                            i:=i + 1;
                                            ArrEarnings[1, i]:=AssignMatrix.Description + '-Interest';
                                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix."Loan Interest")));
                                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                            BalanceArray[1, i]:=0;
                                            //Don't show interest if it's zero
                                            if AssignMatrix."Loan Interest" = 0 then i:=i - 1;
                                        end;
                                        else
                                        begin
                                            if Deduct.Get(AssignMatrix.Code)then if Deduct."Show Balance" then begin
                                                    LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                                    LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                                    BalanceArray[1, i]:=(LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                                end;
                                            //Show Principal only:
                                            ArrEarnings[1, i]:=AssignMatrix.Description;
                                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                        end;
                                        end;
                                    end
                                    else
                                    begin
                                        ArrEarnings[1, i]:=AssignMatrix.Description + ' ' + AssignMatrix."Insurance No";
                                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(AssignMatrix.Amount)));
                                        ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                    end;
                                    TotalDeduction:=TotalDeduction + Abs(AssignMatrix.Amount) + Abs(AssignMatrix."Loan Interest");
                                    if Deduct.Get(AssignMatrix.Code)then begin
                                        if Deduct."Show Balance" then begin
                                            LoanBalances.Reset;
                                            LoanBalances.SetRange(LoanBalances."Loan No", AssignMatrix."Reference No");
                                            LoanBalances.SetRange(LoanBalances."Deduction Code", AssignMatrix.Code);
                                            if not LoanBalances.Find('-')then begin
                                                Deduct.SetRange(Deduct."Employee Filter", Employee."No.");
                                                if(Deduct."Start date" <> 0D) and (Deduct."Start date" <= DateSpecified)then Deduct.SetRange(Deduct."Pay Period Filter", Deduct."Start date", DateSpecified)
                                                else
                                                    Deduct.SetRange(Deduct."Pay Period Filter", 0D, DateSpecified); //Share Top Up Added Below
                                                Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer", Deduct."Share Top Up");
                                                DeductionBalances.Reset;
                                                DeductionBalances.SetRange("Deduction Code", Deduct.Code);
                                                DeductionBalances.SetRange("Employee No", Employee."No.");
                                                if DeductionBalances.Find('-')then begin
                                                    case Deduct."Balance Type" of Deduct."Balance Type"::Increasing: begin
                                                        if Deduct."Exclude Employer Balance" then BalanceArray[1, i]:=(DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Share Top Up"))
                                                        else
                                                            BalanceArray[1, i]:=(DeductionBalances.Amount + Abs(Deduct."Total Amount") + Abs(Deduct."Total Amount Employer") + Abs(Deduct."Share Top Up"));
                                                    end;
                                                    Deduct."Balance Type"::Decreasing: begin
                                                        if Deduct."Exclude Employer Balance" then BalanceArray[1, i]:=DeductionBalances.Amount + Deduct."Total Amount" + Abs(Deduct."Share Top Up")
                                                        else
                                                            BalanceArray[1, i]:=DeductionBalances.Amount + Deduct."Total Amount" + Deduct."Total Amount Employer" + Abs(Deduct."Share Top Up");
                                                    end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    i:=i + 1;
                                until AssignMatrix.Next = 0;
                            end;
                        until DeductsRec.Next = 0;
                    end;
                    ArrEarnings[1, i]:='TOTAL DEDUCTIONS';
                    Evaluate(ArrEarningsAmt[1, i], Format(TotalDeduction));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    /*
                    i:=i+1;

                    ArrEarnings[1,i]:=' ';
                    ArrEarningsAmt[1,i]:=' ';
                    j:=j+1;
                    ArrHeadings[i]:=j;
                    */
                    i:=i + 1;
                    // Net Pay
                    ArrEarnings[1, i]:='NET PAY';
                    j:=j + 1;
                    ArrHeadings[i]:=j;
                    i:=i + 1;
                    ArrEarnings[1, i]:='Net Pay';
                    NetPay:=round(GrossPay - TotalDeduction, 0.5, '=');
                    Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                    EmployeeName:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    TimeToday:=Time;
                    PrintToday:=Today;
                end;
            }
        }
    }
    trigger OnPreReport()
    begin
        // PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        PayPeriodtext:="Assignment Matrix-X".GetFilter("Payroll Period");
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText:=Format(PayrollMonth, 1, 4);
        if PayPeriodtext = '' then Error('Pay period must be specified for this report');
        Evaluate(DateSpecified, Format(PayPeriodtext));
        TimeToday:=Time;
        PrintToday:=Today;
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
        if ApprovalEntries.Find('-')then begin
            repeat if ApprovalEntries."Sequence No." = 1 then begin
                    Approver[1]:=ApprovalEntries."Sender ID";
                    ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
                    if UserSetup.Get(Approver[1])then UserSetup.CalcFields(Signature);
                    Approver[2]:=ApprovalEntries."Last Modified By User ID";
                    ApproverDate[2]:=ApprovalEntries."Last Date-Time Modified";
                    if UserSetup1.Get(Approver[2])then UserSetup1.CalcFields(Signature);
                end;
                if ApprovalEntries."Sequence No." = 2 then begin
                    Approver[3]:=ApprovalEntries."Last Modified By User ID";
                    ApproverDate[3]:=ApprovalEntries."Last Date-Time Modified";
                    if UserSetup2.Get(Approver[3])then UserSetup2.CalcFields(Signature);
                end;
                if ApprovalEntries."Sequence No." = 3 then begin
                    Approver[4]:=ApprovalEntries."Last Modified By User ID";
                    ApproverDate[4]:=ApprovalEntries."Last Date-Time Modified";
                    if UserSetup3.Get(Approver[4])then UserSetup3.CalcFields(Signature);
                end;
            until ApprovalEntries.Next = 0;
        end;
    end;
    var CompanyInformation: Record "Company Information";
    PaymentRec: Record Payments;
    NewNetPay: Decimal;
    Earnings_Description: Text;
    Earnings_Amnt: Decimal;
    SumNetPay: Decimal;
    Deds_Description: Text;
    Deds_amnt: Decimal;
    Allowances: array[100]of Decimal;
    Deductions: array[100]of Decimal;
    EarnRec: Record EarningsX;
    Earn2: Record EarningsX;
    DedRec: Record DeductionsX;
    Earncode: array[100]of Code[10];
    deductcode: array[100]of Code[10];
    EarnDesc: array[30]of Text[150];
    DedDesc: array[30]of Text[150];
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
    Addr: array[10, 100]of Text[250];
    NonCash: Decimal;
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
    PAYE1: Decimal;
    ArrEarnings: array[3, 100]of Text[250];
    ArrDeductions: array[3, 100]of Text[250];
    Index: Integer;
    Index1: Integer;
    ArrEarningsAmt: array[3, 100]of Text[250];
    ArrDeductionsAmt: array[3, 100]of Decimal;
    Year: Integer;
    EmpArray: array[10, 15]of Decimal;
    HoldDate: Date;
    DenomArray: array[3, 12]of Text[50];
    NoOfUnitsArray: array[3, 12]of Integer;
    AmountArray: array[3, 12]of Decimal;
    PayModeArray: array[3]of Text[30];
    HoursArray: array[3, 60]of Decimal;
    CompRec: Record "Human Resources Setup";
    HseLimit: Decimal;
    ExcessRetirement: Decimal;
    CfMpr: Decimal;
    relief: Decimal;
    TaxCode: Code[10];
    HoursBal: Decimal;
    Pay: Record EarningsX;
    Ded: Record DeductionsX;
    HoursArrayD: array[3, 60]of Decimal;
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
    Message2: array[3, 1]of Text[250];
    DeptArr: array[3, 1]of Text[60];
    BasicPay: array[3, 1]of Text[250];
    ApprovalEntries: Record "Approval Entry";
    Approver: array[10]of Code[50];
    ApproverDate: array[10]of DateTime;
    UserSetup: Record "User Setup";
    UserSetup1: Record "User Setup";
    UserSetup2: Record "User Setup";
    UserSetup3: Record "User Setup";
    BasicSalary: Decimal;
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
    BalanceArray: array[3, 100]of Decimal;
    PensionContribution: Decimal;
    ArrHeadings: array[100]of Integer;
    CompInfo: Record "Company Information";
    EarningsCaptionLbl: Label 'EARNINGS';
    Employee_No_CaptionLbl: Label 'Employee No:';
    Name_CaptionLbl: Label 'Name:';
    Dept_CaptionLbl: Label 'Department:';
    AmountCaptionLbl: Label 'AMOUNT';
    Pay_slipCaptionLbl: Label 'PAYSLIP';
    AssignMatrix2: Record "Assignment Matrix-X";
    BalanceArrayAmt: array[3, 100]of Decimal;
    DeductionEmployer: Integer;
    BPayCaptionLbl: Label 'BASIC SALARY';
    DeductsRec: Record DeductionsX;
    EmployeeAcc: Code[80];
    AmountSum: Decimal;
    TimeToday: Time;
    PrintToday: Date;
    procedure ChckRound(var AmtText: Text[30])ChckRound: Text[30]var
        LenthOfText: Integer;
        DecimalPos: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
        Decimalstrlen: Integer;
    begin
        LenthOfText:=StrLen(AmtText);
        DecimalPos:=StrPos(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec:=AmtText;
            DecimalAmt:='.00';
        end
        else
        begin
            AmtWithoutDec:=CopyStr(AmtText, 1, DecimalPos - 1);
            DecimalAmt:=CopyStr(AmtText, DecimalPos + 1, 2);
            Decimalstrlen:=StrLen(DecimalAmt);
            if Decimalstrlen < 2 then begin
                DecimalAmt:='.' + DecimalAmt + '0';
            end
            else
                DecimalAmt:='.' + DecimalAmt end;
        ChckRound:=AmtWithoutDec + DecimalAmt;
    end;
    local procedure GetTaxRelief(): Decimal var
        EarningRec: Record EarningsX;
    begin
        EarningRec.Reset;
        EarningRec.SetRange("Earning Type", EarningRec."Earning Type"::"Tax Relief");
        EarningRec.SetFilter("Flat Amount", '<>%1', 0);
        if EarningRec.FindFirst then exit(EarningRec."Flat Amount")
        else
            exit(0);
    end;
}
