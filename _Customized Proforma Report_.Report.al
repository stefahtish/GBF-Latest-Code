report 50496 "Customized Proforma Report"
{
    Caption = 'Proforma - Invoice';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521628 CustomizedProformaReport.rdl';

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(Nos; SalesInvoiceHeader."No.")
            {
            }
            column(DocumentDate; SalesInvoiceHeader."Document Date")
            {
            }
            column(PostingDate; SalesInvoiceHeader."Posting Date")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CurrencyCode; SalesInvoiceHeader."Currency Code")
            {
            }
            column(SelltoCustomerNo; SalesInvoiceHeader."Sell-to Customer No.")
            {
            }
            column(BilltoCustomerNo; SalesInvoiceHeader."Bill-to Customer No.")
            {
            }
            column(BilltoName; SalesInvoiceHeader."Bill-to Name")
            {
            }
            column(BilltoContactNo; SalesInvoiceHeader."Bill-to Contact No.")
            {
            }
            column(BilltoAddress; SalesInvoiceHeader."Bill-to Address")
            {
            }
            column(BilltoCity; SalesInvoiceHeader."Bill-to City")
            {
            }
            column(BilltoCounty; SalesInvoiceHeader."Bill-to County")
            {
            }
            column(BilltoCountryRegionCode; SalesInvoiceHeader."Bill-to Country/Region Code")
            {
            }
            column(BilltoContact; SalesInvoiceHeader."Bill-to Contact")
            {
            }
            column(BilltoPostCode; SalesInvoiceHeader."Bill-to Post Code")
            {
            }
            column(ShiptoCode; SalesInvoiceHeader."Ship-to Code")
            {
            }
            column(ShiptoName; SalesInvoiceHeader."Ship-to Name")
            {
            }
            column(ShiptoAddress; SalesInvoiceHeader."Ship-to Address")
            {
            }
            column(ShiptoCity; SalesInvoiceHeader."Ship-to City")
            {
            }
            column(ShiptoContact; SalesInvoiceHeader."Ship-to Contact")
            {
            }
            column(ShiptoPostCode; SalesInvoiceHeader."Ship-to Post Code")
            {
            }
            column(ShippingAgentCode; SalesInvoiceHeader."Shipping Agent Code")
            {
            }
            column(ShiptoCounty; SalesInvoiceHeader."Ship-to County")
            {
            }
            column(ShiptoCountryRegionCode; SalesInvoiceHeader."Ship-to Country/Region Code")
            {
            }
            column(OrderDate; SalesInvoiceHeader."Order Date")
            {
            }
            column(ShipmentDate; SalesInvoiceHeader."Shipment Date")
            {
            }
            column(ShipmentMethodCode; SalesInvoiceHeader."Shipment Method Code")
            {
            }
            column(PaymentTermsCode; SalesInvoiceHeader."Payment Terms Code")
            {
            }
            column(DueDate; SalesInvoiceHeader."Due Date")
            {
            }
            column(PaymentDiscount; SalesInvoiceHeader."Payment Discount %")
            {
            }
            column(PmtDiscountDate; SalesInvoiceHeader."Pmt. Discount Date")
            {
            }
            column(PricesIncludingVAT; SalesInvoiceHeader."Prices Including VAT")
            {
            }
            column(InvoiceDiscCode; SalesInvoiceHeader."Invoice Disc. Code")
            {
            }
            // column(OrderNo; SalesInvoiceHeader."Order No.")
            // {
            // }
            column(Amount; SalesInvoiceHeader.Amount)
            {
            }
            column(AmountIncludingVAT; SalesInvoiceHeader."Amount Including VAT")
            {
            }
            column(VATRegistrationNo; SalesInvoiceHeader."VAT Registration No.")
            {
            }
            column(SelltoCustomerName; SalesInvoiceHeader."Sell-to Customer Name")
            {
            }
            column(SelltoAddress; SalesInvoiceHeader."Sell-to Address")
            {
            }
            column(SelltoCity; SalesInvoiceHeader."Sell-to City")
            {
            }
            column(SelltoContact; SalesInvoiceHeader."Sell-to Contact")
            {
            }
            column(SelltoContactNo; SalesInvoiceHeader."Sell-to Contact No.")
            {
            }
            column(SelltoCountryRegionCode; SalesInvoiceHeader."Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; SalesInvoiceHeader."Sell-to County")
            {
            }
            column(SelltoEMail; SalesInvoiceHeader."Sell-to E-Mail")
            {
            }
            column(SelltoPhoneNo; SalesInvoiceHeader."Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; SalesInvoiceHeader."Sell-to Post Code")
            {
            }
            // column(PreAssignedNo; SalesInvoiceHeader."Pre-Assigned No.")
            // {
            // }
            column(UserID; SalesInvoiceHeader."Assigned User ID")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(companyAddress; CompanyInformation.Address)
            {
            }
            column(compAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(HomePage; CompanyInformation."Home Page")
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyBankName; CompanyInformation."Bank Name")
            {
            }
            column(CompanyBankNo; CompanyInformation."Bank Account No.")
            {
            }
            column(CompanyBranch; CompanyInformation."Bank Branch Name")
            {
            }
            column(CompanyBankBranchNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(BankAccountKes; CompanyInformation."Bank Account No.2")
            {
            }
            column(BankAccountUSD; CompanyInformation."Bank Account No.3")
            {
            }
            column(CompanyVATRegistrationNo; CompanyInformation."VAT Registration No.")
            {
            }
            dataitem(SalesInvoiceLine; "Sales Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(DocumentNo; SalesInvoiceLine."Document No.")
                {
                }
                column(LineSelltoCustomerNo; SalesInvoiceLine."Sell-to Customer No.")
                {
                }
                column(LineNo; SalesInvoiceLine."Line No.")
                {
                }
                column(Type; SalesInvoiceLine.Type)
                {
                }
                column(ItemNo; SalesInvoiceLine."No.")
                {
                }
                column(LocationCode; SalesInvoiceLine."Location Code")
                {
                }
                column(LineShipmentDate; SalesInvoiceLine."Shipment Date")
                {
                }
                column(Description; SalesInvoiceLine.Description)
                {
                }
                column(UnitofMeasure; SalesInvoiceLine."Unit of Measure")
                {
                }
                column(UnitofMeasureCode; SalesInvoiceLine."Unit of Measure Code")
                {
                }
                column(Quantity; SalesInvoiceLine.Quantity)
                {
                }
                column(LineAmount; SalesInvoiceLine.Amount)
                {
                }
                column(LineAmountIncludingVAT; SalesInvoiceLine."Amount Including VAT")
                {
                }
                column(LineBilltoCustomerNo; SalesInvoiceLine."Bill-to Customer No.")
                {
                }
                column(UnitCost; SalesInvoiceLine."Unit Cost")
                {
                }
                column(UnitCostLCY; SalesInvoiceLine."Unit Cost (LCY)")
                {
                }
                column(UnitPrice; SalesInvoiceLine."Unit Price")
                {
                }
                column(VAT; SalesInvoiceLine."VAT %")
                {
                }
                column(LineDiscount; SalesInvoiceLine."Line Discount %")
                {
                }
                column(LineDiscountAmount; SalesInvoiceLine."Line Discount Amount")
                {
                }
                column(VATIdentifier; SalesInvoiceLine."VAT Identifier")
                {
                }
                column(VATAmount; SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount)
                {
                }
                column(AllowInvoiceDisc; SalesInvoiceLine."Allow Invoice Disc.")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                GetInvoicedFullName();
            end;
        }
    }
    var CompanyInformation: Record "Company Information";
    UserSetup: Record "User Setup";
    PreparedBy: Text;
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    procedure GetInvoicedFullName()
    var
        Users: Record User;
    begin
        Users.Reset();
        Users.SetRange("User Name", SalesInvoiceHeader."Assigned User ID");
        if Users.FindFirst()then PreparedBy:=Users."Full Name";
    end;
}
