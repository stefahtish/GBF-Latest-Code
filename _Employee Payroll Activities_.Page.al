page 50489 "Employee Payroll Activities"
{
    PageType = CardPart;
    SourceTable = "Employee Payroll Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Employees)
            {
                Caption = 'Employees';

                field("All Employees"; Rec."All Employees")
                {
                    DrillDownPageID = "Employee List";
                }
                field("Active Employees"; Rec."Active Employees")
                {
                    DrillDownPageID = "Employee List";
                }
                field("Board Employees"; Rec."Board Employees")
                {
                    DrillDownPageId = "Employee List";
                }
            }
        }
    }
    actions
    {
    }
}
