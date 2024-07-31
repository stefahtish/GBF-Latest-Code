pageextension 50156 "Payment Methods Ext" extends "Payment Methods"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field("Document Path"; Rec."Document Path")
            {
                ApplicationArea = All;
            }
            field(Default; Rec.Default)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default field';
            }
        }
    }
}
