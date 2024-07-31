page 50361 "Supplier Type"
{
    Caption = 'Supplier Type';
    PageType = List;
    SourceTable = "Supplier Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
