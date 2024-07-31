page 51042 "Lab Management Cues"
{
    PageType = CardPart;
    SourceTable = "Lab Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Lab schedules")
            {
                field("Open lab schedules"; Rec."Open lab schedules")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Lab Annual Testing Schedules";
                }
                field("Submitted Lab Schedules"; Rec."Submitted Lab Schedules")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Lab Annual Testing Schedules";
                }
            }
            cuegroup("Testing Resource Allocations")
            {
                field("Open Testing Resource Alloc"; Rec."Open Testing Resource Alloc")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Testing resource alloc. list";
                }
                field("Testing Allocations Done"; Rec."Testing Allocations Done")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Testing resource alloc. list";
                }
            }
            cuegroup("Sample Reception")
            {
                field("Samples received"; Rec."Samples received")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample reception list";
                }
                field("Samples received sent to lab"; Rec."Samples received sent to lab")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample reception list";
                }
            }
            cuegroup("Sample Tests")
            {
                field("Open Sample Tests"; Rec."Open Sample Tests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample Test List";
                }
                field("Submitted Tests"; Rec."Submitted Tests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample Test List";
                }
            }
            cuegroup("Sample Analysis and Reporting")
            {
                field("Open Sample Analysis"; Rec."Open Sample Analysis")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample analysis list";
                }
                field("Sample Analysis submitted"; Rec."Sample Analysis submitted")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sample analysis list";
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
