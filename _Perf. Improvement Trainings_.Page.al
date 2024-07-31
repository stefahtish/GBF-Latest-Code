page 51296 "Perf. Improvement Trainings"
{
    PageType = ListPart;
    SourceTable = "Appraisal Trainings";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Training Areas"; Rec."Training Areas")
                {
                    ApplicationArea = All;
                }
                field("Training Solutions"; Rec."Training Solutions")
                {
                    ToolTip = 'Courses to be attended Or on-the-job-training';
                    ApplicationArea = All;
                }
                field("Action Taken By"; Rec."Action Taken By")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var
        myInt: Integer;
}
