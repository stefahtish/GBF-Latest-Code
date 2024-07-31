table 50418 "Quote Evaluation Header"
{
    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Procurement Request";
        }
        field(2; Title; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header";
        }
        field(4; "Quote Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Minutes; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Awarding Committee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Committees";
        }
        field(7; "Date of Award"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New, "Pending Approval", Approved, Rejected;
        }
        field(9; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(13; "Award Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Least Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Quote Evaluation".Amount where("Quote No"=field("Quote No"), Amount=filter(>0)));
            Editable = false;
        }
        field(15; "Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Background Profile"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Quotation Deadline"; Date)
        {
            Caption = 'Closing Date';
            DataClassification = ToBeClassified;
        }
        field(18; "Submitted To Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Expected Closing Time"; Time)
        {
            Caption = 'Closing Time';
            DataClassification = ToBeClassified;
        }
        field(20; Stage; Option)
        {
            OptionMembers = Evaluation, Negotiation, Specialized;
            DataClassification = ToBeClassified;
        }
        field(21; Terminated; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request".Terminated where("No."=field("Quote No")));
        }
        field(22; "Legal Aspects"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Quote No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}
