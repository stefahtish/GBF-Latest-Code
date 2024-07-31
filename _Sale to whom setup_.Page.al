page 51147 "Sale to whom setup"
{
    Caption = 'Sale to whom setup';
    PageType = List;
    SourceTable = "Sale to whom Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
