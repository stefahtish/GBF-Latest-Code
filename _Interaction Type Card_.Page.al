page 50855 "Interaction Type Card"
{
    PageType = Card;
    SourceTable = "Interaction Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
            }
        }
    }
    actions
    {
    }
}
