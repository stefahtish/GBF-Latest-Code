report 50232 "Payroll Reconciliation Prev"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollReconciliationPrev.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(EarningsX; EarningsX)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Pay Period Filter";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(EarningsX_Code; Code)
            {
            }
            column(EarningsX_Description; Description)
            {
            }
            column(PAYROLL_RECONCILIATIONCaption; PAYROLL_RECONCILIATIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl)
            {
            }
            column(Next_PeriodCaption; Next_PeriodCaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(EarningsX_Pay_Period_Filter; "Pay Period Filter")
            {
            }
            dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
            {
                DataItemLink = Code = FIELD(Code), "Payroll Period" = FIELD("Pay Period Filter");
                DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Payment));

                column(Assignment_Matrix_X__Employee_No_; "Employee No")
                {
                }
                column(Assignment_Matrix_X_Amount; Amount)
                {
                }
                column(EmpName; EmpName)
                {
                }
                column(LastMonthVal; LastMonthVal)
                {
                }
                column(Difference; Difference)
                {
                }
                column(Assignment_Matrix_X_Amount_Control1000000015; Amount)
                {
                }
                column(LastMonthVal_Control1000000016; LastMonthVal)
                {
                }
                column(Difference_Control1000000017; Difference)
                {
                }
                column(Assignment_Matrix_X_Type; Type)
                {
                }
                column(Assignment_Matrix_X_Code; Code)
                {
                }
                column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
                {
                }
                column(Assignment_Matrix_X_Reference_No; "Reference No")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                        EmpName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    end;
                    LastMonthVal := 0;
                    Difference := 0;
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    Assignmat.SetRange(Assignmat.Amount, "Assignment Matrix-X".Amount);
                    if Assignmat.Find('+') then
                        CurrReport.Skip
                    else begin
                        Assignmat.Reset;
                        Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                        Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                        Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                        Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                        if Assignmat.Find('+') then LastMonthVal := Assignmat.Amount;
                    end;
                    Difference := "Assignment Matrix-X".Amount - LastMonthVal;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CreateTotals(Difference, LastMonthVal, "Assignment Matrix-X".Amount);
                end;
            }
        }
        dataitem(DeductionsX; DeductionsX)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;

            column(DeductionsX_Code; Code)
            {
            }
            column(DeductionsX_Description; Description)
            {
            }
            dataitem(DetailedDeductions; "Assignment Matrix-X")
            {
                DataItemLink = Code = FIELD(Code);
                DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Deduction));

                column(DetailedDeductions__Employee_No_; "Employee No")
                {
                }
                column(EmpName_Control1000000026; EmpName)
                {
                }
                column(DetailedDeductions_Amount; Amount)
                {
                }
                column(LastMonthVal_Control1000000028; LastMonthVal)
                {
                }
                column(Difference_Control1000000029; Difference)
                {
                }
                column(DetailedDeductions_Amount_Control1000000031; Amount)
                {
                }
                column(LastMonthVal_Control1000000032; LastMonthVal)
                {
                }
                column(Difference_Control1000000033; Difference)
                {
                }
                column(DetailedDeductions_Type; Type)
                {
                }
                column(DetailedDeductions_Code; Code)
                {
                }
                column(DetailedDeductions_Payroll_Period; "Payroll Period")
                {
                }
                column(DetailedDeductions_Reference_No; "Reference No")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Emp.Get(DetailedDeductions."Employee No") then begin
                        EmpName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    end;
                    LastMonthVal := 0;
                    Difference := 0;
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", DetailedDeductions."Employee No");
                    Assignmat.SetRange(Assignmat.Type, DetailedDeductions.Type);
                    Assignmat.SetRange(Assignmat.Code, DetailedDeductions.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    Assignmat.SetRange(Assignmat.Amount, DetailedDeductions.Amount);
                    if Assignmat.Find('+') then
                        CurrReport.Skip
                    else begin
                        Assignmat.Reset;
                        Assignmat.SetRange(Assignmat."Employee No", DetailedDeductions."Employee No");
                        Assignmat.SetRange(Assignmat.Type, DetailedDeductions.Type);
                        Assignmat.SetRange(Assignmat.Code, DetailedDeductions.Code);
                        Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                        if Assignmat.Find('+') then LastMonthVal := Assignmat.Amount;
                    end;
                    Difference := DetailedDeductions.Amount - LastMonthVal;
                end;

                trigger OnPreDataItem()
                begin
                    DetailedDeductions.SetRange(DetailedDeductions."Payroll Period", Thismonth);
                    //CurrReport.CreateTotals(Difference, LastMonthVal, DetailedDeductions.Amount);
                end;
            }
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
        Thismonth := EarningsX.GetRangeMin(EarningsX."Pay Period Filter");
        Lastmonth := CalcDate('1M', Thismonth);
    end;

    var
        EmpName: Text[230];
        Emp: Record Employee;
        Assignmat: Record "Assignment Matrix-X";
        Thismonth: Date;
        Lastmonth: Date;
        LastMonthVal: Decimal;
        Difference: Decimal;
        PAYROLL_RECONCILIATIONCaptionLbl: Label 'PAYROLL RECONCILIATION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmployeeCaptionLbl: Label 'Employee';
        Current_PeriodCaptionLbl: Label 'Current Period';
        Next_PeriodCaptionLbl: Label 'Next Period';
        DifferenceCaptionLbl: Label 'Difference';
}
