page 50414 "Appraiser & Appraisee Comments"
{
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                }
                field("Line No"; Rec."Line No")
                {
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                }
                field(Rating; Rec.Rating)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
            }
        }
    }
    actions
    {
    }
}
