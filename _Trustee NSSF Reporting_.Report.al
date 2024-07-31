report 50282 "Trustee NSSF Reporting"
{
    Caption = 'NSSF reporting';
    DefaultLayout = RDLC;
    RDLCLayout = './TrusteeNSSFReporting.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") ORDER(Ascending) WHERE(Type = CONST(Deduction), "Employee type" = filter(Trustee));
            RequestFilterFields = "Payroll Period", "Code";
            RequestFilterHeading = 'NSSF';

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUND__; 'NATIONAL SOCIAL SECURITY FUND ')
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CoNssf; CoNssf)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUND___Control28; 'NATIONAL SOCIAL SECURITY FUND ')
            {
            }
            column(P_O__BOX_30599__; 'P.O. BOX 30599 ')
            {
            }
            column(NAIROBI__; 'NAIROBI ')
            {
            }
            column(Assignment_Matrix_X__Employee_No_; "Employee No")
            {
            }
            column(Name; Name)
            {
            }
            column(ID_No; IDNo)
            {
            }
            column(Emp_Nssf_No; NSSFNo)
            {
            }
            column(ABS_Amount_; Abs(Amount))
            {
            }
            column(ABS__Employer_Amount___; Abs(EmployerAmt))
            {
            }
            column(Emp__Social_Security_No__; Emp."Social Security No.")
            {
            }
            column(ABS__Employer_Amount____ABS_Amount__ABS_EmpVoluntary_; Abs("Employer Amount") + Abs(Amount) + Abs(EmpVoluntary))
            {
            }
            column(ABS_EmpVoluntary_; Abs(EmpVoluntary))
            {
            }
            column(EmployeeTotal; EmployeeTotal)
            {
            }
            column(EmployerTotal; EmployerTotal)
            {
            }
            column(SumTotal; SumTotal)
            {
            }
            column(ABS_EmpVoluntary__Control1000000013; Abs(EmpVoluntary))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(COMPANY_NSSF_No_Caption; COMPANY_NSSF_No_CaptionLbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(CONTRIBUTIONS_RETURN_FORMCaption; CONTRIBUTIONS_RETURN_FORMCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(Employee_VoluntaryCaption; Employee_VoluntaryCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
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
            column(DESIGNATION____________________________________________________________Caption_Control1000000006; DESIGNATION____________________________________________________________Caption_Control1000000006Lbl)
            {
            }
            column(DATE_____________________________________________________________________Caption_Control1000000007; DATE_____________________________________________________________________Caption_Control1000000007Lbl)
            {
            }
            column(NAME_________________________________________________________________________Caption_Control1000000008; NAME_________________________________________________________________________Caption_Control1000000008Lbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption_Control1000000009; SIGNATURE___________________________________________________________Caption_Control1000000009Lbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
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
            column(Gross_Pay; GetGrossPay("Employee No"))
            {
            }
            column(Surname; Surname)
            {
            }
            column(OtherName; OtherName)
            {
            }
            column(KRAPinNo; KRAPinNo)
            {
            }
            column(CompName; CompName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Employee No") then begin
                    Name := Emp."First Name" + ' ' + Emp."Last Name";
                    Surname := Emp."Last Name";
                    OtherName := Emp."First Name" + ' ' + Emp."Middle Name";
                    KRAPinNo := Emp."PIN Number";
                    IDNo := Emp."ID No.";
                    NSSFNo := Emp."NSSF No.";
                    Emp.SetRange(Emp."Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                    Emp.CalcFields(Emp."Basic Pay");
                    if BeginDate = DateSpecified then
                        BasicPay := Emp."Basic Pay"
                    else
                        BasicPay := Emp."Basic Pay";
                    SSFNo := Emp."Social Security No.";
                end;
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Payment then begin
                    if Payment.Get("Assignment Matrix-X".Code) then GroupHeader := Payment.Description;
                end;
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
                    if Deduction.Get("Assignment Matrix-X".Code) then begin
                        GroupHeader := Deduction.Description;
                        //******Get Voluntary Contributions***********//
                        Deduction.SetRange(Deduction."Voluntary Code", "Assignment Matrix-X".Code);
                        Deduction.SetRange(Deduction."Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                        Deduction.SetRange(Deduction."Employee Filter", "Assignment Matrix-X"."Employee No");
                        Deduction.CalcFields("Voluntary Amount");
                        EmpVoluntary := Deduction."Voluntary Amount";
                    end;
                    EmployerAmt := "Assignment Matrix-X".Amount;
                end;
                TotalBasic := TotalBasic + BasicPay;
                EmployerTotal := EmployerTotal + Abs("Assignment Matrix-X"."Employer Amount");
                EmployeeTotal := EmployeeTotal + Abs("Assignment Matrix-X".Amount);
                SumTotal := SumTotal + Abs("Assignment Matrix-X"."Employer Amount") + Abs("Assignment Matrix-X".Amount) + Abs(EmpVoluntary);
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Code);
                //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                "Assignment Matrix-X".SetRange("Assignment Matrix-X".Type, "Assignment Matrix-X".Type::Deduction);
                //CurrReport.CreateTotals(EmpVoluntary);
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
        CompRec.Get;
        HRSetup.Get();
        HRSetup.TestField("Company NSSF No");
        CoNssf := HRSetup."Company NSSF No";
        CompName := CompRec.Name;
        GetPayPeriod;
        DateSpecified := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X"."Payroll Period");
        if PayPeriod.Get(DateSpecified) then PayPeriodText := PayPeriod.Name;
        nssfcode := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X".Code);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Emp: Record Employee;
        Name: Text[250];
        Payment: Record EarningsX;
        Deduction: Record DeductionsX;
        TypeFilter: Text[30];
        GroupHeader: Text[30];
        BasicPay: Decimal;
        SSFNo: Code[30];
        TotalBasic: Decimal;
        PayPeriod: Record "Payroll Period Trustees";
        PayPeriodText: Text[30];
        Title: Text[30];
        DateSpecified: Date;
        BeginDate: Date;
        CompRec: Record "Company Information";
        CoNssf: Text[30];
        SumTotal: Decimal;
        EmployeeTotal: Decimal;
        EmployerTotal: Decimal;
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        nssfcode: Code[10];
        EmpVoluntary: Decimal;
        HRSetup: Record "Human Resources Setup";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        COMPANY_NSSF_No_CaptionLbl: Label 'COMPANY NSSF No.';
        UserCaptionLbl: Label 'User';
        CONTRIBUTIONS_RETURN_FORMCaptionLbl: Label 'CONTRIBUTIONS RETURN FORM';
        PERIODCaptionLbl: Label 'PERIOD';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        NSSF_No_CaptionLbl: Label 'NSSF No.';
        Employee_VoluntaryCaptionLbl: Label 'Employee Voluntary';
        TotalCaptionLbl: Label 'Total';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        Approving_OfficerCaptionLbl: Label 'Approving Officer';
        DESIGNATION____________________________________________________________Caption_Control1000000006Lbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________Caption_Control1000000007Lbl: Label 'DATE ....................................................................';
        NAME_________________________________________________________________________Caption_Control1000000008Lbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________Caption_Control1000000009Lbl: Label 'SIGNATURE ..........................................................';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        IDNo: Code[20];
        NSSFNo: Code[20];
        GrossPay: Decimal;
        EmployerAmt: Decimal;
        Surname: Text;
        OtherName: Text;
        KRAPinNo: Code[50];
        CompName: Text;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then BeginDate := PayPeriod."Starting Date";
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

    procedure GetGrossPay(EmpNo: Code[20]): Decimal
    var
        AssMatrix: Record "Assignment Matrix-X";
        Gpay: Decimal;
    begin
        AssMatrix.Reset;
        AssMatrix.SetRange(Type, AssMatrix.Type::Payment);
        AssMatrix.SetRange("Payroll Period", DateSpecified);
        AssMatrix.SetRange("Employee No", EmpNo);
        AssMatrix.SetRange(Taxable, true);
        if AssMatrix.Find('-') then begin
            AssMatrix.CalcSums(Amount);
            Gpay := AssMatrix.Amount;
        end;
        exit(Gpay);
    end;
}
