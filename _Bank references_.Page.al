page 50716 "Bank references"
{
    Caption = 'Bank references';
    PageType = ListPart;
    SourceTable = "Payroll Approval Bank Ref";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Bank; Rec.Bank)
                {
                    ToolTip = 'Specifies the value of the Bank field';
                    ApplicationArea = All;
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field';
                    ApplicationArea = All;
                }
                field("Pay Directly"; Rec."Pay Directly")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
