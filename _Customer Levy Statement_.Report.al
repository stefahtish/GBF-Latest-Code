report 50429 "Customer Levy Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerLevyStatement.rdlc';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Customer Levy Statement';

    dataset
    {
        dataitem(LicenseApplications; "License Applications")
        {
            column(CustomerNo; "Customer No.")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApplicationType; "Application Type")
            {
            }
            column(ApprovalStatus; "Approval Status")
            {
            }
            column(Category; Category)
            {
            }
            column(Email; Email)
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(HeadOffice; "Head Office")
            {
            }
            column(Headofficecomment; "Head office comment")
            {
            }
            column(Inspectionfindings; "Inspection findings")
            {
            }
            column(InvoiceNo; "Invoice No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Paid; Paid)
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
}
