report 50387 "Risk Assessment Impact Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskAsseImpactGuideReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Rating Guideline"; "Risk Rating Guideline")
        {
            column(Rating; Rating)
            {
            }
            column(Financial; Financial)
            {
            }
            column(Regulatory; Regulatory)
            {
            }
            column(Legal; Legal)
            {
            }
            column(Reputational; Reputational)
            {
            }
            column(Customer; Customer)
            {
            }
            column(People; People)
            {
            }
            column(Reporting; Reporting)
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
    var
}
