report 50216 "Close Pay Period"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            DataItemTableView = WHERE("Employee Type" = FILTER(Permanent | Contract));
            RequestFilterFields = "Employee No";

            trigger OnPostDataItem()
            begin
                if PayperiodStart <> StartingDate then
                    Error(Error000)
                else begin
                    if PayPeriod.Get(StartingDate) then begin
                        PayPeriod."Close Pay" := true;
                        PayPeriod.Closed := true;
                        PayPeriod.CreateLeaveEntitlment(PayPeriod);
                        PayPeriod.Modify;
                        Message(Text000);
                    end;
                end;
                //Go Through Assignment Matrix for Loans and Validate Code
                NewPeriod := CalcDate('1M', PayperiodStart);
                Loan.Reset;
                if Loan.Find('-') then begin
                    repeat
                        AssMatrix.Reset;
                        AssMatrix.SetRange("Payroll Period", NewPeriod);
                        AssMatrix.SetRange(Code, Loan."Employee No");
                        if AssMatrix.Find('-') then begin
                            repeat
                                if EmpRec.Get("Assignment Matrix-X"."Employee No") then begin
                                    if (EmpRec.Status = EmpRec.Status::Inactive) then AssMatrix.Validate(Code);
                                    AssMatrix.Modify;
                                end;
                            until AssMatrix.Next = 0;
                        end;
                    until Loan.Next = 0;
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
    trigger OnPreReport()
    begin
        if not Confirm('Please backup up before closing current period! OK to Proceed?') then Error('The period has not been closed');
        PayrollRun.Run;
        Commit;
        DeducePayPeriod;
        ClosePeriodTrans;
        CreateNewEntries(PayperiodStart);
        UpdateSalaryPointers(PayperiodStart);
    end;

    var
        Proceed: Boolean;
        CurrentPeriodEnd: Date;
        DaysAdded: Code[10];
        PayPeriod: Record "Payroll PeriodX";
        StartingDate: Date;
        PayperiodStart: Date;
        LoansUpdate: Boolean;
        PayHistory: Record "Employee Account History";
        EmpRec: Record Employee;
        TaxableAmount: Decimal;
        RightBracket: Boolean;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        NetPay: Decimal;
        Loan: Record "Employee Earnings History";
        ReducedBal: Decimal;
        InterestAmt: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        relief: Decimal;
        Outstanding: Decimal;
        CreateRec: Boolean;
        benefits: Record EarningsX;
        deductions: Record DeductionsX;
        InterestDiff: Decimal;
        Rounding: Boolean;
        PD: Record "Assignment Matrix-X";
        Pay: Record EarningsX;
        Ded: Record DeductionsX;
        TaxCode: Code[10];
        CfAmount: Decimal;
        TempAmount: Decimal;
        EmpRec1: Record Employee;
        Emprec2: Record Employee;
        NewPeriod: Date;
        AssMatrix: Record "Assignment Matrix-X";
        PayrollRun: Report "Payroll Run1";
        Schedule: Record "Repayment Schedule";
        Window: Dialog;
        EmployeeName: Text[200];
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        LoanApplicationForm: Record "Loan Application";
        Discontinue: Boolean;
        LoanInterest: Decimal;
        Error000: Label 'Cannot Close this Pay period Without Closing the preceding ones';
        Text000: Label 'The period has been closed';

    procedure GetCurrentPeriod(var Payperiod: Record "Payroll PeriodX")
    begin
        CurrentPeriodEnd := Payperiod."Starting Date";
        StartingDate := CurrentPeriodEnd;
        CurrentPeriodEnd := CalcDate('1M', CurrentPeriodEnd - 1);
    end;

    procedure DeducePayPeriod()
    var
        PayPeriodRec: Record "Payroll PeriodX";
    begin
        PayPeriodRec.Reset;
        PayPeriodRec.SetRange(PayPeriodRec."Close Pay", false);
        if PayPeriodRec.FindFirst then PayperiodStart := PayPeriodRec."Starting Date";
    end;

    procedure ClosePeriodTrans()
    var
        EarnDeduct: Record "Assignment Matrix-X";
    begin
        EarnDeduct.Reset;
        EarnDeduct.SetFilter("Employee Type", '<>%1', EarnDeduct."Employee Type"::Trustee);
        EarnDeduct.SetRange(EarnDeduct."Payroll Period", PayperiodStart);
        if EarnDeduct.Find('-') then
            repeat
                EarnDeduct.Closed := true;
                EarnDeduct."Payroll Period" := PayperiodStart;
                EarnDeduct.Modify;
            until EarnDeduct.Next = 0;
    end;

    procedure CreateNewEntries(var CurrPeriodStat: Date)
    var
        PaymentDed: Record "Assignment Matrix-X";
        AssignMatrix: Record "Assignment Matrix-X";
        EmpEarnRec: Record "Employee Earnings History";
        Employees: Record Employee;
    begin
        /*This function creates new entries for the next Payroll period which are accessible and editable
       by the user of the Payroll. It should ideally create new entries if the EmpRec is ACTIVE*/
        NewPeriod := CalcDate('1M', PayperiodStart);
        Window.Open('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.Reset;
        PaymentDed.SetRange(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SetRange(PaymentDed."Next Period Entry", true);
        PaymentDed.SetFilter("Effective End Date", '%1|>=%2', 0D, NewPeriod);
        //PaymentDed.SETFILTER(PaymentDed.Amount, '<>%1',0);
        if PaymentDed.Find('-') then begin
            repeat
                Employees.Reset();
                Employees.SetRange("No.", PaymentDed."Employee No");
                Employees.SetFilter(Status, '=%1', Employees.Status::Active);
                if Employees.FindFirst() then begin
                    CreateRec := true;
                    AssignMatrix.Init;
                    "Assignment Matrix-X".SetFilter("Employee Type", '<>%1', "Assignment Matrix-X"."Employee Type"::Trustee);
                    AssignMatrix."Employee No" := PaymentDed."Employee No";
                    AssignMatrix.Type := PaymentDed.Type;
                    AssignMatrix.Code := PaymentDed.Code;
                    AssignMatrix."Department Code" := PaymentDed."Department Code";
                    AssignMatrix."Reference No" := PaymentDed."Reference No";
                    AssignMatrix.Gratuity := PaymentDed.Gratuity;
                    AssignMatrix.Retirement := PaymentDed.Retirement;
                    AssignMatrix."Effective Start Date" := PaymentDed."Effective Start Date";
                    AssignMatrix.Tenure := PaymentDed.Tenure;
                    AssignMatrix."Effective End Date" := PaymentDed."Effective End Date";
                    AssignMatrix."Payroll Period" := CalcDate('1M', PayperiodStart);
                    AssignMatrix.Validate("Payroll Period");
                    if PaymentDed."Loan Repay" then begin
                        ;
                        AssignMatrix.Amount := -CalculateRepaymentAmount(PaymentDed."Employee No", PaymentDed."Reference No", LoanInterest, PayperiodStart);
                        AssignMatrix."Loan Interest" := -LoanInterest;
                    end
                    else
                        AssignMatrix.Amount := PaymentDed.Amount;
                    if PaymentDed.Prorated then begin
                        AssignMatrix.Amount := EmpEarnRec.FetchFullAmt(PaymentDed);
                    end;
                    AssignMatrix."Loan Interest" := PaymentDed."Loan Interest";
                    AssignMatrix.Description := PaymentDed.Description;
                    AssignMatrix.Taxable := PaymentDed.Taxable;
                    AssignMatrix."Tax Deductible" := PaymentDed."Tax Deductible";
                    AssignMatrix.Frequency := PaymentDed.Frequency;
                    AssignMatrix."Pay Period" := PaymentDed."Pay Period";
                    AssignMatrix.Validate("Payroll Period");
                    AssignMatrix."Non-Cash Benefit" := PaymentDed."Non-Cash Benefit";
                    AssignMatrix.Quarters := PaymentDed.Quarters;
                    AssignMatrix."No. of Units" := PaymentDed."No. of Units";
                    AssignMatrix.Section := PaymentDed.Section;
                    AssignMatrix."Basic Pay" := PaymentDed."Basic Pay";
                    AssignMatrix."Salary Grade" := PaymentDed."Salary Grade";
                    AssignMatrix."Department Code" := PaymentDed."Department Code";
                    AssignMatrix."Employer Amount" := PaymentDed."Employer Amount";
                    AssignMatrix."Department Code" := PaymentDed."Department Code";
                    AssignMatrix."Next Period Entry" := PaymentDed."Next Period Entry";
                    AssignMatrix."Posting Group Filter" := PaymentDed."Posting Group Filter";
                    AssignMatrix."Loan Repay" := PaymentDed."Loan Repay";
                    AssignMatrix.DebitAcct := PaymentDed.DebitAcct;
                    AssignMatrix.CreditAcct := PaymentDed.CreditAcct;
                    AssignMatrix."Basic Salary Code" := PaymentDed."Basic Salary Code";
                    AssignMatrix."Normal Earnings" := PaymentDed."Normal Earnings";
                    AssignMatrix."Insurance No" := PaymentDed."Insurance No";
                    AssignMatrix."Tax Relief" := PaymentDed."Tax Relief";
                    AssignMatrix.Area := PaymentDed.Area;
                    AssignMatrix."Ext Insurance Amount" := PaymentDed."Ext Insurance Amount";
                    AssignMatrix."House Allowance Code" := PaymentDed."House Allowance Code";
                    AssignMatrix."Commuter Allowance Code" := PaymentDed."Commuter Allowance Code";
                    AssignMatrix."Salary Arrears Code" := PaymentDed."Salary Arrears Code";
                    AssignMatrix."Sacco Deduction" := PaymentDed."Sacco Deduction";
                    if PaymentDed."Department Code" = '' then begin
                        Emprec2.Reset;
                        if Emprec2.Get(PaymentDed."Employee No") then AssignMatrix."Department Code" := Emprec2."Global Dimension 1 Code";
                    end;
                    //END EMM
                    if EmpRec.Get(PaymentDed."Employee No") then begin
                        AssignMatrix."Payroll Group" := EmpRec."Posting Group";
                        Window.Update(1, EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name");
                        //MESSAGE('%1',EmpRec."Employee Job Type");
                        if (EmpRec.Status = EmpRec.Status::Active) and (CreateRec = true) and (AssignMatrix.Amount <> 0) and (EmpRec."Employee Job Type" = EmpRec."Employee Job Type"::"  ") then AssignMatrix.Insert;
                    end;
                end;
            until PaymentDed.Next = 0;
        end;
        //Manage loans
        PaymentDed.Reset;
        PaymentDed.SetRange(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SetRange(Type, PaymentDed.Type::Deduction);
        if PaymentDed.Find('-') then begin
            repeat
                Employees.Reset();
                Employees.SetRange("No.", PaymentDed."Employee No");
                Employees.SetFilter(Status, '=%1', Employees.Status::Active);
                if Employees.FindFirst() then begin
                    if LoanApplicationForm.Get(PaymentDed."Reference No") then //here
 begin
                        LoanApplicationForm.SetRange(LoanApplicationForm."Date filter", 0D, PayperiodStart);
                        LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment", Receipts);
                        if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment" - Abs(LoanApplicationForm.Receipts)) = 0 then begin
                            Message('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.Delete;
                        end
                        else begin
                            if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment" - Abs(LoanApplicationForm.Receipts)) < LoanApplicationForm.Repayment then begin
                                LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment", LoanApplicationForm.Receipts);
                                PaymentDed.Amount := -(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment" - Abs(LoanApplicationForm.Receipts));
                                PaymentDed."Next Period Entry" := false;
                                PaymentDed.Modify;
                            end;
                        end;
                    end;
                end;
            until PaymentDed.Next = 0;
        end;
    end;

    procedure Initialize()
    var
        InitEarnDeduct: Record "Assignment Matrix-X";
    begin
        InitEarnDeduct.SetRange(InitEarnDeduct.Closed, false);
        repeat
            InitEarnDeduct."Payroll Period" := PayperiodStart;
            InitEarnDeduct.Modify;
        until InitEarnDeduct.Next = 0;
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := Round(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if Round((TaxableAmount), 0.01) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        IncomeTax := -TotalTax;
    end;

    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Assignment Matrix-X";
        Payrollmonths: Record "Payroll PeriodX";
        allowances: Record EarningsX;
    begin
        PaymentDeduction.Init;
        PaymentDeduction."Employee No" := Employee;
        PaymentDeduction.Code := BenefitCode;
        PaymentDeduction.Type := PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period" := CalcDate('1M', PayperiodStart);
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode) then PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.Insert;
    end;

    procedure CoinageAnalysis(var NetPay: Decimal) NetPay1: Decimal
    var
        Index: Integer;
        Intex: Integer;
        AmountArray: array[15] of Decimal;
        NoOfUnitsArray: array[15] of Integer;
        MinAmount: Decimal;
    begin
    end;

    procedure UpdateSalaryPointers(var PayrollPeriod: Date)
    var
        Emp: Record Employee;
        RollingMonth: Integer;
    begin
        Emp.Reset;
        Emp.SetRange(Emp.Status, Emp.Status::Inactive);
        if Emp.Find('-') then begin
            repeat
                if Format(Date2DMY(NewPeriod, 2)) = Emp."Incremental Month" then begin
                    if IncStr(Emp.Present) < Emp.Halt then begin
                        //MESSAGE('%1 %2',INCSTR(Emp.Present),Emp.Halt);
                        Emp.Previous := Emp.Present;
                        Emp.Present := IncStr(Emp.Present);
                        Emp.Modify;
                    end;
                end;
            until Emp.Next = 0;
        end;
    end;

    procedure CalculateRepaymentAmount(var EmpNo: Code[20]; var LoanNo: Code[20]; var LoanInterest: Decimal; LastPayment: Date) Repayment: Decimal
    var
        LoanApplication: Record "Loan Application";
        RepaymentSchedule: Record "Repayment Schedule";
        RepaymentAmt: Decimal;
        Balance: Decimal;
        NonPayrollReceipts: Decimal;
    begin
        Repayment := 0;
        LoanInterest := 0;
        //Get the loan being repaid
        LoanApplication.Reset;
        LoanApplication.SetRange(LoanApplication."Loan No", LoanNo);
        LoanApplication.SetRange(LoanApplication."Employee No", EmpNo);
        LoanApplication.SetRange("Date filter", 0D, LastPayment);
        if LoanApplication.FindFirst then begin
            if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::"Reducing Balance" then begin
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - (LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);
                Repayment := LoanApplication.Repayment;
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                if Balance <= 0 then Repayment := 0;
                if Balance < Repayment then Repayment := Balance;
                exit(Repayment);
            end
            else begin
                /*
                RepaymentSchedule.RESET;
                RepaymentSchedule.SETRANGE(RepaymentSchedule."Loan No",LoanNo);
                RepaymentSchedule.SETRANGE(RepaymentSchedule."Employee No",EmpNo);
                RepaymentSchedule.SETRANGE("Repayment Date",CALCDATE('1M',PayperiodStart));
                 IF RepaymentSchedule.FINDFIRST THEN BEGIN
                    Repayment:=-RepaymentSchedule."Monthly Repayment";
                    Repayment:=PayrollRounding(Repayment);
                    EXIT(Repayment);
                 END;
                 */
                //Get Principal Repayment and subtract the interest on the balance
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - Abs(LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);
                //MESSAGE('bal%1',Balance);
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                if Balance < Repayment then
                    Repayment := Balance
                else
                    Repayment := LoanApplication.Repayment;
                if Balance <= 0 then Repayment := 0;
                if Balance < Repayment then Repayment := Balance;
                exit(Repayment);
            end;
        end;
    end;

    procedure CalculateRepaymentInterest(var EmpNo: Code[20]; var LoanNo: Code[20]; LastPayment: Date) LoanInterest: Decimal
    var
        LoanApplication: Record "Loan Application";
        RepaymentSchedule: Record "Repayment Schedule";
        RepaymentAmt: Decimal;
        Balance: Decimal;
        NonPayrollReceipts: Decimal;
    begin
        LoanInterest := 0;
        Balance := 0;
        //Get the loan being repaid
        LoanApplication.Reset;
        LoanApplication.SetRange(LoanApplication."Loan No", LoanNo);
        LoanApplication.SetRange(LoanApplication."Employee No", EmpNo);
        LoanApplication.SetRange("Date filter", 0D, LastPayment);
        if LoanApplication.FindFirst then begin
            if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::"Reducing Balance" then begin
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - (LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                exit(LoanInterest);
            end
            else begin
                //Get Principal Repayment and subtract the interest on the balance
                LoanApplication.CalcFields("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - Abs(LoanApplication."Total Repayment") - Abs(LoanApplication.Receipts);
                //MESSAGE('bal%1',Balance);
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance / 12);
                LoanInterest := PayrollRounding(LoanInterest);
                exit(LoanInterest);
            end;
        end;
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
}
