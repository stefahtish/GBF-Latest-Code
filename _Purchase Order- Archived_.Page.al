page 50371 "Purchase Order- Archived"
{
    Caption = 'Purchase Order';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    CardPageId = "Purchase Order Archived";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval,Print';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order), Archived = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor No.';
                    Editable = PageEditable;
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update;
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor Name';
                    Editable = PageEditable;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update;
                    end;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    Editable = PageEditable;

                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the vendor''s buy-from address.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor on the purchase document.';
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Suite;
                    Caption = 'Contact';
                    Editable = PageEditable;
                    ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the posting date of the record.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies when the related purchase invoice must be paid.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Suite;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ToolTip = 'Specifies the date which the Vendor provides the Vendor Invoice';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the vendor''s shipment number.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = true;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = true;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = Advanced;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    Importance = Standard;
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = Advanced;
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Suite;
                    Editable = PageEditable;
                    Importance = Standard;
                    ToolTip = 'Specifies the vendor''s order number.';
                }
                field(Reference; Rec.Reference)
                {
                    Caption = 'LPO Reference';
                    Editable = PageEditable;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Alternate Vendor Address Code';
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies the order address of the related vendor.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Advanced;
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Advanced;
                    Editable = PageEditable;
                    Importance = Standard;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';

                    trigger OnValidate()
                    begin
                        SetPageView;
                    end;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Editable = PageEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueueUsed;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    Caption = 'Request For Quotation No.';
                    Editable = PageEditable;
                    Importance = Promoted;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    Caption = 'PRF No.';
                    Editable = PageEditable;
                }
                field("LPO Type"; Rec."LPO Type")
                {
                    Editable = PageEditable;
                }
                field(Replenishment; Rec.Replenishment)
                {
                    Editable = PageEditable;
                }
                group(Control121)
                {
                    Editable = false;
                    ShowCaption = false;
                    Visible = CommentVisible;

                    field("Cancel Comments"; Rec."Cancel Comments")
                    {
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    field("Cancelled By"; Rec."Cancelled By")
                    {
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                }
            }
            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = Suite;
                Editable = Rec."Buy-from Vendor No." <> '';
                Enabled = Rec."Buy-from Vendor No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                Editable = PageEditable;

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the currency of amounts on the purchase document.';

                    trigger OnAssistEdit()
                    var
                        DocumentTotals: Codeunit "Document Totals";
                    begin
                        Clear(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = ACTION::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.SaveRecord;
                            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
                            CurrPage.Update(false);
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash,  or check.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of the vendor.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    Importance = Additional;
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Advanced;
                    Importance = Additional;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                Editable = PageEditable;

                group(Control83)
                {
                    ShowCaption = false;

                    group(Control94)
                    {
                        ShowCaption = false;

                        field(ShippingOptionWithLocation; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            OptionCaption = 'Default (Company Address),Location,Customer Address,Custom Address';
                            ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Location: One of the company''s location addresses. Custom Address: Any ship-to address that you specify in the fields below.';
                            Visible = ShowShippingOptionsWithLocation;

                            trigger OnValidate()
                            begin
                                ValidateShippingOption;
                            end;
                        }
                        field(ShippingOptionWithoutLocation; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            HideValue = ShowShippingOptionsWithLocation AND (ShipToOptions = ShipToOptions::Location);
                            OptionCaption = 'Default (Company Address),,Customer Address,Custom Address';
                            ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Custom Address: Any ship-to address that you specify in the fields below.';
                            Visible = NOT ShowShippingOptionsWithLocation;

                            trigger OnValidate()
                            begin
                                ValidateShippingOption
                            end;
                        }
                        group(Control99)
                        {
                            ShowCaption = false;

                            group(Control98)
                            {
                                ShowCaption = false;
                                Visible = ShipToOptions = ShipToOptions::Location;

                                field("Location Code"; Rec."Location Code")
                                {
                                    ApplicationArea = Location;
                                    Importance = Promoted;
                                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                                }
                            }
                            group(Control101)
                            {
                                ShowCaption = false;
                                Visible = ShipToOptions = ShipToOptions::"Customer Address";

                                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                                {
                                    ApplicationArea = Suite;
                                    Caption = 'Customer';
                                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                                }
                                field("Ship-to Code"; Rec."Ship-to Code")
                                {
                                    ApplicationArea = Suite;
                                    Editable = Rec."Sell-to Customer No." <> '';
                                    ToolTip = 'Specifies the code for another delivery address than the vendor''s own address, which is entered by default.';
                                }
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of the company at the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the postal code of the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the city of the vendor on the purchase document.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Contact"; Rec."Ship-to Contact")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Contact';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of a contact person for the address of the address that you want the items on the purchase document to be shipped to.';
                            }
                        }
                    }
                }
                group(Control71)
                {
                    ShowCaption = false;

                    field(PayToOptions; PayToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pay-to';
                        OptionCaption = 'Default (Vendor),Another Vendor';
                        ToolTip = 'Specifies the vendor that the purchase document will be paid to. Default (Vendor): The same as the vendor on the purchase document. Another Vendor: Any vendor that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if PayToOptions = PayToOptions::"Default (Vendor)" then Rec.Validate("Pay-to Vendor No.", Rec."Buy-from Vendor No.");
                        end;
                    }
                    group(Control95)
                    {
                        ShowCaption = false;
                        Visible = PayToOptions = PayToOptions::"Another Vendor";

                        field("Pay-to Name"; Rec."Pay-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Importance = Promoted;
                            ToolTip = 'Specifies the name of the vendor sending the invoice.';
                        }
                        field("Pay-to Address"; Rec."Pay-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies the address of the vendor sending the invoice.';
                        }
                        field("Pay-to Address 2"; Rec."Pay-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field("Pay-to Post Code"; Rec."Pay-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field("Pay-to City"; Rec."Pay-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies the city of the vendor on the purchase document.';
                        }
                        field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                        {
                            ApplicationArea = Advanced;
                            Caption = 'Contact No.';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';
                        }
                        field("Pay-to Contact"; Rec."Pay-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
                            Importance = Additional;
                            ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
                        }
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Editable = PageEditable;

                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the area of the customer or vendor, for the purpose of reporting to INTRASTAT.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Editable = PageEditable;

                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number that the vendor uses for the purchase order.';
                }
            }
        }
        area(factboxes)
        {
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = Advanced;
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";

                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Purchase Header", "Document Type", "No.");
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;

                action(Receipts)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of posted purchase receipts for the order.';
                }
                action(Invoices)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of ongoing purchase invoices for the order.';
                }
                action(PostedPrepaymentInvoices)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'View related posted sales invoices that involve a prepayment. ';
                }
                action(PostedPrepaymentCrMemos)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                separator(Action181)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the transfer order.';
                }
                action("Whse. Receipt Lines")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'View ongoing warehouse receipts for the document, in advanced warehouse configurations.';
                }
                separator(Action182)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;

                    action(Warehouse_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;

                    action("Get &Sales Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Advanced;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';

                        trigger OnAction()
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
            }
        }
        // area(processing)
        // {
        //     group(Approval)
        //     {
        //         Caption = 'Approval';
        //         action(Approve)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Approve';
        //             Image = Approve;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             PromotedIsBig = true;
        //             ToolTip = 'Approve the requested changes.';
        //             Visible = OpenApprovalEntriesExistForCurrUser;
        //             trigger OnAction()
        //             var
        //                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //             begin
        //                 ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
        //             end;
        //         }
        //         action(Reject)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Reject';
        //             Image = Reject;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             PromotedIsBig = true;
        //             ToolTip = 'Reject the requested changes.';
        //             Visible = OpenApprovalEntriesExistForCurrUser;
        //             trigger OnAction()
        //             var
        //                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //             begin
        //                 ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
        //             end;
        //         }
        //         action(Delegate)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Delegate';
        //             Image = Delegate;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             ToolTip = 'Delegate the requested changes to the substitute approver.';
        //             Visible = OpenApprovalEntriesExistForCurrUser;
        //             trigger OnAction()
        //             var
        //                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //             begin
        //                 ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
        //             end;
        //         }
        //         action(Comment)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Comments';
        //             Image = ViewComments;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             ToolTip = 'View or add comments for the record.';
        //             Visible = OpenApprovalEntriesExistForCurrUser;
        //             trigger OnAction()
        //             var
        //                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //             begin
        //                 ApprovalsMgmt.GetApprovalComment(Rec);
        //             end;
        //         }
        //         action(RejectLPO)
        //         {
        //             Caption = 'Cancel Approved LPO';
        //             Image = Reject;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             Visible = DocReleased;
        //             trigger OnAction()
        //             var
        //                 CancelApprovedLPO: Report "Cancel Approved LPO";
        //             begin
        //                 if Confirm('Are you sure you want to cancel LPO No. %1', false, "No.") = true then begin
        //                     PurchaseHeader.Reset;
        //                     PurchaseHeader.SetRange("No.", "No.");
        //                     if PurchaseHeader.FindFirst then begin
        //                         CancelApprovedLPO.SetTableView(PurchaseHeader);
        //                         CancelApprovedLPO.RunModal;
        //                     end;
        //                     Message('LPO %1 cancelled successfully', "No.");
        //                 end else
        //                     exit;
        //                 Commit;
        //                 CurrPage.Close;
        //             end;
        //         }
        //     }
        //     group(Action13)
        //     {
        //         Caption = 'Release';
        //         Image = ReleaseDoc;
        //         separator(Action73)
        //         {
        //         }
        //         action(Release)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Re&lease';
        //             Image = ReleaseDoc;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             ShortCutKey = 'Ctrl+F9';
        //             ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';
        //             Visible = false;
        //             trigger OnAction()
        //             var
        //                 ReleasePurchDoc: Codeunit "Release Purchase Document";
        //             begin
        //                 ReleasePurchDoc.PerformManualRelease(Rec);
        //             end;
        //         }
        //         action(Reopen)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Re&open';
        //             Enabled = Status <> Status::Open;
        //             Image = ReOpen;
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';
        //             Visible = false;
        //             trigger OnAction()
        //             var
        //                 ReleasePurchDoc: Codeunit "Release Purchase Document";
        //             begin
        //                 ReleasePurchDoc.PerformManualReopen(Rec);
        //             end;
        //         }
        //         separator(Action611)
        //         {
        //         }
        //     }
        //     group("F&unctions")
        //     {
        //         Caption = 'F&unctions';
        //         Image = "Action";
        //         action(CalculateInvoiceDiscount)
        //         {
        //             AccessByPermission = TableData "Vendor Invoice Disc." = R;
        //             ApplicationArea = Suite;
        //             Caption = 'Calculate &Invoice Discount';
        //             Image = CalculateInvoiceDiscount;
        //             ToolTip = 'Calculate the discount that can be granted based on all lines in the purchase document.';
        //             trigger OnAction()
        //             begin
        //                 ApproveCalcInvDisc;
        //                 PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
        //             end;
        //         }
        //         separator(Action190)
        //         {
        //         }
        //         action(GetRecurringPurchaseLines)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Get Recurring Purchase Lines';
        //             Ellipsis = true;
        //             Image = VendorCode;
        //             ToolTip = 'Insert purchase document lines that you have set up for the vendor as recurring. Recurring purchase lines could be for a monthly replenishment order or a fixed freight expense.';
        //             trigger OnAction()
        //             var
        //                 StdVendPurchCode: Record "Standard Vendor Purchase Code";
        //             begin
        //                 StdVendPurchCode.InsertPurchLines(Rec);
        //             end;
        //         }
        //         separator(Action75)
        //         {
        //         }
        //         action(CopyDocument)
        //         {
        //             ApplicationArea = Suite;
        //             Caption = 'Copy Document';
        //             Ellipsis = true;
        //             Image = CopyDocument;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';
        //             trigger OnAction()
        //             begin
        //                 CopyPurchDoc.SetPurchHeader(Rec);
        //                 CopyPurchDoc.RunModal;
        //                 Clear(CopyPurchDoc);
        //                 if Get("Document Type", "No.") then;
        //             end;
        //         }
        //         action(MoveNegativeLines)
        //         {
        //             ApplicationArea = Advanced;
        //             Caption = 'Move Negative Lines';
        //             Ellipsis = true;
        //             Image = MoveNegativeLines;
        //             ToolTip = 'Prepare to create a replacement sales order in a sales return process.';
        //             trigger OnAction()
        //             begin
        //                 Clear(MoveNegPurchLines);
        //                 MoveNegPurchLines.SetPurchHeader(Rec);
        //                 MoveNegPurchLines.RunModal;
        //                 MoveNegPurchLines.ShowDocument;
        //             end;
        //         }
        //         group(Action225)
        //         {
        //             Caption = 'Dr&op Shipment';
        //             Image = Delivery;
        //             action(Functions_GetSalesOrder)
        //             {
        //                 ApplicationArea = Suite;
        //                 Caption = 'Get &Sales Order';
        //                 Image = "Order";
        //                 RunObject = Codeunit "Purch.-Get Drop Shpt.";
        //                 ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
        //             }
        //         }
        //         group(Action186)
        //         {
        //             Caption = 'Speci&al Order';
        //             Image = SpecialOrder;
        //             action(Action187)
        //             {
        //                 AccessByPermission = TableData "Sales Shipment Header" = R;
        //                 ApplicationArea = Advanced;
        //                 Caption = 'Get &Sales Order';
        //                 Image = "Order";
        //                 ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
        //                 trigger OnAction()
        //                 var
        //                     PurchHeader: Record "Purchase Header";
        //                     DistIntegration: Codeunit "Dist. Integration";
        //                 begin
        //                     PurchHeader.Copy(Rec);
        //                     DistIntegration.GetSpecialOrders(PurchHeader);
        //                     Rec := PurchHeader;
        //                 end;
        //             }
        //         }
        //         action("Archive Document")
        //         {
        //             ApplicationArea = Advanced;
        //             Caption = 'Archi&ve Document';
        //             Image = Archive;
        //             ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';
        //             trigger OnAction()
        //             begin
        //                 ArchiveManagement.ArchivePurchDocument(Rec);
        //                 CurrPage.Update(false);
        //             end;
        //         }
        //         action("Send Intercompany Purchase Order")
        //         {
        //             AccessByPermission = TableData "IC G/L Account" = R;
        //             ApplicationArea = Intercompany;
        //             Caption = 'Send Intercompany Purchase Order';
        //             Image = IntercompanyOrder;
        //             ToolTip = 'Send the purchase order to the intercompany outbox or directly to the intercompany partner if automatic transaction sending is enabled.';
        //             trigger OnAction()
        //             var
        //                 ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
        //                 ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //             begin
        //                 if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
        //                     ICInOutboxMgt.SendPurchDoc(Rec, false);
        //             end;
        //         }
        //         separator(Action189)
        //         {
        //         }
        //         group(IncomingDocument)
        //         {
        //             Caption = 'Incoming Document';
        //             Image = Documents;
        //             action(IncomingDocCard)
        //             {
        //                 ApplicationArea = Suite;
        //                 Caption = 'View Incoming Document';
        //                 Enabled = HasIncomingDocument;
        //                 Image = ViewOrder;
        //                 ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';
        //                 trigger OnAction()
        //                 var
        //                     IncomingDocument: Record "Incoming Document";
        //                 begin
        //                     IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
        //                 end;
        //             }
        //             action(SelectIncomingDoc)
        //             {
        //                 AccessByPermission = TableData "Incoming Document" = R;
        //                 ApplicationArea = Suite;
        //                 Caption = 'Select Incoming Document';
        //                 Image = SelectLineToApply;
        //                 ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';
        //                 trigger OnAction()
        //                 var
        //                     IncomingDocument: Record "Incoming Document";
        //                 begin
        //                     Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.", RecordId));
        //                 end;
        //             }
        //             action(IncomingDocAttachFile)
        //             {
        //                 ApplicationArea = Suite;
        //                 Caption = 'Create Incoming Document from File';
        //                 Ellipsis = true;
        //                 Enabled = CreateIncomingDocumentEnabled;
        //                 Image = Attach;
        //                 ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';
        //                 trigger OnAction()
        //                 var
        //                     IncomingDocumentAttachment: Record "Incoming Document Attachment";
        //                 begin
        //                     IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
        //                 end;
        //             }
        //             action(RemoveIncomingDoc)
        //             {
        //                 ApplicationArea = Suite;
        //                 Caption = 'Remove Incoming Document';
        //                 Enabled = HasIncomingDocument;
        //                 Image = RemoveLine;
        //                 ToolTip = 'Remove any incoming document records and file attachments.';
        //                 trigger OnAction()
        //                 var
        //                     IncomingDocument: Record "Incoming Document";
        //                 begin
        //                     if IncomingDocument.Get("Incoming Document Entry No.") then
        //                         IncomingDocument.RemoveLinkToRelatedRecord;
        //                     "Incoming Document Entry No." := 0;
        //                     Modify(true);
        //                 end;
        //             }
        //         }
        //         group(Flow)
        //         {
        //             Caption = 'Flow';
        //             Image = Flow;
        //             action(CreateFlow)
        //             {
        //                 ApplicationArea = Basic, Suite;
        //                 Caption = 'Create a Flow';
        //                 Image = Flow;
        //                 Promoted = true;
        //                 PromotedCategory = Category9;
        //                 PromotedOnly = true;
        //                 ToolTip = 'Create a new Flow from a list of relevant Flow templates.';
        //                 Visible = IsSaaS;
        //                 trigger OnAction()
        //                 var
        //                     FlowServiceManagement: Codeunit "Flow Service Management";
        //                     FlowTemplateSelector: Page "Flow Template Selector";
        //                 begin
        //                     // Opens page 6400 where the user can use filtered templates to create new flows.
        //                     FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetPurchasingTemplateFilter);
        //                     FlowTemplateSelector.Run;
        //                 end;
        //             }
        //             action(SeeFlows)
        //             {
        //                 ApplicationArea = Basic, Suite;
        //                 Caption = 'See my Flows';
        //                 Image = Flow;
        //                 Promoted = true;
        //                 PromotedCategory = Category9;
        //                 PromotedOnly = true;
        //                 RunObject = Page "Flow Selector";
        //                 ToolTip = 'View and configure Flows that you created.';
        //             }
        //         }
        //     }
        //     group(Action17)
        //     {
        //         Caption = 'Warehouse';
        //         Image = Warehouse;
        //         action("Create &Whse. Receipt")
        //         {
        //             AccessByPermission = TableData "Warehouse Receipt Header" = R;
        //             ApplicationArea = Warehouse;
        //             Caption = 'Create &Whse. Receipt';
        //             Image = NewReceipt;
        //             ToolTip = 'Create a warehouse receipt to start a receive and put-away process according to an advanced warehouse configuration.';
        //             trigger OnAction()
        //             var
        //                 GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        //             begin
        //                 GetSourceDocInbound.CreateFromPurchOrder(Rec);
        //                 if not Find('=><') then
        //                     Init;
        //             end;
        //         }
        //         action("Create Inventor&y Put-away/Pick")
        //         {
        //             AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
        //             ApplicationArea = Warehouse;
        //             Caption = 'Create Inventor&y Put-away/Pick';
        //             Ellipsis = true;
        //             Image = CreateInventoryPickup;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';
        //             trigger OnAction()
        //             begin
        //                 CreateInvtPutAwayPick;
        //                 if not Find('=><') then
        //                     Init;
        //             end;
        //         }
        //         separator(Action74)
        //         {
        //         }
        //     }
        //     group(Print)
        //     {
        //         Caption = 'Print';
        //         Image = Print;
        //         action("&Print")
        //         {
        //             ApplicationArea = Suite;
        //             Caption = '&Print';
        //             Ellipsis = true;
        //             Image = Print;
        //             Promoted = true;
        //             PromotedCategory = Category10;
        //             ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
        //             trigger OnAction()
        //             var
        //                 PurchaseHeader: Record "Purchase Header";
        //             begin
        //                 PurchaseHeader := Rec;
        //                 CurrPage.SetSelectionFilter(PurchaseHeader);
        //                 PurchaseHeader.PrintRecords(true);
        //             end;
        //         }
        //         action(SendCustom)
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'Send';
        //             Ellipsis = true;
        //             Image = SendToMultiple;
        //             Promoted = true;
        //             PromotedCategory = Category10;
        //             PromotedIsBig = true;
        //             ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';
        //             trigger OnAction()
        //             var
        //                 PurchaseHeader: Record "Purchase Header";
        //             begin
        //                 PurchaseHeader := Rec;
        //                 CurrPage.SetSelectionFilter(PurchaseHeader);
        //                 PurchaseHeader.SendRecords;
        //             end;
        //         }
        //     }
        // }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCurrentShippingAndPayToOption;
        SetPageView;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DummyApplicationAreaSetup: Record "Application Area Setup";
    begin
        JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
        SetExtDocNoMandatoryCondition;
        //ShowShippingOptionsWithLocation := DummyApplicationAreaSetup.IsLocationEnabled OR DummyApplicationAreaSetup.IsAllDisabled;
        PageEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        if (not DocNoVisible) and (Rec."No." = '') then Rec.SetBuyFromVendorFromFilter;
        CalculateCurrentShippingAndPayToOption;
        Rec."Prices Including VAT" := true;
    end;

    trigger OnOpenPage()
    var
        PermissionManager: Codeunit "Permission Manager";
    begin
        SetDocNoVisible;
        if UserMgt.GetPurchasesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FilterGroup(0);
        end;
        if (Rec."No." <> '') and (Rec."Buy-from Vendor No." = '') then DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));
        SetPageView;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not DocumentIsPosted then exit(Rec.ConfirmCloseUnposted);
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        Committment: Codeunit Committment;
        ChangeExchangeRate: Page "Change Exchange Rate";
        ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address";
        PayToOptions: Option "Default (Vendor)","Another Vendor";
        [InDataSet]
        JobQueueVisible: Boolean;
        [InDataSet]
        JobQueueUsed: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?';
        CreateIncomingDocumentEnabled: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        IsSaaS: Boolean;
        ErrorMsg: Text;
        PageEditable: Boolean;
        DocPending: Boolean;
        DocReleased: Boolean;
        CommentVisible: Boolean;
        ProcurementManagement: Codeunit "Procurement Management";
        PurchaseHeader: Record "Purchase Header";
        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';

    local procedure Post(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        ApplicationAreaSetup: Record "Application Area Setup";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
    begin
        if ApplicationAreaSetup.Suite then LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        Rec.SendToPosting(PostingCodeunitID);
        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;
        if IsScheduledPosting then CurrPage.Close;
        CurrPage.Update(false);
        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then exit;
        if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then ShowPostedConfirmationMessage;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get;
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
        SetExtDocNoMandatoryCondition;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst then if InstructionMgt.ShowConfirm(OpenPostedPurchaseOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) then PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;

    local procedure ValidateShippingOption()
    begin
        case ShipToOptions of
            ShipToOptions::"Default (Company Address)", ShipToOptions::"Custom Address":
                begin
                    Rec.Validate("Location Code", '');
                    Rec.Validate("Sell-to Customer No.", '');
                end;
            ShipToOptions::Location:
                begin
                    Rec.Validate("Location Code");
                    Rec.Validate("Sell-to Customer No.", '');
                end;
            ShipToOptions::"Customer Address":
                begin
                    Rec.Validate("Sell-to Customer No.");
                    Rec.Validate("Location Code", '');
                end;
        end;
    end;

    local procedure CalculateCurrentShippingAndPayToOption()
    begin
        case true of
            Rec."Sell-to Customer No." <> '':
                ShipToOptions := ShipToOptions::"Customer Address";
            Rec."Location Code" <> '':
                ShipToOptions := ShipToOptions::Location;
            else if Rec.ShipToAddressEqualsCompanyShipToAddress then
                ShipToOptions := ShipToOptions::"Default (Company Address)"
                else
                    ShipToOptions := ShipToOptions::"Custom Address";
        end;
        if Rec."Pay-to Vendor No." = Rec."Buy-from Vendor No." then
            PayToOptions := PayToOptions::"Default (Vendor)"
        else
            PayToOptions := PayToOptions::"Another Vendor";
    end;

    local procedure SetPageView()
    begin
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if (Rec.Status = Rec.Status::"Pending Approval") then
            DocPending := true
        else
            DocPending := false;
        if (Rec.Status <> Rec.Status::Open) or Rec."Old LPO" then
            PageEditable := false
        else
            PageEditable := true;
        if Rec."Cancel Comments" <> '' then
            CommentVisible := true
        else
            CommentVisible := false;
    end;
}
