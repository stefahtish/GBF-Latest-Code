page 51069 "Density Report"
{
    AutoSplitKey = true;
    Caption = 'Density Report';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Results in g/ml"; Rec."Results in g/ml")
                {
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
