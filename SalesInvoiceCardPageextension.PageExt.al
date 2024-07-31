pageextension 50110 SalesInvoiceCardPageextension extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(Branch; Rec.Branch)
            {
                ApplicationArea = All;
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
