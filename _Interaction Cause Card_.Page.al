page 50856 "Interaction Cause Card"
{
    PageType = Card;
    SourceTable = "Interaction Cause";
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
                field("Interaction No."; Rec."Interaction No.")
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
    }
}
