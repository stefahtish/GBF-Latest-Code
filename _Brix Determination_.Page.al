page 51070 "Brix Determination"
{
    AutoSplitKey = true;
    Caption = 'Brix Determination';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Brix content (g/ml)"; Rec."Brix content (g/ml)")
                {
                    Caption = 'Sucrose content (g/ml)';
                    ApplicationArea = All;
                }
                field("Specifications g/ml"; Rec."Specifications g/ml")
                {
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
