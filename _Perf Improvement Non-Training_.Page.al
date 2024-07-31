page 51297 "Perf Improvement Non-Training"
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
                field("Job Rotation"; Rec."Job Rotation")
                {
                }
                field(Transfer; Rec.Transfer)
                {
                }
                field(Counselling; Rec.Counselling)
                {
                }
                field(Coaching; Rec.Coaching)
                {
                }
                Field("Action Location"; Rec."Action Location")
                {
                    Caption = 'Specify where';
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
