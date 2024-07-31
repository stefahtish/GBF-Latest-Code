page 51476 "Applicant Skills"
{
    Caption = 'Skills';
    PageType = ListPart;
    SourceTable = ApplicantSkills;
    CardPageId = "Applicant SkillCard";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                    ApplicationArea = All;
                }
                field("Skill Code"; Rec."Skill Code")
                {
                    ToolTip = 'Specifies the value of the Skill Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
            }
        }
    }
}
