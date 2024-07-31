pageextension 50111 DimensionValuePageExt extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field(HQ; Rec.HQ)
            {
                ApplicationArea = All;
            }
            field(Lab; Rec.Lab)
            {
                ApplicationArea = All;
            }
            field(Email; Rec.Email)
            {
                ApplicationArea = All;
            }
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
