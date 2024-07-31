page 51119 "Strategic Periods"
{
    Caption = 'Strategic Plan Periods';
    PageType = List;
    SourceTable = "Strategic Period";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Plan Name"; Rec."Plan Name")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("TimeFrames")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page TimeFrames;
                RunPageLink = "Plan Name" = field("Plan Name");
            }
        }
    }
}
