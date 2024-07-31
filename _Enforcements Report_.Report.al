report 50416 "Enforcements Report"
{
    RDLCLayout = './EnforcementsReport.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(EnforcementHeader; "Enforcement Header")
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
            column(Branch; Branch)
            {
            }
            column(Confiscation_Officer_No; "Confiscation Officer No")
            {
            }
            column(Confiscation_Officer_Name; "Confiscation Officer Name")
            {
            }
            //column(no)
            column(Officer_s_Telephone_No_; "Officer's Telephone No.")
            {
            }
            column(Compliance_Status; "Compliance Status")
            {
            }
            dataitem("Enforcement NonCompliance"; "Enforcement NonCompliance")
            {
                DataItemLink = "No." = field("No.");

                column(No_Lines; "No.")
                {
                }
                column(Name_Lines; Name)
                {
                }
                column(Action_To_be_Taken; "Action To be Taken")
                {
                }
                column(Compliance_Dateline; "Compliance Dateline")
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
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
