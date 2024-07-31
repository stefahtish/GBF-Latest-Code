page 51255 "Risk Likelihood Guideline"
{
    PageType = List;
    SourceTable = "Risk Likelihood Guideline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Likelihood; Rec.Likelihood)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
