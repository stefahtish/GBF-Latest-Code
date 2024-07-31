page 50174 "Award Comment"
{
    Caption = 'Award Comment';
    PageType = StandardDialog;
    SourceTable = "Quote Evaluation Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Award Comment"; Rec."Award Comment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
