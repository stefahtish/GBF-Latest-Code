page 50638 "Bracket Table"
{
    PageType = List;
    SourceTable = "Bracket TablesX";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bracket Code"; Rec."Bracket Code")
                {
                }
                field("Bracket Description"; Rec."Bracket Description")
                {
                }
                field("Effective Starting Date"; Rec."Effective Starting Date")
                {
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                }
                field(Annual; Rec.Annual)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Brackets)
            {
                Caption = 'Brackets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tax Table";
                RunPageLink = "Table Code" = FIELD("Bracket Code");
            }
        }
    }
}
