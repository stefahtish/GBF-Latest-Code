page 50652 "Payroll Request Lines"
{
    PageType = ListPart;
    SourceTable = "Payroll Request Lines";
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
                }
                field("Previous Value"; Rec."Previous Value")
                {
                }
                field("New Value"; Rec."New Value")
                {
                }
                field(Change; Rec.Change)
                {
                }
            }
        }
    }
    actions
    {
    }
}
