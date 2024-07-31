page 50995 "Cont_Approxi Pro Sum"
{
    PageType = ListPart;
    SourceTable = "Cert_Provi Sum";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Delivarable; Rec.Delivarable)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Amount; Rec.Amount)
                {
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
        Schdl.SetRange("Conract No.", Rec."Conract No.");
        Schdl.SetCurrentKey("No.");
        if Schdl.FindLast then
            Rec."No." := (Schdl."No." + 1)
        else
            Rec."No." += 1;
    end;

    var
        Schdl: Record "Cert_Provi Sum";
        Contract: Record Contract;
}
