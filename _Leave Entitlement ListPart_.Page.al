page 50420 "Leave Entitlement ListPart"
{
    PageType = ListPart;
    SourceTable = "Employee Leave";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Code"; Rec."Leave Code")
                {
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                }
                field(Entitlement; Rec.Entitlement)
                {
                }
                field("Total Days Taken"; Rec."Total Days Taken")
                {
                }
                field("Balance Brought Forward"; Rec."Balance Brought Forward")
                {
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
            }
        }
    }
    actions
    {
    }
}
