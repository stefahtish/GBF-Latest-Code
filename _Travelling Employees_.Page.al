page 50456 "Travelling Employees"
{
    PageType = ListPart;
    SourceTable = "Travelling Employee";
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
                    Enabled = false;
                }
                field("Shortcut Dimension 1"; Rec."Shortcut Dimension 1")
                {
                    Enabled = false;
                }
                field("Shortcut Dimension 2"; Rec."Shortcut Dimension 2")
                {
                    Enabled = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Enabled = false;
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Enabled = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field("Request No."; Rec."Request No.")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
