report 50328 "Prospective Suppliers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProspectiveSuppliers2.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Prospective Supplier Tender"; "Prospective Supplier Tender")
        {
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
            column(Prospect_No_; "Prospect No.")
            {
            }
            column(Tender_No_; "Tender No.")
            {
            }
            dataitem("Prospective Suppliers"; "Prospective Suppliers")
            {
                DataItemLink = "No." = field("Prospect No.");

                column(Ref_No_; "Ref No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Physical_Address; "Physical Address")
                {
                }
                column(Telephone_No; "Telephone No")
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
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
