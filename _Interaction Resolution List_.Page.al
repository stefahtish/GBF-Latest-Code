page 50857 "Interaction Resolution List"
{
    CardPageID = "Interaction Resolutions";
    PageType = List;
    SourceTable = "Interaction Resolution";
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
                field("Cause No."; Rec."Cause No.")
                {
                }
                field(Cause; Rec.Cause)
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }
        }
    }
    actions
    {
    }
}
