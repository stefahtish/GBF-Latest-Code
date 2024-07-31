page 50458 "Approved Leaves"
{
    CardPageID = "Emp Leave Application Card Mod";
    PageType = List;
    SourceTable = "Leave Application";
    SourceTableView = WHERE(Status = FILTER(Released));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Leave Code"; Rec."Leave Code")
                {
                }
                field("Days Applied"; Rec."Days Applied")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
