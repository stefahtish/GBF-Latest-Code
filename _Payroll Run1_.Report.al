report 50214 "Payroll Run1"
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
                Acting: Record "Employee Acting Position";
                ActingStartDate: Date;
                ActingEndDate: Date;
                lvNetPay: Decimal;
                lvEarning: Decimal;
                lvDeductions: Decimal;
                lvPaye: Decimal;
                DormancyDate: Date;
                lvBasicPay: Decimal;
            begin
                Clear(lvDeductions);
                Clear(lvEarning);
                Clear(lvNetPay);
                Clear(lvPaye);
                Clear(lvBasicPay);
                LastPayment := CalcDate('CM', LastMonth);
                Percentage := (Round(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));
                //Auto Assign Defaults if None are Assigned
                if "Employment Type" <> "Employment Type"::Partime then begin
                    if Employee."Employment Status" = Employee."Employment Status"::Active then begin
                        EmployeeRec.Copy(Employee);
                        EmployeeRec.SetRange("Employment Status", Employee."Employment Status"::Active);
                        EmployeeRec.SetRange("Pay Period Filter", Month);
                        EmployeeRec.CalcFields("Total Allowances", "Total Deductions", "Insurance Premium", "Loan Interest");
                    end;
                    //Delete Entries of Employees not Active
                    if Employee."Employment Status" <> Employee."Employment Status"::Active then begin
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        AssignMatrix.DeleteAll;
                        exit;
                    end;
                    //Non Casual Employees...................................................................................................................................
                    //Increment Employee Salary
                    PayrollMgt.IncrementEmployeeSalary(Employee."No.", Month);
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
                                        AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
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
                    //Assign New Pointer
                    CurrentMonth := Date2DMY(Month, 2);
                    Evaluate(CurrentMonthtext, Format(CurrentMonth));
                    if CurrentMonthtext = Employee."Incremental Month" then begin
                        if Employee.Halt <> Employee.Present then begin
                            NextPointer := IncStr(Employee.Present);
                            if NextPointer <> Employee.Halt then begin
                                if ScalePointer.Get(Employee."Salary Scale", NextPointer) then;
                                if Employee.Halt <> NextPointer then begin
                                    if not PointerExist(Employee, Month, Employee.Present, Employee.Previous) then begin
                                        Employee.Previous := Employee.Present;
                                        Employee.Present := ScalePointer."Salary Pointer";
                                        Employee.Modify;
                                    end;
                                    UpdateEarnings(Employee);
                                    UpdatePointers(Employee, Month, Employee.Present, Employee.Previous);
                                end;
                            end;
                        end;
                    end;
                    //Increment Employee Salary
                    PayrollMgt.IncrementEmployeeSalary(Employee."No.", Month);
                    //Pay Partime Workers;
                    if PayrollMgt.CheckIfPartime(Employee."No.") <> 0 then begin
                        ScaleBenefits.Reset;
                        ScaleBenefits.SetRange("Salary Scale", Employee."Salary Scale");
                        ScaleBenefits.SetRange("Salary Pointer", Employee.Present);
                        if ScaleBenefits.FindFirst then begin
                            repeat
                                PayrollMgt.PayPertimers(Employee."No.", ScaleBenefits."ED Code");
                            until ScaleBenefits.Next = 0;
                        end;
                    end;
                    //Calculate items that requires employee request Like Overtime.
                    Earnings.Reset;
                    Earnings.SetRange("Requires Employee Request", true);
                    if Earnings.Find('-') then begin
                        repeat
                            PayrollMgt.PayPertimers(Employee."No.", Earnings.Code);
                        until Earnings.Next = 0;
                    end;
                    Deductions.Reset;
                    Deductions.SetRange("PAYE Code", true);
                    if Deductions.Find('-') then begin
                        //Delete Previous PAYE
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange(Code, Deductions.Code);
                        if Deductions.Find('-') then begin
                            //Delete All Previous PAYE
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange(Code, Deductions.Code);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.DeleteAll;
                        end;
                        // Validate assigment matrix code incase basic salary change and update calculation based on basic salary
                        AssignMatrix.Reset;
                        AssignMatrix.SetRange("Employee No", Employee."No.");
                        AssignMatrix.SetRange("Payroll Period", Month);
                        if AssignMatrix.Find('-') then begin
                            repeat
                                if AssignMatrix.Type = AssignMatrix.Type::Payment then begin
                                    if Earnings.Get(AssignMatrix.Code) then begin
                                        if (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Hourly Rate") then begin
                                            AssignMatrix.Validate(Code);
                                            //AssignMatrix.VALIDATE("Employee Voluntary");
                                            AssignMatrix.Amount := Round(AssignMatrix.Amount, 1);
                                            AssignMatrix.Modify;
                                        end;
                                        //Set amount to 0 if an employee not paying tax was set for a tax relief
                                        if Earnings."Earning Type" = Earnings."Earning Type"::"Tax Relief" then
                                            if Employee."Pays tax?" = false then begin
                                                if AssignMatrix.Amount > 0 then AssignMatrix.Amount := 0;
                                                AssignMatrix.Modify;
                                            end;
                                        if (Employee."Leave Category" <> '') and (Earnings."Basic Salary Code") then begin
                                            if PayrollLeaveCategory.Get(Employee."Leave Category") then begin
                                                AssignMatrix.Amount := (PayrollLeaveCategory."% of Basic Pay" / 100) * AssignMatrix.Amount;
                                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                                                AssignMatrix.Modify;
                                            end;
                                        end;
                                    end;
                                    GVEarning := GVEarning + AssignMatrix.Amount;
                                end;
                                if AssignMatrix.Retirement = false then begin
                                    if AssignMatrix.Type = AssignMatrix.Type::Deduction then begin
                                        if Deductions.Get(AssignMatrix.Code) then begin
                                            if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                                AssignMatrix.Validate(Code);
                                                AssignMatrix.Validate("Employee Voluntary");
                                                AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                                                AssignMatrix.Modify;
                                            end;
                                        end;
                                    end;
                                end;
                                if AssignMatrix.Type = AssignMatrix.Type::Deduction then begin
                                    if Deductions.Get(AssignMatrix.Code) then begin
                                        if (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") and (Deductions."PAYE Code" = false) then begin
                                            AssignMatrix.Validate(Code);
                                            AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                                            AssignMatrix.Modify;
                                        end;
                                    end;
                                    GVDeduction := GVDeduction + AssignMatrix.Amount;
                                end;
                            until AssignMatrix.Next = 0;
                        end;
                        //Pay Leave Allowance.
                        if PayLeave then begin
                            LeaveEndDate := LastMonth;
                            LeaveStartDate := CalcDate('-6M', LeaveEndDate);
                            EmploymentDate := DMY2Date(Date2DMY(Employee."Employment Date", 1), Date2DMY(Employee."Employment Date", 2), Date2DMY(LeaveEndDate, 3));
                            if (EmploymentDate >= LeaveStartDate) and (EmploymentDate <= LeaveEndDate) then begin
                                Earnings.Reset;
                                Earnings.SetRange("Leave Allwance", true);
                                if Earnings.Find('-') then begin
                                    AssignMatrix.Init;
                                    AssignMatrix."Employee No" := Employee."No.";
                                    AssignMatrix.Type := AssignMatrix.Type::Payment;
                                    AssignMatrix.Code := Earnings.Code;
                                    AssignMatrix."Reference No" := '';
                                    AssignMatrix.Validate(Code);
                                    AssignMatrix."Payroll Period" := Month;
                                    AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                    AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                    AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                    AssignMatrix.Validate(Amount);
                                    if (AssignMatrix.Amount <> 0) and (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then begin
                                        AssignMatrix.Insert;
                                    end
                                end;
                            end;
                        end;
                        //flag out acting allowance
                        Earnings.Reset;
                        Earnings.SetRange("Acting Allowance", true);
                        if Earnings.Find('-') then begin
                            AssignMatrix.Reset();
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            AssignMatrix.SetRange("Payroll Period", Month);
                            AssignMatrix.SetRange(Code, Earnings.Code);
                            if AssignMatrix.FindFirst() then AssignMatrix.Delete();
                        end;
                        //Pay acting allowance
                        Acting.Reset();
                        Acting.SetRange("Employee No.", Employee."No.");
                        Acting.SetRange(Status, Acting.Status::Approved);
                        Acting.SetFilter("Acting Amount", '>%1', 0);
                        if Acting.Find('-') then begin
                            repeat
                                ActingStartDate := CalcDate('-CM', Acting."Start Date");
                                ActingEndDate := CalcDate('-CM', Acting."End Date");
                                if (Month >= ActingStartDate) and (Month <= ActingEndDate) then begin
                                    Earnings.Reset;
                                    Earnings.SetRange("Acting allowance", true);
                                    if Earnings.Find('-') then begin
                                        AssignMatrix.Reset();
                                        AssignMatrix.SetRange("Employee No", Employee."No.");
                                        AssignMatrix.SetRange("Payroll Period", Month);
                                        AssignMatrix.SetRange(Code, Earnings.Code);
                                        if AssignMatrix.FindFirst() then AssignMatrix.Delete();
                                        AssignMatrix.Init;
                                        AssignMatrix."Payroll Period" := Month;
                                        AssignMatrix.Type := AssignMatrix.Type::Payment;
                                        AssignMatrix."Employee No" := Acting."Employee No.";
                                        AssignMatrix.Frequency := AssignMatrix.Frequency::"Non-recurring";
                                        AssignMatrix.Code := Earnings.Code;
                                        AssignMatrix.Validate(Code);
                                        AssignMatrix.Amount := Acting."Acting Amount";
                                        AssignMatrix.Insert();
                                    end;
                                    exit;
                                end;
                            until Acting.Next() = 0;
                        end;
                        //Validate Loans
                        LoanInterest := 0;
                        LoanApplication.Reset;
                        LoanApplication.SetRange("Employee No", Employee."No.");
                        LoanApplication.SetRange("Loan Status", LoanApplication."Loan Status"::Issued);
                        LoanApplication.SetRange("Stop Loan", false);
                        if LoanApplication.Find('-') then
                            repeat
                                AssignMatrix.Reset;
                                AssignMatrix.SetRange("Employee No", Employee."No.");
                                AssignMatrix.SetRange("Payroll Period", Month);
                                AssignMatrix.SetRange("Reference No", LoanApplication."Loan No");
                                AssignMatrix.SetRange("Loan Repay", true);
                                if AssignMatrix.Find('-') then
                                    repeat
                                        if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::Amortised then
                                            AssignMatrix.Amount := -(ClosePayPeriod.CalculateRepaymentAmount(Employee."No.", LoanApplication."Loan No", LoanInterest, LastPayment))
                                        else
                                            AssignMatrix.Amount := -(ClosePayPeriod.CalculateRepaymentAmount(Employee."No.", LoanApplication."Loan No", LoanInterest, LastPayment) - LoanInterest);
                                        AssignMatrix.Amount := PayrollRounding(AssignMatrix.Amount);
                                        AssignMatrix."Loan Interest" := -(ClosePayPeriod.CalculateRepaymentInterest(Employee."No.", LoanApplication."Loan No", LastPayment));
                                        AssignMatrix."Loan Interest" := PayrollRounding(AssignMatrix."Loan Interest");
                                        AssignMatrix.Modify;
                                        //Delete Loan
                                        if AssignMatrix.Amount = 0 then AssignMatrix.Delete;
                                    until AssignMatrix.Next = 0;
                            until LoanApplication.Next = 0;
                        //End of Loans
                        //Assign Insurance Relief
                        if EmployeeRec."Insurance Relief" = true then begin
                            if EmployeeRec."Insurance Premium" <> 0 then begin
                                Earnings.Reset;
                                Earnings.SetCurrentKey("Earning Type");
                                Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                                if Earnings.Find('-') then begin
                                    AssignMatrix.Init;
                                    AssignMatrix."Employee No" := Employee."No.";
                                    AssignMatrix.Type := AssignMatrix.Type::Payment;
                                    AssignMatrix.Code := Earnings.Code;
                                    AssignMatrix."Reference No" := '';
                                    AssignMatrix.Validate(Code);
                                    AssignMatrix."Payroll Period" := Month;
                                    AssignMatrix."Department Code" := Employee."Global Dimension 1 Code";
                                    AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                    AssignMatrix."Posting Group Filter" := Employee."Posting Group";
                                    AssignMatrix.Validate(Amount);
                                    if (AssignMatrix.Amount <> 0) and (not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")) then begin
                                        AssignMatrix.Insert;
                                    end
                                    else begin
                                        Earnings.Reset;
                                        Earnings.SetCurrentKey("Earning Type");
                                        Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Insurance Relief");
                                        if Earnings.Find('-') then begin
                                            AssignMatrix.Reset;
                                            AssignMatrix.SetRange("Payroll Period", DateSpecified);
                                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                                            AssignMatrix.SetRange(Code, Earnings.Code);
                                            AssignMatrix.SetRange("Employee No", Employee."No.");
                                            if AssignMatrix.Find('-') then begin
                                                AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                                AssignMatrix.Validate(Amount);
                                                AssignMatrix.Modify;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end
                        else begin
                            AssignMatrix.Reset;
                            AssignMatrix.SetRange("Payroll Period", DateSpecified);
                            AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SetRange(Code, Earnings.Code);
                            AssignMatrix.SetRange("Employee No", Employee."No.");
                            if AssignMatrix.Find('-') then begin
                                AssignMatrix.Amount := Abs(EmployeeRec."Insurance Premium" * (Earnings.Percentage / 100));
                                AssignMatrix.Validate(Amount);
                                AssignMatrix.Modify;
                            end;
                        end;
                        Deductions.Reset;
                        Deductions.SetRange("PAYE Code", true);
                        if Deductions.Find('-') then begin
                            GetPaye.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetireCont);
                            //Create PAYE
                            //Update Tax Relief
                            if (IncomeTax > 0) and (Employee."Employee Job Type" <> Employee."Employee Job Type"::Director) and (not Employee."Secondary Employee") then begin
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
                                    //lvEarning := lvEarning + AssignMatrix.Amount;
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
                            if IncomeTax > 0 then IncomeTax := -Round(IncomeTax, 1);
                            AssignMatrix.Amount := IncomeTax;
                            lvPaye := IncomeTax;
                            //Message(Format(lvPaye));
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
                if Employee."Employment Type" = Employee."Employment Type"::Partime then begin
                    AssignMatrix.Reset;
                    AssignMatrix.SetRange("Employee No", Employee."No.");
                    AssignMatrix.SetRange("Payroll Period", Month);
                    AssignMatrix.SetRange("Next Period Entry", false);
                    AssignMatrix.SetFilter("Effective End Date", '<%1', Month);
                    AssignMatrix.DeleteAll;
                    Earnings.Reset;
                    Earnings.SetRange("Casual Code", true);
                    if Earnings.FindFirst then begin
                        repeat
                            PayrollMgt.PayPertimers(Employee."No.", Earnings.Code);
                        until Earnings.Next = 0;
                    end;
                end;
                //START
                GvAssMatrix.CopyFilters(AssignMatrix);
                GvAssMatrix.SetRange(Taxable, true);
                if GvAssMatrix.FindSet() then
                    repeat
                        lvEarning := lvEarning + GvAssMatrix.Amount;
                    until GvAssMatrix.Next() = 0;
                GvAssMatrix2.CopyFilters(AssignMatrix);
                GvAssMatrix2.SetFilter(GvAssMatrix2.Type, '%1', GvAssMatrix2.Type::Deduction);
                if GvAssMatrix2.FindSet() then
                    repeat
                        lvDeductions := lvDeductions + GvAssMatrix2.Amount;
                    until GvAssMatrix2.Next() = 0;
                GvAssMatrix3.CopyFilters(AssignMatrix);
                GvAssMatrix3.SetRange("Basic Salary Code", true);
                if GvAssMatrix3.FindFirst() then lvBasicPay := GvAssMatrix3.Amount;
                lvNetPay := lvEarning + lvDeductions;
                HRSetup.Get();
                if HRSetup."Enforce a third rule" then begin
                    if lvNetPay < (lvBasicPay / 3) then Error('The payroll calculation for employee %1 defies the 1/3 rule defined in the Human Resources setup, net pay for the Employee is %2  should greater or equal to %3', Employee."No.", lvNetPay, Round(lvBasicPay / 3));
                end;
                //END
                Window.Update(1, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
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
        GVDeduction: Decimal;
        GVEarning: Decimal;
        GvAssMatrix: Record "Assignment Matrix-X";
        GvAssMatrix2: Record "Assignment Matrix-X";
        GvAssMatrix3: Record "Assignment Matrix-X";
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
        LastPayment: Date;
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
        TrusteesPayPeriod: Record "Payroll Period Trustees";
        PayrollLeaveCategory: Record "Payroll Leave Category";
    //START
    procedure CheckOneThirdRule(AssignMat: Record "Assignment Matrix-X"; EmpNo: Code[20]; PayP: Date; var NetPay: Decimal; NewDed: Decimal): Boolean
    var
        Earnin: Decimal;
        Deduc: Decimal;
        EmpRec: Record Employee;
        ExemptAmt: Decimal;
        EarningRec: Record "Assignment Matrix-X";
        EarningRec2: Record "Assignment Matrix-X";
        EmpBasic: Decimal;
        TotalEarnings: Decimal;
        TotalDeds: Decimal;
        DeductionsRec: Record "Assignment Matrix-X";
    begin
        HRSetup.Get();
        if HRSetup."Enforce a third rule" then begin
            HRSetup.TestField("Net pay ratio to Earnings");
            EmpRec.Reset();
            EmpRec.SetRange("No.", EmpNo);
            EmpRec.SetRange("Pay Period Filter", PayP);
            if EmpRec.Find('-') then begin
                Clear(EmpBasic);
                EmpRec.CalcFields("Total Allowances", "Total Deductions", "Cumm. PAYE");
                EarningRec.Reset();
                EarningRec.SetRange("Basic Salary Code", true);
                EarningRec.SetRange(EarningRec."Employee No", EmpNo);
                EarningRec.SetRange(EarningRec."Payroll Period", PayP);
                if EarningRec.FindFirst() then begin
                    EmpBasic := EarningRec.Amount;
                end;
                if EmpRec."Total Allowances" <> 0 then begin
                    if not GetExemptDeductions(EmpNo, PayP) then begin
                        /*if ((Abs(EmpRec."Total Allowances")) - (Abs(EmpRec."Total Deductions") + NewDed)) /
                            (EmpRec."Total Allowances") >= HRSetup."Net pay ratio to Earnings" then
                            exit(true)
                        else begin
                            NetPay := EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
                            exit(false);
                        end;*/
                        NetPay := Abs(EmpRec."Total Allowances") - Abs(EmpRec."Total Deductions");
                        if (EmpBasic / 3) >= NetPay then begin
                            exit(false);
                        end
                        else begin
                            NetPay := EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
                            exit(true);
                        end;
                    end
                    else
                        exit(true);
                end;
            end;
        end
        else
            exit(true);
    end;

    procedure GetExemptDeductions(EmpNo: Code[20]; Period: Date): Boolean
    var
        AssignMat: Record "Assignment Matrix-X";
        Ded: Record DeductionsX;
    begin
        Ded.reset;
        Ded.SetRange("Exempt from a third rule", true);
        if Ded.find('-') then
            repeat
                AssignMat.Reset();
                AssignMat.SetRange("Employee No", EmpNo);
                AssignMat.SetRange(Type, AssignMat.Type::Deduction);
                AssignMat.SetRange("Payroll Period", Period);
                AssignMat.SetRange(Code, Ded.Code);
                if AssignMat.Find('-') then
                    exit(true)
                else
                    exit(false);
            until Ded.Next = 0;
    end;
    //END
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

    procedure DefaultAssignment(EmployeeRec: Record Employee)
    var
        ScaleBenefits: Record "Scale Benefits";
    begin
        GetPayPeriod;
        if BeginDate <> 0D then begin
            AssignMatrix.Init;
            AssignMatrix."Employee No" := EmployeeRec."No.";
            AssignMatrix.Type := AssignMatrix.Type::Payment;
            AssignMatrix."Payroll Period" := BeginDate;
            AssignMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
            ScaleBenefits.Reset;
            ScaleBenefits.SetRange("Salary Scale", EmployeeRec."Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", EmployeeRec.Present);
            if ScaleBenefits.Find('-') then begin
                repeat
                    AssignMatrix.Code := ScaleBenefits."ED Code";
                    AssignMatrix.Validate(Code);
                    AssignMatrix.Amount := ScaleBenefits.Amount;
                    AssignMatrix.Validate(Amount);
                    if not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No") then
                        AssignMatrix.Insert
                    else begin
                        AssignMatrix.Code := ScaleBenefits."ED Code";
                        AssignMatrix.Validate(Code);
                        AssignMatrix.Amount := ScaleBenefits.Amount;
                        AssignMatrix.Validate(Amount);
                        AssignMatrix.Modify;
                    end;
                until ScaleBenefits.Next = 0;
            end;
            // Insert Deductions assigned to every employee
            Deductions.Reset;
            Deductions.SetRange("Applies to All", true);
            if Deductions.Find('-') then begin
                repeat
                    AssignMatrix.Init;
                    AssignMatrix."Employee No" := EmployeeRec."No.";
                    AssignMatrix.Type := AssignMatrix.Type::Deduction;
                    AssignMatrix."Payroll Period" := BeginDate;
                    AssignMatrix."Department Code" := EmployeeRec."Global Dimension 1 Code";
                    AssignMatrix.Code := Deductions.Code;
                    AssignMatrix.Validate(Code);
                    if not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No") then
                        AssignMatrix.Insert
                    else begin
                        AssignMatrix.Code := Deductions.Code;
                        AssignMatrix.Validate(Code);
                    end;
                until Deductions.Next = 0;
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
        if not SalaryPointers.Get(EmployeeRec."No.") then begin
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
        if SalaryPointers.Get(EmployeeRec."No.") then
            exit(true)
        else
            exit(false);
    end;

    procedure SetPayPeriod(PayPeriod: date)
    begin
        BeginDate := PayPeriod;
    end;
}
