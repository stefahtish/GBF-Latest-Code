page 50426 "Position SupervisedX"
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
