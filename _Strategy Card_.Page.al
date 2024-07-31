page 51116 "Strategy Card"
{
    Caption = 'Strategy card';
    PageType = Card;
    SourceTable = Strategy;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Strategy Code"; Rec."Strategy Code")
                {
                    ApplicationArea = All;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = All;
                }
            }
            part("Strategy Activities"; "Strategy Activities")
            {
                Caption = 'Activities';
                SubPageLink = "Strategy Code" = field("Strategy Code"), KRA = field(KRA), "Strategic Issue No." = field("Strategic Issue No."), "Strategy Objective No." = field("Strategy Objective No.");
            }
        }
    }
}
