page 50854 "Interaction Cause"
{
    PageType = List;
    SourceTable = "Interaction Cause";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

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
