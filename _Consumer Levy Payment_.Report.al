report 50433 "Consumer Levy Payment"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Consumer Levy Payment';
    DefaultLayout = RDLC;
    RDLCLayout = './Consumer Levy Payment.rdl';

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
                // RequestFilterFields = "Application no";
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
                dataitem("Monthly Form of Return"; "Monthly Form of Return")
                {
                    DataItemLink = "Applicant No."=field("Application No");

                    column(BaseDate_MonthlyFormofReturn; "Base Date")
                    {
                    }
                    column(TotalAmount_MonthlyFormofReturn; "Total Amount")
                    {
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
        License.Reset();
        License.SetRange("Customer No.", Customer."No.");
        ApplicantLicense.Reset();
        ApplicantLicense.SetRange("Applicant No.", License."Application no");
        Products.Reset();
        Products.SetRange("Application no", ApplicantLicense."Applicant No.");
        Returns.Reset();
    end;
    var Month: Text;
    License: Record "Licensing dairy Enterprise";
    ApplicantLicense: Record "Issued Applicant License";
    Products: Record "Applicants Products per outlet";
    Returns: Record "Monthly Form of Return";
}
