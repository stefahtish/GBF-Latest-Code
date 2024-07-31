report 50464 "Post Training Effectiveness"
{
    ApplicationArea = All;
    Caption = 'Post Training Effectiveness';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Post Training Effectiveness.docx';

    dataset
    {
        dataitem(EmployeeAppraisal; "Employee Appraisal")
        {
            column(AppraiseeName_EmployeeAppraisal; "Appraisee Name")
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
