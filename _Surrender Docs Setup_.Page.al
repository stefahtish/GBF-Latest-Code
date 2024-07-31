page 51458 "Surrender Docs Setup"
{
    PageType = List;
    SourceTable = "Surrender Docs Setup";
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
