report 50284 "Trustee Payroll Reconciliation"
{
    Caption = 'Payroll Reconciliation';
    DefaultLayout = RDLC;
    RDLCLayout = './TrusteePayrollReconciliation.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(EarningsX; EarningsX)
        {
            DataItemTableView = SORTING(Code) WHERE("Non-Cash Benefit" = CONST(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Pay Period Filter";

            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(EarningsX_Description; Description)
            {
            }
            column(PAYROLL_RECONCILIATION_DETAILED_REPORTCaption; PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl)
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
            column(Last_PeriodCaption; Last_PeriodCaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(EarningsX_Code; Code)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "), "Employment Type" = const(Trustee));

                column(Employee__No__; "No.")
                {
                }
                column(EmpName; EmpName)
                {
                }
                column(ThisMonthVal; ThisMonthVal)
                {
                }
                column(LastMonthVal; LastMonthVal)
                {
                }
                column(Difference; Difference)
                {
                }
                column(ThisMonthVal_Control1000000043; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000044; LastMonthVal)
                {
                }
                column(Difference_Control1000000045; Difference)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LastMonthVal := 0;
                    Difference := 0;
                    ThisMonthVal := 0;
                    EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    //Last Month
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, EarningsX.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.Find('+') then begin
                        LastMonthVal := Assignmat.Amount;
                    end;
                    //CurrentMonth
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, EarningsX.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
                    if Assignmat.Find('+') then begin
                        ThisMonthVal := Assignmat.Amount;
                    end;
                    Difference := ThisMonthVal - LastMonthVal;
                    if Difference = 0 then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
                end;
            }
        }
        dataitem(DeductionsX; DeductionsX)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;

            column(DeductionsX_Description; Description)
            {
            }
            column(DeductionsX_Code; Code)
            {
            }
            dataitem(EmpDed; Employee)
            {
                DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "), "Employment Type" = filter(trustee));

                column(EmpDed__No__; "No.")
                {
                }
                column(EmpName_Control1000000035; EmpName)
                {
                }
                column(ThisMonthVal_Control1000000036; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000037; LastMonthVal)
                {
                }
                column(Difference_Control1000000038; Difference)
                {
                }
                column(ThisMonthVal_Control1000000039; ThisMonthVal)
                {
                }
                column(LastMonthVal_Control1000000040; LastMonthVal)
                {
                }
                column(Difference_Control1000000041; Difference)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LastMonthVal := 0;
                    Difference := 0;
                    ThisMonthVal := 0;
                    EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    //Last Month
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, DeductionsX.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.Find('+') then begin
                        LastMonthVal := Assignmat.Amount + Assignmat."Loan Interest";
                    end;
                    //CurrentMonth
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, DeductionsX.Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
                    if Assignmat.Find('+') then begin
                        ThisMonthVal := Assignmat.Amount + Assignmat."Loan Interest";
                    end;
                    Difference := ThisMonthVal - LastMonthVal;
                    if Difference = 0 then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
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
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
        Thismonth := EarningsX.GetRangeMin(EarningsX."Pay Period Filter");
        Lastmonth := CalcDate('-1M', Thismonth);
    end;

    var
        EmpName: Text[230];
        Emp: Record Employee;
        Assignmat: Record "Assignment Matrix-X";
        Thismonth: Date;
        Lastmonth: Date;
        LastMonthVal: Decimal;
        Difference: Decimal;
        CompInfo: Record "Company Information";
        i: Integer;
        EarnRec: Record EarningsX;
        EarnCode: array[100] of Code[20];
        ThisMonthVal: Decimal;
        PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl: Label 'PAYROLL RECONCILIATION DETAILED REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmployeeCaptionLbl: Label 'Employee';
        Current_PeriodCaptionLbl: Label 'Current Period';
        Last_PeriodCaptionLbl: Label 'Last Period';
        DifferenceCaptionLbl: Label 'Difference';
}
