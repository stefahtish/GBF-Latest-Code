page 50734 "Payroll EFT File Generations"
{
    ApplicationArea = All;
    Caption = 'Payment File Generations';
    PageType = List;
    SourceTable = Payments;
    UsageCategory = Lists;
    InsertAllowed = false;
    CardPageId = "Payroll EFT File Generation";
    SourceTableView = where("Payment Type"=const("Payroll EFT File Gen"), Posted=const(false));

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
