page 51257 "Risk RAG Status Setup"
{
    PageType = List;
    SourceTable = "Risk RAG Status";
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
                field("Gross Risk start"; Rec."Gross Risk start")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gross Risk end"; Rec."Gross Risk end")
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
