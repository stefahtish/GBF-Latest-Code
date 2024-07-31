page 50680 "Deductions Balances"
{
    PageType = ListPart;
    SourceTable = "Deduction Balances";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
    actions
    {
    }
}
