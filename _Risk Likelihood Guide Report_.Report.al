report 50388 "Risk Likelihood Guide Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskLikelihoodGuideReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Likelihood Guideline"; "Risk Likelihood Guideline")
        {
            column(Rating; Rating)
            {
            }
            column(Likelihood; Likelihood)
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
}
