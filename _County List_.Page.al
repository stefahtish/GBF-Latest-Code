page 51158 "County List"
{
    PageType = List;
    SourceTable = CountyNew;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("County Code"; Rec."County Code")
                {
                }
                field(County; Rec.County)
                {
                }
                field(Country; Rec.Country)
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Sub-counties")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Sub-County List";
                RunPageLink = "County Code" = field("County Code"), "Country Code" = field(Country);
            }
        }
    }
}
