page 51447 "Affected Work"
{
    Caption = 'Affected Work';
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
                field("Employee Affected Skills"; Rec."Employee Affected Skills")
                {
                    ToolTip = 'Specifies the value of the Employee Affected Skills field.';
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
