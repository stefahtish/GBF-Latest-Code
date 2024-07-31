report 50478 "Contract Expiry"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ContractExpiry.rdl';

    dataset
    {
        dataitem("Project Header"; "Project Header")
        {
            column(No_; "No.")
            {
            }
            column(Estimated_Start_Date; "Estimated Start Date")
            {
            }
            column(Estimated_End_Date; "Estimated End Date")
            {
            }
            column(Project_Budget; "Project Budget")
            {
            }
            column(Description; Description)
            {
            }
            column(Direct_Contract; "Direct Contract")
            {
            }
            column(Contact_Person; "Contact Person")
            {
            }
            column(Contact_E_Mail_Address; "Contact E-Mail Address")
            {
            }
            column(Company_E_mail; "Company E-mail")
            {
            }
            column(Company_Logo; CompanyInfor.Picture)
            {
            }
            column(Company_Name; CompanyInfor.Name)
            {
            }
            trigger OnPreDataItem()
            begin
                Clear(EstimatedDate);
                PurchSetup.Get();
                EstimatedDate:=CalcDate(PurchSetup."Contract Notification Period", Today);
                "Project Header".SetFilter("Estimated End Date", '%1..%2', Today, EstimatedDate);
            end;
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
    }
    trigger OnPreReport()
    begin
        CompanyInfor.get();
        CompanyInfor.CalcFields(Picture);
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    EstimatedDate: Date;
    CompanyInfor: Record "Company Information";
}
