page 50454 "Travel Expense"
{
    PageType = ListPart;
    SourceTable = "Travel Expense";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Fuel Amount"; Rec."Requested Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Available Budget"; Rec."Available Budget")
                {
                }
            }
        }
    }
    actions
    {
    }
}
