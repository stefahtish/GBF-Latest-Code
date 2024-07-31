table 50223 "Training Need"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    HRSetup.TestField("Training Needs Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Needs Nos");
                end;
            end;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GenLedSetup.Get;
                GenLedSetup.TestField("Current Budget Start Date");
                GenLedSetup.TestField("Current Budget End Date");
                if "Start Date" <> 0D then begin
                    if "Start Date" < GenLedSetup."Current Budget Start Date" then Error(Text001, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget Start Date"), Format(GenLedSetup."Current Budget Start Date"));
                    if "Start Date" > GenLedSetup."Current Budget End Date" then Error(Text002, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget End Date"), Format(GenLedSetup."Current Budget End Date"));
                    if "End Date" <> 0D then begin
                        if "Start Date" > "End Date" then Error(Text002, FieldCaption("Start Date"), Format("Start Date"), FieldCaption("End Date"), Format("End Date"));
                        if "End Date" < "Start Date" then Error(Text001, FieldCaption("End Date"), Format("End Date"), FieldCaption("Start Date"), Format("Start Date"));
                        Duration:=("End Date" - "Start Date") + 1 end;
                end;
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Start Date");
            end;
        }
        field(5; "Duration Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hours, Days, Weeks, Months, Years;
        }
        field(6; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            CalcFormula = Sum("Training Needs Lines".Amount WHERE("Document No."=FIELD(Code)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if Posted then begin
                    if Duration <> xRec.Duration then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Duration:=xRec.Duration;
                    end;
                end;
                CurrencyRec.InitRoundingPrecision;
                if "Currency Code" = '' then "Cost Of Training (LCY)":=Round("Cost Of Training", CurrencyRec."Amount Rounding Precision")
                else
                    "Cost Of Training (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Cost Of Training", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(8; Location; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Country Code"=CONST(''))Destination."Destination Code"
            ELSE IF("Country Code"=FILTER(<>''))Destination."Destination Code" WHERE("Country/Region Code"=FIELD("Country Code"));
        }
        field(9; Qualification; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Qualification.Code;
        }
        field(10; "Re-Assessment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Source; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Training Source & Facilitators".Source;
        }
        field(12; "Need Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Calendar,Appraisal,CPD, Adhoc,Disciplinary';
            OptionMembers = Calendar, Appraisal, CPD, Adhoc, Disciplinary;
        }
        field(13; Provider; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Vendor.Get(Provider)then "Provider Name":=Vendor.Name;
            end;
        }
        field(14; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(16; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(17; "Training Objectives"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Venue; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate("Cost Of Training");
            end;
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Closed,Application';
            OptionMembers = Open, Closed, Application;
        }
        field(21; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Cost Of Training (LCY)"; Decimal)
        {
            CalcFormula = Sum("Training Needs Lines"."Amount (LCY)" WHERE("Document No."=FIELD(Code)));
            FieldClass = FlowField;
        }
        field(23; "Provider Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "No. of Participants"; Integer)
        {
            CalcFormula = Count("Training Request" WHERE("Training Need"=FIELD(Code), Status=FILTER(Released)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Total PerDiem"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(29; "Dimension Set ID"; Integer)
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
        field(30; DimVal1; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code=FIELD("Shortcut Dimension 1 Code"), "Global Dimension No."=CONST(1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; DimVal2; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code=FIELD("Shortcut Dimension 2 Code"), "Global Dimension No."=CONST(2)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(33; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Open/Closed"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Closed';
            OptionMembers = Open, Closed;
        }
        field(35; "Skill code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Skill Code";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Needs Nos");
            NoSeriesManagement.InitSeries(HRSetup."Training Needs Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;
    trigger OnModify()
    begin
        TrainingNeedsLines.Reset;
        TrainingNeedsLines.SetRange("Document No.", Code);
        if TrainingNeedsLines.FindFirst then repeat TrainingNeedsLines."Start Date":="Start Date";
                TrainingNeedsLines."End Date":="End Date";
                TrainingNeedsLines."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                TrainingNeedsLines."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                TrainingNeedsLines."Dimension Set ID":="Dimension Set ID";
                TrainingNeedsLines."Currency Code":="Currency Code";
                TrainingNeedsLines.Modify;
            until TrainingNeedsLines.Next = 0;
    end;
    var OK: Boolean;
    NoSeriesManagement: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    HRSetup: Record "Human Resources Setup";
    CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    Employee: Record Employee;
    Vendor: Record Vendor;
    TrainingNeedsLines: Record "Training Needs Lines";
    GenLedSetup: Record "General Ledger Setup";
    Text001: Label 'The %1 %2 cannot be earlier than the %3 %4.';
    Text002: Label 'The %1 %2 cannot be after the %3 %4.';
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
    /*         OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet2(
                    "Dimension Set ID", StrSubstNo('%1 %2', 'Training', Code),
                    "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                if OldDimSetID <> "Dimension Set ID" then begin
                    Modify;
                end; */
    end;
}
