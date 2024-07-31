page 51004 Contract_Worklist
{
    CardPageID = "Work Contract2";
    PageType = List;
    SourceTable = Contract_Work;
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
                field("Previous Gross work done Date"; Rec."Previous Gross work done Date")
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
