pageextension 50142 GenBatchExt extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field("Payroll period"; Rec."Payroll period")
            {
                ApplicationArea = all;
            }
            field("Payroll start date"; Rec."Payroll start date")
            {
                ApplicationArea = all;
            }
        }
    }
    var myInt: Integer;
}
