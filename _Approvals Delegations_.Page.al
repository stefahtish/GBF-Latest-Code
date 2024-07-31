page 50202 "Approvals Delegations"
{
    CardPageID = "Approvals Delegation";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approvals Delegation";
    SourceTableView = WHERE(Status = CONST(Open));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delegation No."; Rec."Delegation No.")
                {
                    Editable = false;
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
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("Current User", UserId);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Current User", UserId);
    end;
}
