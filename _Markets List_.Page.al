page 51162 "Markets List"
{
    PageType = List;
    SourceTable = Market;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Market Code"; Rec."Market Code")
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
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
