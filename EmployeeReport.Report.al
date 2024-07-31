report 50515 EmployeeReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Employee Report';
    RDLCLayout = './Reports/EmployeeReport.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Pay Period Filter";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr; CompanyInfo.Address)
            {
            }
            column(CompanyCIty; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(FullName; FullName)
            {
            }
            column(Birth_Date; "Birth Date")
            {
            }
            column(Basic_Pay; "Basic Pay")
            {
            }
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(Bank_Account_Number; "Bank Account Number")
            {
            }
            column(Bank_Account_Name;'')
            {
            }
            column(PIN_Number; "PIN Number")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(NSSF_No_; "NSSF No.")
            {
            }
            column(NHIF_No; "NHIF No")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Job_Title; "Job Title")
            {
            }
            column(Salary_Scale; "Salary Scale")
            {
            }
            column(Cost_Center_Code; "Cost Center Code")
            {
            }
            column(Date_of_Birth___Age; "Date of Birth - Age")
            {
            }
            column(Appointmet_Date; "Date Of Join")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
    var myInt: Integer;
    CompanyInfo: Record "Company Information";
    EndDate: Date;
    StartDate: Date;
}
