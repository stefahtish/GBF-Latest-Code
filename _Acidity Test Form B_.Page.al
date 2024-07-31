page 51105 "Acidity Test Form B"
{
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
                field("Titer (ml)"; Rec."Titer (ml)")
                {
                    Caption = 'pH';
                    ApplicationArea = All;
                }
                field("Specification (%)"; Rec."Specification (%)")
                {
                    Caption = 'Temp(°C)';
                }
                field(Specifications; Rec.Specifications)
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
