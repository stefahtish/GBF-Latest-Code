page 50469 "Applicants ShortList Listpart"
{
    PageType = ListPart;
    SourceTable = "Applicants Shortlist";
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
                field("Applicant Type"; Rec."Applicant Type")
                {
                }
                field("Application No."; Rec."Application No.")
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
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Total Score"; Rec."Total Score")
                {
                }
            }
        }
    }
    actions
    {
    }
}
