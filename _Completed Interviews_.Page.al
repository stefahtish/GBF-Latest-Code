page 51508 "Completed Interviews"
{
    CardPageID = "Interview Card";
    PageType = List;
    SourceTable = "Applicant job applied";
    SourceTableView = WHERE(Interviewed = FILTER(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Need Code"; Rec."Need Code")
                {
                    ToolTip = 'Specifies the value of the Need Code field';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ToolTip = 'Specifies the value of the Qualified field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
