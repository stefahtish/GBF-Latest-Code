report 50307 "Goods Received Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportGRNReport.rdl';
    ApplicationArea = All;

    // RDLCLayout = './GoodsReceivedNote.rdl';
    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";

            column(BuyfromVendorNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
            {
            }
            column(PostingDate_PurchRcptHeader; "Purch. Rcpt. Header"."Posting Date")
            {
            }
            column(OrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
            {
            }
            column(ShortcutDimension1Code_PurchRcptHeader; "Purch. Rcpt. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchRcptHeader; "Purch. Rcpt. Header"."Shortcut Dimension 2 Code")
            {
            }
            column(BuyfromVendorName_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(UserID_PurchRcptHeader; "Purch. Rcpt. Header"."Assigned User ID")
            {
            }
            column(VendorInvoiceNo_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Order No.")
            {
            }
            column(VendorShipmentNo_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Shipment No.")
            {
            }
            column(DocumentDate_PurchRcptHeader; "Purch. Rcpt. Header"."Document Date")
            {
            }
            column(Amount_PurchRcptHeader; "Purch. Rcpt. Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchRcptHeader; "Purch. Rcpt. Header"."Amount Including VAT")
            {
            }
            column(DateTimePosted_PurchRcptHeader; "Purch. Rcpt. Header"."Date-Time Posted")
            {
            }
            column(VendorInvoiceDate_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Invoice Date")
            {
            }
            column(DeliveryNo; "Purch. Rcpt. Header"."Delivery No.")
            {
            }
            column(GRNNo; "Purch. Rcpt. Header"."GRN Nos")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(RemainingQuantity; RemainingQuantity)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(UsersName; GetUserName(UserId))
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(Type_PurchRcptLine; "Purch. Rcpt. Line".Type)
                {
                }
                column(No_PurchRcptLine; "Purch. Rcpt. Line"."No.")
                {
                }
                column(Description_PurchRcptLine; "Purch. Rcpt. Line".Description)
                {
                }
                column(UnitofMeasure_PurchRcptLine; "Purch. Rcpt. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchRcptLine; "Purch. Rcpt. Line".Quantity)
                {
                }
                column(QuantityInvoiced_PurchRcptLine; "Purch. Rcpt. Line"."Quantity Invoiced")
                {
                }
                column(OrderNo_PurchRcptLine; "Purch. Rcpt. Line"."Order No.")
                {
                }
                column(DirectUnitCost_PurchRcptLine; "Purch. Rcpt. Line"."Direct Unit Cost")
                {
                }
                column(VATBaseAmount_PurchRcptLine; "Purch. Rcpt. Line"."VAT Base Amount")
                {
                }
                column(Unit_Price_LCY; "Purch. Rcpt. Line"."Unit Price (LCY)")
                {
                }
                column(Department; "Purch. Rcpt. Line"."Shortcut Dimension 2 Code")
                {
                }
                column(VAT_PurchRcptLine; "Purch. Rcpt. Line"."VAT %")
                {
                }
                column(Amount_PurchRcptLine; "Purch. Rcpt. Line".Amount)
                {
                }
                column(AmountIncludingVAT_PurchRcptLine; "Purch. Rcpt. Line"."Amount Including VAT")
                {
                }
                column(CompanyNameCaption; CompanyNameCaption)
                {
                }
                column(GRNCation; GRNCation)
                {
                }
                column(scheme_caption; scheme_caption)
                {
                }
                column(received_from_caption; received_from_caption)
                {
                }
                column(carrier_caption; carrier_caption)
                {
                }
                column(received_by_caption; received_by_caption)
                {
                }
                column(purchreq_caption; purchreq_caption)
                {
                }
                column(bin_no_caption; bin_no_caption)
                {
                }
                column(storeledger_caption; storeledger_caption)
                {
                }
                column(invndate_cation; invndate_cation)
                {
                }
                column(item_caption; item_caption)
                {
                }
                column(goods_caption; goods_caption)
                {
                }
                column(qty_received; qty_received)
                {
                }
                column(qty_ordered; qty_ordered)
                {
                }
                column(officialuse; officialuse)
                {
                }
                column(PurchNo; "purchorder_no.")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(VatTotal; VatTotal)
                {
                }
                column(Counter; Counter)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //TotalAmount:="Purch. Rcpt. Line".Quantity*"Purch. Rcpt. Line"."Direct Unit Cost";
                    // //TOTALS
                    // IF "Purch. Rcpt. Line"."Quantity Invoiced">0 THEN BEGIN
                    // TotalAmount:=TotalAmount+(("Purch. Rcpt. Line"."Quantity Invoiced"*"Purch. Rcpt. Line"."Unit Cost (LCY)")*
                    //          ((100-"Purch. Rcpt. Line"."Line Discount %")/100));
                    // VatTotal:=VatTotal+("Purch. Rcpt. Line"."Quantity Invoiced"*"Purch. Rcpt. Line"."Unit Cost (LCY)")*(
                    // "Purch. Rcpt. Line"."VAT %"/100);
                    // END;
                    Counter := Counter + 1;
                end;

                trigger OnPreDataItem()
                begin
                    // TotalAmount:=0;
                    // VatTotal:=0;
                    Counter := 0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                RemainingQuantity := 0;
                InspectionLines.Reset();
                InspectionLines.SetRange("Order No", "Purch. Rcpt. Header"."No.");
                If InspectionLines.FindFirst() then begin
                    RemainingQuantity := InspectionLines."Quantity Ordered" - InspectionLines."Quantity Received";
                    Remarks := InspectionLines.Remarks;
                end;
            end;
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
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        CompanyNameCaption: Label 'NATIONAL IRRIGATION BOARD';
        GRNCation: Label 'GOODS RECEIVED NOTE';
        scheme_caption: Label 'SCHEME';
        received_from_caption: Label 'RECEIVED FROM';
        carrier_caption: Label 'CARRIER';
        received_by_caption: Label 'RECEIVED BY';
        purchreq_caption: Label 'PURCHASE REQUISITION No.';
        bin_no_caption: Label 'BIN No.';
        storeledger_caption: Label 'STORE LEDGER';
        invndate_cation: Label 'INVOICE & DATE';
        item_caption: Label 'Items';
        goods_caption: Label 'GOODS:';
        qty_received: Label 'Quantity Received';
        qty_ordered: Label 'Quantity Ordered';
        "purchorder_no.": Label 'Purchase Order No.';
        officialuse: Label 'OFFICIAL USE:';
        CompanyInfo: Record "Company Information";
        TotalAmount: Decimal;
        ISOCaption: Label 'KUC/ADMIN/R/19';
        VatTotal: Decimal;
        Counter: Integer;
        InspectionLines: Record "Inspection Lines";
        RemainingQuantity: Decimal;
        Remarks: Text;
        UsersName: Code[50];
    //Procedure to Get FullName:
    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        Users.Reset();
        Users.SetRange("User Name", UserCode);
        if Users.FindFirst() then exit(Users."Full Name");
    end;
}
