page 50795 "EFT File Generations"
{
    ApplicationArea = All;
    Caption = 'Payment File Generations';
    PageType = List;
    SourceTable = Payments;
    UsageCategory = Lists;
    InsertAllowed = false;
    // Editable = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;
    CardPageId = "EFT File Generation";
    SourceTableView = where("Payment Type"=const("EFT File Gen"), "EFT File Generated"=const(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = NoRejectionComment;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = NoRejectionComment;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("EFT File Generated"; Rec."EFT File Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT File Generated field';
                }
                field("EFT Reference"; Rec."EFT Reference")
                {
                    caption = 'Reference';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Reference field';
                }
                field("EFT Date"; Rec."EFT Date")
                {
                    caption = 'Date';
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
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        NoRejectionComment:=Rec.CheckRejectionComment(Rec."Payment Type"::"Staff Claim", Rec."No.");
    end;
    var NoRejectionComment: Boolean;
}
