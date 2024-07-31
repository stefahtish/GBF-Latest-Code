page 51038 "License notes"
{
    Caption = 'License notes';
    PageType = ListPart;
    SourceTable = "License Notes Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the value of the Note field';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
