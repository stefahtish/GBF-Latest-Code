page 50820 "Supplier Evaluation Setup"
{
    // DeleteAllowed = false;
    CardPageId = "Supplier Evaluation Setup Card";
    PageType = List;
    SourceTable = "Supplier Evaluation SetUp";
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
