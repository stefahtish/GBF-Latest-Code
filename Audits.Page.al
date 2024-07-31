page 50893 Audits
{
    PageType = List;
    SourceTable = Audit;
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
                field("Type of Audit"; Rec."Type of Audit")
                {
                }
                field("Risk Assessment Rating"; Rec."Risk Assessment Rating")
                {
                }
            }
        }
    }
    actions
    {
    }
}
