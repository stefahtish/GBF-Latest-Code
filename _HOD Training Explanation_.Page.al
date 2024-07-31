page 51448 "HOD Training Explanation"
{
    Caption = 'HOD Training Explanation';
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
                field("Training Recommendation"; Rec."Training Recommendation")
                {
                    ToolTip = 'Specifies the value of the Training Recommendation field.';
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
