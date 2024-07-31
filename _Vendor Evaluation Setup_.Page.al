page 51287 "Vendor Evaluation Setup"
{
    PageType = List;
    SourceTable = "Supplier Evaluation SetUp";
    CardPageId = "Vendor Evaluation Setup Card";
    SourceTableView = where(Type = const(Existing));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field("Evaluation Description"; Rec."Evalueation Description")
                {
                }
                field("Score Criteria"; Rec."Score Criteria")
                {
                }
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                }
                field(Active; Rec.Active)
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
    }
}
