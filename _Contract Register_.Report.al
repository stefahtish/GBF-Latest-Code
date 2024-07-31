report 50488 "Contract Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ContractRegister.rdl';

    dataset
    {
        dataitem("Project Header"; "Project Header")
        {
            column(Company_Logo; CompInfor.Picture)
            {
            }
            column(No_; "No.")
            {
            }
            column(Nature_Of_Contract; "Nature Of Contract")
            {
            }
            column(ScopeofContract_ProjectHeader; "Scope of Contract")
            {
            }
            column(Parties_ProjectHeader; Parties)
            {
            }
            column(Responsibilty_Holder; "Responsibilty Holder")
            {
            }
            column(Responsibilty_Holder_Name; "Responsibilty Holder Name")
            {
            }
            column(Company_E_mail; "Company E-mail")
            {
            }
            column(Company_Physical_Address; "Company Physical Address")
            {
            }
            column(Company_PIN_No_; "Company PIN No.")
            {
            }
            column(Company_Telephone_No; "Company Telephone No")
            {
            }
            column(Contact_Person; "Contact Person")
            {
            }
            column(Contact_Phone_No_; "Contact Phone No.")
            {
            }
            column(Contact_E_Mail_Address; "Contact E-Mail Address")
            {
            }
            column(Contract_No; "Contract No")
            {
            }
            column(Job_Title; "Job Title")
            {
            }
            column(Branch_Code; "Branch Code")
            {
            }
            column(Bank_account_No; "Bank account No")
            {
            }
            column(Bank_Code; "Bank Code")
            {
            }
            column(Terms_And_Conditions; "Terms And Conditions")
            {
            }
            column(Special_Conditions; "Special Conditions")
            {
            }
            column(Project_Date; "Project Date")
            {
            }
            column(EstimatedStartDate_ProjectHeader; "Estimated Start Date")
            {
            }
            column(Actual_End_Date; "Actual End Date")
            {
            }
            column(Actual_Start_Date; "Actual Start Date")
            {
            }
            column(Estimated_End_Date; "Estimated End Date")
            {
            }
            column(Actual_Duration; "Actual Duration")
            {
            }
            column(Estimated_Duration; "Estimated Duration")
            {
            }
            column(Extension_duration; "Extension duration")
            {
            }
            column(Project_Budget; "Project Budget")
            {
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
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfor.Get();
        CompInfor.CalcFields(Picture);
    end;
    var CompInfor: Record "Company Information";
}
