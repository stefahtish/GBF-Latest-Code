table 50301 "Training Needs Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Need";
        }
        field(3; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Budget"."Budget Item No";

            trigger OnValidate()
            var
                TrainingBudget: Record "Training Budget";
            begin
                TrainingBudget.SetRange("Budget Item No", "Expense Code");
                if TrainingBudget.FindFirst()then begin
                    "G/L Account":=TrainingBudget."No.";
                    "Expense name":=TrainingBudget.Description;
                    "Budget Line":=TrainingBudget."Source of Funds";
                end;
            end;
        }
        field(4; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision;
                if "Currency Code" = '' then "Amount (LCY)":=Round(Amount, CurrencyRec."Amount Rounding Precision")
                else
                    "Amount (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", Amount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(8; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(14; Status; Option)
        {
            CalcFormula = Lookup("Training Need".Status WHERE(Code=FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'New,Closed,Application';
            OptionMembers = Open, Closed, Application;
        }
        field(15; "Expense name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Budget Line"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(2; "Line No"; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        TrainingNeed.Get("Document No.");
        TrainingNeed.TestField("Start Date");
        TrainingNeed.TestField("End Date");
        "Start Date":=TrainingNeed."Start Date";
        "End Date":=TrainingNeed."End Date";
        "Shortcut Dimension 1 Code":=TrainingNeed."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code":=TrainingNeed."Shortcut Dimension 2 Code";
        "Dimension Set ID":=TrainingNeed."Dimension Set ID";
        "Currency Code":=TrainingNeed."Currency Code";
    end;
    var TrainingNeed: Record "Training Need";
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    DimMgt: Codeunit DimensionManagement;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Training', "Document No."), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
        end;
    end;
}
