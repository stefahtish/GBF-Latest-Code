page 51118 "Strategy List"
{
    Caption = 'Strategy List';
    PageType = List;
    CardPageId = "Strategy Card";
    SourceTable = Strategy;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
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
        }
    }
}
