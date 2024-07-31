page 50694 "Loan Interest Lines-Payroll"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Loan Interest Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Period Reference"; Rec."Period Reference")
                {
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                }
                field("Interest Due"; Rec."Interest Due")
                {
                }
            }
        }
    }
    actions
    {
    }
}
