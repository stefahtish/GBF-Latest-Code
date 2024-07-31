page 50409 "Disciplinary Cases"
{
    Caption = 'Types of hearing';
    PageType = List;
    SourceTable = "Disciplinary Cases";
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
                field("Recommended Action"; Rec."Recommended Action")
                {
                }
                field("Action Description"; Rec."Action Description")
                {
                }
            }
        }
    }
    actions
    {
    }
}
