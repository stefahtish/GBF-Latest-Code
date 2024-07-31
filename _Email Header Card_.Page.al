page 50661 "Email Header Card"
{
    PageType = Card;
    SourceTable = "Email Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field("Total Items"; Rec."Total Items")
                {
                }
                field("Total Sent"; Rec."Total Sent")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(Control11; "Email Logging Lines")
            {
                SubPageLink = No = FIELD(No);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Mail Schedule")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Complete;
                    Payroll.MailRepaymentSchedule(Rec);
                end;
            }
        }
    }
    var
        Payroll: Codeunit Payroll;
}
