table 50490 "Funds Mgt Comment Line"
{
    Caption = 'Funds Mgt Comment Line';
    DrillDownPageID = "Funds Mgt Comment List";
    LookupPageID = "Funds Mgt Comment List";

    fields
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Table Name';
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Load,Discharge';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "None", "Payment Voucher", "Petty Cash", Imprest, Requisition, ImprestSurrender, Interbank, Receipt, "Staff Claim", "Staff Advance", AdvanceSurrender, Load, Discharge;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
        }
        field(6; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(7; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(8; "User Id"; Code[50])
        {
        }
    }
    keys
    {
        key(Key1; "Table Id", "Document Type", "Document No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    procedure SetUpNewLine()
    var
        CommentLine: Record "Funds Mgt Comment Line";
    begin
        CommentLine.SetRange("Table Id", "Table Id");
        CommentLine.SetRange("Document Type", "Document Type");
        CommentLine.SetRange("Document No.", "Document No.");
        CommentLine.SetRange(Date, WorkDate);
        if not CommentLine.FindFirst then Date:=WorkDate;
    end;
}
