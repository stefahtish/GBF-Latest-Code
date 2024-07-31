page 50410 "Disciplinary Actions"
{
    PageType = List;
    SourceTable = "Disciplinary Actions";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Warning Letter"; Rec."Warning Letter")
                {
                }
            }
        }
    }
    actions
    {
    }
}
