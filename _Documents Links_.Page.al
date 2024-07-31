page 51182 "Documents Links"
{
    Caption = 'Document Links';
    PageType = List;
    SourceTable = "Interbank Document Links";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field("Document Name"; Rec."Document Name")
                {
                    ToolTip = 'Specifies the value of the Document Name field.';
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ToolTip = 'Specifies the value of the URL field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
