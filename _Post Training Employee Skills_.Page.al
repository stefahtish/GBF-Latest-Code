page 51443 "Post Training Employee Skills"
{
    Caption = 'Employee Skills';
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
                field(Skills; Rec.Skills)
                {
                    ToolTip = 'Specifies the value of the Skills field.';
                    ApplicationArea = All;
                }
                field(Ratings; Rec.Ratings)
                {
                    ToolTip = 'Specifies the value of the Ratings field.';
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
