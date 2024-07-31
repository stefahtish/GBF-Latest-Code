page 50556 "House Type"
{
    PageType = List;
    SourceTable = "House Type";
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
