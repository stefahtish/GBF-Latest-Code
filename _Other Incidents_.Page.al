page 50407 "Other Incidents"
{
    PageType = ListPart;
    SourceTable = "Students Travelling";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    Visible = false;
                }
                field("Student No"; Rec."Student No")
                {
                }
                field("Student Name"; Rec."Student Name")
                {
                }
                field("Student Programme"; Rec."Student Programme")
                {
                }
                field("Student Programme Name"; Rec."Student Programme Name")
                {
                }
            }
        }
    }
    actions
    {
    }
}
