page 50669 "Employee HR Posting Group"
{
    PageType = List;
    SourceTable = "Employee Posting GroupX";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Salary Account"; Rec."Salary Account")
                {
                }
                field("PAYE Account"; Rec."PAYE Account")
                {
                }
                field("Income Tax Account"; Rec."Income Tax Account")
                {
                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {
                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {
                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                }
                field("Operating Overtime"; Rec."Operating Overtime")
                {
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {
                }
                field("Pay Period Filter"; Rec."Pay Period Filter")
                {
                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                }
                field("Earnings and deductions"; Rec."Earnings and deductions")
                {
                }
                field("Daily Salary"; Rec."Daily Salary")
                {
                }
                field("Normal Overtime"; Rec."Normal Overtime")
                {
                }
                field("Weekend Overtime"; Rec."Weekend Overtime")
                {
                }
                field("Enterprise Filter"; Rec."Enterprise Filter")
                {
                }
                field("Activity Filter"; Rec."Activity Filter")
                {
                }
                field("Date Filter"; Rec."Date Filter")
                {
                }
                field(Seasonals; Rec.Seasonals)
                {
                }
                field(Pension; Rec.Pension)
                {
                }
            }
        }
    }
    actions
    {
    }
}
