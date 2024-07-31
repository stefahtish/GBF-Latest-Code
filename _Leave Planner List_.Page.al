page 51424 "Leave Planner List"
{
    Caption = 'Leave Planner List';
    CardPageId = "Leave Planner";
    PageType = List;
    SourceTable = "Leave Planner Header";
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
