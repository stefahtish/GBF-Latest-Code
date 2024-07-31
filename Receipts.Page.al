page 50142 Receipts
{
    CardPageID = Receipt;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = SORTING("No.") WHERE(Posted = CONST(false), "Payment Type" = CONST(Receipt));
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
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                }
                field("Received From"; Rec."Received From")
                {
                }
                field("On behalf of"; Rec."On behalf of")
                {
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                }
                field("Bank Code"; Rec."Paying Bank Account")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posted Date"; Rec."Posted Date")
                {
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }
        }
    }
    actions
    {
    }
}
