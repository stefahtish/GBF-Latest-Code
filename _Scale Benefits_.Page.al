page 50633 "Scale Benefits"
{
    PageType = Card;
    SourceTable = "Scale Benefits";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                    Editable = false;
                }
                field("Salary Pointer"; Rec."Salary Pointer")
                {
                    Editable = false;
                }
                field("ED Code"; Rec."ED Code")
                {
                    Caption = 'Earning Code';
                }
                field("ED Description"; Rec."ED Description")
                {
                    Caption = 'Earning Description';
                    Editable = false;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Payment Option"; Rec."Payment Option")
                {
                    Visible = false;
                }
                field(Rate; Rec.Rate)
                {
                    Visible = false;
                }
                field("Based on branches"; Rec."Based on branches")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Branch")
            {
                Visible = Rec."Based on branches";
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = false;
                RunObject = Page "House Allowance Setup";
                RunPageLink = "Job group" = FIELD("Salary Scale"), Pointer = FIELD("Salary Pointer"), Code = field("ED Code");
            }
        }
    }
}
