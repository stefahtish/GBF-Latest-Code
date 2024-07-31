page 51459 "Surrender Mandatory Docs"
{
    PageType = ListPart;
    SourceTable = "Surrender Mandatory Docs";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
