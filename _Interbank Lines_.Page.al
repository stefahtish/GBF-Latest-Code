page 50280 "Interbank Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payment Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Bank Account Name';
                }
                field(Description; Rec.Description)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes;
        GetPaymentHeader;
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
        if Payments."Payment Narration" <> '' then Rec.Description := Payments."Payment Narration";
    end;

    var
        Payments: Record Payments;

    local procedure GetPaymentHeader()
    begin
        if Payments.Get(Rec.No) then;
    end;
}
