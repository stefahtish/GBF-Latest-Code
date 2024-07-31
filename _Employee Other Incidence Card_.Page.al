page 50448 "Employee Other Incidence Card"
{
    PageType = Card;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
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
                field(Gender; Rec.Gender)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                }
            }
            label("Other Incident")
            {
            }
            part(Control12; "Other Incidences")
            {
                SubPageLink = "Request No" = FIELD("No.");
            }
        }
    }
    actions
    {
    }
}
