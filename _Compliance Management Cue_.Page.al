page 51041 "Compliance Management Cue"
{
    PageType = CardPart;
    SourceTable = "Compliance Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Enforcements)
            {
                field("Open enforcements"; Rec."Open enforcements")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Enforcement List";
                }
                field("Submitted enforcements"; Rec."Submitted enforcements")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Enforcement List";
                }
                field("Overdue Compliances"; Rec."Overdue Compliances")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Non-compliances";
                }
            }
            cuegroup("Various Means of Handling")
            {
                field("Means of Handling"; Rec."Means of Handling")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Means of Handling Setup";
                }
            }
            cuegroup("Regulatory permits")
            {
                field(Permits; Rec.Permits)
                {
                    ApplicationArea = All;
                    DrillDownPageId = Permits;
                }
            }
            cuegroup(Applications)
            {
                field("Permit Applications"; Rec."Permit Applications")
                {
                    Caption = 'Applicant registrations';
                    ApplicationArea = All;
                    DrillDownPageId = "Applicant Registrations";
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
