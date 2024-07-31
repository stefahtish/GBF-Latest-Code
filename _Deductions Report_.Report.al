report 50239 "Deductions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DeductionsReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where("Employment type" = filter(<> trustee));

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
            column(No_Employee; Employee."No.")
            {
            }
            column(First_Name; Employee."First Name")
            {
            }
            column(Middle_Name; Employee."Middle Name")
            {
            }
            column(Last_Name; Employee."Last Name")
            {
            }
            column(ID_No; Employee."ID No.")
            {
            }
            column(PIN_Number; Employee."PIN Number")
            {
            }
            column(Total_Deductions; Employee."Total Deductions")
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
}
