pageextension 50123 "Item List Ext" extends "Item List"
{
    actions
    {
        // Add changes to page actions here
        addbefore("Inventory - Reorders")
        {
            action("Stock Report")
            {
                ApplicationArea = All;
                Image = PutAway;

                trigger OnAction()
                var
                    StockRept: Report "Stock Report";
                begin
                    StockRept.RunModal();
                end;
            }
        }
    }
    var myInt: Integer;
}
