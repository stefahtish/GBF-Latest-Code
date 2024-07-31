page 50813 "Tender Evaluation List-Archive"
{
    CardPageID = "Tender Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Tender Evaluation Header";
    SourceTableView = WHERE("Tender Generated" = CONST(true));
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
