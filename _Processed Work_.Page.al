page 51008 "Processed Work"
{
    CardPageID = "Processed Work Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Contract_WorkP;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("IPC No."; Rec."IPC No.")
                {
                }
            }
        }
    }
    actions
    {
    }
}
