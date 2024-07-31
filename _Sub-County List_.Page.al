page 51160 "Sub-County List"
{
    PageType = List;
    SourceTable = "Sub-County";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field(Name; Rec.Name)
                {
                }
                field(Station; Rec.Station)
                {
                    Caption = 'Branch';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Locations)
            {
                Promoted = true;
                Visible = false;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Locations List";
                RunPageLink = "County Code" = field("County Code"), "Country Code" = field("Country Code"), "Sub-County Code" = field("Sub-County Code");
            }
        }
    }
}
