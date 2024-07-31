page 50502 "Qualified Interviewee Listpart"
{
    PageType = ListPart;
    SourceTable = Applicants2;
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
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    Caption = 'Phone Number';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Selected; Rec.Selected)
                {
                    Caption = 'Employ';
                }
            }
        }
    }
    actions
    {
    }
}
