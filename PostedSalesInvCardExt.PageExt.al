pageextension 50134 PostedSalesInvCardExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Order No.")
        {
            field(Branch; Rec.Branch)
            {
                ApplicationArea = All;
            }
        }
    }
}
