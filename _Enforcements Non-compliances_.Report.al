report 50415 "Enforcements Non-compliances"
{
    RDLCLayout = './Enforcements.rdl';
    WordLayout = './Enforcements.docx';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem("Enforcement NonCompliance"; "Enforcement NonCompliance")
        {
            DataItemTableView = where(Overdue = const(true));

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
            column(Confiscation_Officer_No; "Compliance Officer No")
            {
            }
            column(Confiscation_Officer_Name; "Compliance Officer Name")
            {
            }
            dataitem(EnforcementHeader; "Enforcement Header")
            {
                DataItemLink = "No." = field("No.");

                column(No_; "No.")
                {
                }
                column(Branch; Branch)
                {
                }
                column(Officer_s_Telephone_No_; "Officer's Telephone No.")
                {
                }
                column(Compliance_Status; "Compliance Status")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                end;
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
