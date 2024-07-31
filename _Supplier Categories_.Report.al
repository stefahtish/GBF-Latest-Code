report 50482 "Supplier Categories"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './suppliercategories.rdl';

    dataset
    {
        dataitem("Prequalified Supplier Categ"; "Prequalified Supplier Categ")
        {
            RequestFilterFields = "Category Code";

            column(Category_Code; "Category Code")
            {
            }
            column(Category; Category)
            {
            }
            column(Vendor; Vendor)
            {
            }
            dataitem("Prospective Suppliers"; "Prospective Suppliers")
            {
                DataItemLink = "No."=field(Vendor);

                column(No_; "No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Company_PIN_No_; "Company PIN No.")
                {
                }
                column(Organization_Type; "Organization Type")
                {
                }
                column(Mobile_No; "Mobile No")
                {
                }
                column(E_mail; "E-mail")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var myInt: Integer;
}
