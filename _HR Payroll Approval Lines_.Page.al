page 50701 "HR Payroll Approval Lines"
{
    Caption = 'Payroll Approval Lines';
    PageType = ListPart;
    SourceTable = "Payroll Approval Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payee No"; Rec."Payee No")
                {
                    Caption = 'Employee No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee No field';
                }
                field("Payee Name"; Rec."Payee Name")
                {
                    Caption = 'Employee Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee Name field';
                }
                // field("Previous Earning"; Rec."Previous Earning")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Previous Earning field';
                // }
                // field("Increament Amount"; Rec."Increament Amount")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Increament Amount field';
                // }
                field("Total Earning"; Rec."Total Earning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Earning field';
                }
                // field("Total Arrears"; Rec."Total Arrears")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Total Arrears field';
                // }
                field("Total Deduction"; Rec."Total Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Deduction field';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Amount field';
                }
            }
        }
    }
}
