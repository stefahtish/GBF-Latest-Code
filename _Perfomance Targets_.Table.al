table 50651 "Perfomance Targets"
{
    Caption = 'Perfomance Targets';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Document No." <> "Document No." THEN NoSeriesMgt.TestManual(PlanningSetup."Perfomance Contract Nos");
            end;
        }
        field(2; KRA; Code[20])
        {
            Caption = 'KRA';
            DataClassification = ToBeClassified;
            TableRelation = "Key Result Area";

            trigger OnValidate()
            var
                KRA2: Record "Key Result Area";
            begin
                if KRA2.Get(KRA)then "KRA Description":=KRA2.Description;
            end;
        }
        field(3; "Strategic Objective Code"; Code[20])
        {
            Caption = 'Strategic Objective Code';
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective".Code where("Issue Code"=field("Strategic Issue"), "KRA Code"=field(KRA));

            // TableRelation = "Strategic Objective".Code where("Issue Code" = field("Strategic Issue"));
            trigger OnValidate()
            var
                Objective: Record "Strategic Objective";
            begin
                Objective.Reset();
                Objective.SetRange(Code, "Strategic Objective Code");
                if Objective.Find('-')then "Strategic Obj. Description":=Objective.Description;
            end;
        }
        field(4; "Strategy Code"; Code[20])
        {
            Caption = 'Strategy Code';
            DataClassification = ToBeClassified;
            TableRelation = Strategy."Strategy Code" where("Strategy Objective No."=field("Strategic Objective Code"), "Strategic Issue No."=field("Strategic Issue"), KRA=field(KRA));

            trigger OnValidate()
            var
                Strategies: record Strategy;
            begin
                Strategies.Reset();
                Strategies.SetRange(Strategies."Strategy Code", "Strategy Code");
                if Strategies.FindFirst()then "Strategy Description":=Strategies.Strategy;
            end;
        }
        field(5; Activity; Text[2048])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        //TableRelation = "Strategic Activities"."Activity Code" where("Strategy Code" = field("Strategy Code"));
        }
        field(6; TimeFrame; Code[20])
        {
            Caption = 'TimeFrame';
            DataClassification = ToBeClassified;
            TableRelation = "Time Frames"."Time Frame" where(Closed=const(false));
        }
        field(7; Unit; Code[20])
        {
            Caption = 'Unit';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; Weight; Code[100])
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(9; "Annual  Target"; Decimal)
        {
            Caption = 'Annual  Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Annual  Target" where("Document No."=field("Document No.")));
        }
        field(10; "Q1 Target"; Decimal)
        {
            Caption = 'Q1 Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Q1 Target" where("Document No."=field("Document No.")));
        }
        field(11; "Q2 Target"; Decimal)
        {
            Caption = 'Q2 Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Q2 Target" where("Document No."=field("Document No.")));
        }
        field(12; "Q3 Target"; Decimal)
        {
            Caption = 'Q3 Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Q3 Target" where("Document No."=field("Document No.")));
        }
        field(13; "Q4 Target"; Decimal)
        {
            Caption = 'Q4 Target';
            FieldClass = FlowField;
            CalcFormula = sum("Perfomance Targets Lines"."Q4 Target" where("Document No."=field("Document No.")));
        }
        field(16; "Strategy Description"; Text[200])
        {
            Caption = 'Strategy Description';
            DataClassification = ToBeClassified;
        }
        field(17; "Criteria Code"; Code[20])
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
        field(18; "Criteria Description"; Text[200])
        {
            Caption = 'Criteria Description';
            DataClassification = ToBeClassified;
        }
        field(19; "Activity Code"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Activity"."Activity Code" where("Strategy Code"=field("Strategy Code"), "Strategy Objective No."=field("Strategic Objective Code"), "Strategic Issue No."=field("Strategic Issue"), KRA=field(KRA));

            trigger OnValidate()
            var
                Activities: record "Strategic Activity";
            begin
                Activities.Reset();
                Activities.SetRange(Activities."Activity Code", "Activity Code");
                if Activities.FindFirst()then Activity:=Activities.Activity2;
            end;
        }
        field(20; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Pefomance Indicator Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Perfomance SubCriteria".Code where("Criteria Code"=field("Criteria Code"));

            trigger OnValidate()
            var
                Indicators: Record "Perfomance SubCriteria";
            begin
                Indicators.SetRange(Code, "Pefomance Indicator Code");
                if Indicators.FindFirst()then "Indicator Description":=Indicators.Description;
            end;
        }
        field(25; "Indicator Description"; Text[2040])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "KRA Description"; Text[2040])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Strategic Obj. Description"; Text[2040])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Strategic Issue"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Issue".Code where("KRA Code"=field(KRA));

            trigger OnValidate()
            var
                StrategicIssue: Record "Strategic Issue";
            begin
                StrategicIssue.Reset();
                StrategicIssue.SetRange(Code, "Strategic Issue");
                if StrategicIssue.Find('-')then "Strategic Issue Description":=StrategicIssue.Description;
            end;
        }
        field(29; "Strategic Issue Description"; Text[2040])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Document No.", "Criteria Code", Activity, "Pefomance Indicator Code")
        {
        }
    }
    trigger OnInsert()
    begin
        if not PlanningSetup.Get()then begin
            PlanningSetup.Init();
            PlanningSetup.Insert();
        end;
        "Date Captured":=Today;
        "User ID":=UserId;
        PlanningSetup.TESTFIELD("Perfomance Contract Nos");
        NoSeriesMgt.InitSeries(PlanningSetup."Perfomance Contract Nos", xRec."No. Series", TODAY, "Document No.", "No. Series");
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    PlanningSetup: Record "Strategic Planning Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure CheckExisting()
    var
        Target: Record "Perfomance Targets";
    begin
        if(TimeFrame <> '') and (KRA <> '') and ("Criteria Code" <> '') and ("Pefomance Indicator Code" <> '') and ("Strategic Issue" <> '') and ("Strategic Objective Code" <> '') and ("Strategy Code" <> '') and ("Activity Code" <> '')then begin
            Target.Reset();
            Target.SetFilter("Document No.", '<>%1', Rec."Document No.");
            Target.SetRange("Criteria Code", "Criteria Code");
            Target.SetRange("Pefomance Indicator Code", "Pefomance Indicator Code");
            Target.SetRange(KRA, KRA);
            Target.SetRange("Strategic Issue", "Strategic Issue");
            Target.SetRange("Strategic Objective Code", "Strategic Objective Code");
            Target.SetRange("Strategy Code", "Strategy Code");
            Target.SetRange("Activity Code", "Activity Code");
            Target.SetRange(TimeFrame, TimeFrame);
            if Target.FindFirst()then Error('Target for Subcriteria %1, Criteria %2 Timeframe %3 and Activity %4 have been input in another document %5', Target."Pefomance Indicator Code", Target."Criteria Code", Target.TimeFrame, Target.Activity, Target."Document No.");
        end;
    end;
}
