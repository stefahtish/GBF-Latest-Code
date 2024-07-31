page 51464 "Approved Targets List"
{
    Caption = 'Approved Targets List';
    PageType = List;
    CardPageId = "Target Setup Header";
    SourceTable = "Target Setup Header";
    SourceTableView = WHERE("Target Status" = FILTER(Approved));
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
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
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
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ToolTip = 'Specifies the value of the Appraisal Period field.';
                    ApplicationArea = All;
                }
                field("Appraisal Status"; Rec."Target Status")
                {
                    ToolTip = 'Specifies the value of the Appraisal Status field.';
                    ApplicationArea = All;
                }
                field("Appraisal Type Description"; Rec."Appraisal Type Description")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type Description field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ToolTip = 'Specifies the value of the Appraiser No field.';
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
