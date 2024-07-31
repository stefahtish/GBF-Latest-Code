page 51269 "Risk Management Cues"
{
    PageType = CardPart;
    SourceTable = "Risk Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Risk)
            {
                field("Risk Identification"; Rec."Risk Identification")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Risks List";
                }
                field("Risk Assessment"; Rec."Risk Assessment")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Risk Champion List";
                }
                field("Escalated risks"; Rec."Escalated risks")
                {
                    Caption = 'Risks under board review';
                    ApplicationArea = All;
                    DrillDownPageId = "Risk Champion List";
                }
                field("Closed risks"; Rec."Closed risks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Closed Risks";
                }
            }
            cuegroup("Risk register")
            {
                field("Project risks"; Rec."Project risks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Project Risk Register";
                }
                field("Department risks"; Rec."Department risks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Department Risk Register";
                }
                field("Corporate risks"; Rec."Corporate risks")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Corporate Risk Register";
                }
                field("Closed risks from registers"; Rec."Closed risks from registers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Archived Risk Register";
                }
            }
            cuegroup(Incidences)
            {
                field("Open incidences"; Rec."Open incidences")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Reports";
                }
                field("Pending incidences"; Rec."Pending incidences")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Reports - Pending";
                }
                field("Incidences under review"; Rec."Incidences under review")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Reports - Solved";
                }
                field("Escalated incidences"; Rec."Escalated incidences")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Reports-Escalated";
                }
                field("Solved incidences"; Rec."Solved incidences")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Reports- Closed";
                }
            }
            cuegroup("Risk Survey")
            {
                field("Risk surveys"; Rec."Risk surveys")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Risk Surveys";
                }
                field("Reported risk surveys"; Rec."Reported risk surveys")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Reported Risk Surveys";
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
