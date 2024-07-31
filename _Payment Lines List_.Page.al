page 51245 "Payment Lines List"
{
    ApplicationArea = basic, suite;
    PageType = ListPart;
    SourceTable = "Payment Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = basic, suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = basic, suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = basic, suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = basic, suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = basic, suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = basic, suite;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = basic, suite;
                }
                field("NetAmount LCY"; Rec."NetAmount LCY")
                {
                    ApplicationArea = basic, suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = basic, suite;
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = basic, suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = basic, suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = basic, suite;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = basic, suite;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = basic, suite;
                }
            }
        }
    }
    actions
    {
    }
}
