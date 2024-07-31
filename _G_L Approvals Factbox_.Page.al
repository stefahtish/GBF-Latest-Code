page 50121 "G/L Approvals Factbox"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Approval Entry";
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
    procedure SetFilterFromApprovalEntry(ApprovalEntry: Record "Approval Entry"): Boolean
    begin
        Rec.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        Rec.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
        CurrPage.Update(false);
        exit(not Rec.IsEmpty);
    end;
}
