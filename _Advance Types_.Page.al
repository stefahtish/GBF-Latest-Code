page 50111 "Advance Types"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = WHERE(Type = FILTER(Advance));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Based On Travel Rates Table"; Rec."Based On Travel Rates Table")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                }
                field("VAT Code"; Rec."VAT Code")
                {
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Advance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Advance;
    end;
}
