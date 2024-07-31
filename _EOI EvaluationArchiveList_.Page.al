page 50785 "EOI EvaluationArchiveList"
{
    CardPageID = "EOI Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "EOI Evaluation Header";
    SourceTableView = WHERE("EOI Generated" = CONST(true));
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
                field("EOI Generated"; Rec."EOI Generated")
                {
                }
            }
        }
    }
    actions
    {
    }
}
