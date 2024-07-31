report 50219 "NHIF 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NHIF2.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            DataItemTableView = where("Employee type" = filter(<> trustee));

            column(Payroll_No; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Surname; Surname)
            {
            }
            column(Other_Names; FirstName)
            {
            }
            column(NHIF_No; NHIFNo)
            {
            }
            column(ID_No; IDNo)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Contact; CompanyInfo."Phone No.")
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Today; Today)
            {
            }
            dataitem("Company Information"; "Company Information")
            {
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
                {
                }
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(EMail_CompanyInformation; "Company Information"."E-Mail")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Employee.Get("Assignment Matrix-X"."Employee No") then begin
                    EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    NHIFNo := Employee."NHIF No";
                    IDNo := Employee."ID No.";
                    FirstName := Employee."First Name" + ' ' + Employee."Middle Name";
                    Surname := Employee."Last Name";
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
        CompanyInfo.Get();
        HRSetup.Get();
    end;

    var
        DateSpecified: Date;
        TotalAmount: Decimal;
        "Count": Integer;
        Deductions: Record DeductionsX;
        EmployerNHIFNo: Code[20];
        DOB: Date;
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        CompPINNo: Code[20];
        YEAR: Date;
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        LastFieldNo: Integer;
        BeginDate: Date;
        NHIFCODE: Code[10];
        HRSetup: Record "Human Resources Setup";
        EmployeeName: Text;
        FirstName: Text;
        Surname: Text;
        NHIFNo: Code[20];
        IDNo: Code[20];

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
