report 50171 "Item Costing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemCosting.rdlc';
    Caption = 'Status';
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") WHERE("Entry Type" = CONST(Purchase));
            RequestFilterFields = "Item No.", "Source No.", "Document No.", "Posting Date";

            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(GlobalDimension1Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(DocumentDate_ItemLedgerEntry; "Item Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_ItemLedgerEntry; "Item Ledger Entry"."External Document No.")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Item.Reset;
                Item.SetRange("No.", "Item Ledger Entry"."Item No.");
                if Item.FindFirst then ItemDescription := Item.Description;
                Vendor.Reset;
                Vendor.SetRange("No.", "Item Ledger Entry"."Source No.");
                if Vendor.FindFirst then VendorName := Vendor.Name;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if statusdate = 0D then statusdate := WorkDate;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        Text000: Label 'As of %1';
        Text001: Label 'Enter the Status Date';
        StatusCaptionLbl: Label 'Status';
        PageCaptionLbl: Label 'Page';
        UnitCostCaptionLbl: Label 'Unit Cost';
        PostingDateCaptionLbl: Label 'Posting Date';
        QuantityCaptionLbl: Label 'Quantity';
        InventoryValuationCaptionLbl: Label 'Inventory Valuation';
        TotalCaptionLbl: Label 'Total';
        HereofPositiveCaptionLbl: Label 'Hereof Positive';
        HereofNegativeCaptionLbl: Label 'Hereof Negative';
        ItemDescription: Text[50];
        Item: Record Item;
        CompanyInformation: Record "Company Information";
        statusdate: Date;
        VendorName: Text;
        Vendor: Record Vendor;
}
