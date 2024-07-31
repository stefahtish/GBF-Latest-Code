report 50247 "Monthly Difference Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MonthlyDifferenceReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            DataItemTableView = where("Employee type" = filter(<> trustee));
            RequestFilterFields = "Payroll Period";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Earn_Name; GetEarningCode("Assignment Matrix-X".Code))
            {
            }
            column(Code_AssignmentMatrixX; "Assignment Matrix-X".Code)
            {
            }
            column(Payroll_Period; "Assignment Matrix-X"."Payroll Period")
            {
            }
            column(Employee_No; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Employee_Name; GetEmpName("Assignment Matrix-X"."Employee No"))
            {
            }
            column(Amount; "Assignment Matrix-X".Amount)
            {
            }
            column(Previos_Period; XPeriod)
            {
            }
            column(Previous_Amount; XAmount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if PayPeriod.Get("Assignment Matrix-X"."Payroll Period") then XPeriod := CalcDate('-1M', "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", XPeriod);
                AssignMatrix.SetRange("Employee No", "Assignment Matrix-X"."Employee No");
                AssignMatrix.SetRange(Code, "Assignment Matrix-X".Code);
                if AssignMatrix.Find('-') then //AssignMatrix.CALCFIELDS(Amount);
                    XAmount := AssignMatrix.Amount;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        AssignMatrix: Record "Assignment Matrix-X";
        TotalAmount: Decimal;
        PayPeriod: Record "Payroll PeriodX";
        XPeriod: Date;
        XAmount: Decimal;
        CompanyInfo: Record "Company Information";

    procedure GetMonth()
    begin
    end;

    procedure GetEarningCode("Code": Code[20]): Text
    var
        Earnings: Record EarningsX;
        Deductions: Record DeductionsX;
    begin
        if Earnings.Get(Code) then exit(Earnings.Description);
        if Deductions.Get(Code) then exit(Deductions.Description);
    end;

    procedure GetEmpName(EmployeeNo: Code[20]): Text[200]
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
}
