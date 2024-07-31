page 50965 "Testing Target Products"
{
    Caption = 'Testing target products';
    PageType = ListPart;
    SourceTable = "Testing Target Dairy Product";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Target dairy product"; Rec."Target dairy product")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
