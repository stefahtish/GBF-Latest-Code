page 51115 "Strategic Objective"
{
    Caption = 'Strategic Objective';
    PageType = List;
    SourceTable = "Strategic Objective";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("KRA Code"; Rec."KRA Code")
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
            action("Strategies")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Strategy List";
                RunPageLink = KRA = field("KRA Code"), "Strategic Issue No." = field("Issue Code"), "Strategy Objective No." = field(Code);
            }
        }
    }
}
