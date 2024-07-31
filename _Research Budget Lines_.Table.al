table 50636 "Research Budget Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Activity=const(Promotion))"G/L Budget Entry"."Entry No." where("Current Year"=const(true), Promotion=const(true))
            else if(Activity=const(Partnership))"G/L Budget Entry"."Entry No." where("Current Year"=const(true), Partnership=const(true))
            else if(Activity=const(Stakeholders))"G/L Budget Entry"."Entry No." where("Current Year"=const(true), Support=const(true))
            else if(Activity=const(Dairy))"G/L Budget Entry"."Entry No." where("Current Year"=const(true), Dairy=const(true))
            else if(Activity=const(Research))"G/L Budget Entry"."Entry No." where("Current Year"=const(true), Survey=const(true));

            trigger OnValidate()
            var
                GLBudget: Record "G/L Budget Entry";
                GLAccount: Record "G/L Account";
            begin
                if GLBudget.Get("Entry No")then begin
                    "Expense Code":=GLBudget."G/L Account No.";
                    "Budget Amount":=GLBudget.Amount;
                    "Dimension Set ID":=GLBudget."Dimension Set ID";
                    if GLAccount.Get(GLBudget."G/L Account No.")then "Expense name":=GLAccount.Name;
                end;
            end;
        }
        field(3; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ResearchBudget: Record "Research Budget";
            begin
            // ResearchBudget.SetRange("Expense Code", "Expense Code");
            // if ResearchBudget.FindFirst() then begin
            //     "G/L Account" := ResearchBudget."Source of Funds";
            //     "Budget Line" := ResearchBudget."Source of Funds";
            // end;
            end;
        }
        field(4; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
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
            //Editable = false;
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
        field(15; "Expense name"; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; "Budget Line"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17; "Activity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Promotion, Partnership, Dairy, Research, Stakeholders;
            OptionCaption = ' ,Promotion,Partnership,Dairy,Research,Stakeholders';
        }
        field(18; "Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Expense Code", Activity)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;
    var ExpenseCode: Record "Expense Code";
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
