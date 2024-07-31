report 50390 "Risk RAG Guideline Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskRAGGuidelineReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk RAG Status Guideline"; "Risk RAG Status Guideline")
        {
            column(Option; Option)
            {
            }
            column(Treatment; Treatment)
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
}
