page 50418 "Employee Leave Balances"
{
    CardPageID = "Employee Leaves";
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
            }
        }
    }
    actions
    {
    }
}
