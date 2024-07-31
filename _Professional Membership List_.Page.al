page 50394 "Professional Membership List"
{
    CardPageID = "Professional Membership Card";
    PageType = List;
    SourceTable = Employee;
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
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
            }
        }
    }
    actions
    {
    }
}
