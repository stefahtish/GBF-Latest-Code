page 50770 "RFQ Subform"
{
    AutoSplitKey = true;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Internal Request Line";
    SourceTableView = WHERE("Document Type" = CONST(RFQ));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Qty. to Order"; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Order';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Caption = '<Total Amount>';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = ShowDim;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = ShowDim;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Caption = '<Total Line Amount>';
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Approved Budget Amount"; Rec."Approved Budget Amount")
                {
                    Caption = 'Approved Plan Amount';
                    Visible = false;
                }
                field("Commitment Amount"; Rec."Commitment Amount")
                {
                    Visible = false;
                }
                field("Actual Expense"; Rec."Actual Expense")
                {
                    Visible = false;
                }
                field("Available amount"; Rec."Available amount")
                {
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("<Control21>"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Caption = '<Control21>';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Supplier; Rec.Supplier)
                {
                    Visible = ShowSupplier;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Visible = ShowSupplier;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Quantity Ordered"; Rec."Quantity Received")
                {
                    Caption = 'Quantity Ordered';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = ShowSupplier;
                }
                field("VAT %"; Rec."VAT %")
                {
                    Visible = ShowSupplier;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = ShowSupplier;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    Visible = ShowSupplier;
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    Visible = ShowSupplier;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = ShowSupplier;
                }
                field("Order No."; Rec."Order No.")
                {
                    Visible = ShowSupplier;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Specifications; Rec.Specification2)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled) then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
    end;

    trigger OnInit()
    begin
        ShowSupplier := false
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PurchSetup.Get;
        Rec."Procurement Plan" := PurchSetup."Effective Procurement Plan";
    end;

    trigger OnOpenPage()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        //Carol
        //IF Status::Approved  THEN Field Supplier editable TRUE
        //END
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled) then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        [InDataSet]
        ShowDim: Boolean;
        Status: Integer;
        ShowSupplier: Boolean;
        PurchaseHeader: Record "Internal Request Header";
        VATVisible: Boolean;
        PurchaseRequest: Page "Purchase Request";
        PurchSetup: Record "Purchases & Payables Setup";
        ProcurementPlan: Record "Procurement Plan";

    procedure ShowFields(MultiDonor: Boolean)
    begin
        if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;
        CurrPage.Update;
    end;

    local procedure ShowSup(var Show: Boolean)
    begin
        if Show = true then
            ShowSupplier := true
        else
            ShowSupplier := false;
        CurrPage.Update;
    end;
}
