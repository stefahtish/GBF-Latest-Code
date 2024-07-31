report 50237 "Staff Pension Contribution"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffPensionContribution.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(AssignMatrix; "Assignment Matrix-X")
        {
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
            column(Employee_No; AssignMatrix."Employee No")
            {
            }
            column(Basic_Pay; BasicPay)
            {
            }
            column(EE_Amount; Abs(EE))
            {
            }
            column(ER_Amount; ER)
            {
            }
            column(AVC; AVC)
            {
            }
            column(Employee_Name; Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if AssignMatrix.Retirement then begin
                    EE := AssignMatrix.Amount;
                    ER := AssignMatrix."Employer Amount";
                    AVC := AssignMatrix."Employee Voluntary" + AssignMatrix."Employer Voluntary";
                end;
                if AssignMatrix."Basic Salary Code" then begin
                    BasicPay := AssignMatrix.Amount;
                end;
                Employee.Reset;
                Employee.SetRange("No.", AssignMatrix."Employee No");
                if Employee.Find('-') then begin
                    Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        Name: Text;
        BasicPay: Decimal;
        EE: Decimal;
        ER: Decimal;
        AVC: Decimal;
}
