report 50475 "Stock Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './StockReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Unit_Cost; "Unit Cost")
            {
            }
            column(Unit_Price; "Unit Price")
            {
            }
            column(Reorder_Point; "Reorder Point")
            {
            }
            column(Reorder_Quantity; "Reorder Quantity")
            {
            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {
            }
            column(Unit_of_Measure_Id; "Unit of Measure Id")
            {
            }
            column(TotalCost; TotalCost)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(TotalCost);
                TotalCost:=(Item.Inventory * "Unit Cost");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var TotalCost: Decimal;
}
