page 50390 "Employment History List"
{
    CardPageID = "Scale Benefits";
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
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
            }
        }
    }
    actions
    {
    }
}
