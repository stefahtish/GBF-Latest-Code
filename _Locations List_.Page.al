page 51161 "Locations List"
{
    PageType = List;
    SourceTable = Locations;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Country Code"; Rec."Country Code")
                {
                    Visible = false;
                }
                field(Region; Rec.Region)
                {
                    Visible = false;
                }
                field("County Code"; Rec."County Code")
                {
                    Visible = false;
                }
                field("Sub-County Code"; Rec."Sub-County Code")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Markets)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Markets List";
                RunPageLink = "County Code" = field("County Code"), "Country Code" = field("Country Code"), "Sub-County Code" = field("Sub-County Code"), "Location Code" = field("Location Code");
            }
        }
    }
}
