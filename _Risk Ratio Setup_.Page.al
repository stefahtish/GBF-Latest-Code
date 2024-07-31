page 51209 "Risk Ratio Setup"
{
    PageType = List;
    SourceTable = "Risk Ratio";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Rating"; Rec."Min.Rating")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Rating"; Rec."Max.Rating")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
