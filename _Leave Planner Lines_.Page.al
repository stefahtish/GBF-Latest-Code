page 51426 "Leave Planner Lines"
{
    Caption = 'Leave Planner Lines';
    PageType = ListPart;
    SourceTable = "Leave Planner Lines";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    Enabled = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                }
            }
        }
    }
}
