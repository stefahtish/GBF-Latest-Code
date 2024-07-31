page 51477 "Applicant SkillCard"
{
    Caption = 'Applicant SkillCard';
    PageType = Card;
    SourceTable = ApplicantSkills;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
            }
        }
    }
}
