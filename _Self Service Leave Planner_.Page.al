page 51429 "Self Service Leave Planner"
{
    Caption = 'Leave Planner List';
    CardPageId = "Leave Planner";
    PageType = List;
    SourceTable = "Leave Planner Header";
    SourceTableView = where(Submitted = const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Submitted; Rec.Submitted)
                {
                    enabled = false;
                }
            }
        }
    }
}
