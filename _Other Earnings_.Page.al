page 50632 "Other Earnings"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Other Earnings";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code"; Rec."Earning Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
    }
}
