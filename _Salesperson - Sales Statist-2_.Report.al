report 50150 "Salesperson - Sales Statist-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalespersonSalesStatistics-cust.rdlc';
    Caption = 'Salesperson - Sales Statistics';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code";

            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION__________SalespersonFilter; TableCaption + ': ' + SalespersonFilter)
            {
            }
            column(SalespersonFilter; SalespersonFilter)
            {
            }
            column(Cust__Ledger_Entry__TABLECAPTION__________CustLedgEntryFilter; "Cust. Ledger Entry".TableCaption + ': ' + CustLedgEntryFilter)
            {
            }
            column(CustLedgEntryFilter; CustLedgEntryFilter)
            {
            }
            column(Cust__Ledger_Entry___Sales__LCY__; SalesLCY)
            {
            }
            column(Cust__Ledger_Entry___Profit__LCY__; ProfitLCY)
            {
            }
            column(Cust__Ledger_Entry___Inv__Discount__LCY__; InvDiscLCY)
            {
            }
            column(Cust__Ledger_Entry___Pmt__Disc__Given__LCY__; PmtDiscGivenLCY)
            {
            }
            column(Cust__Ledger_Entry___Pmt__Tolerance__LCY__; PmtToleranceLCY)
            {
            }
            column(AdjProfit; AdjProfit)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            trigger OnAfterGetRecord()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                CostCalculationMgt: Codeunit "Cost Calculation Management";
            begin
                SalesLCY := 0;
                ProfitLCY := 0;
                InvDiscLCY := 0;
                PmtDiscGivenLCY := 0;
                PmtToleranceLCY := 0;
                AdjProfit := 0;
                CustLedgEntry.CopyFilters("Cust. Ledger Entry");
                CustLedgEntry.SetRange("Salesperson Code", Code);
                if CustLedgEntry.FindSet then
                    repeat
                        SalesLCY += CustLedgEntry."Sales (LCY)";
                        ProfitLCY += CustLedgEntry."Profit (LCY)";
                        InvDiscLCY += CustLedgEntry."Inv. Discount (LCY)";
                        PmtDiscGivenLCY += CustLedgEntry."Pmt. Disc. Given (LCY)";
                        PmtToleranceLCY += CustLedgEntry."Pmt. Tolerance (LCY)";
                        if CustLedgEntry."Document Type" in [CustLedgEntry."Document Type"::Invoice, CustLedgEntry."Document Type"::"Credit Memo"] then
                            AdjProfit += CustLedgEntry."Profit (LCY)" + CostCalculationMgt.CalcCustLedgAdjmtCostLCY(CustLedgEntry)
                        else
                            AdjProfit += CustLedgEntry."Profit (LCY)" until CustLedgEntry.Next = 0
                else
                    CurrReport.Skip
            end;
        }
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            MaxIteration = 0;
            RequestFilterFields = "Posting Date";
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
        ReportLabel = 'Salesperson - Sales Statistics';
        PageLabel = 'Page';
        AmountsInLCYLabel = 'All amounts are in KES';
        ProfitPctLabel = 'Profit %';
        InvDiscAmountLabel = 'Invoice Disc. Amount (KES)';
        PmtDiscGivenLabel = 'Payment Disc. Given (KES)';
        PmtToleranceLabel = 'Pmt. Tolerance (KES)';
        AdjProfitPctLabel = 'Adjusted Profit %';
        AdjProfitLCYLabel = 'Adjusted Profit (KES)';
        TotalLabel = 'Total';
        SalesLCYLabel = 'Sales (KES)';
        ProfitLCYLabel = 'Profit (KES)';
        CodeLabel = 'Code';
    }
    trigger OnPreReport()
    begin
        SalespersonFilter := "Salesperson/Purchaser".GetFilters;
        CustLedgEntryFilter := "Cust. Ledger Entry".GetFilters;
        PeriodText := "Cust. Ledger Entry".GetFilter("Posting Date");
    end;

    var
        Text000: Label 'Period: %1';
        SalespersonFilter: Text;
        CustLedgEntryFilter: Text;
        PeriodText: Text;
        AdjProfit: Decimal;
        SalesLCY: Decimal;
        ProfitLCY: Decimal;
        InvDiscLCY: Decimal;
        PmtDiscGivenLCY: Decimal;
        PmtToleranceLCY: Decimal;
}
