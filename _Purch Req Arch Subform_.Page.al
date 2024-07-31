page 50164 "Purch Req Arch Subform"
{
    AutoSplitKey = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Internal Request Line";
    SourceTableView = WHERE("Document Type" = CONST(Purchase));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = ShowDim;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = ShowDim;
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
                    Visible = true;

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
                    Visible = true;

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
                    Visible = true;

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
                    Visible = true;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Qty. to Order"; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Order';
                }
                field("Quantity Ordered"; Rec."Quantity Received")
                {
                    Caption = 'Quantity Ordered';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
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
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then
            ShowSupplier := true
        else
            ShowSupplier := false
    end;

    trigger OnInit()
    begin
        ShowSupplier := false
    end;

    trigger OnOpenPage()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        //Carol
        //IF Status::Approved  THEN Field Supplier editable TRUE
        //END
        //removed one key Carol
        if PurchaseHeader.Get(Rec."Document Type") then begin
            if PurchaseHeader.Status = PurchaseHeader.Status::Released then
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
