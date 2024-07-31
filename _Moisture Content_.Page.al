page 51073 "Moisture Content"
{
    AutoSplitKey = true;
    Caption = 'Moisture Content';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(W1; Rec.W1)
                {
                    ApplicationArea = All;
                }
                field(W2; Rec.W2)
                {
                    ApplicationArea = All;
                }
                field(W3; Rec.W3)
                {
                    Caption = 'W3 (W2+W1)';
                    ApplicationArea = All;
                }
                field(W4; Rec.W4)
                {
                    ApplicationArea = All;
                }
                field("Moisture Content((W3-W4)/W2"; Rec."Moisture Content((W3-W4)/W2")
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
