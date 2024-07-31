page 50501 "Qualified Interviewees"
{
    CardPageID = "Qualified Interviewee Card";
    PageType = List;
    SourceTable = "Recruitment Needs";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
    }
}
