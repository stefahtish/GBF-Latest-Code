page 51064 "Milk Preservation Test"
{
    AutoSplitKey = true;
    Caption = 'Milk Preservation Test';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sample Name"; Rec."Sample Name")
                {
                    ApplicationArea = All;
                }
                field("Results Rapid test (mg/L)"; Rec."Results Rapid test (mg/L)")
                {
                    ApplicationArea = All;
                }
                field("Specifications"; Rec."Specifications")
                {
                    ApplicationArea = All;
                }
                field("Interpretation(Preserved)"; Rec."Interpretation(Preserved)")
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
