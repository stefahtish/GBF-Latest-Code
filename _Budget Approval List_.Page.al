page 50270 "Budget Approval List"
{
    CardPageID = "Budget Approval Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Budget Approval Header";
    SourceTableView = WHERE(Status = FILTER(<> Approved));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Approvals; Rec.Approvals)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; Links)
            {
            }
        }
    }
    actions
    {
    }
}
