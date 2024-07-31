report 50192 "Employee Data"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeData.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Salary Scale", "Job Position";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
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
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(Job_ID; Employee."Job Position")
            {
            }
            column(JobTitle_Employee; Employee."Job Title")
            {
            }
            column(GlobalDimension1Code_Employee; Employee."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Employee; GetDept(Employee."Global Dimension 2 Code"))
            {
            }
            column(Salary_Scale; Employee."Salary Scale")
            {
            }
            column(Pointer_Employee; Employee.Present)
            {
            }
            column(Employment_Date; Employee."Employment Date")
            {
            }
            column(Date_of_Birth; Employee."Birth Date")
            {
            }
            column(Basic_Pay; Employee."Basic Pay")
            {
            }
            column(House_Allowance; Employee."House Allowance")
            {
            }
            column(Gender; Employee.Gender)
            {
            }
            column(Ethnicity; Employee."Ethnic Origin")
            {
            }
            column(employee_Country; Employee."Country/Region Code")
            {
            }
            column(Disability; Employee.Disability)
            {
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";

    procedure GetDept("Code": Code[20]): Text[200]
    var
        DimValue: Record "Dimension Value";
    begin
        DimValue.Reset;
        DimValue.SetRange(Code, Code);
        if DimValue.Find('-') then begin
            exit(DimValue.Name);
        end;
    end;
}
