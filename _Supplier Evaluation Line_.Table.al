table 50432 "Supplier Evaluation Line"
{
    Caption = 'Supplier Evaluation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'Tender No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Procurement Request";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Evaluation Type"; Text[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Evaluation SetUp" where(Type=const(Tender));

            trigger OnValidate()
            begin
                if EvalSetup.Get("Evaluation Type")then begin
                    "Evaluation Description":=EvalSetup."Evalueation Description";
                    "Max Score":=EvalSetup."Maximum Score";
                end;
            end;
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
            TableRelation = "Prospective Suppliers"."No.";
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
            CalcFormula = sum("Supplier Evaluation Score".Score where("Document No."=field("Quote No"), "Supplier Code"=field(Supplier)));
        }
    }
    keys
    {
        key(PK; "Quote No", "Line No.")
        {
            Clustered = true;
        }
    }
    var EvalSetup: Record "Supplier Evaluation SetUp";
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
