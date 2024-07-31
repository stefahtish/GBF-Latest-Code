page 51090 "Moisture Analyser test"
{
    Caption = 'Moisture Analyser test';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Moisture content (%w/w)"; Rec."Moisture content (%w/w)")
                {
                    ApplicationArea = All;
                }
                field("Specification (%w/w)"; Rec."Specification (%w/w)")
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
