page 50733 "Appraisal Target Lines"
{
    Caption = 'Appraisal Target Lines';
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Target Setup Lines";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("SNo."; Rec."SNo.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Rating"; Rec."Total Rating")
                {
                    ToolTip = 'Specifies the value of the Total Rating field.';
                    ApplicationArea = All;
                    Caption = 'Total Self Rating';
                    Editable = false;
                }
                field("Performance Appraisal Score"; Rec."Performance Appraisal Score")
                {
                    ToolTip = 'Specifies the value of the Performance Appraisal Score field.';
                    Caption = 'Total Supervisor Score';
                    Editable = false;
                    ApplicationArea = All;
                    Visible = UnderReview or UnderFurtherReview;
                }
                field("Moderated Score"; Rec."Moderated Score")
                {
                    ToolTip = 'Specifies the value of the Moderated Score field.';
                    ApplicationArea = All;
                    Caption = 'Total Moderated Score';
                    Editable = false;
                    Visible = UnderFurtherReview;
                }
                field("Max Score"; Rec."Max Score")
                {
                    ToolTip = 'Specifies the value of the Max Score field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Performance Indicators")
            {
                Image = CampaignEntries;
                RunObject = page "Performance Indicators";
                RunPageLink = ObjectiveCode=field("SNo."), "Target No."=FIELD("Target No"), "Employee No."=field("Employee No"), "Appraisal Period"=field("Appraisal Period");
            }
        }
    }
    var UnderReview: Boolean;
    UnderFurtherReview: Boolean;
    EmployeeAppraisal: Record "Employee Appraisal";
    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;
    local procedure SetControlAppearance()
    begin
        UnderFurtherReview:=false;
        UnderReview:=false;
        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Target No", Rec."Target No");
        If EmployeeAppraisal.FindFirst()then case EmployeeAppraisal."Appraisal Status" of EmployeeAppraisal."Appraisal Status"::Review: begin
                UnderReview:=true;
            end;
            EmployeeAppraisal."Appraisal Status"::"Further Review": begin
                UnderFurtherReview:=true;
            end;
            end;
    end;
}
