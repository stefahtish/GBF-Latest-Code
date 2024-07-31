page 50205 "Closed Approvals Delegations"
{
    CardPageID = "Approvals Delegation";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approvals Delegation";
    SourceTableView = WHERE(Status = CONST(Resumed));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delegation No."; Rec."Delegation No.")
                {
                }
                field("Current User"; Rec."Current User")
                {
                }
                field("Delegation Start Date"; Rec."Delegation Start Date")
                {
                }
                field("Delegation End Date"; Rec."Delegation End Date")
                {
                }
                field("Reason for Delegation"; Rec."Reason for Delegation")
                {
                }
                field("Delegated To"; Rec."Delegated To")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}
