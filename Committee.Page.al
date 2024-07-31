page 50759 Committee
{
    PageType = List;
    SourceTable = "Procurement Committees";
    CardPageId = "Procurement Committee Card";
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
                field(Members; Rec.Members)
                {
                }
                field(Permanent; Rec.Permanent)
                {
                }
            }
        }
    }
    actions
    {
    }
}
