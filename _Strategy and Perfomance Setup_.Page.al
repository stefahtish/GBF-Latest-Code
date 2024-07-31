page 51123 "Strategy and Perfomance Setup"
{
    PageType = Card;
    SourceTable = "Strategic Planning Setups";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Perfomance Contract Nos"; Rec."Perfomance Contract Nos")
                {
                    ApplicationArea = All;
                }
                field("Perfomance Actuals Nos"; Rec."Perfomance Actuals Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
