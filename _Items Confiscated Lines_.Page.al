page 51017 "Items Confiscated Lines"
{
    Caption = 'Items Confiscated';
    PageType = ListPart;
    SourceTable = "Items confiscated Line2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field("Reason for seizure"; Rec."Reason for seizure")
                {
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
