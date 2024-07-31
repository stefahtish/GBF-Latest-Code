table 50394 "Loan Interest Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    HRSetup.TestField("Loan Interest Nos");
                    NoSeriesManagement.TestManual(HRSetup."Loan Interest Nos");
                end;
            end;
        }
        field(2; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX"."Starting Date"; //WHERE(Closed = CONST(false));

            trigger OnValidate()
            var
                PeriodRec: Record "Payroll PeriodX";
            begin
                if PeriodRec.Get("Period Reference")then begin
                    "Period Narration":=PeriodRec.Name + ' ' + Format(Date2DMY("Period Reference", 3));
                    Description:=StrSubstNo('%1 Interest Charged', "Period Narration");
                end;
            end;
        }
        field(7; "Period Narration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Dimension Set ID"; Integer)
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
        field(13; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Date Reversed"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Loan Interest Nos");
            NoSeriesManagement.InitSeries(HRSetup."Loan Interest Nos", xRec."No Series", 0D, "No.", "No Series");
        end;
        "Created By":=UserId;
        "Date Entered":=Today;
    end;
    var NoSeriesManagement: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    HRSetup: Record "Human Resources Setup";
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then Modify;
    end;
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
    /*         OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet2(
                    "Dimension Set ID", StrSubstNo('%1 %2', 'Interest Doc', "No."),
                    "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                if OldDimSetID <> "Dimension Set ID" then begin
                    Modify;
                end; */
    end;
}
