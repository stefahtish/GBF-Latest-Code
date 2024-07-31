report 50406 "Maintenace Job Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './JobCard.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(MaintenanceRegistration; "Maintenance Registration")
        {
            column(FANo; "FA No.")
            {
            }
            column(DateofService; "Date of Service")
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(DriversSignature; "Driver's Signature")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(InvoiceNo; "Invoice No.")
            {
            }
            column(ItemClassCode; "Item Class Code")
            {
            }
            column(ItemDescription; "Item Description")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(MaintenanceNo; "Maintenance No")
            {
            }
            column(MaintenanceVendorNo; "Maintenance Vendor No.")
            {
            }
            column(ServiceProviderName; "Service Provider Name")
            {
            }
            column(ServiceProvider; "Service Provider")
            {
            }
            column(ServiceRepairDescription; "Service/Repair Description")
            {
            }
            column(ServiceType; "Service Type")
            {
            }
            column(ServiceDate; "Service Date")
            {
            }
            column(ServiceIntervalType; "Service Interval Type")
            {
            }
            column(ServiceIntervals; "Service Intervals")
            {
            }
            column(ServiceLSOLPONo; "Service LSO/LPO No.")
            {
            }
            column(ServiceMileage; "Service Mileage")
            {
            }
            column(ServicePeriod; "Service Period")
            {
            }
            column(TransportManagerRemarks; "Transport Manager Remarks")
            {
            }
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
    trigger OnInitReport()
    begin
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
