report 50253 NHIF
{
    DefaultLayout = RDLC;
    RDLCLayout = './NHIF.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE(Type = CONST(Deduction), "Employee type" = filter(<> trustee));
            RequestFilterFields = "Payroll Period", "Code";

            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Address; Address)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME_Control1000000006; CompanyName)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4_____Control1000000009; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerNHIFNo_Control1000000007; EmployerNHIFNo)
            {
            }
            column(ABS__Assignment_Matrix_X1__Amount_; Abs("Assignment Matrix-X".Amount))
            {
            }
            column(Emp__ID_Number_; Emp."ID No.")
            {
            }
            column(YEAR; YEAR)
            {
            }
            column(Emp__NHIF_No__; Emp."NHIF No")
            {
            }
            column(FirstName_____Emp__Middle_Name______LastName; FirstName + ' ' + Emp."Middle Name" + ' ' + LastName)
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Assignment_Matrix_X__Payroll_Group_; "Payroll Group")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Counter; Counter)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(ID_PassportCaption; ID_PassportCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaption; MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(AmountCaption_Control1000000005; AmountCaption_Control1000000005Lbl)
            {
            }
            column(PageCaption_Control44; PageCaption_Control44Lbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(ID_PassportCaption_Control1000000049; ID_PassportCaption_Control1000000049Lbl)
            {
            }
            column(Date_of_BirthCaption_Control1000000051; Date_of_BirthCaption_Control1000000051Lbl)
            {
            }
            column(NHIF_No_Caption_Control1000000053; NHIF_No_Caption_Control1000000053Lbl)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaption; NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
            {
            }
            column(EMPLOYER_NOCaption_Control1000000008; EMPLOYER_NOCaption_Control1000000008Lbl)
            {
            }
            column(Payroll_No_Caption_Control1000000056; Payroll_No_Caption_Control1000000056Lbl)
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
            column(IdNo; IdNo)
            {
            }
            column(OtherNames; OtherNames)
            {
            }
            column(CompName; CompName)
            {
            }
            column(LastName; LastName)
            {
            }
            column(Today; Today)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                    NhifNo := Emp."NHIF No";
                    FirstName := Emp."First Name";
                    LastName := Emp."Last Name";
                    OtherNames := Emp."First Name" + ' ' + Emp."Middle Name";
                    IdNo := Emp."ID No.";
                    //YEAR:=Emp."Birth Date";
                    TotalAmount := TotalAmount + Abs("Assignment Matrix-X".Amount);
                end;
                Counter := Counter + 1;
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
        DateSpecified := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X"."Payroll Period");
        NHIFCODE := "Assignment Matrix-X".GetRangeMin("Assignment Matrix-X".Code);
        CompInfoSetup.Get();
        CompName := CompInfoSetup.Name;
        HRSetup.Get();
        HRSetup.TestField("Company NHIF No");
        EmployerNHIFNo := HRSetup."Company NHIF No";
        //CompPINNo:=CompInfoSetup."Scheme PIN No.";
        Address := CompInfoSetup.Address;
        Tel := CompInfoSetup."Phone No.";
    end;

    var
        DateSpecified: Date;
        NhifNo: Code[20];
        Emp: Record Employee;
        IdNo: Code[20];
        FirstName: Text[30];
        LastName: Text[30];
        TotalAmount: Decimal;
        "Count": Integer;
        Deductions: Record DeductionsX;
        EmployerNHIFNo: Code[20];
        DOB: Date;
        CompInfoSetup: Record "Company Information";
        "HR Details": Record Employee;
        CompPINNo: Code[20];
        YEAR: Date;
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        LastFieldNo: Integer;
        BeginDate: Date;
        NHIFCODE: Code[10];
        HRSetup: Record "Human Resources Setup";
        AmountCaptionLbl: Label 'Amount';
        PageCaptionLbl: Label 'Page';
        ID_PassportCaptionLbl: Label 'ID/Passport';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        PERIODCaptionLbl: Label 'PERIOD';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        NHIF_No_CaptionLbl: Label 'NHIF No.';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl: Label 'MONTHLY PAYROLL (BY-PRODUCT) RETURNS TO NHIF';
        TEL_NOCaptionLbl: Label 'TEL NO';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        AmountCaption_Control1000000005Lbl: Label 'Amount';
        PageCaption_Control44Lbl: Label 'Page';
        UserCaptionLbl: Label 'User';
        ID_PassportCaption_Control1000000049Lbl: Label 'ID/Passport';
        Date_of_BirthCaption_Control1000000051Lbl: Label 'Date of Birth';
        NHIF_No_Caption_Control1000000053Lbl: Label 'NHIF No.';
        NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND REPORT';
        Name_of_EmployeeCaption_Control1000000055Lbl: Label 'Name of Employee';
        EMPLOYER_NOCaption_Control1000000008Lbl: Label 'EMPLOYER NO';
        Payroll_No_Caption_Control1000000056Lbl: Label 'Payroll No.';
        OtherNames: Text;
        CompName: Text;

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

    procedure GetDefaults(): Code[20]
    var
        Ded: record DeductionsX;
    begin
        Ded.reset;
        Ded.SetRange(nhif, true);
        if Ded.FindFirst() then exit(Ded.Code);
    end;
}
