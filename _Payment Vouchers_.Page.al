page 50147 "Payment Vouchers"
{
    CardPageID = "Payment Voucher";
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"), Status = FILTER(Open), Posted = CONST(false));
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
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Notes)
            {
            }
            systempart(Control17; MyNotes)
            {
            }
            systempart(Control18; Links)
            {
            }
        }
    }
    actions
    {
    }
    // trigger OnOpenPage()
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         if not UserSetup."Show All" then begin
    //             FilterGroup(2);
    //             SetRange("Created By", UserId);
    //         end;
    //     end else
    //         Error('%1 does not exist in the Users Setup', UserId);
    // end;
    var
        UserSetup: Record "User Setup";
}
