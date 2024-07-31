table 50433 "Supplier Evaluation SetUp"
{
    Caption = 'Supplier Evaluation Score Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Evalueation Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Evaluation Heading';
        }
        field(3; "Maximum Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Minimum Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Description; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(8; "Total Maximum Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Setup Line"."Maximum Score" where(Code=field(Code)));
        }
        field(9; "Score Criteria";enum "Supplier Evaluation Score Types")
        {
        }
        field(10; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote", Existing;
        }
        field(11; "Total PassMark"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Setup Line".Passmark where(Code=field(Code)));
        }
        field(12; "Procurement Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request" where("Process Type"=field(Type));
        }
        field(13; "RFP Passmark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Evaluation Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Preliminary, Technical;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
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
