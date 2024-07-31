page 50690 "Imprest Deduction Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Post';
    SourceTable = "Imprest Deduction";
    ApplicationArea = All;

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
            part(Control11; "Imprest Deduction Line")
            {
                Editable = Rec."Status" = Rec."Status"::"open";
                SubPageLink = "Document No." = FIELD("No.");
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
                    Text001: Label 'Are you sure you want to send these Imprest Amounts to the Payroll?';
                    Text002: Label 'The Imprest Amounts have been successfully sent to the Payroll.';
                begin
                    if Confirm(Text001, false) = true then begin
                        PayrollManagement.SendImprestToPayroll(Rec."No.");
                        Message(Text002);
                    end;
                end;
            }
            action("Generate Lines")
            {
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Open";

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to generate lines?';
                    Text002: Label 'Lines have been generated successfully.';
                    Text003: Label 'There is nothing to generate.';
                begin
                    if Confirm(Text001, false) = true then begin
                        if Rec.GenerateOverdueImprest then
                            Message(Text002)
                        else
                            Message(Text003);
                    end;
                end;
            }
        }
    }
    var
        PayrollManagement: Codeunit Payroll;
}
