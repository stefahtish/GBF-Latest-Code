page 50851 "Interaction Channels"
{
    PageType = List;
    SourceTable = "Interaction Channel";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Day Start Time"; Rec."Day Start Time")
                {
                }
                field("Day End Time"; Rec."Day End Time")
                {
                }
            }
        }
    }
    actions
    {
    }
}
