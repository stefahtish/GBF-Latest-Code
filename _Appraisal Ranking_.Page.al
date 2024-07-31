page 50445 "Appraisal Ranking"
{
    PageType = List;
    SourceTable = "Appraisal Grades";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Score; Rec.Score)
                {
                }
                field(Rating; Rec.Rating)
                {
                }
            }
        }
    }
    actions
    {
    }
}
