report 50358 "Risk Matrix"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskMatrix.rdl';
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
            column(CompanyAddr; CompanyInfo.Address)
            {
            }
            column(CompanyCIty; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(Period; "Audit Header"."Audit Period Start Date")
            {
            }
            column(AuditPeriod; "Audit Header"."Audit Period Start Date")
            {
            }
            column(Date; "Audit Header".Date)
            {
            }
            column(RiskRatingX; "Audit Header"."Risk Rating")
            {
            }
            column(RiskLikelihoodX; "Audit Header"."Risk Likelihood")
            {
            }
            column(RiskImpact; "Audit Header"."Risk Impact")
            {
            }
            column(RiskRating2; "Audit Header"."Risk Rating")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Audit Line Type" = FILTER("Internal Risk" | "External Risk"), "Risk Impacts" = FILTER(<> ''), "Risk Likelihood" = FILTER(<> ''));

                column(RiskLikelihood; "Audit Lines"."Risk Likelihood")
                {
                }
                column(RiskRating; "Audit Lines".Rating2)
                {
                }
                column(RiskImpacts; "Audit Lines"."Risk Impacts")
                {
                }
                column(RiskLikelihoodDesc; GetLikelihood("Audit Lines"."Risk Likelihood"))
                {
                }
                column(RiskImpactDesc; GetImpact("Audit Lines"."Risk Impacts"))
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
        RiskImpact: Record "Risk Impacts";
        RiskLikelihood: Record "Risk Likelihood";

    local procedure GetLikelihood(LikeCode: Code[20]): Text[100]
    begin
        if RiskLikelihood.Get(LikeCode) then exit(RiskLikelihood.Description);
    end;

    local procedure GetImpact(ImpactCode: Code[20]): Text[250]
    begin
        if RiskImpact.Get(ImpactCode) then exit(RiskImpact.Description);
    end;
}
