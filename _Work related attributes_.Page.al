page 50628 "Work related attributes"
{
    PageType = List;
    SourceTable = "Work related attributes";
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
        area(Navigation)
        {
            action(Indicators)
            {
                Image = CampaignEntries;
                RunObject = page "Work related indicators";
                RunPageLink = AttributeCode = field(Code);
            }
        }
    }
}
