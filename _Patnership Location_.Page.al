page 51337 "Patnership Location"
{
    Caption = 'Implementing Counties';
    PageType = ListPart;
    SourceTable = "Patnership Location2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Country Code"; Rec."Country Code")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'County Name';
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }
}
