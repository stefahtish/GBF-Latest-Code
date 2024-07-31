pageextension 50124 "Posted Purch. Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        modify("Order No.")
        {
            Visible = true;
        }
    }
    var myInt: Integer;
}
