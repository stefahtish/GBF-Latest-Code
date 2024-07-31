table 50288 "Appraisal Lines-JD"
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
                TestField(Weighting);
                if "Score/Points" > Weighting then Error('Value cannot be greater than Weighting value');
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
            TableRelation = "Score Setup";
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
                TestField(Weighting);
                if "Final Self-Appraisal" > Weighting then Error('Value cannot be greater than Weighting value');
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
