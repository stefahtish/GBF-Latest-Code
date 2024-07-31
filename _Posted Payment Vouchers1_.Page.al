page 50150 "Posted Payment Vouchers1"
{
    CardPageID = "Approved/Posted PV Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"), Status = CONST(Released), Posted = CONST(true));
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
                field(Payee; Rec.Payee)
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posted Date"; Rec."Posted Date")
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
        area(processing)
        {
            action(Navigate)
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
        }
    }
}
