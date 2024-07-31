page 50449 "Other Incidences"
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
