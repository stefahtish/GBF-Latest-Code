page 50807 "RFP Evaluation List"
{
    CardPageID = "RFP Evaluation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "RFP Evaluation Header";
    SourceTableView = WHERE("RFP Generated" = CONST(false));
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
                field("RFP Generated"; Rec."RFP Generated")
                {
                }
            }
        }
    }
    actions
    {
    }
}
