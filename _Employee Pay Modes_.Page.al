page 50671 "Employee Pay Modes"
{
    PageType = List;
    SourceTable = "Employee Pay Modes";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("Total Earnings"; Rec."Total Earnings")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Pay Period Filter"; Rec."Pay Period Filter")
                {
                }
                field("Pay Mode Filter"; Rec."Pay Mode Filter")
                {
                }
                field("Net Pay A/C"; Rec."Net Pay A/C")
                {
                }
            }
        }
    }
    actions
    {
    }
}
