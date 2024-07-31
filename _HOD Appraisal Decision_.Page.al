page 51299 "HOD Appraisal Decision"
{
    PageType = ListPart;
    SourceTable = "Appraisal Decision";
    Caption = 'Recommendation\Decision Head of Department';
    SourceTableView = where(Person = filter(HOD));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Appraisee Performance"; Rec."Appraisee Performance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remarks on Appraisee overall performance';
                }
                field("Merit Recommendation"; Rec."Merit Recommendation")
                {
                    ToolTip = 'Merit recommendation to the MD';
                }
                field("Training Action"; Rec."Training Action")
                {
                }
                field("Job Rotation"; Rec."Job Rotation")
                {
                    Caption = 'Job rotation Action';
                }
                field(Transfer; Rec.Transfer)
                {
                }
            }
        }
    }
}
