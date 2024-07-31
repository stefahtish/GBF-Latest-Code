page 50894 "Audit Types"
{
    PageType = List;
    SourceTable = "Audit Types";
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
                field(Name; Rec.Name)
                {
                }
            }
        }
    }
    actions
    {
    }
}
