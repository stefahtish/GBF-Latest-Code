table 50440 "Vendor Evaluation Line"
{
    Caption = 'Vendor Evaluation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Evaluation Type"; Text[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Evaluation SetUp";
        }
        field(4; "Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pass"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Comments"; Text[50])
        {
        }
        field(7; "Supplier"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(8; "Supplier Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Evaluation Description"; Text[100])
        {
        }
        field(10; "Max Score"; Decimal)
        {
        }
        field(11; "Tender No."; Code[50])
        {
        }
        field(12; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Vendor Evaluation Line".Score);
        }
        field(13; "Evaluation Line"; Text[70])
        {
            Caption = 'Evaluation Category';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Evaluation Setup Line".Code where(HeaderCode=field("Evaluation Type"));

            trigger OnValidate()
            begin
                if EvalSetupLines.Get("Evaluation Line")then begin
                    "Line Description":=EvalSetupLines.Description;
                    "Eval Lines Maximum score":=EvalSetupLines."Maximum Score";
                end;
            end;
        }
        field(14; "Line Description"; Blob)
        {
            Caption = 'Evaluation category Description';
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(15; "Eval Lines Maximum score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No, Supplier, "Evaluation Type", "Evaluation Line", "Line No.")
        {
            Clustered = true;
        }
    }
    var EvalSetup: Record "Supplier Evaluation SetUp";
    EvalSetupLines: Record "Vendor Evaluation Setup Line";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
    end;
}
