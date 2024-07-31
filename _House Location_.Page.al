page 50557 "House Location"
{
    PageType = List;
    SourceTable = "House Location";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
