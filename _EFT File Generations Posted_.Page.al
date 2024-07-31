page 50798 "EFT File Generations Posted"
{
    ApplicationArea = All;
    Caption = 'Payment File Generations Posted';
    PageType = List;
    SourceTable = Payments;
    UsageCategory = History;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    CardPageId = "EFT File Generation";
    SourceTableView = where("Payment Type"=const("EFT File Gen"), "EFT File Generated"=const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("EFT File Generated"; Rec."EFT File Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT File Generated field';
                }
                field("EFT Reference"; Rec."EFT Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Reference field';
                }
                field("EFT Date"; Rec."EFT Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Date field';
                }
                field("Total Amount"; Rec."Total EFT Amount")
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
            }
        }
    }
}
