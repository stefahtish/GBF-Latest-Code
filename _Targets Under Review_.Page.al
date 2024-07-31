page 51463 "Targets Under Review"
{
    Caption = 'Targets Under Review';
    PageType = List;
    CardPageId = "Target Setup Header";
    SourceTable = "Target Setup Header";
    SourceTableView = WHERE("Target Status" = FILTER("Under Review"));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Target No"; Rec."Target No")
                {
                    ToolTip = 'Specifies the value of the Target No field.';
                    ApplicationArea = All;
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ToolTip = 'Specifies the value of the Appraiser No field.';
                    ApplicationArea = All;
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    ToolTip = 'Specifies the value of the Appraisee Name field.';
                    ApplicationArea = All;
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    ToolTip = 'Specifies the value of the Appraisee''s Job Title field.';
                    ApplicationArea = All;
                }
                field("Target Status"; Rec."Target Status")
                {
                    ToolTip = 'Specifies the value of the Appraisal Status field.';
                    ApplicationArea = All;
                }
                field("Appraisal Type Description"; Rec."Appraisal Type Description")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type Description field.';
                    ApplicationArea = All;
                }
                // field(AppraisalType; Rec.AppraisalType)
                // {
                //     ToolTip = 'Specifies the value of the Appraisal Type field.';
                //     ApplicationArea = All;
                // }
                field(Directorate; Rec.Directorate)
                {
                    ToolTip = 'Specifies the value of the Directorate field.';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field("Division/Section"; Rec."Division/Section")
                {
                    ToolTip = 'Specifies the value of the Division/Section field.';
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                    ApplicationArea = All;
                }
                field("Second Appraiser Job"; Rec."Second Appraiser Job")
                {
                    ToolTip = 'Specifies the value of the Second Appraiser Job field.';
                    ApplicationArea = All;
                }
                field("Second Appraiser Name"; Rec."Second Appraiser Name")
                {
                    ToolTip = 'Specifies the value of the Second Appraiser Name field.';
                    ApplicationArea = All;
                }
                field("Second Appraiser No."; Rec."Second Appraiser No.")
                {
                    ToolTip = 'Specifies the value of the Second Appraiser No. field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                // field("Type"; Rec.AppraisalType)
                // {
                //     ToolTip = 'Specifies the value of the Type field.';
                //     ApplicationArea = All;
                // }
                field("Total Weighting"; Rec."Total Weighting")
                {
                    ToolTip = 'Specifies the value of the Total Weighting field.';
                    ApplicationArea = All;
                }
                field("Total score"; Rec."Total score")
                {
                    ToolTip = 'Specifies the value of the Total score field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Appraisee ID", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}
