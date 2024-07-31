page 50450 "Other Incidencts"
{
    CardPageID = "Employee Disciplinary Case";
    PageType = List;
    SourceTable = "Employee Discplinary";
    SourceTableView = WHERE(Posted = FILTER(true));
    Caption = 'Closed Disciplinary Cases';
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
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }
    actions
    {
    }
}
