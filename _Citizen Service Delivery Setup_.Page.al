page 51232 "Citizen Service Delivery Setup"
{
    Caption = 'Citizen Service Delivery Setup';
    PageType = List;
    SourceTable = "Citizen Service Delivery Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                }
            }
        }
    }
}
