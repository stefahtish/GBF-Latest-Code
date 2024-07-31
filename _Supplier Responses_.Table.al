table 50729 "Supplier Responses"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Supplier Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Supplier Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "MyField"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Response No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(7; Type;enum "Purchase Line Type")
        {
            DataClassification = ToBeClassified;
        }
        field(8; No; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item;
        }
        field(9; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Unit of Measure"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(12; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Price";
                "Amount Inclusive VAT":=Quantity * "Unit Price";
            end;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Procurement Plan"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(15; "Procurement Plan Item"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan"), "Department Code"=FIELD("Shortcut Dimension 1 Code"));

            trigger OnValidate()
            begin
                if ProcurementPlan.Get("Procurement Plan", "Shortcut Dimension 1 Code", "Procurement Plan Item")then begin
                    if ProcurementPlan."Procurement Type" = ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::Item;
                    end;
                    if ProcurementPlan."Procurement Type" <> ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::"G/L Account";
                        No:=ProcurementPlan."Source of Funds";
                    end;
                    "Budget Line":=ProcurementPlan."Source of Funds";
                    Description:=ProcurementPlan."Item Description";
                end;
            end;
        }
        field(16; "Budget Line"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Request Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            Caption = 'Expected Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(22; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(24; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(26; Specifications; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(28; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Amount Inclusive VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Specification2; Blob)
        {
            Caption = 'Specification';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var DimMgt: Codeunit DimensionManagement;
    ReqHeader: Record "Internal Request Header";
    ProcurementPlan: Record "Procurement Plan";
    ProspectiveRec: Record "Prospective Suppliers";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
