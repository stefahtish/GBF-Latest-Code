page 50477 "Score Setup"
{
    PageType = List;
    SourceTable = "Score Setup";
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
                field("Pass Mark"; Rec."Pass Mark")
                {
                }
            }
        }
    }
    actions
    {
    }
}
