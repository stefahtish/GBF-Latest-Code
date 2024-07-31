table 50730 "Employee Qualifications"
{
    Caption = 'Qualification';
    DataCaptionFields = "Code", Description;
    //EDDIE HR
    DrillDownPageID = "Application Qualifications";
    LookupPageID = "Application Qualifications";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[2000])
        {
            Caption = 'Description';
        }
        field(50000; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(50001; "Field of Study"; Code[2000])
        {
            TableRelation = "Field of Study";
        }
        field(50002; "Education Level";enum "Education Level")
        {
            DataClassification = ToBeClassified;
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
}
