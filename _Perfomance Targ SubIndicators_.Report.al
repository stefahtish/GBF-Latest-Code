report 50422 "Perfomance Targ SubIndicators"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PerfomanceTargetSubIndicators.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Criteria Category"; "Criteria Category")
        {
            column(Code; Code)
            {
            }
            column(Description; Description)
            {
            }
            dataitem("Perfomance SubCriteria"; "Perfomance SubCriteria")
            {
                DataItemLink = "Criteria Code" = field(Code);
                RequestFilterFields = TimeFrame;

                column(SubCriteria_Code; Code)
                {
                }
                column(SubCriteria_Description; Description)
                {
                }
                column(TimeFrame; TimeFrame)
                {
                }
                column(Weight; Weight)
                {
                }
                column(Annual__Target; "Annual  Target")
                {
                }
                column(Q1_Target; "Q1 Target")
                {
                }
                column(Q2_Target; "Q2 Target")
                {
                }
                column(Q3_Target; "Q3 Target")
                {
                }
                column(Q4_Target; "Q4 Target")
                {
                }
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
