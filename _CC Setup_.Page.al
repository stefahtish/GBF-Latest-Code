page 51333 "CC Setup"
{
    Caption = 'CC Setup';
    PageType = List;
    SourceTable = "Vehicle CC Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    ApplicationArea = All;
                }
                field("Rate per Kilometer"; Rec."Rate per Kilometer")
                {
                    ToolTip = 'Specifies the value of the Rate per Kilometer field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
