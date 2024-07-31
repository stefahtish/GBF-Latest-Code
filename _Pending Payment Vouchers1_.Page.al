page 50187 "Pending Payment Vouchers1"
{
    Caption = 'Pending Approval PVs';
    CardPageID = "Pending PV Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    UsageCategory = Lists;
    // SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"),
    //                         Status = CONST("Pending Approval"),
    //                         Posted = CONST(false),
    //                         Requisition = const(false));
    SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"), Status = CONST("Pending Approval"), Posted = CONST(false));
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
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}
