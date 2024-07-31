page 51187 "Risk Rating"
{
    PageType = List;
    SourceTable = "Risk Rating";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Rating; Rec.Rating)
                {
                }
                field(Descriptor; Rec.Descriptor)
                {
                }
            }
        }
    }
    actions
    {
    }
}
