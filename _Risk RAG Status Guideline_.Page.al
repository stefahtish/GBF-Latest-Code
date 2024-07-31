page 51256 "Risk RAG Status Guideline"
{
    PageType = List;
    SourceTable = "Risk RAG Status Guideline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field(Option; Rec.Option)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Treatment; Rec.Treatment)
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
