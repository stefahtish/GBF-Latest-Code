page 50763 "Quote Evaluation List"
{
    CardPageID = "Quote Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Quote Evaluation Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No"; Rec."Quote No")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Quote Generated"; Rec."Quote Generated")
                {
                }
            }
        }
    }
    actions
    {
    }
}
