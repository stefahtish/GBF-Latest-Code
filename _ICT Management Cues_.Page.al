page 51279 "ICT Management Cues"
{
    Caption = 'ICT Management Cues';
    PageType = CardPart;
    SourceTable = "Risk Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
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
