page 50122 "Posted Approval Factbox"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Posted Approval Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sender ID"; Rec."Sender ID")
                {
                    Caption = 'Sender';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    Caption = 'Approver';
                }
            }
        }
    }
    actions
    {
    }
}
