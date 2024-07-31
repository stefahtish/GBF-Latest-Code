report 50215 "Payroll Run"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Nature of Employment", "Pay Period Filter";

            trigger OnAfterGetRecord()
            var
                LeaveStartDate: Date;
                LeaveEndDate: Date;
                EmploymentDate: Date;
                EmpRequest: Record "Employee Pay Requests";
                PayPeriod: Record "Payroll PeriodX";
            begin
                Percentage := (Round(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                //SLEEP(200);
                Window.Update(1, Percentage);
                Window.Update(2, (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));
                //Auto Assign Defaults if None are Assigned
                if Employee."Employment Type" <> Employee."Employment Type"::Partime then begin
                    if Employee.Status = Employee.Status::Active then begin
                        EmployeeRec.Copy(Employee);
                        EmployeeRec.SetRange(Status, Employee.Status::Active);
                        EmployeeRec.SetRange("Pay Period Filter", Month);
                        EmployeeRec.CalcFields("Total Allowances", "Total Deductions", "Insurance Premium", "Loan Interest");
                    end;
                    //Delete Entries of Employees not Active
                    if Employee.Status <> Employee.Status::Active then begin
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        AssignMatrix.DeleteAll;
                    end;
                    //Non Casual Employees...................................................................................................................................
                    //Prorate Earnings
                    if Employee."Date Of Join" <> 0D then begin
                        if ((Date2DMY(Employee."Date Of Join", 2)) = (Date2DMY(Month, 2))) and ((Date2DMY(Employee."Date Of Join", 3)) = (Date2DMY(Month, 3))) then begin
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange("Non-Cash Benefit", false);
                            if AssignMatrix.Find('-') then
                                repeat
                                    if Earnings.Get(AssignMatrix.Code) then;
                                    if Earnings.Prorate then begin
                                        if not AssignMatrix.Prorated then EmployeeEarnRec.UpdateEntries(AssignMatrix);
                                        AssignMatrix.Amount := ((CalcDate('1M', Month)) - Employee."Date Of Join") / ((CalcDate('1M', Month)) - Month) * EmployeeEarnRec.FetchFullAmt(AssignMatrix);
                                        /*//MESSAGE(FORMAT(Month));
                                        MESSAGE(FORMAT(((CALCDATE('1M',Month))-Employee."Date Of Join")));
                                        //MESSAGE(FORMAT(CALCDATE('1M',Month)));
                                        //MESSAGE(FORMAT(Employee."Date Of Join"));
                                        MESSAGE(FORMAT((CALCDATE('1M',Month))-Month));
                                        MESSAGE(FORMAT(EmployeeEarnRec.FetchFullAmt(AssignMatrix)));*/
                                        AssignMatrix.Prorated := true;
                                        AssignMatrix.Modify;
                                    end;
                                until AssignMatrix.Next = 0;
                        end;
                    end;
                    Deductions.Reset;
                    Deductions.SetRange("PAYE Code", true);
                    if Deductions.Find('-') then begin
                        GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);
                        //Create PAYE
                        //Update Tax Relief
                        if (IncomeTax > 0) and (Employee."Employee Job Type" <> Employee."Employee Job Type"::Director) then begin
                            Earnings.Reset;
                            Earnings.SetCurrentKey("Earning Type");
                            Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                            if Earnings.Find('-') then begin
                                repeat
                                    AssignMatrix.Reset;
                                    AssignMatrix.SetRange("Payroll Period", Month);
                                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                                    AssignMatrix.SetRange(Code, Earnings.Code);
                                    AssignMatrix.SetRange("Employee No", Employee."No.");
                                    if not AssignMatrix.Find('-') then begin
                                        AssignMatrix.Init;
                                        AssignMatrix."Employee No" := Employee."No.";
                                        AssignMatrix.Type := AssignMatrix.Type::Payment;
                                        AssignMatrix.Code := Earnings.Code;
                                        AssignMatrix."Reference No" := '';
                                        AssignMatrix.Validate(Code);
                                        AssignMatrix."Payroll Period" := Month;
                                        AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                        if AssignMatrix.Amount <> 0 then AssignMatrix.Insert;
                                    end
                                    else begin
                                        AssignMatrix.Reset;
                                        AssignMatrix.SetRange("Payroll Period", Month);
                                        AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                                        AssignMatrix.SetRange(Code, Earnings.Code);
                                        AssignMatrix.SetRange("Employee No", Employee."No.");
                                        if AssignMatrix.Find('-') then begin
                                            AssignMatrix.Validate(Code);
                                            AssignMatrix.Modify;
                                        end;
                                    end;
                                until Earnings.Next = 0;
                            end
                            else begin
                                Earnings.Reset;
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Tax Relief");
                                if Earnings.Find('-') then begin
                                end;
                            end;
                            //Recompute Tax after Adding Tax Relief
                            GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);
                        end;
                        //Create PAYE
                        AssignMatrix.Init;
                        AssignMatrix."Employee No" := Employee."No.";
                        AssignMatrix.Validate("Employee No");
                        AssignMatrix.Type := AssignMatrix.Type::Deduction;
                        AssignMatrix.Code := Deductions.Code;
                        AssignMatrix.Validate(Code);
                        AssignMatrix."Reference No" := '';
                        AssignMatrix."Payroll Period" := Month;
                        AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                        if IncomeTax > 0 then IncomeTax := -IncomeTax;
                        AssignMatrix.Amount := IncomeTax;
                        AssignMatrix.Paye := true;
                        AssignMatrix."Taxable amount" := TaxableAmount;
                        AssignMatrix."Less Pension Contribution" := RetireCont;
                        AssignMatrix.Paye := true;
                        AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                        AssignMatrix.Validate(Amount);
                        if AssignMatrix.Amount <> 0 then AssignMatrix.Insert;
                    end
                    else
                        Error(Text001);
                    //Update Bank Account History
                    EmployeeAccHistory.UpdateAccountDetails(Employee, Month);
                    //Update Pay Mode, Company, Department, Posting Group
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange("Employee No", Employee."No.");
                    AssignMatrix.SetRange("Payroll Period", Month);
                    if AssignMatrix.Find('-') then
                        repeat
                            AssignMatrix."Pay Mode" := Employee."Pay Mode";
                            AssignMatrix."Payroll Group" := Employee.Company;
                            AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                            AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                            AssignMatrix."Salary Grade" := Employee."Salary Scale";
                            AssignMatrix.Modify;
                        until AssignMatrix.Next = 0;
                    //Casual Workers
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
            end;

            trigger OnPreDataItem()
            begin
                Window.Open(Text000 + Text002);
                TotalCount := Count;
                PayPeriod.SetRange(Closed, false);
                if PayPeriod.Find('-') then begin
                    Month := PayPeriod."Starting Date";
                    LastMonth := CalcDate('-1M', Month);
                    if PayPeriod."Leave Payment Period" then PayLeave := true;
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
    var
        AssignMatrix: Record "Assignment Matrix-X";
        BeginDate: Date;
        DateSpecified: Date;
        BasicSalary: Decimal;
        TaxableAmount: Decimal;
        HRSetup: Record "Human Resources Setup";
        HseLimit: Decimal;
        TaxCode: Code[10];
        retirecontribution: Decimal;
        ExcessRetirement: Decimal;
        GrossPay: Decimal;
        TotalBenefits: Decimal;
        TaxablePay: Decimal;
        RetireCont: Decimal;
        TotalQuarters: Decimal;
        IncomeTax: Decimal;
        relief: Decimal;
        EmployeeRec: Record Employee;
        NetPay: Decimal;
        NetPay1: Decimal;
        Index: Integer;
        Intex: Integer;
        AmountRemaining: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        DenomArray: array[1, 12] of Text[50];
        NoOfUnitsArray: array[1, 12] of Integer;
        AmountArray: array[1, 60] of Decimal;
        PayMode: Text[30];
        PayPeriodtext: Text[30];
        EndDate: Date;
        DaysinAmonth: Decimal;
        HoursInamonth: Decimal;
        Earnings: Record EarningsX;
        CfMpr: Decimal;
        Deductions: Record DeductionsX;
        NormalOvertimeHours: Decimal;
        WeekendOvertime: Decimal;
        Window: Dialog;
        EmployeeName: Text[230];
        NoOfDays: Integer;
        Month: Date;
        GetPaye: Codeunit Payroll;
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        ScalePointer: Record "Salary Pointer";
        SalaryScale: Record "Salary Scale";
        CurrentMonth: Integer;
        CurrentMonthtext: Text[30];
        LoanType: Record "Loan Product Type";
        LoanApplication: Record "Loan Application";
        LoanBalance: Decimal;
        InterestAmt: Decimal;
        RefNo: Code[20];
        LastMonth: Date;
        NextPointer: Code[10];
        LoanInterest: Decimal;
        ScaleBenefits: Record "Scale Benefits";
        EmployeeAccHistory: Record "Employee Account History";
        EmployeeEarnRec: Record "Employee Earnings History";
        Text002: Label 'For Employee:#2###############';
        Text000: Label 'Calculating Payroll @1@@@@@@@@@@@@@@@';
        Text001: Label 'You Must specify Paye Code under deductions';
        PayrollMgt: Codeunit Payroll;
        PayLeave: Boolean;
        ClosePayPeriod: Report "Close Pay Period";
        Percentage: Integer;
        Counter: Integer;
        TotalCount: Integer;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
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
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then IncomeTax := 0;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
            Month := PayPeriod."Starting Date";
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

    procedure DefaultAssignment(Earning: Code[20])
    var
        EmployeeRec: Record Employee;
        Earnings: Record EarningsX;
        Deductions: Record DeductionsX;
    begin
        Earnings.reset;
        Earnings.SetRange(Code, Earning);
        if Earnings.FindFirst() then begin
            EmployeeRec.SetFilter(Status, '=%1', EmployeeRec.Status::Active);
            if EmployeeRec.Find('-') then begin
                repeat
                    GetPayPeriod;
                    AssignMatrix.init;
                    case Earnings."Calculation Method" of
                        Earnings."Calculation Method"::"Flat amount":
                            AssignMatrix.Amount := Earnings."Flat Amount";
                        // % Of Basic Pay
                        Earnings."Calculation Method"::"% of Basic pay":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Basic Pay", "Basic Arrears");
                                /*//Leave Allowance
                                        IF Payments."Leave Allwance"=TRUE THEN
                                          BEGIN
                                            Amount:=(Payments.Percentage*(Employee."Basic Pay"*12));
                                          END ELSE*/
                                //Gratuity
                                /*if Payments.Gratuity = true then begin
                                            //Amount:=Payments.Percentage/100*(PayrollMgt.GetMonthWorked(Employee."No."));
                                            //Amount:=Payments.Percentage/100*(Employee."Basic Pay"*12);
                                        end else*/
                                Earnings.TestField(Percentage);
                                AssignMatrix.Amount := Earnings.Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                        // % Of Basic after Tax
                        Earnings."Calculation Method"::"% of Basic after tax":
                            begin
                                if HRSetup."Company overtime hours" <> 0 then AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                        // Based on Hourly Rate
                        Earnings."Calculation Method"::"Based on Hourly Rate":
                            begin
                                /*
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             IF Payments."Overtime Factor"<>0 THEN
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             Amount:=PayrollRounding(Amount);
                                             */
                            end;
                        // Based on Daily Rate
                        Earnings."Calculation Method"::"Based on Daily Rate":
                            begin
                                /*
                                            Amount:=Employee."Driving Licence"*Employee."days worked";
                                            Amount:=PayrollRounding(Amount);
                                            */
                            end;
                        // % F Gross Pay
                        Earnings."Calculation Method"::"% of Gross pay":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                AssignMatrix.Amount := ((Earnings.Percentage / 100) * (Employee."Total Allowances"));
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                        // % of Taxable Income
                        Earnings."Calculation Method"::"% of Taxable income":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Taxable Allowance");
                                AssignMatrix.Amount := ((Earnings.Percentage / 100) * (Employee."Taxable Allowance"));
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                        //% of Other Earnings              
                        Earnings."Calculation Method"::"% of Annual Basic":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Basic Pay");
                                AssignMatrix.Amount := ((Earnings.Percentage / 100) * (Employee."Basic Pay" * 12));
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end
                        else begin
                            if Earnings."Leave Allwance" = true then begin
                                Employee.Reset;
                                Employee.SetRange("No.", AssignMatrix."Employee No");
                                if Employee.Find('-') then begin
                                    if Employee."Employment Type" = Employee."Employment Type"::Permanent then AssignMatrix.Amount := ((Employee."Basic Pay" * 12) * (Earnings.Percentage / 100));
                                end
                                else begin
                                    if Employee."Employment Type" = Employee."Employment Type"::Contract then AssignMatrix.Amount := ((Employee."Basic Pay" * PayrollMgt.GetMonthWorked(AssignMatrix."Employee No")) * (Earnings.Percentage / 100));
                                end;
                            end;
                        end;
                    end;
                    if Earnings."Reduces Tax" then begin
                        AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                    end;
                    AssignMatrix."Employee No" := Employee."No.";
                    AssignMatrix.Validate(code, Earnings.Code);
                    AssignMatrix."Payroll Period" := Month;
                    AssignMatrix.Type := AssignMatrix.Type::Payment;
                    if (AssignMatrix.Amount <> 0) and (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then AssignMatrix.Insert();
                until Employee.next = 0;
            end;
        end;
    end;

    procedure DefaultAssignmentDed(Earning: Code[20])
    var
        EmployeeRec: Record Employee;
        //Earnings: Record EarningsX;
        Deductions: Record DeductionsX;
    begin
        Deductions.reset;
        Deductions.SetRange(Code, Earning);
        if Deductions.FindFirst() then begin
            EmployeeRec.SetFilter(Status, '=%1', EmployeeRec.Status::Active);
            if EmployeeRec.Find('-') then begin
                repeat
                    GetPayPeriod;
                    AssignMatrix.init;
                    case Deductions."Calculation Method" of
                        Deductions."Calculation Method"::"Flat amount":
                            begin
                                AssignMatrix.Amount := Deductions."Flat Amount";
                                AssignMatrix."Employer Amount" := Deductions."Flat Amount Employer";
                            end;
                        // % Of Basic Pay
                        Deductions."Calculation Method"::"% of Basic pay":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Basic Pay", "Basic Arrears");
                                /*//Leave Allowance
                                        IF Payments."Leave Allwance"=TRUE THEN
                                          BEGIN
                                            Amount:=(Payments.Percentage*(Employee."Basic Pay"*12));
                                          END ELSE*/
                                //Gratuity
                                /*if Payments.Gratuity = true then begin
                                            //Amount:=Payments.Percentage/100*(PayrollMgt.GetMonthWorked(Employee."No."));
                                            //Amount:=Payments.Percentage/100*(Employee."Basic Pay"*12);
                                        end else*/
                                Deductions.TestField(Percentage);
                                AssignMatrix.Amount := Deductions.Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                        // Based on Hourly Rate
                        Deductions."Calculation Method"::"Based on Hourly Rate":
                            begin
                                /*
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             IF Payments."Overtime Factor"<>0 THEN
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             Amount:=PayrollRounding(Amount);
                                             */
                            end;
                        // % F Gross Pay
                        Deductions."Calculation Method"::"% of Gross pay":
                            begin
                                Employee.SetRange("Pay Period Filter", Month);
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                AssignMatrix.Amount := ((Deductions.Percentage / 100) * (Employee."Total Allowances"));
                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                            end;
                    end;
                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                    AssignMatrix."Employee No" := Employee."No.";
                    AssignMatrix.Validate(code, Deductions.Code);
                    AssignMatrix."Payroll Period" := Month;
                    if (AssignMatrix.Amount <> 0) and (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then AssignMatrix.Insert();
                until Employee.next = 0;
            end;
        end;
    end;

    procedure UpdateEarnings(EmployeeRec: Record Employee)
    begin
        Earnings.Reset;
        if Earnings.Find('-') then
            repeat
                if ScaleBenefits.Get(EmployeeRec."Salary Scale", EmployeeRec.Present, Earnings.Code) then begin
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange(AssignMatrix.Code, Earnings.Code);
                    AssignMatrix.SetRange(AssignMatrix.Type, AssignMatrix.Type::Payment);
                    AssignMatrix.SetRange(AssignMatrix."Employee No", EmployeeRec."No.");
                    AssignMatrix.SetRange(AssignMatrix."Payroll Period", Month);
                    if AssignMatrix.Find('-') then begin
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        if AssignMatrix."Manual Entry" = false then AssignMatrix.Modify;
                    end
                    else begin
                        AssignMatrix.Init;
                        AssignMatrix."Employee No" := EmployeeRec."No.";
                        AssignMatrix.Type := AssignMatrix.Type::Payment;
                        AssignMatrix.Code := Earnings.Code;
                        AssignMatrix.Validate(AssignMatrix.Code);
                        AssignMatrix."Payroll Period" := Month;
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        AssignMatrix."Manual Entry" := false;
                        AssignMatrix.Insert;
                    end;
                end;
            until Earnings.Next = 0;
    end;

    procedure UpdatePointers(EmployeeRec: Record Employee; PayPeriod: Date; PresentPointer: Code[20]; PreviousPointer: Code[20])
    var
        SalaryPointers: Record "Salary Pointer Details";
    begin
        if not SalaryPointers.Get(EmployeeRec."No.", PayPeriod, PresentPointer, PreviousPointer) then begin
            SalaryPointers.Init;
            SalaryPointers."Employee No" := EmployeeRec."No.";
            SalaryPointers."Payroll Period" := PayPeriod;
            SalaryPointers.Present := PresentPointer;
            SalaryPointers.Previous := PreviousPointer;
            SalaryPointers.Insert;
        end;
    end;

    procedure PointerExist(EmployeeRec: Record Employee; PayPeriod: Date; PresentPointer: Code[20]; PreviousPointer: Code[20]): Boolean
    var
        SalaryPointers: Record "Salary Pointer Details";
    begin
        if SalaryPointers.Get(EmployeeRec."No.", PayPeriod, PresentPointer, PreviousPointer) then
            exit(true)
        else
            exit(false);
    end;
}
