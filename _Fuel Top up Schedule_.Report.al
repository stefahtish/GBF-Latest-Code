report 50393 "Fuel Top up Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FuelTopupSchedule.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(FuelAllocations; "Fuel Allocations")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddr; CompanyAddr)
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
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(Period; Period)
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
            column(TotalBalance; "Total Balance")
            {
            }
            column(TotalUsage; "Total Usage")
            {
            }
            column(Startdate; "Start date")
            {
            }
            column(Enddate; "End date")
            {
            }
            dataitem("Fuel Allocation Lines"; "Fuel Allocation Lines")
            {
                DataItemLink = Period = field(Period);

                column(Vehicle; Vehicle)
                {
                }
                column(Usage; Usage)
                {
                }
                column(Minimum_Amount; "Minimum Amount")
                {
                }
                column(Balance; Balance)
                {
                }
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
        CompanyAddr: Code[80];
}
