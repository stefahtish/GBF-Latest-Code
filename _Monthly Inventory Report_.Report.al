report 50498 "Monthly Inventory Report"
{
    Caption = 'Monthly Inventory Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521630 MonthlyInventoryReport.rdl';

    dataset
    {
        dataitem(ItemRec; Item)
        {
            RequestFilterFields = "Date Filter";

            column(No; ItemRec."No.")
            {
            }
            column(Description; ItemRec.Description)
            {
            }
            column(BaseUnitofMeasure; ItemRec."Base Unit of Measure")
            {
            }
            column(ReorderPoint; ItemRec."Reorder Point")
            {
            }
            column(Inventory; ItemRec.Inventory)
            {
            }
            column(UnitCost; ItemRec."Unit Cost")
            {
            }
            column(UnitPrice; ItemRec."Unit Price")
            {
            }
            column(NetInvoicedQty; ItemRec."Net Invoiced Qty.")
            {
            }
            column(NetChange; ItemRec."Net Change")
            {
            }
            column(PurchasesQty; ItemRec."Purchases (Qty.)")
            {
            }
            column(SalesQty; ItemRec."Sales (Qty.)")
            {
            }
            column(PositiveAdjmtQty; ItemRec."Positive Adjmt. (Qty.)")
            {
            }
            column(NegativeAdjmtQty; ItemRec."Negative Adjmt. (Qty.)")
            {
            }
            column(PurchasesLCY; ItemRec."Purchases (LCY)")
            {
            }
            column(SalesLCY; ItemRec."Sales (LCY)")
            {
            }
            column(PositiveAdjmtLCY; ItemRec."Positive Adjmt. (LCY)")
            {
            }
            column(NegativeAdjmtLCY; ItemRec."Negative Adjmt. (LCY)")
            {
            }
            column(QtyonPurchOrder; ItemRec."Qty. on Purch. Order")
            {
            }
            column(QtyonSalesOrder; ItemRec."Qty. on Sales Order")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(PhoneNumber; CompanyInfo."Phone No.")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Datefilter; Datefilter)
            {
            }
            column(Totalvalue; TotalSales)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(SalesAmt; Amount[1])
            {
            }
            column(PurchAmt; Amount[2])
            {
            }
            column(OpeningBals; TotalOpbal[1])
            {
            }
            trigger OnAfterGetRecord()
            begin
                TotalSales:=ItemRec.Inventory * ItemRec."Unit Price";
                Clear(Amount);
                //Total Negative Adjustments:
                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Item No.", ItemRec."No.");
                ItemLedgerEntries.SetFilter("Entry Type", '%1', ItemLedgerEntries."Entry Type"::"Negative Adjmt.");
                ItemLedgerEntries.SetRange("Posting Date", StartDate, EndDate);
                if ItemLedgerEntries.FindSet()then begin
                    ItemLedgerEntries.CalcSums(Quantity);
                    Amount[1]:=ItemLedgerEntries.Quantity;
                end;
                //Total Positive Invetory Adjustments and Purchase:
                ItemLedgerEntry1.Reset();
                ItemLedgerEntry1.SetRange("Item No.", "No.");
                ItemLedgerEntry1.SetFilter("Entry Type", '%1| %2', ItemLedgerEntry1."Entry Type"::"Positive Adjmt.", ItemLedgerEntry1."Entry Type"::Purchase);
                ItemLedgerEntry1.SetRange("Posting Date", StartDate, EndDate);
                if ItemLedgerEntry1.FindSet()then begin
                    ItemLedgerEntry1.CalcSums(Quantity);
                    Amount[2]:=ItemLedgerEntry1.Quantity;
                end;
                //Total Opening Bslances:
                ItemledgerRec.Reset();
                ItemledgerRec.SetRange("Item No.", "No.");
                ItemledgerRec.SetFilter("Posting Date", '<%1', StartDate);
                if ItemledgerRec.FindSet()then begin
                    ItemledgerRec.CalcSums(Quantity);
                    TotalOpbal[1]:=ItemledgerRec.Quantity;
                end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        StartDate:=ItemRec.GetRangeMin("Date Filter");
        EndDate:=ItemRec.GetRangeMax("Date Filter");
    end;
    var CompanyInfo: Record "Company Information";
    Datefilter: Date;
    StartDate: Date;
    EndDate: Date;
    OpeningBalance: Decimal;
    Purchasemade: Decimal;
    SalesMade: Decimal;
    TotalSales: Decimal;
    ItemLedgerEntries, ItemLedgerEntry1, ItemledgerRec: Record "Item Ledger Entry";
    Amount: array[100000]of Decimal;
    TotalOpbal: array[100000]of Decimal;
//Procedure to Compute Opening balance
}
