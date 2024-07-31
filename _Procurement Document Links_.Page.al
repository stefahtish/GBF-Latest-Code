page 51420 "Procurement Document Links"
{
    Caption = 'Procurement Document Links';
    PageType = ListPart;
    SourceTable = "Procurement Document Links";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Link; Rec.Link)
                {
                    ToolTip = 'Specifies the value of the Link field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
