report 50222 "Monthly PAYE Reportx"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MonthlyPAYEReportx.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") WHERE("Employee Job Type" = CONST("  "));
            RequestFilterFields = "Pay Period Filter"; //, , "No.", "Global Dimension 1 Code", "Global Dimension 2 Code"

            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4____; UpperCase(Format(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(Logo; CompanyRec.Picture)
            {
            }
            column(SortBy; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4_____Control5; UpperCase(Format(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName_Control9; CoName)
            {
            }
            column(SortBy_Control29; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4__Control22; Format(Today, 0, 4))
            {
            }
            column(USERID_Control24; UserId)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name_________Middle_Name________Last_Name_; "First Name" + '  ' + "Middle Name" + '  ' + "Last Name")
            {
            }
            column(Employee__PIN_Number_; "PIN Number")
            {
            }
            column(Employee_Employee__Taxable_Income_; Employee."Taxable Income")
            {
            }
            column(ABS_Employee__Cumm__PAYE__; Abs(Employee."Cumm. PAYE"))
            {
            }
            column(TotalTaxable; TotalTaxable)
            {
            }
            column(ABS_TotalPaye_; Abs(TotalPaye))
            {
            }
            column(RecordNo; RecordNo)
            {
            }
            column(Employee_NamesCaption; Employee_NamesCaptionLbl)
            {
            }
            column(FilterCaption; FilterCaptionLbl)
            {
            }
            column(PIN_NumberCaption; PIN_NumberCaptionLbl)
            {
            }
            column(USERCaption; USERCaptionLbl)
            {
            }
            column(PAYE_KshsCaption; PAYE_KshsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption; MONTHLY_PAYE_REPORT_CaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(Pay_NumberCaption; Pay_NumberCaptionLbl)
            {
            }
            column(TAXABLE_PAYCaption; TAXABLE_PAYCaptionLbl)
            {
            }
            column(PERIODCaption_Control27; PERIODCaption_Control27Lbl)
            {
            }
            column(Employee_NamesCaption_Control12; Employee_NamesCaption_Control12Lbl)
            {
            }
            column(Pay_NumberCaption_Control7; Pay_NumberCaption_Control7Lbl)
            {
            }
            column(PIN_NumberCaption_Control13; PIN_NumberCaption_Control13Lbl)
            {
            }
            column(PAYE_KshsCaption_Control15; PAYE_KshsCaption_Control15Lbl)
            {
            }
            column(USERCaption_Control26; USERCaption_Control26Lbl)
            {
            }
            column(CurrReport_PAGENO_Control23Caption; CurrReport_PAGENO_Control23CaptionLbl)
            {
            }
            column(FilterCaption_Control30; FilterCaption_Control30Lbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption_Control47; MONTHLY_PAYE_REPORT_Caption_Control47Lbl)
            {
            }
            column(TAXABLE_PAYCaption_Control1000000001; TAXABLE_PAYCaption_Control1000000001Lbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(Approving_OfficerCaption; Approving_OfficerCaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption_Control1000000007; DESIGNATION____________________________________________________________Caption_Control1000000007Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000008; DATE_____________________________________________________________________Caption_Control1000000008Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000009; NAME_________________________________________________________________________Caption_Control1000000009Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000010; SIGNATURE___________________________________________________________Caption_Control1000000010Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CfMpr := 0;
                /*
                 IF EmpBank.GET("Employee's Bank","Bank Branch") THEN
                    BankName:=EmpBank.Name; */
                Employee.CalcFields("Taxable Allowance", "Tax Deductible Amount", Employee."Cumm. PAYE");
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions", Employee."Taxable Income");
                Employee.CalcFields("Benefits-Non Cash", "Total Savings", "Retirement Contribution");
                if Employee."Cumm. PAYE" = 0 then begin
                    CurrReport.Skip
                end;
                TotalPaye := TotalPaye + Employee."Cumm. PAYE";
                TotalTaxable := TotalTaxable + Employee."Taxable Income";
                RecordNo := RecordNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyRec.Get;
                CoName := CompanyRec.Name;
                if BeginDate = DateSpecified then Employee.SetRange(Status, Employee.Status::Active);
                NoOfRecords := Count;
                DeptFilter := '';
                ProjFilter := '';
                SecLocFilter := '';
                NoFilter := '';
                if Employee.GetFilter("Global Dimension 1 Code") <> '' then DeptFilter := 'Dept ' + Employee.GetFilter("Global Dimension 1 Code");
                if Employee.GetFilter("No.") <> '' then NoFilter := 'No ' + Employee.GetFilter("No.");
                if Employee.GetFilter("Global Dimension 2 Code") <> '' then ProjFilter := 'Proj ' + Employee.GetFilter("Global Dimension 2 Code");
                /*IF Employee.GETFILTER(Location) <> '' THEN
                 SecLocFilter:='Sec/Loc ' + Employee.GETFILTER(Location);*/
                SortBy := NoFilter + DeptFilter + ProjFilter + SecLocFilter;
                /*CUser:=USERID;
                    GetGroup.GetUserGroup(CUser,GroupCode);
                    SETRANGE(Employee."Posting Group",GroupCode);*/
                //EVALUATE(EmployeeNo,"No.");
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
        CompanyRec.Get;
        CompanyRec.CalcFields(Picture);
        GetPayPeriod;
        PayPeriodtext := Employee.GetFilter("Pay Period Filter");
        if PayPeriodtext = '' then Error('Pay period must be specified for this report');
        DateSpecified := Employee.GetRangeMin("Pay Period Filter");
        HoldDate := Employee.GetRangeMin("Pay Period Filter");
        if PayPeriod.Get(DateSpecified) then PayPeriodtext := PayPeriod.Name;
        Year := Date2DMY(HoldDate, 3);
        PayPeriodtext := PayPeriodtext + '-' + Format(Year);
        EndDate := CalcDate('1M', DateSpecified - 1);
    end;

    var
        Addr: array[10, 30] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        Transactions: Record "Assignment Matrix-X";
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        DateSpecified: Date;
        EndDate: Date;
        EmpBank: Record "Employee Bank AccountX";
        BankName: Text[30];
        BasicSalary: Decimal;
        TaxableAmt: Decimal;
        RightBracket: Boolean;
        NetPay: Decimal;
        PayPeriodRec: Record "Employee Bank AccountX";
        PayDeduct: Record "Assignment Matrix-X";
        EmpRec: Record Employee;
        EmpNo: Code[10];
        TaxableAmount: Decimal;
        PAYE: Decimal;
        ArrEarnings: array[10, 50] of Text[250];
        ArrDeductions: array[10, 50] of Text[250];
        Index: Integer;
        Index1: Integer;
        j: Integer;
        ArrEarningsAmt: array[10, 50] of Text[250];
        ArrDeductionsAmt: array[10, 50] of Text[250];
        Year: Integer;
        EmpArray: array[10, 15] of Decimal;
        HoldDate: Date;
        DenomArray: array[3, 11] of Text[50];
        NoOfUnitsArray: array[3, 11] of Integer;
        AmountArray: array[3, 11] of Decimal;
        PayModeArray: array[3] of Text[30];
        HoursArray: array[10, 50] of Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        CompanyRec: Record "Company Information";
        CoName: Text[80];
        TotalTaxable: Decimal;
        TotalPaye: Decimal;
        TaxCode: Code[10];
        SortBy: Text[30];
        NoFilter: Text[40];
        DeptFilter: Text[30];
        ProjFilter: Text[30];
        SecLocFilter: Text[30];
        GrossPay: Decimal;
        RetireCont: Decimal;
        retirecontribution: Decimal;
        TotalBenefits: Decimal;
        TaxablePay: Decimal;
        TotalQuarters: Decimal;
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        EmployeeNo: Integer;
        Employee_NamesCaptionLbl: Label 'Employee Names';
        FilterCaptionLbl: Label 'Filter';
        PIN_NumberCaptionLbl: Label 'PIN Number';
        USERCaptionLbl: Label 'USER';
        PAYE_KshsCaptionLbl: Label 'PAYE Kshs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MONTHLY_PAYE_REPORT_CaptionLbl: Label 'MONTHLY PAYE REPORT ';
        PERIODCaptionLbl: Label 'PERIOD';
        Pay_NumberCaptionLbl: Label 'Pay Number';
        TAXABLE_PAYCaptionLbl: Label 'TAXABLE PAY';
        PERIODCaption_Control27Lbl: Label 'PERIOD';
        Employee_NamesCaption_Control12Lbl: Label 'Employee Names';
        Pay_NumberCaption_Control7Lbl: Label 'Pay Number';
        PIN_NumberCaption_Control13Lbl: Label 'PIN Number';
        PAYE_KshsCaption_Control15Lbl: Label 'PAYE Kshs';
        USERCaption_Control26Lbl: Label 'USER';
        CurrReport_PAGENO_Control23CaptionLbl: Label 'Page';
        FilterCaption_Control30Lbl: Label 'Filter';
        MONTHLY_PAYE_REPORT_Caption_Control47Lbl: Label 'MONTHLY PAYE REPORT ';
        TAXABLE_PAYCaption_Control1000000001Lbl: Label 'TAXABLE PAY';
        TOTALSCaptionLbl: Label 'TOTALS';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        DESIGNATION____________________________________________________________Caption_Control1000000007Lbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________Caption_Control1000000008Lbl: Label 'DATE ....................................................................';
        NAME_________________________________________________________________________Caption_Control1000000009Lbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________Caption_Control1000000010Lbl: Label 'SIGNATURE ..........................................................';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';

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
            PayPeriodtext := PayPeriod.Name;
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
}
