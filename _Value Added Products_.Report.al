report 50432 "Value Added Products"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Value Added Product Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Value Added Product.RDL';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(Name_DataItemName; Name)
            {
            }
            column(No_DataItemName; "No.")
            {
            }
            column(Month; Month)
            {
            }
            dataitem("Licensing dairy Enterprise"; "Licensing dairy Enterprise")
            {
                DataItemLink = "Customer No."=field("No.");

                column(BusinessName_LicensingdairyEnterprise; "Business Name")
                {
                }
                dataitem("Issued Applicant License"; "Issued Applicant License")
                {
                    DataItemLink = "Applicant No."=field("Application No");

                    column(LicenseNo_IssuedApplicantLicense; "License No.")
                    {
                    }
                    column(Category_IssuedApplicantLicense; Category)
                    {
                    }
                }
                dataitem("Applicants Products per outlet"; "Applicants Products per outlet")
                {
                    DataItemLink = "Application No"=field("Application No");

                    column(Product_ApplicantsProductsperoutlet; Product)
                    {
                    }
                    column(Quantityhandled_ApplicantsProductsperoutlet; "Quantity handled")
                    {
                    }
                }
                dataitem("Monthly Form of Return"; "Monthly Form of Return")
                {
                    DataItemLink = "No."=field("Application No");

                    column(AmountPaid_MonthlyFormofReturn; "Amount Paid")
                    {
                    }
                    dataitem("Monthly Returns  Product"; "Monthly Returns  Product")
                    {
                        DataItemLink = "ApplicationNo"=field("No.");

                        column(Product_MonthlyReturnsProduct; Product)
                        {
                        }
                        column(Quantity_MonthlyReturnsProduct; Quantity)
                        {
                        }
                    }
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
                // field(Name; SourceExpression)
                // {
                //     ApplicationArea = All;
                // }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        Month:=FORMAT(Today, 0, '<Month Text>');
        License.Reset();
        License.SetRange("Customer No.", Customer."No.");
        ApplicantLicense.Reset();
        ApplicantLicense.SetRange("Applicant No.", License."Application no");
        Products.Reset();
        Products.SetRange("Application no", ApplicantLicense."Applicant No.");
        Returns.Reset();
        Returns.SetRange("Applicant No.", ApplicantLicense."Applicant No.");
    end;
    var Month: Text;
    License: Record "Licensing dairy Enterprise";
    ApplicantLicense: Record "Issued Applicant License";
    Products: Record "Applicants Products per outlet";
    Returns: Record "Monthly Form of Return";
}
