page 51012 "Reversed Work contarct"
{
    CardPageID = "Processed WorkRvd Card";
    PageType = List;
    SourceTable = Contract_WorkRv;
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
