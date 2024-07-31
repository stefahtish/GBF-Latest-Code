page 51265 "Board Attendance Register"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Board Attendance Register";
    PromotedActionCategories = 'New,Process,Report,Post';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::"open";

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control11; "Board Attendance Reg Lines")
            {
                Editable = Rec."Status" = Rec."Status"::"open";
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to send these sitting allowance amounts to the Payroll?';
                    Text002: Label 'The sitting allowance Amounts have been successfully sent to the Payroll.';
                begin
                    if Confirm(Text001, false) = true then begin
                        PayrollManagement.SendAllowancesToPayroll(Rec."No.");
                        Message(Text002);
                    end;
                end;
            }
        }
    }
    var PayrollManagement: Codeunit Payroll;
}
