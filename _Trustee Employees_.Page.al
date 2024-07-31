page 50581 "Trustee Employees"
{
    CardPageID = "Trustee Employee Card";
    PageType = List;
    SourceTable = Employee;
    SourceTableView = WHERE("Employment Type" = FILTER(Trustee));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                }
                field("Home District"; Rec."Home District")
                {
                }
                field(County; Rec.County)
                {
                }
                field(Status; Rec.Status)
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
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
    end;
}
