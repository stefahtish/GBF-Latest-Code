report 50292 "Master Roll-Board Members"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MasterRollBoardMembers.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(AssignmentMatrixX; "Assignment Matrix-X")
        {
            DataItemTableView = sorting("Employee No") WHERE("Employee Type" = const(Trustee));
            RequestFilterFields = "Payroll Period";

            column(EmployeeNo; "Employee No")
            {
            }
            column(Type; Type)
            {
            }
            column(Code; Code)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Description; Description)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(CodeName; CodeName)
            {
            }
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
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
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            trigger OnAfterGetRecord()
            begin
                NetPay := 0;
                TotalEarnings := 0;
                TotalDeductions := 0;
                if EmpRec.Get(AssignmentMatrixX."Employee No") then begin
                    EmpName := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    Employee.Reset();
                    Employee.SetFilter("No.", EmpRec."No.");
                    Employee.SetRange("Pay Period Filter", DateSpecified);
                    if Employee.FindFirst then begin
                        Employee.CalcFields("Total Allowances", "Total Deductions");
                        TotalEarnings := Employee."Total Allowances";
                        TotalDeductions := Employee."Total Deductions";
                        NetPay := Employee."Total Allowances" - abs(Employee."Total Deductions");
                    end;
                end;
                case AssignmentMatrixX.Type of
                    AssignmentMatrixX.Type::Payment:
                        begin
                            Earnings.get(AssignmentMatrixX.Code);
                            CodeName := Earnings.Description;
                        end;
                    AssignmentMatrixX.Type::Deduction:
                        begin
                            Deductions.get(AssignmentMatrixX.Code);
                            CodeName := Deductions.Description;
                        end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        DateSpecified := AssignmentMatrixX.GetRangeMin("Payroll Period");
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        EmpRec: Record Employee;
        NetPay: Decimal;
        TotalEarnings: Decimal;
        TotalDeductions: Decimal;
        DateSpecified: Date;
        EmpName: Text;
        Earnings: Record EarningsX;
        Deductions: Record DeductionsX;
        CodeName: Text;
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
}
