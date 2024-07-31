page 50802 "Tender Evaluation List"
{
    CardPageID = "Tender Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Tender Evaluation Header";
    SourceTableView = WHERE("Tender Generated" = CONST(false));
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
                field("Tender Generated"; Rec."Tender Generated")
                {
                }
            }
        }
    }
    actions
    {
    }
}
