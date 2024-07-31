page 51168 "Risk Impacts"
{
    PageType = List;
    SourceTable = "Risk Impacts";
    SourceTableView = SORTING("Impact Score") ORDER(Ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Impact Score"; Rec."Impact Score")
                {
                }
                field("Financial start"; Rec."Financial start")
                {
                }
                field("Financial End"; Rec."Financial End")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Domains)
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Risk Impact Domains";
                RunPageLink = "Impact Code" = FIELD(Code);
            }
        }
    }
}
