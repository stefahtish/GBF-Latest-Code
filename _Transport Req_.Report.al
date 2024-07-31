report 50187 "Transport Req"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransportReq.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Travel Requests"; "Travel Requests")
        {
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Picture; CompanyInfo.Picture)
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
            column(Request_No; "Travel Requests"."Request No.")
            {
            }
            column(Request_Date; "Travel Requests"."Request Date")
            {
            }
            column(Start_Date; "Travel Requests"."Trip Planned Start Date")
            {
            }
            column(End_Date; "Travel Requests"."Trip Planned End Date")
            {
            }
            column(Destination; "Travel Requests".Destinations)
            {
            }
            column(Status; "Travel Requests".Status)
            {
            }
            column(No_of_Non_Employees; "Travel Requests"."No. of Non Employees")
            {
            }
            column(No_of_Personnel; "Travel Requests"."No. of Personnel")
            {
            }
            column(No_of_Students; "Travel Requests"."No. of Students")
            {
            }
            column(Counter; Counter)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Counter := "Travel Requests".Count + 1;
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
        Counter: Integer;
}
