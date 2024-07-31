report 50507 "Purch HistorySupplier"
{
    Caption = 'Purchase History Per Supplier';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 515216389 PurchHistory Report.rdl';

    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            RequestFilterFields = "Buy-from Vendor No.";

            column(Nos; PurchInvHeader."No.")
            {
            }
            column(BuyfromVendorNo; PurchInvHeader."Buy-from Vendor No.")
            {
            }
            column(PaytoVendorNo; PurchInvHeader."Pay-to Vendor No.")
            {
            }
            column(RequisitionNo; PurchInvHeader."Requisition No.")
            {
            }
            column(OrderNo; PurchInvHeader."Order No.")
            {
            }
            column(ShortcutDim1Code; PurchInvHeader."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDim2Code; PurchInvHeader."Shortcut Dimension 2 Code")
            {
            }
            column(PostingDate; PurchInvHeader."Posting Date")
            {
            }
            column(BuyVendorName; PurchInvHeader."Buy-from Vendor Name")
            {
            }
            column(PaytoName; PurchInvHeader."Pay-to Name")
            {
            }
            column(Compname; CompInfo.Name)
            {
            }
            column(CompLogo; CompInfo.Picture)
            {
            }
            column(CountRows; CountRows)
            {
            }
            dataitem(PurchInvLine; "Purch. Inv. Line")
            {
                DataItemLinkReference = PurchInvHeader;
                DataItemLink = "Document No."=field("No.");

                column(Document_No_; PurchInvLine."Document No.")
                {
                }
                column(AmountIncludingVAT; PurchInvLine."Amount Including VAT")
                {
                }
                column(Amount; PurchInvLine.Amount)
                {
                }
                column(LineAmount; PurchInvLine."Line Amount")
                {
                }
                column(UnitCost; PurchInvLine."Unit Cost")
                {
                }
                column(DirectUnitCost; PurchInvLine."Direct Unit Cost")
                {
                }
                column(LineType; PurchInvLine.Type)
                {
                }
                column(Description; PurchInvLine.Description)
                {
                }
                column(Quantity; PurchInvLine.Quantity)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CountRows+=1;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;
    var CompInfo: Record "Company Information";
    CountRows: Integer;
}
