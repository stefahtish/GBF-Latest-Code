page 51268 "HR Management Cues"
{
    Caption = 'HR Management Cues';
    PageType = CardPart;
    SourceTable = "HR Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Employees")
            {
                field("Employees Active"; Rec."Employees Active")
                {
                    ApplicationArea = All;
                }
                field("Employees Inactive"; Rec."Employees Inactive")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Disciplinary)
            {
                field("Employee Discilinary cases"; Rec."Employee Discilinary cases")
                {
                    ApplicationArea = All;
                }
                field("Closed Disciplinary Cases"; Rec."Closed Disciplinary Cases")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Recruitment)
            {
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Requests"; Rec."Recruitment Requests")
                {
                    ApplicationArea = All;
                }
                field(Applicants; Rec.Applicants)
                {
                    ApplicationArea = All;
                }
                field("Recruitment Shortlist"; Rec."Recruitment Shortlist")
                {
                    ApplicationArea = All;
                }
                field("Interview List"; Rec."Interview List")
                {
                    ApplicationArea = All;
                }
            }
            // cuegroup("Leave Management")
            // {
            //     field("Leave Applications"; "Leave Applications")
            //     {
            //         ApplicationArea = All;
            //         DrillDownPageId = "Leave Application List";
            //     }
            //     field("Leave Recalls"; "Leave Recalls")
            //     {
            //         ApplicationArea = All;
            //         DrillDownPageId = "Leave Recall List";
            //     }
            //     field("Leave Adjustments"; "Leave Adjustments")
            //     {
            //         ApplicationArea = All;
            //         DrillDownPageId = "Leave Adjustment List";
            //     }
            // }
            cuegroup("Perfomance")
            {
                field("Open Appraisals"; Rec."Open Appraisals")
                {
                    ApplicationArea = All;
                }
                field("Appraisals Under Review"; Rec."Appraisals Under Review")
                {
                    ApplicationArea = All;
                }
                field("Appraisals Further Review"; Rec."Appraisals Further Review")
                {
                    ApplicationArea = All;
                }
                field("Completed Appraisals"; Rec."Completed Appraisals")
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Acting and Promotion")
            {
                field("Acting Duties"; Rec."Acting Duties")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Acting Duties List";
                }
                field("Acting Duties Approved"; Rec."Acting Duties Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Acting Duties List";
                }
                // field(Promotions; Promotions)
                // {
                //     ApplicationArea = All;
                //     DrillDownPageId = "Promotion List";
                // }
                field("Promotions Approved"; Rec."Promotions Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Promotion List Approved";
                }
            }
            cuegroup("Training")
            {
                field("Training Needs"; Rec."Training Needs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Training Needs";
                }
                field("Training Needs Applications"; Rec."Training Needs Applications")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Training Needs Application";
                }
                field("Training Requests"; Rec."Training Requests")
                {
                    ApplicationArea = All;
                }
                field("Approved Training requests"; Rec."Approved Training requests")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
