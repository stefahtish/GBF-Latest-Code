page 51178 "Audit Area Subsections"
{
    Caption = 'Subsections';
    PageType = List;
    SourceTable = "Audit Areas Subsections";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Subsection; Rec.Subsection)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
