page 51059 "Research scope"
{
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
                    ApplicationArea = Basic, Suite;
                }
                field("Date Held"; Rec."Date Held")
                {
                }
                field(County; Rec.County)
                {
                }
                field("County Name"; Rec."County Name")
                {
                    Editable = false;
                }
                field(Venue; Rec.Venue)
                {
                }
                field(Outcome; Rec.Outcome)
                {
                }
            }
        }
    }
    actions
    {
    }
}
