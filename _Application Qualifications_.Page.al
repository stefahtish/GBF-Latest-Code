page 51496 "Application Qualifications"
{
    Caption = 'Application Qualifications';
    PageType = List;
    SourceTable = "Employee Qualifications";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Level field.';
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field of Study field.';
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Type field.';
                }
            }
        }
    }
}
