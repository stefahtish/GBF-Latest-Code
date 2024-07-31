page 50395 "Professional Membership Card"
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
            }
            part(Control8; "Professional Membership")
            {
            }
        }
    }
    actions
    {
    }
}
