pageextension 50127 EmployeeListPageExt extends "Employee List"
{
    layout
    {
        modify("Job Title")
        {
            Visible = false;
        }
        addafter("Job Title")
        {
            field("Job Title2"; Rec."Job Title2")
            {
                ApplicationArea = All;
            }
        }
        addafter(Comment)
        {
            field(Gender; Rec.Gender)
            {
                ApplicationArea = All;
            }
            field("PIN Number"; Rec."PIN Number")
            {
                ApplicationArea = All;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
            }
            field("Social Security No."; Rec."Social Security No.")
            {
                ApplicationArea = All;
            }
            field("NHIF No"; Rec."NHIF No")
            {
                ApplicationArea = All;
            }
            field(Disabled; Rec.Disabled)
            {
                ApplicationArea = All;
            }
            field("Employment Type"; Rec."Employment Type")
            {
                ApplicationArea = All;
            }
            field("Employment Status"; Rec."Employment Status")
            {
                ToolTip = 'Specifies the value of the Employment Status field.';
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ToolTip = 'Specifies the employment status of the employee.';
                ApplicationArea = All;
            }
            field("Bank Account Number"; Rec."Bank Account Number")
            {
                ApplicationArea = All;
            }
        }
    }
}
