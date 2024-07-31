report 50196 "Transport Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransportRequests.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Travel Requests"; "Travel Requests")
        {
            RequestFilterFields = "Request No.", "Request Date";

            column(Company_Name; CompanyInfo.Name)
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
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(No_of_Students; "Travel Requests"."No. of Students")
            {
            }
            column(Request_No; "Travel Requests"."Request No.")
            {
            }
            column(Request_Date; "Travel Requests"."Request Date")
            {
            }
            column(Employee_No; "Travel Requests"."Employee No.")
            {
            }
            column(Employee_Name; "Travel Requests"."Employee Name")
            {
            }
            column(Destination; "Travel Requests".Destinations)
            {
            }
            column(No_of_Personnel_; "Travel Requests"."No. of Personnel")
            {
            }
            column(Status; "Travel Requests".Status)
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
        Status: Option;
}
