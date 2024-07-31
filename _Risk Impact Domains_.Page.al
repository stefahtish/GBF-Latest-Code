page 51188 "Risk Impact Domains"
{
    PageType = List;
    SourceTable = "Risk Domain";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Impact Code"; Rec."Impact Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Domain Code"; Rec."Domain Code")
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
        area(processing)
        {
            action("Domain Descriptors")
            {
                Image = Entries;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Risk Impact Descriptors";
                RunPageLink = "Impact Code" = FIELD("Impact Code"), "Domain Code" = FIELD("Domain Code");
            }
        }
    }
}
