page 50554 "Housing Issue Setup"
{
    PageType = List;
    SourceTable = "Housing Issue Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Criteria; Rec.Criteria)
                {
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field(Points; Rec.Points)
                {
                }
            }
        }
    }
    actions
    {
    }
}
