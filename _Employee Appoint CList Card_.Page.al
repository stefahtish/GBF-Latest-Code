page 50393 "Employee Appoint CList Card"
{
    PageType = Card;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'National ID';
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field(Address; Rec.Address)
                {
                }
            }
            part(Control11; "Appointment Checklist ListPart")
            {
            }
        }
    }
    actions
    {
    }
}
