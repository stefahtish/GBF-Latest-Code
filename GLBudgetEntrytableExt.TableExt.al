tableextension 50115 GLBudgetEntrytableExt extends "G/L Budget Entry"
{
    fields
    {
        field(50000; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                if "Global Dimension 2 Code" = '' then exit;
                GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(50001; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashed with other fields from Budget Approval Lines Table';
        }
        field(50002; "Transferred from/To Ac"; Code[20])
        {
            Caption = 'Transferred from/To Ac';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ObsoleteState = Removed;
            ObsoleteReason = 'Clashed with other fields from Budget Approval Lines Table';
        }
        field(50006; "Budget Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open, "Pending Approval", Approved, Rejected;
        }
        field(50020; Transferred_; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Transferred from/To Ac_"; Code[20])
        {
            Caption = 'Transferred from/To Ac';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50022; Dairy; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Research Budget Setup"."Dairy Standards" where("Activity Code"=field("Budget Dimension 3 Code")));
        }
        field(50023; Support; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Research Budget Setup"."Stakeholder support" where("Activity Code"=field("Budget Dimension 3 Code")));
        }
        field(50024; Promotion; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Research Budget Setup"."Promotion Activities" where("Activity Code"=field("Budget Dimension 3 Code")));
        }
        field(50025; Partnership; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Research Budget Setup"."Partnersip Activities" where("Activity Code"=field("Budget Dimension 3 Code")));
        }
        field(50026; Survey; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Research Budget Setup"."Research and Survey" where("Activity Code"=field("Budget Dimension 3 Code")));
        }
        field(50027; CurrYear; Boolean)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50028; "Current Year"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Budget Name"."Current Year" where(Name=field("Budget Name")));
        }
    }
    var Text000: Label 'The dimension value %1 has not been set up for dimension %2.';
    GLSetupRetrieved: Boolean;
    GLSetup: Record "General Ledger Setup";
    local procedure ValidateDimValue(DimCode: Code[20]; var DimValueCode: Code[20])
    var
        DimValue: Record "Dimension Value";
    begin
        if DimValueCode = '' then exit;
        DimValue."Dimension Code":=DimCode;
        DimValue.Code:=DimValueCode;
        DimValue.Find('=><');
        if DimValueCode <> CopyStr(DimValue.Code, 1, StrLen(DimValueCode))then Error(Text000, DimValueCode, DimCode);
        DimValueCode:=DimValue.Code;
    end;
    local procedure GetGLSetup()
    begin
        if not GLSetupRetrieved then begin
            GLSetup.Get;
            GLSetupRetrieved:=true;
        end;
    end;
    procedure GetNextEntryNo(): Integer var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetEntry.SetCurrentKey("Entry No.");
        if GLBudgetEntry.FindLast then exit(GLBudgetEntry."Entry No." + 1);
        exit(1);
    end;
}
