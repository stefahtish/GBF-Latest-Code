page 50782 "EOI Evaluation List"
{
    CardPageID = "EOI Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "EOI Evaluation Header";
    ApplicationArea = All;

    //SourceTableView = WHERE("EOI Generated" = CONST(false));
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
