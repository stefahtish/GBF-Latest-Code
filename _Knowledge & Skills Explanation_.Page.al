page 51444 "Knowledge & Skills Explanation"
{
    Caption = 'Knowledge & Skills Explanation';
    PageType = ListPart;
    SourceTable = "Post Training Evaluation Lines";
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
                    // MultiLine = true;
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
