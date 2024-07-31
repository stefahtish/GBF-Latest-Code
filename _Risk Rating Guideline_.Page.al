page 51254 "Risk Rating Guideline"
{
    PageType = List;
    SourceTable = "Risk Rating Guideline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field(Rating; Rec.Rating)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Financial; Rec.Financial)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(Regulatory; Rec.Regulatory)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(Legal; Rec.Legal)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(Reputational; Rec.Reputational)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(People; Rec.People)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field(Reporting; Rec.Reporting)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
    }
}
