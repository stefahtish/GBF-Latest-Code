page 51446 "HOD Explanation"
{
    Caption = 'HOD Explanation';
    PageType = ListPart;
    SourceTable = "Post Training Evaluation Line2";
    ApplicationArea = All;

    // AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Improvement Explanation"; Rec."Improvement Explanation")
                {
                    ToolTip = 'Specifies the value of the Improvement Explanation field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger onInsertRecord(BelowXrec: Boolean): Boolean;
    var
        myInt: Integer;
    begin
        Rec."Line No." := Rec.GetNextLineNo();
    end;
}
