page 51474 "Escalated Employee Case"
{
    Caption = 'Escalated Employee Disciplinary Case';
    CardPageID = "Employee Disciplinary Case";
    PageType = List;
    SourceTable = "Employee Discplinary";
    SourceTableView = where(Posted = const(False), Escalate = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Disciplinary Nos"; Rec."Disciplinary Nos")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Date of Join"; Rec."Date of Join")
                {
                }
            }
        }
    }
    actions
    {
    }
}
