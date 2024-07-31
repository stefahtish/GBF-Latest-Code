table 50213 "Appraisal Lines"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Appraisal Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Key Responsibility"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        // TableRelation = "Strategic Imp Objectives";
        // trigger OnValidate()
        // var
        //     StrategicObj: Record "Strategic Imp Objectives";
        // begin
        //     IF StrategicObj.GET("Key Responsibility") THEN
        //         "Key Responsibility" := StrategicObj.Description;
        // END;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; "Key Indicators"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Agreed Target Date"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Weighting; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(9; "Results Achieved Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Score/Points"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(11; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Appraiser's Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Appraisee's comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Appraisal Heading Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Objectives, "Core Values", "Core Competencies", "Managerial and Supervisory";
        }
        field(17; "Appraisal Header"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Format Header";
        }
        field(18; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Rating; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Performance Plan,Appraisal';
            OptionMembers = "Performance Plan", Appraisal;
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Setting,Review,Appraisal';
            OptionMembers = Setting, Review, Appraisal;
        }
        field(23; Indentation; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(24; "Mid-Year Appraisal"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Weighting);
                if "Mid-Year Appraisal" > Weighting then Error('Value cannot be greater than Weighting value');
            end;
        }
        field(25; "Final Self-Appraisal"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Mid-Year Appraisal");
                TestField(Weighting);
                if "Final Self-Appraisal" > Weighting then Error('Value cannot be greater than Weighting value');
                //Variance := "Score/Points" - "Final Self-Appraisal";
                "Total marks per target":=("Final Self-Appraisal" + "Mid-Year Appraisal") / 2;
            end;
        }
        field(26; "Appraisal Line Type"; Option)
        {
            Caption = 'Objective Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Objective,Main Heading,Main Heading End,Sub-Heading,Sub-Heading End';
            OptionMembers = Objective, "Objective Heading", "Objective Heading End", "Sub-Heading", "Sub-Heading End";

            trigger OnValidate()
            var
                GLEntry: Record "G/L Entry";
                GLBudgetEntry: Record "G/L Budget Entry";
            begin
                HrMgt.IndentAppraisalGoals("Appraisal No");
            end;
        }
        field(27; Totaling; Text[250])
        {
            Caption = 'Totaling';
            DataClassification = ToBeClassified;
        //This property is currently not supported
        //TestTableRelation = false;
        //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //ValidateTableRelation = false;
        }
        field(28; KPI; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "FY Target"; Decimal)
        {
            //caption = 'Approved performance targets';
            DataClassification = ToBeClassified;
        }
        field(30; Variance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Initiative code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Strategy."Strategy Code" where("Strategy Objective No."=field("Objective Code"));

            trigger OnValidate()
            var
                StrategicInit: Record Strategy;
            begin
                StrategicInit.Reset;
                StrategicInit.SetRange("Strategy Code", "Initiative code");
                if StrategicInit.Find('-')then begin
                    Description:=StrategicInit.Strategy;
                end;
            end;
        }
        field(32; "Activity code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Activity"."Activity Code" where("Strategy Code"=field("Initiative code"));

            trigger OnValidate()
            var
                StrategicAct: Record "Strategic Activity";
            begin
                StrategicAct.Reset;
                StrategicAct.SetRange(StrategicAct."Activity Code", "Activity code");
                if StrategicAct.Find('-')THEN begin
                    "Key Indicators":=StrategicAct.Activity2;
                end;
            END;
        }
        field(33; "Objective Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Objective".Code;

            trigger OnValidate()
            var
                StrategicObj: Record "Strategic Objective";
            begin
                StrategicObj.Reset;
                StrategicObj.SetRange(Code, "Objective Code");
                if StrategicObj.Find('-')THEN begin
                    "Key Responsibility":=StrategicObj.Description;
                end;
            END;
        }
        field(34; Task; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Agreed perfomance targets"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Actual targets"; Text[1000])
        {
            Caption = 'Actual/achieved targets';
            DataClassification = ToBeClassified;
        }
        field(37; "Employee's Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Supervisor's Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Total marks per target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Duties and Responsibility"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Performance Rating"; Option)
        {
            OptionMembers = "1", "2", "3", "4", "5";
            OptionCaption = '1,2,3,4,5';
        }
        field(42; "Next Year Duties"; Boolean)
        {
        }
        field(43; "Appraisee No"; Code[20])
        {
        }
        field(44; MyField; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appraisal No", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var HrMgt: Codeunit "HR Management";
}
