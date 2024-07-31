report 50367 "Compliance Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ComplianceRegister.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER(Compliance));

            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(ResponsiblePersonnel; "Audit Lines"."Responsible Personnel")
                {
                }
                column(ResponsiblePersonnelCode; "Audit Lines"."Responsible Personnel Code")
                {
                }
                column(Frequency; "Audit Lines".Frequency)
                {
                }
                column(ComplianceStatus; "Audit Lines"."Compliance Status")
                {
                }
                column(Title; "Audit Lines".Title)
                {
                }
                column(DescriptionofLegislation; "Audit Lines"."Description of Legislation")
                {
                }
                column(RelevantLegislation; "Audit Lines"."Relevant Legislation")
                {
                }
                column(Remarks; "Audit Lines".Remarks)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
