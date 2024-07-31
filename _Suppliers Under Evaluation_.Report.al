report 50319 "Suppliers Under Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProspectiveSuppliers.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(SupplierEvaluationHeader; "Supplier Evaluation Header")
        {
            RequestFilterFields = "Quote No", Stage;

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
            column(Quote_No; "Quote No")
            {
            }
            column(Status; Status)
            {
            }
            column(Stage; Stage)
            {
            }
            column(Supplier_Code; "Supplier Code")
            {
            }
            column(Supplier_Name; "Supplier Name")
            {
            }
            dataitem("Prospective Suppliers"; "Prospective Suppliers")
            {
                DataItemLink = "No." = field("Supplier Code");

                column(Ref_No_; "No.")
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
