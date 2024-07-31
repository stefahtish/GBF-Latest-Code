table 50245 "R. Shortlisting Criteria"
{
    fields
    {
        field(1; "Need Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No.";
        }
        field(2; "Stage Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Stages";

            trigger OnValidate()
            begin
                if RStages.Get("Stage Code")then begin
                    "Stage Name":=RStages.Description;
                    "Application Stage":=RStages.Application;
                    "Interview Stage":=RStages.Interview;
                end;
            end;
        }
        field(3; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job"."Job ID";
        }
        field(4; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(5; Qualification; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Qualifications.Get(Qualification)then "Qualification Description":=Qualifications.Description;
            end;
        }
        field(6; "Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Qualification Description"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Stage Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Interview Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interview Setup";

            trigger OnValidate()
            begin
                if Interview.Get("Interview Type")then "Interview Description":=Interview.Description;
            end;
        }
        field(10; "Interview Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Application Stage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Interview Stage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Need Code", "Stage Code", "Job ID", "Qualification Type", Qualification, "Interview Type")
        {
            Clustered = true;
            SumIndexFields = "Desired Score";
        }
    }
    fieldgroups
    {
    }
    var Qualifications: Record Qualification;
    RStages: Record "Recruitment Stages";
    Interview: Record "Interview Setup";
}
