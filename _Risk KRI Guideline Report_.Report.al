report 50391 "Risk KRI Guideline Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskKRIGuidelineReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk KRI Setup"; "Risk KRI Setup")
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
            column(Family_of_KRI_Ref; "Family of KRI Ref")
            {
            }
            column(Employee_No; "Employee No")
            {
            }
            column(Indicator; Indicator)
            {
            }
            column(Frequency; Frequency)
            {
            }
            column(BASIS; BASIS)
            {
            }
            column(TriggerValue; TriggerValue)
            {
            }
            column(TriggerStatus; TriggerStatus)
            {
            }
            column(IndicativeUnits; IndicativeUnits)
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
}
