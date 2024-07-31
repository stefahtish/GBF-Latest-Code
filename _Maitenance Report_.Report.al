report 50186 "Maitenance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MaitenanceReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Maintenance Registration"; "Maintenance Registration")
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
            column(Maintenance_No; "Maintenance Registration"."Maintenance No")
            {
            }
            column(FA_No; "Maintenance Registration"."FA No.")
            {
            }
            column(Service_Date; "Maintenance Registration"."Service Date")
            {
            }
            column(Item_No; "Maintenance Registration"."Item No.")
            {
            }
            column(Item_Description; "Maintenance Registration"."Item Description")
            {
            }
            column(Date_of_Service; "Maintenance Registration"."Date of Service")
            {
            }
            column(Date; "Maintenance Registration".Date)
            {
            }
            column(Amount; "Maintenance Registration".Amount)
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
