page 51264 "Board Attendance Reg Lines"
{
    PageType = ListPart;
    SourceTable = "Board Attendance Reg. Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("No of sittings"; Rec."No of sittings")
                {
                }
                field("Sitting allowance"; Rec."Sitting allowance")
                {
                    Caption = 'Allowance per sitting';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
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
