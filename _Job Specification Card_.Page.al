page 50398 "Job Specification Card"
{
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
                field("Total Score"; Rec."Total Score")
                {
                }
            }
        }
    }
    actions
    {
    }
}
