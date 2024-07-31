page 50297 "Input Tax Types"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = WHERE(Type = FILTER("Input Tax"));
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
                field("Cost of Sale"; Rec."Cost of Sale")
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
        Rec.Type := Rec.Type::"Input Tax";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Input Tax";
    end;
}
