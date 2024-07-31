pageextension 50148 "Unit Of Measure PageExt" extends "Units of Measure"
{
    layout
    {
        addlast(Control1)
        {
            field(Products; Rec.Products)
            {
                ApplicationArea = All;
            }
        }
    }
}
