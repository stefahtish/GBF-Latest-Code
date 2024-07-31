page 50400 "Positions Supervising"
{
    PageType = ListPart;
    SourceTable = "Positions Supervised";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Position Supervised"; Rec."Position Supervised")
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
    actions
    {
    }
}
