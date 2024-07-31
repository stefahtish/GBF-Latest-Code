page 51385 "Supplier Evaluation Setup1"
{
    //DeleteAllowed = false;
    CardPageId = "Supplier EvaluationSetupCard1";
    PageType = List;
    SourceTable = "Supplier Evaluation SetUp";
    Caption = 'Supplier Evaluation Setup';
    ApplicationArea = All;

    //SourceTableView = where(Type = const(Quotation));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field("Evalueation Description"; Rec."Evalueation Description")
                {
                    Caption = 'Evaluation Description';
                }
                field("Minimum Score"; Rec."Minimum Score")
                {
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                }
                field(Active; Rec.Active)
                {
                }
                field("Procurement Ref No."; Rec."Procurement Ref No.")
                {
                }
            }
        }
    }
    actions
    {
    }
}
