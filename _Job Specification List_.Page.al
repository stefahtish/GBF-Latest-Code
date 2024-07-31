page 50399 "Job Specification List"
{
    CardPageID = "Job Specification Card";
    PageType = List;
    SourceTable = "Company Job";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("No of Posts"; Rec."No of Posts")
                {
                }
            }
        }
    }
    actions
    {
    }
}
