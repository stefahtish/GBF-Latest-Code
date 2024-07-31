page 50997 "Schedue List All"
{
    CardPageID = Contract_Card;
    PageType = List;
    SourceTable = "Payment Schedule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Schedule No."; Rec."Schedule No.")
                {
                }
                field(Activity; Rec.Activity)
                {
                }
                field(Delivarable; Rec.Delivarable)
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
