page 51088 "Peroxide conventional test"
{
    AutoSplitKey = true;
    Caption = 'Determination of peroxide addition';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Results potassium iodide"; Rec."Results potassium iodide")
                {
                    ApplicationArea = All;
                }
                field("Interpretation(Preserved)"; Rec."Interpretation(Preserved)")
                {
                    ApplicationArea = All;
                }
                field("Specifications"; Rec."Specifications")
                {
                    Caption = 'Specification(Should not be absent)';
                    ApplicationArea = All;
                }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
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
