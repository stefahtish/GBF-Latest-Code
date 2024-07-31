page 51019 "Target Clients"
{
    Caption = 'Target Clients';
    PageType = ListPart;
    SourceTable = "Target Clients";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Client; Rec.Client)
                {
                }
            }
        }
    }
}
