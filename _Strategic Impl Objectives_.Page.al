page 50613 "Strategic Impl Objectives"
{
    Caption = 'Targets Setup';
    PageType = List;
    SourceTable = "Strategic Imp Objectives";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max Score"; Rec."Max Score")
                {
                    ToolTip = 'Specifies the value of the Max Score field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Performance Indicators")
            {
                Image = CampaignEntries;
                RunObject = page "Strategic Impl Initiative";
                RunPageLink = ObjectiveCode = field(Code);
            }
        }
    }
}
