page 51061 "Research Recommendations"
{
    Caption = 'Recommendations';
    PageType = ListPart;
    SourceTable = "ResearchSurvey Workplan Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Recommendations';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
