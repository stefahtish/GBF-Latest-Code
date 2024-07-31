table 50290 "Appraisal Comments"
{
    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Person; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Appraiser,Appraisee,Second Supervisor,HR,Trust Secretary,Dev Action,Significant Positive Issues,Significant Negative Issues,Substantial Achievements,Perfomance Improvement Plan,Staff Training and Dev Needs,OtherInterventios';
            OptionMembers = " ", Appraiser, Appraisee, "Second Supervisor", HR, "Trust Secretary", "Dev Action", "Significant Positive Issues", "Significant Negative Issues", "Substantial Achievements", "Perfomance Improvement Plan", "Staff Training and Dev Needs", "Other interventions";
        }
        field(3; "Performance Related Dicussions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Extent of Discussion Help"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Very Much,Much,Not at all';
            OptionMembers = " ", "Very Much", Much, "Not at all";
        }
        field(5; "Comments on Performance"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Comments On Supervisor"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Comments by Second Suprvisor"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Target Achievement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Values,Core Competences,Curriculum Delivery,Research,Initiative & Willingness,Managerial & Supervisory';
            OptionMembers = " ", Values, "Core Competences", "Curriculum Delivery", Research, "Initiative & Willingness", "Managerial & Supervisory";
        }
        field(10; "End Year Rating"; Decimal)
        {
            CalcFormula = Sum("Appraisal Competences".Score WHERE("Appraisal No."=FIELD("Appraisal No."), "Core Value/Competence"=FIELD("Target Achievement")));
            FieldClass = FlowField;
        }
        field(11; "Total Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Average Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Comment Type"; Option)
        {
            OptionMembers = " ", Achievement, Constraint;
            OptionCaption = ' ,Achievement,Constraint';
        }
        field(14; "Appraisal Report Comment"; Text[1000])
        {
        }
        field(15; "Performance Reward Comments"; Text[1000])
        {
        }
        field(16; "Performance Reward Decision"; Option)
        {
            OptionMembers = " ", Warnings, Demotion, Separation, "Placement on performance improvement plan";
            OptionCaption = ' ,Warnings,Demotion,Separation,Placement on performance improvement plan';
        }
        field(17; "Promotional Potential"; Text[1000])
        {
        }
        field(18; Recognition; Text[1000])
        {
        }
        field(19; "Merit Increment"; Option)
        {
            OptionMembers = " ", "Recommended", "Not Recommended";
            OptionCaption = ' ,Recommeded,Not Recommended';
        }
        field(20; "Annual Increment"; Option)
        {
            OptionMembers = " ", "Granted", "Not Granted";
            OptionCaption = ' ,Granted,Not Granted';
        }
    }
    keys
    {
        key(Key1; "Appraisal No.", Person, "Comments on Performance")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
