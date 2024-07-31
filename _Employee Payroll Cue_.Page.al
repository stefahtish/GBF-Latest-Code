page 50670 "Employee Payroll Cue"
{
    PageType = CardPart;
    SourceTable = "Employee Payroll Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Employee Statistics")
            {
                field("All Employees"; Rec."All Employees")
                {
                    DrillDownPageId = "Employee List";
                }
                field("Active Employees"; Rec."Active Employees")
                {
                    DrillDownPageId = "Employee List-Filtered";
                }
                field("Board Employees"; Rec."Board Employees")
                {
                    DrillDownPageId = "Board of Directors";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
