page 50392 "Employee Appointment Check"
{
    CardPageID = "Employee Appoint CList Card";
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
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
            }
        }
    }
    actions
    {
    }
}
