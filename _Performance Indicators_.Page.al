page 50717 "Performance Indicators"
{
    Caption = 'Performance Indicators';
    PageType = List;
    SourceTable = "Strategic Imp Initiatives";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("No."; Rec."SNo.")
                {
                }
                field("Objective"; Rec.Initiatives)
                {
                }
                field(Timelines; Rec.Timelines)
                {
                    ToolTip = 'Specifies the value of the Timelines field.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
                field(ObjectiveCode; Rec.ObjectiveCode)
                {
                    Caption = 'Key result area';
                    Visible = false;
                }
                field("Strategic Objectives"; Rec."Strategic Objectives")
                {
                    Visible = false;
                }
                field("Mark Out of Score"; Rec."Mark Out of Score")
                {
                    ToolTip = 'Specifies the value of the Mark Out of Score field.';
                    ApplicationArea = All;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ToolTip = 'Specifies the value of the Self Rating field.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Self Rating" > 16 then Error('Self Rating Should be less than 16');
                    end;
                }
                field("Performance Appraisal Score"; Rec."Performance Appraisal Score")
                {
                    ToolTip = 'Specifies the value of the Performance Appraisal Score field.';
                    ApplicationArea = All;
                    Visible = UnderReview or UnderFurtherReview;

                    trigger OnValidate()
                    begin
                        if Rec."Performance Appraisal Score" > 16 then Error('Performance Appraisal Score Should be less than 16');
                    end;
                }
                field("Moderated Score"; Rec."Moderated Score")
                {
                    ToolTip = 'Specifies the value of the Moderated Score field.';
                    ApplicationArea = All;
                    Visible = UnderFurtherReview;

                    trigger OnValidate()
                    begin
                        if Rec."Moderated Score" > 16 then Error('Moderated Score Should be less than 16');
                    end;
                }
                field(Score; Rec.Score)
                { }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                    Visible = UnderFurtherReview;
                }
            }
        }
    }
    actions
    {
    }
    var
        UnderReview: Boolean;
        UnderFurtherReview: Boolean;
        EmployeeAppraisal: Record "Employee Appraisal";

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    begin
        UnderFurtherReview := false;
        UnderReview := false;
        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Target No", Rec."Target No.");
        If EmployeeAppraisal.FindFirst() then
            case EmployeeAppraisal."Appraisal Status" of
                EmployeeAppraisal."Appraisal Status"::Review:
                    begin
                        UnderReview := true;
                    end;
                EmployeeAppraisal."Appraisal Status"::"Further Review":
                    begin
                        UnderFurtherReview := true;
                    end;
            end;
    end;
}
