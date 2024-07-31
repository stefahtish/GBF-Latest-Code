page 50650 "Emp Payment Types"
{
    PageType = List;
    SourceTable = "Employee Pay Types";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                }
                field("Earning Code"; Rec."Earning Code")
                {
                }
                field(Formula; Rec.Formula)
                {
                }
            }
        }
    }
    actions
    {
    }
}
