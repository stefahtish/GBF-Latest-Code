page 50648 "Tax Table"
{
    PageType = Card;
    SourceTable = BracketsX;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table Code"; Rec."Table Code")
                {
                }
                field("Tax Band"; Rec."Tax Band")
                {
                }
                field("Taxable Amount"; Rec."Taxable Amount")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
        }
    }
    actions
    {
    }
}
