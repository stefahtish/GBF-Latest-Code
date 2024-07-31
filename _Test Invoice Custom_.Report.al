report 50492 "Test Invoice Custom"
{
    Caption = 'Sales Document - Test';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report 51521623 Sales Document Invoice.rdl';

    //  RDLCLayout = './Reports/Report 51521623 Sale Document Invoice.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(Nos; SalesHeader."No.")
            {
            }
            column(DocumentDate; SalesHeader."Document Date")
            {
            }
            column(PostingDate; SalesHeader."Posting Date")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CurrencyCode; SalesHeader."Currency Code")
            {
            }
            column(SelltoCustomerNo; SalesHeader."Sell-to Customer No.")
            {
            }
            column(BilltoCustomerNo; SalesHeader."Bill-to Customer No.")
            {
            }
            column(BilltoName; SalesHeader."Bill-to Name")
            {
            }
            column(BilltoContactNo; SalesHeader."Bill-to Contact No.")
            {
            }
            column(BilltoAddress; SalesHeader."Bill-to Address")
            {
            }
            column(BilltoCity; SalesHeader."Bill-to City")
            {
            }
            column(BilltoCounty; SalesHeader."Bill-to County")
            {
            }
            column(BilltoCountryRegionCode; SalesHeader."Bill-to Country/Region Code")
            {
            }
            column(BilltoContact; SalesHeader."Bill-to Contact")
            {
            }
            column(BilltoPostCode; SalesHeader."Bill-to Post Code")
            {
            }
            column(ShiptoCode; SalesHeader."Ship-to Code")
            {
            }
            column(ShiptoName; SalesHeader."Ship-to Name")
            {
            }
            column(ShiptoAddress; SalesHeader."Ship-to Address")
            {
            }
            column(ShiptoCity; SalesHeader."Ship-to City")
            {
            }
            column(ShiptoContact; SalesHeader."Ship-to Contact")
            {
            }
            column(ShiptoPostCode; SalesHeader."Ship-to Post Code")
            {
            }
            column(ShippingAgentCode; SalesHeader."Shipping Agent Code")
            {
            }
            column(ShiptoCounty; SalesHeader."Ship-to County")
            {
            }
            column(ShiptoCountryRegionCode; SalesHeader."Ship-to Country/Region Code")
            {
            }
            column(OrderDate; SalesHeader."Order Date")
            {
            }
            column(ShipmentDate; SalesHeader."Shipment Date")
            {
            }
            column(ShipmentMethodCode; SalesHeader."Shipment Method Code")
            {
            }
            column(PaymentTermsCode; SalesHeader."Payment Terms Code")
            {
            }
            column(DueDate; SalesHeader."Due Date")
            {
            }
            column(PaymentDiscount; SalesHeader."Payment Discount %")
            {
            }
            column(PmtDiscountDate; SalesHeader."Pmt. Discount Date")
            {
            }
            column(PricesIncludingVAT; SalesHeader."Prices Including VAT")
            {
            }
            column(InvoiceDiscCode; SalesHeader."Invoice Disc. Code")
            {
            }
            // column(OrderNo; SalesHeader."Order No.")
            // {
            // }
            column(Amount; SalesHeader.Amount)
            {
            }
            column(AmountIncludingVAT; SalesHeader."Amount Including VAT")
            {
            }
            column(VATRegistrationNo; SalesHeader."VAT Registration No.")
            {
            }
            column(SelltoCustomerName; SalesHeader."Sell-to Customer Name")
            {
            }
            column(SelltoAddress; SalesHeader."Sell-to Address")
            {
            }
            column(SelltoCity; SalesHeader."Sell-to City")
            {
            }
            column(SelltoContact; SalesHeader."Sell-to Contact")
            {
            }
            column(SelltoContactNo; SalesHeader."Sell-to Contact No.")
            {
            }
            column(SelltoCountryRegionCode; SalesHeader."Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; SalesHeader."Sell-to County")
            {
            }
            column(SelltoEMail; SalesHeader."Sell-to E-Mail")
            {
            }
            column(SelltoPhoneNo; SalesHeader."Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; SalesHeader."Sell-to Post Code")
            {
            }
            // column(PreAssignedNo; SalesHeader."Pre-Assigned No.")
            // {
            // }
            // column(UserID; SalesHeader."User ID")
            // {
            // }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(companyAddress; CompanyInformation.Address)
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
                DataItemLinkReference = SalesHeader;
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
    //  Users.Reset();
    //   Users.SetRange("User Name", SalesHeader."User ID");
    //   if Users.FindFirst() then
    //  PreparedBy := Users."Full Name";
    end;
}
