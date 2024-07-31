report 50499 "Monthly Backup Report"
{
    Caption = 'Monthly Backup Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521631 MonthlyBackupReport.rdl';

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
            column(PurchAmt; Amount[1])
            {
            }
            column(SalesAmtRec; SalesAmt[1])
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Purchaserec; Purchasemade)
            {
            }
            column(Salesrec; SalesMade)
            {
            }
            column(OpeningBalances; OpeningBalance)
            {
            }
            trigger OnAfterGetRecord()
            begin
                TotalSales:=ItemRec.Inventory * ItemRec."Unit Price";
                //Compute Purchase made between Date filter:
                CalculatePurchaseQuantity();
                //Compute Negative Adjustment in the Invetory:
                CalculateSalesAdjustment();
                //Compute the Opening Balance of quantity:
                OpeningBalancesForItems();
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
    Amount: array[100000]of Decimal;
    SalesAmt: array[100000]of Decimal;
    //Procedure to Compute Total Amount Purchased:
    procedure CalculatePurchaseQuantity()
    var
        ItemLedgerEntries: Record "Item Ledger Entry";
    begin
        ItemLedgerEntries.Reset();
        ItemLedgerEntries.SetRange("Item No.", ItemRec."No.");
        ItemLedgerEntries.SetRange("Posting Date", StartDate, EndDate);
        ItemLedgerEntries.SetFilter("Entry Type", '%1|%2', ItemLedgerEntries."Entry Type"::"Positive Adjmt.", ItemLedgerEntries."Entry Type"::Purchase);
        if ItemLedgerEntries.FindSet()then begin
            ItemLedgerEntries.CalcSums(Quantity);
            Amount[1]:=ItemLedgerEntries.Quantity;
        end;
    end;
    //Procedure to Calculate Negative Adjustment in the Inventory:
    procedure CalculateSalesAdjustment()
    var
        ItemLedgerEntry1: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry1.Reset();
        ItemLedgerEntry1.SetRange("Item No.", ItemRec."No.");
        ItemLedgerEntry1.SetRange("Posting Date", StartDate, EndDate);
        ItemLedgerEntry1.SetFilter("Entry Type", '%1', ItemLedgerEntry1."Entry Type"::"Negative Adjmt.");
        if ItemLedgerEntry1.FindSet()then begin
            ItemLedgerEntry1.CalcSums(Quantity);
            SalesAmt[1]:=ItemLedgerEntry1.Quantity;
        end;
    end;
    //Procedure to Compute the Opening Balances for Items:
    procedure OpeningBalancesForItems()
    var
        ItemLedgerRec: Record "Item Ledger Entry";
    begin
        ItemLedgerRec.Reset();
        ItemLedgerRec.SetRange("Item No.", ItemRec."No.");
        ItemLedgerRec.SetFilter("Posting Date", '<%1', StartDate);
        if ItemLedgerRec.FindSet()then begin
            repeat OpeningBalance+=ItemLedgerRec.Quantity;
            until ItemLedgerRec.Next() = 0;
        end;
    end;
}
