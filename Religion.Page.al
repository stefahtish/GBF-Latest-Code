page 51433 Religion
{
    Caption = 'Religion';
    PageType = List;
    SourceTable = Religion;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
