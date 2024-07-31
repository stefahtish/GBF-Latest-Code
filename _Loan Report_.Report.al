report 50296 "Loan Report"
{
    Caption = ' ';
    DefaultLayout = RDLC;
    RDLCLayout = './CarloanReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Payroll PeriodX"; "Payroll PeriodX")
        {
            RequestFilterFields = "Pay Period Filter";

            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(Tel; Tel)
            {
            }
            column(Address; Address)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(Payroll_PeriodX_Name; Name)
            {
            }
            column(Payroll_PeriodX__Starting_Date_; UpperCase(Format("Starting Date", 0, '<month text> <year4>')))
            {
            }
            column(Payroll_PeriodCaption; Payroll_PeriodCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(ADDRESSCaptions; ADDRESSCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(MONTHLY_EARNINGS_REPORTCaption; MONTHLY_EARNINGS_REPORTCaptionLbl)
            {
            }
            column(Payroll_PeriodX_Starting_Date; "Starting Date")
            {
            }
            column(Payroll_PeriodX_Earnings_Code_Filter; "Payroll PeriodX"."Deductions Code Filter")
            {
            }
            dataitem(DeductionsX; DeductionsX)
            {
                DataItemLink = "Pay Period Filter" = FIELD("Starting Date"); //Code = FIELD("Deductions Code Filter"), 
                DataItemTableView = SORTING(Code) where("Loan Type" = filter("Car Loan"));

                column(EarningsX_Description; Description)
                {
                }
                column(EarningsX_Code; Code)
                {
                }
                column(EarningsX_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
                {
                    DataItemLink = Code = FIELD(Code), "Payroll Period" = FIELD("Pay Period Filter");
                    DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Deduction));

                    column(Assignment_Matrix_X__Assignment_Matrix_X__Amount; Amount)
                    {
                    }
                    column(LastName; LastName)
                    {
                    }
                    column(MiddleName; MiddleName)
                    {
                    }
                    column(Assignment_Matrix_X__Assignment_Matrix_X___Employee_No_; "Employee No")
                    {
                    }
                    column(FirstName; FirstName)
                    {
                    }
                    column(TotalAmount; TotalAmount)
                    {
                    }
                    column(Counter; Counter)
                    {
                    }
                    column(Total_AmountCaption; Total_AmountCaptionLbl)
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
                    column(ID_No; GetIDNo("Employee No"))
                    {
                    }
                    column(KRA_Pin; GetKRAPin("Employee No"))
                    {
                    }
                    column(Interest_Amount; "Interest Amount")
                    {
                    }
                    column(Loan_Interest; "Loan Interest")
                    {
                    }
                    column(Loan_Balance; Balance)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                            NhifNo := Emp."NHIF No";
                            FirstName := Emp."First Name";
                            LastName := Emp."Last Name";
                            MiddleName := Emp."Middle Name";
                            TotalAmount := TotalAmount + "Assignment Matrix-X".Amount;
                        end;
                        //Get loan balances
                        LoanBalances.Reset;
                        LoanBalances.SetRange("Loan No", "Assignment Matrix-X"."Reference No");
                        LoanBalances.SetRange("Deduction Code", "Assignment Matrix-X".Code);
                        if LoanBalances.Find('-') then begin
                            case LoanBalances."Interest Calculation Method" of
                                LoanBalances."Interest Calculation Method"::"Reducing Balance", LoanBalances."Interest Calculation Method"::"Flat Rate", LoanBalances."Interest Calculation Method"::Amortised:
                                    begin
                                        LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                        LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                        Balance := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                    end;
                                else begin
                                    LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                                    LoanBalances.CalcFields(LoanBalances."Total Repayment", Receipts);
                                    Balance := (LoanBalances."Approved Amount" + LoanBalances."Total Repayment" - Abs(LoanBalances.Receipts));
                                end;
                            end;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Assignment Matrix-X".SetRange("Payroll Period", "Payroll PeriodX"."Starting Date");
                        if CompInfoSetup.Get() then;
                    end;
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                end;
            }
            trigger OnPreDataItem()
            begin
                "Payroll PeriodX".SetFilter("Starting Date", "Payroll PeriodX".GetFilter("Pay Period Filter"));
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        PayPeriodtext := "Payroll PeriodX".GetFilter("Pay Period Filter");
        Evaluate(DateSpecified, Format(PayPeriodtext));
    end;

    trigger OnInitReport()
    begin
    end;

    trigger OnPostReport()
    begin
    end;

    var
        DateSpecified: Date;
        PayPeriodtext: Text;
        NhifNo: Code[20];
        Emp: Record Employee;
        Id: Code[20];
        FirstName: Text[30];
        LastName: Text[30];
        TotalAmount: Decimal;
        "Count": Integer;
        Deductions: Record "Assignment Matrix-X";
        EmployerNHIFNo: Code[20];
        DOB: Date;
        CompInfoSetup: Record "Employee Earnings History";
        "HR Details": Record Employee;
        CompPINNo: Code[20];
        YEAR: Integer;
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        StopDate: Date;
        StartDate: array[1000] of Date;
        InitialDate: Date;
        i: Integer;
        CurrentDate: Date;
        EarningsRec: Record EarningsX;
        Payroll_PeriodCaptionLbl: Label 'Payroll Period';
        AmountCaptionLbl: Label 'Amount';
        PERIODCaptionLbl: Label 'PERIOD';
        TEL_NOCaptionLbl: Label 'TEL NO';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        PageCaptionLbl: Label 'Page';
        MONTHLY_EARNINGS_REPORTCaptionLbl: Label 'MONTHLY DEDUCTIONS REPORT';
        Total_AmountCaptionLbl: Label 'Total Amount';
        CompanyInfo: Record "Company Information";
        Balance: Decimal;
        LoanBalances: Record "Loan Application";
        MiddleName: Text[100];
        Ded: Record DeductionsX;
        DefaultLoanType: Option " ",KCB,"Coop Loan I","Coop Loan II",HELB,"Self HELB","Staff Advance","Car Loan";

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

    procedure GetKRAPin(EmpNo: Code[20]): Code[50]
    begin
        if Emp.Get(EmpNo) then exit(Emp."PIN Number");
    end;

    procedure GetIDNo(EmployeeNo: Code[20]): Code[50]
    begin
        if Emp.Get(EmployeeNo) then exit(Emp."ID No.");
    end;

    procedure GetLoanDeductionCode(LoanType: Option " ",KCB,"Coop Loan I","Coop Loan II",HELB,"Self HELB","Staff Advance","Car Loan"): Code[20]
    var
        myInt: Integer;
    begin
        Ded.Reset();
        Ded.SetRange("Loan Type", LoanType);
        if Ded.FindFirst() then exit(Ded.Code);
    end;
}
