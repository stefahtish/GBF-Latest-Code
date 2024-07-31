report 50494 "Custom Purchase Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521625 CustomPurchaseInvoice.rdl';

    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            column(No; PurchInvHeader."No.")
            {
            }
            column(BuyfromVendorNo; PurchInvHeader."Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName; PurchInvHeader."Buy-from Vendor Name")
            {
            }
            column(PaytoVendorNo; PurchInvHeader."Pay-to Vendor No.")
            {
            }
            column(PaytoName; PurchInvHeader."Pay-to Name")
            {
            }
            column(PaytoAddress; PurchInvHeader."Pay-to Address")
            {
            }
            column(DocumentDate; PurchInvHeader."Document Date")
            {
            }
            column(PostingDate; PurchInvHeader."Posting Date")
            {
            }
            column(OrderNo; PurchInvHeader."Order No.")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPostcode; CompanyInformation."Post Code")
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompBank; CompanyInformation."Bank Account Name")
            {
            }
            column(CompVat; CompanyInformation."VAT Registration No.")
            {
            }
            column(CompGiro; CompanyInformation."Giro No.")
            {
            }
            column(CompAccount; CompanyInformation."Bank Account No.")
            {
            }
            dataitem(PurchInvLine; "Purch. Inv. Line")
            {
                DataItemLinkReference = PurchInvHeader;
                DataItemLink = "Document No."=field("No.");

                column(ItemNo; PurchInvLine."No.")
                {
                }
                column(Description; PurchInvLine.Description)
                {
                }
                column(Quantity; PurchInvLine.Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(UnitofMeasureCode; PurchInvLine."Unit of Measure Code")
                {
                }
                column(DirectUnitCost; PurchInvLine."Direct Unit Cost")
                {
                }
                column(LineDiscount; PurchInvLine."Line Discount %")
                {
                }
                column(LineDiscountAmount; PurchInvLine."Line Discount Amount")
                {
                }
                column(AllowInvoiceDisc; PurchInvLine."Allow Invoice Disc.")
                {
                }
                column(VATIdentifier; PurchInvLine."VAT Identifier")
                {
                }
                column(Amount; PurchInvLine.Amount)
                {
                }
                column(AmountIncludingVAT; PurchInvLine."Amount Including VAT")
                {
                }
                column(LineAmount; PurchInvLine."Line Amount")
                {
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var CompanyInformation: Record "Company Information";
}
