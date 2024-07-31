report 50389 "Risk Rating Matrix Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskRatingMatrixReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk RAG Status Guideline"; "Risk RAG Status Guideline")
        {
            column(pagecap; pagecap)
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
        pagecap: Label 'Risk Rating Matrix';
}
