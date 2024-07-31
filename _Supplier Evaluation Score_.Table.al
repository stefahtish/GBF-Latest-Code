table 50455 "Supplier Evaluation Score"
{
    Caption = 'Supplier Evaluation Score';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Supplier Code"; Code[50])
        {
            Caption = 'Supplier Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Score Parameter"; Code[50])
        {
            Caption = 'Score Parameter';
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Evaluation SetUp";
        }
        field(4; "Score Description"; Text[100])
        {
            Caption = 'Score Description';
            DataClassification = ToBeClassified;
        }
        field(5; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Score > "Maximum Score" then Error('Score %1 can not be greater than %2', Score, "Maximum Score");
            end;
        }
        field(6; "Maximum Score"; Decimal)
        {
            Caption = 'Maximum Score';
            DataClassification = ToBeClassified;
        }
        field(7; "Tender No."; code[50])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; Pass; Boolean)
        {
            Caption = 'Pass';
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(11; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score Line".Score where("Document No."=field("Document No."), "Score Parameter"=field("Score Parameter")));
        }
        field(12; "Score Criteria";enum "Supplier Evaluation Score Types")
        {
        }
        field(13; "Yes/No"; Option)
        {
            OptionMembers = " ", Yes, No;
            OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
        field(14; "Total Passmark"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score Line".Passmark where("Document No."=field("Document No."), "Supplier Code"=field("Supplier Code"), "Score Parameter"=field("Score Parameter")));
        }
        field(15; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Supplier Code", "Score Parameter")
        {
            Clustered = true;
        }
    }
}
