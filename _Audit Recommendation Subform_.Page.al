page 51212 "Audit Recommendation Subform"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Rec.Number)
                {
                }
                field("Audit Description"; Rec."Audit Description")
                {
                    Caption = 'Recommendation';
                }
            }
        }
    }
    actions
    {
    }
}
