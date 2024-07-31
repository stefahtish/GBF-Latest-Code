table 50193 "ICT Workplan"
{
    Caption = 'ICT Workplan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Activity Code"; Code[20])
        {
            ObsoleteState = Removed;
            Caption = 'Activity Code';
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance SubCriteria".code;
        // trigger OnValidate()
        // var
        //     SubCriteria: Record "Perfomance SubCriteria";
        // begin
        //     SubCriteria.reset;
        //     SubCriteria.SetRange(Code, "Activity Code");
        //     SubCriteria.SetRange(TimeFrame, "Time Frame");
        //     if SubCriteria.FindFirst() then begin
        //         "Activity Description" := SubCriteria.Description;
        //         Target := SubCriteria."Annual  Target";
        //     end;
        // end;
        }
        field(3; Target; Decimal)
        {
            Caption = 'Target';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Time Frame"; Code[20])
        {
            Caption = 'Time Frame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame";
        // trigger OnValidate()
        // begin
        //     if "Activity Code" <> ' ' then
        //         Validate("Activity Code");
        // end;
        }
        field(8; "Activity Description"; Text[200])
        {
            ObsoleteState = Removed;
            Caption = 'Activity Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Estimated Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("ICT WorkPlan Lines"."Estimated Budget" where("No."=field("No.")));
        }
        field(10; Status;enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Key Perfomance Criteria"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Key Perfomance Criteria Setup";

            trigger OnValidate()
            var
                KPISetup: Record "Key Perfomance Criteria Setup";
            begin
                if KPISetup.get("Key Perfomance Criteria")then "KP Criteria Description":=KPISetup.Description;
            end;
        }
        field(13; "KP Criteria Description"; Text[100])
        {
            Caption = 'Key Perfomance criteria description';
            DataClassification = ToBeClassified;
        }
        field(14; "Key Result Area"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Key Result Area";

            trigger OnValidate()
            var
                KRASetup: Record "Key Result Area";
            begin
                if KRASetup.get("Key Result Area")then "KRA Description":=KRASetup.Description;
            end;
        }
        field(15; "KRA Description"; Text[100])
        {
            Caption = 'Key Result Area description';
            DataClassification = ToBeClassified;
        }
        field(16; "Criteria Code"; Code[20])
        {
            Caption = 'Criteria Code';
            DataClassification = ToBeClassified;
            TableRelation = "Criteria Category";

            trigger OnValidate()
            var
                Categories: record "Criteria Category";
            begin
                Categories.Reset();
                Categories.SetRange(Categories.Code, "Criteria Code");
                if Categories.FindFirst()then begin
                    "Criteria Description":=Categories.Description;
                end;
            end;
        }
        field(17; "Criteria Description"; Text[200])
        {
            Caption = 'Criteria Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if not ICTSetup.Get then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;
        ICTSetup.TestField("Workplan Nos");
        NoSeriesMgt.InitSeries(ICTSetup."Workplan Nos", xRec."No. Series", Today, "No.", "No. Series");
        "Created By":=UserId;
        "Document Date":=Today;
    end;
    var ICTSetup: Record "ICT Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
