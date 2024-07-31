page 50591 "Training Request Lines"
{
    PageType = ListPart;
    SourceTable = "Training Request Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                }
                field("Expense Name"; Rec."Expense Name")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
}
