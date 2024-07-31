page 51445 "Employee Recommendations"
{
    Caption = 'Employee Recommendations';
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
                field(Recommendations; Rec.Recommendations)
                {
                    ToolTip = 'Specifies the value of the Recommendations field.';
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
