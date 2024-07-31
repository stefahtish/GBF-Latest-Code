report 50362 "Risk Survey"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskSurvey.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompaCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(No; "Audit Header"."No.")
            {
            }
            column(Date; "Audit Header".Date)
            {
            }
            column(CreatedBy; "Audit Header"."Created By")
            {
            }
            column(Status; "Audit Header".Status)
            {
            }
            column(Description; "Audit Header".Description)
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Audit Header"."Shortcut Dimension 2 Code")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(AuditLineType; "Audit Lines"."Audit Line Type")
                {
                }
                column(DescriptionText; DNotesText)
                {
                }
                column(RiskRating; "Audit Lines"."Risk Likelihood")
                {
                }
                column(LineNo_AuditLines; "Audit Lines"."Line No.")
                {
                }
                column(RiskMitigation; "Audit Lines"."Risk Mitigation")
                {
                }
                column(RiskOpportunities; "Audit Lines"."Risk Opportunities")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    "Audit Lines".CalcFields(Description);
                    "Audit Lines".Description.CreateInStream(Instr);
                    DNotes.Read(Instr);
                    DNotesText := Format(DNotes);
                    //End of Conversion
                end;
            }
        }
        dataitem("Risk Likelihood"; "Risk Likelihood")
        {
            column(Code_RiskLikelihood; "Risk Likelihood".Code)
            {
            }
            column(Description_RiskLikelihood; "Risk Likelihood".Description)
            {
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
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
}
