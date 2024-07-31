table 50205 "Proc. Lines Change Request"
{
    fields
    {
        field(1; "Requisition No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    "Procurement Plan":=ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code":=ReqHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    "Procurement Plan":=ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code":=ReqHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;
            end;
        }
        field(3; Type;enum "Purchase Line Type")
        {
            DataClassification = ToBeClassified;
        }
        field(4; No; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item
            else if(Type=const("Fixed Asset"))"Fixed Asset"
            else if(Type=const("Charge (Item)"))"Item Charge"
            else if(Type=const(Resource))Resource;

            trigger OnValidate()
            begin
            end;
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit of Measure"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Price";
            end;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Procurement Plan"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(11; "Procurement Plan Item"; Code[30])
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
        field(12; "Budget Line"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Request Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Expected Receipt Date"; Date)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header"=R;
            Caption = 'Expected Receipt Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            // CheckReservationDateConflict(FIELDNO("Expected Receipt Date"));
            //
            // IF "Expected Receipt Date" <> 0D THEN
            //  VALIDATE(
            //    "Planned Receipt Date",
            //    CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
            //      CalChange."Source Type"::Location,"Location Code",'',
            //      CalChange."Source Type"::Location,"Location Code",'',FALSE))
            // ELSE
            //  VALIDATE("Planned Receipt Date","Expected Receipt Date");
            end;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
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
        field(19; "Shortcut Dimension 2 Code"; Code[20])
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
        field(20; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(23; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(24; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Amount Inclusive VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Specification2; Blob)
        {
            Caption = 'Specification';
            DataClassification = ToBeClassified;
        }
        field(28; "FA Disposal Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Bid Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Staff Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Suggested"; Boolean)
        {
        }
        field(33; "Awarded"; Boolean)
        {
        }
        field(34; "Prospect No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "FA Disposal No"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Change Request"."FA Disposal No." where("Requisition No"=field(No)));
        }
        field(39; "Process Type"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Change Request"."Process Type" where("Requisition No"=field(No)));
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote";
        }
        field(60021; Number; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Number, "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Expected Receipt Date")
        {
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    ReqHeader: Record "Internal Request Header";
    ProcurementPlan: Record "Procurement Plan";
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
}
