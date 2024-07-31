report 50417 "Permit Applications"
{
    RDLCLayout = './PermitApplications.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(LicenseApplications; "License Applications")
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
            column(Application_Date; "Application Date")
            {
            }
            column(Outlet; Outlet)
            {
            }
            column(Category; Category)
            {
            }
            column(Paid_license_fee; "Paid license fee")
            {
            }
            column(Status; Status)
            {
            }
            column(Reason_for_non_issuance; "Reason for non-issuance")
            {
            }
            column(Name; Name)
            {
            }
            column(Station; Station)
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
