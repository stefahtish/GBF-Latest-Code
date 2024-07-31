report 50418 "Levy Defaulters"
{
    RDLCLayout = './LevyDefaulters.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(MonthlyFormofReturn2; "Monthly Form of Return")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(No_; "No.")
            {
            }
            column(Applicant_No_; "Applicant No.")
            {
            }
            column(Applicant_Name; "Applicant Name")
            {
            }
            column(Base_Date; "Base Date")
            {
            }
            column(Total_Amount; "Total Amount")
            {
            }
            column(Paid; Paid)
            {
            }
            column(Date_of_Last_Return; "Date of Last Return")
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
