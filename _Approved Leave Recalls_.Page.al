page 50406 "Approved Leave Recalls"
{
    PageType = List;
    SourceTable = "Employee Off/Holiday";
    SourceTableView = WHERE(Status = CONST(Released));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Recalled From"; Rec."Recalled From")
                {
                }
                field("Recalled To"; Rec."Recalled To")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}
