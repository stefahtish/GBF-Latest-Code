page 51492 "Supplier Evaluation Setup3"
{
    //DeleteAllowed = false;
    CardPageId = "Supplier EvaluationSetupCard3";
    PageType = List;
    SourceTable = "Supplier Evaluation SetUp";
    Caption = 'Supplier Evaluation Setup';
    ApplicationArea = All;

    //SourceTableView = where(Type = const(RFP));
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
