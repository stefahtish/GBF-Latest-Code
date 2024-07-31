page 51247 "Vendor Transactions FactBox"
{
    Caption = 'Vendor Statistics';
    PageType = CardPart;
    SourceTable = Vendor;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = Basic, Suite;

                trigger OnDrillDown()
                var
                    VendLedgEntry: Record "Vendor Ledger Entry";
                    DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                begin
                    DtldVendLedgEntry.SetRange("Vendor No.", Rec."No.");
                    Rec.CopyFilter("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                    Rec.CopyFilter("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                    Rec.CopyFilter("Currency Filter", DtldVendLedgEntry."Currency Code");
                    VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                end;
            }
            field("Outstanding Orders (LCY)"; Rec."Outstanding Orders (LCY)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Amt. Rcd. Not Invd. (LCY)';
            }
            field("Outstanding Invoices (LCY)"; Rec."Outstanding Invoices (LCY)")
            {
                ApplicationArea = Basic, Suite;
            }
            field(TotalAmountLCY; TotalAmountLCY)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                Caption = 'Total (LCY)';
            }
            field("Balance Due (LCY)"; Rec.CalcOverDueBalance)
            {
                ApplicationArea = Basic, Suite;
                CaptionClass = Format(StrSubstNo(Text000, Format(WorkDate)));

                trigger OnDrillDown()
                var
                    VendLedgEntry: Record "Vendor Ledger Entry";
                    DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                begin
                    DtldVendLedgEntry.SetFilter("Vendor No.", Rec."No.");
                    Rec.CopyFilter("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                    Rec.CopyFilter("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                    Rec.CopyFilter("Currency Filter", DtldVendLedgEntry."Currency Code");
                    VendLedgEntry.DrillDownOnOverdueEntries(DtldVendLedgEntry);
                end;
            }
            field(GetInvoicedPrepmtAmountLCY; Rec.GetInvoicedPrepmtAmountLCY)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoiced Prepayment Amount (LCY)';
            }
            //    field("Payments Request";"Payments Request")
            //  { ApplicationArea = Basic, Suite;
            ////  }
            // field("Payment Stage";"Payment Stage")
            //{ ApplicationArea = Basic, Suite;
            //}
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Rec.SetAutoCalcFields("Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");
        TotalAmountLCY := Rec."Balance (LCY)" + Rec."Outstanding Orders (LCY)" + Rec."Amt. Rcd. Not Invoiced (LCY)" + Rec."Outstanding Invoices (LCY)";
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        TotalAmountLCY := 0;
        exit(Rec.Find(Which));
    end;

    var
        TotalAmountLCY: Decimal;
        Text000: Label 'Overdue Amounts (LCY) as of %1';

    procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Vendor Card", Rec);
    end;
}
