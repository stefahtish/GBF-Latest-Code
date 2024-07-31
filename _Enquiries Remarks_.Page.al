page 50883 "Enquiries Remarks"
{
    AutoSplitKey = true;
    PageType = Listpart;
    SourceTable = "Enquiries Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Action"; Rec.Action)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(User; Rec.User)
                {
                }
            }
        }
    }
    actions
    {
    }
}
