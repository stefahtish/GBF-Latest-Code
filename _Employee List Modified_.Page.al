page 50679 "Employee List Modified"
{
    Caption = 'Employee List';
    CardPageID = "Employee Card Custom";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("PIN Number"; Rec."PIN Number")
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                }
                field("NHIF No"; Rec."NHIF No")
                {
                }
                field(Disabled; Rec.Disabled)
                {
                }
                field("Employment Type"; Rec."Employment Type")
                {
                }
                field("Employment Status"; Rec."Employment Status")
                {
                    ToolTip = 'Specifies the value of the Employment Status field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                }
                field("Home District"; Rec."Home District")
                {
                }
                field(County; Rec.County)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = BasicHR;
                Visible = true;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
            }
        }
    }
    var
        Payroll: Codeunit Payroll;
        MailPayslip: Report "Mail Bulk Payslips";
        UserSetup: Record "User Setup";

    procedure ChangeCompany(CompTo: Text[250])
    var
        Employee: Record Employee;
    begin
        Rec.ChangeCompany(CompTo);
    end;
}
