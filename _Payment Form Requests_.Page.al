page 50356 "Payment Form Requests"
{
    Caption = 'Request for payment forms';
    CardPageID = "Payment Form Request";
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Request"), Posted = CONST(false));
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
                field(Date; Rec.Date)
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
