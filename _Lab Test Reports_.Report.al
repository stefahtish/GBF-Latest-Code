report 50208 "Lab Test Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LabTestReports.rdl';
    Caption = 'Lab Test Results';
    ApplicationArea = All;

    dataset
    {
        dataitem(SampleTargetTestAnalysisNew; "Sample Target Test AnalysisNew")
        {
            column(EntryNo; "Entry No.")
            {
            }
            column(SampleID; "Sample ID")
            {
            }
            column(Code; Code)
            {
            }
            column(Results; Results)
            {
            }
            column(Specification; Specification)
            {
            }
            column(Remarks; Remarks)
            {
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
}
