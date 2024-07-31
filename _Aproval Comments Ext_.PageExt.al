pageextension 50138 "Aproval Comments Ext" extends "Approval Comments FactBox"
{
    layout
    {
        addafter("Date and Time")
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Designation; Rec.Designation)
            {
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
    }
}
