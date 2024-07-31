page 51110 "Research Management Cue"
{
    PageType = CardPart;
    SourceTable = "Research Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Export Promotions")
            {
                field("Open Export Promotions"; Rec."Open Export Promotions")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Promotion Activity Plans";
                }
                field("Submitted Export Promotions"; Rec."Submitted Export Promotions")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Promotion Activity Plans";
                }
            }
            cuegroup("Stakeholder Support")
            {
                field("Open Stakeholder Support"; Rec."Open Stakeholder Support")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Stake. Support Activity Plans";
                }
                field("Submitted Stakeholder Support"; Rec."Submitted Stakeholder Support")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Stake. Support Activity Plans";
                }
            }
            cuegroup("Dairy Standards")
            {
                field("Open Dairy Standards"; Rec."Open Dairy Standards")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Dairy stds Activity Plans";
                }
                field("Submitted Dairy Standards"; Rec."Submitted Dairy Standards")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Dairy stds Activity Plans";
                }
            }
            cuegroup("Partnerships")
            {
                field("Open Partnership Activity Plans"; Rec."Open Partnership Activity Plan")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Partnership support list";
                }
                field("Patrnership Activity Plans"; Rec."Partnership Activity Plans")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Partnership support list";
                }
            }
            cuegroup("Research and Surveys Activity Plans")
            {
                field("Open Research Survey workplans"; Rec."Open Research Survey workplans")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Partnership support list";
                }
                field("Research and Survey Workplans"; Rec."Research and Survey Workplans")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Partnership support list";
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
