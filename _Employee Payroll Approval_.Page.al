page 50700 "Employee Payroll Approval"
{
    ApplicationArea = All;
    Caption = 'Payroll Approval';
    PageType = List;
    SourceTable = "Payroll Approval";
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where("Payroll Type"=const(Employee));
    CardPageId = "Employee Payroll Approval Card";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field("Total Earning"; Rec."Total Earning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Earning field';
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Arrears field';
                }
                field("Total Deduction"; Rec."Total Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Deduction field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                // field("Created By"; Rec."Created By")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Created By field';
                // }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                // field("Last Modified By"; Rec."Last Modified By")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Last Modified By field';
                // }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified Date field';
                }
            }
        }
    }
}
