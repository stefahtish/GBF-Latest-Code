page 51421 "Employee Salary Increment"
{
    Caption = 'Employee Salary Increment';
    PageType = ListPart;
    SourceTable = "Employee Salary Increment";
    InsertAllowed = false;
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                    ApplicationArea = All;
                }
                field("Previous Salary Scale"; Rec."Previous Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Previous Salary Scale field';
                    ApplicationArea = All;
                }
                field("Previous Salary Pointer"; Rec."Previous Salary Pointer")
                {
                    ToolTip = 'Specifies the value of the Previous Salary Pointer field';
                    ApplicationArea = All;
                }
                /*
                 field("Previous Salary"; Rec."Previous Salary")
                {
                    ToolTip = 'Specifies the value of the Previous Salary field';
                    ApplicationArea = All;
                }
                 */
                field("Current Salary Scale"; Rec."Current Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Current Salary Scale field';
                    ApplicationArea = All;
                }
                field("Current Salary Pointer"; Rec."Current Salary Pointer")
                {
                    ToolTip = 'Specifies the value of the Current Salary Pointer field';
                    ApplicationArea = All;
                }
                /*
                 field("Current Salary"; Rec."Current Salary")
                {
                    ToolTip = 'Specifies the value of the Current Salary field';
                    ApplicationArea = All;
                } 
                */
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
