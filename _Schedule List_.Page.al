page 50991 "Schedule List"
{
    PageType = ListPart;
    SourceTable = "Payment Schedule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Schedule No."; Rec."Schedule No.")
                {
                }
                field(Activity; Rec.Activity)
                {
                }
                field(Delivarable; Rec.Delivarable)
                {
                }
                field("Payment %"; Rec."Payment %")
                {
                    trigger OnValidate()
                    begin
                        Schdl.Reset;
                        Schdl.SetRange("Contract No.", Rec."Contract No.");
                        if Schdl.FindFirst then Contract.Reset;
                        Contract.SetRange("Contract No.", Rec."Contract No.");
                        if Contract.FindFirst then Rec.Amount := Rec."Payment %" * 0.01 * Contract."Contract Value";
                        Rec.Modify;
                    end;
                }
                field("Payment Sum %"; Rec."Payment Sum %")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Paid; Rec.Paid)
                {
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Schdl.Reset;
        Schdl.SetRange("Contract No.", Rec."Contract No.");
        Schdl.SetCurrentKey("Schedule No.");
        if Schdl.FindLast then
            Rec."Schedule No." := (Schdl."Schedule No." + 1)
        else
            Rec."Schedule No." += 1;
    end;

    var
        Schdl: Record "Payment Schedule";
        Contract: Record Contract1;
}
