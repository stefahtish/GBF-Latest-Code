page 50604 "Applicant Job Education"
{
    Caption = 'Applicant Job Education';
    PageType = ListPart;
    CardPageId = "Applicant Job Education Card";
    SourceTable = "Applicant Job Education2";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Education Type"; Rec."Education Type")
                {
                    ApplicationArea = All;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Education Level"; "Education Level")
                // {
                //     ApplicationArea = All;
                // }
                // field("Applicant Education level"; Rec."Applicant Education level")
                // {
                //     Caption = 'Education level';
                //     ApplicationArea = All;
                // }
                field("Applicant Education level33"; Rec."Education Level33")
                {
                    Caption = 'Education level';
                    ApplicationArea = All;
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = All;
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                }
                field("Highest Level"; Rec."Highest Level")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = true;
                }
                field("Need Code"; Rec."Need Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
