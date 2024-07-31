report 50191 "Employee Important Dates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeImportantDates.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Emp_No; Employee."No.")
            {
            }
            column(Emp_FirstName; Employee."First Name")
            {
            }
            column(Emp_MiddleName; Employee."Middle Name")
            {
            }
            column(Emp_LastName; Employee."Last Name")
            {
            }
            column(Date_of_Birth; Employee."Birth Date")
            {
            }
            column(Date_of_Join; Employee."Date Of Join")
            {
            }
            column(Date_of_Leaving; Employee."Date Of Leaving")
            {
            }
            column(PensionSchemeJoin_Employee; Employee."Pension Scheme Join")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
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
}
