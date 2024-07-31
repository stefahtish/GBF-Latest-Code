page 50758 "Procurement Methods"
{
    PageType = Card;
    SourceTable = "Procurement Method";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
            part("Procurement Documents"; "Procurement Documents")
            {
                SubPageLink = Type = field(Type);
            }
        }
    }
    actions
    {
    }
}
