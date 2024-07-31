page 51235 "Audit Interview Worksheet"
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
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Question';
                }
                field("Audit Description"; Rec."Audit Description")
                {
                    ApplicationArea = All;
                    Caption = 'Comment';
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                    Caption = 'Initials';
                }
            }
        }
    }
}
