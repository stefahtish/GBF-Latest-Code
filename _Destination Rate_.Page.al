page 50116 "Destination Rate"
{
    PageType = List;
    SourceTable = "Destination Rate Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;

                field("Employee Job Group"; Rec."Employee Job Group")
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Advance Code"; Rec."Advance Code")
                {
                }
                field("Daily Rate (Amount)"; Rec."Daily Rate (Amount)")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Destination Type"; Rec."Destination Type")
                {
                }
                field("Rate Type"; Rec."Rate Type")
                {
                }
            }
        }
    }
    actions
    {
    }
}
