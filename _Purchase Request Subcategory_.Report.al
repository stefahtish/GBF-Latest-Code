report 50294 "Purchase Request Subcategory"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseRequestSubcategory.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(InternalRequestHeader; "Internal Request Header")
        {
            column(No; "No.")
            {
            }
            column(Supplier_Subcategory; "Supplier Subcategory")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(ProcurementPlan; "Procurement Plan")
            {
            }
            column(ReasonDescription; "Reason Description")
            {
            }
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
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
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
