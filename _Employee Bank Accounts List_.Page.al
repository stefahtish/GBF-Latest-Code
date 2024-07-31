page 50565 "Employee Bank Accounts List"
{
    Caption = 'Employee Bank/FOSA Accounts List';
    PageType = ListPart;
    SourceTable = "Employee Bank Accounts";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Enabled = false;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    Enabled = false;
                }
                field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
                {
                    Enabled = false;
                }
                field("Account number"; Rec."Account number")
                {
                    ApplicationArea = All;
                }
                field("Percentage to transfer"; Rec."Percentage to transfer")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
