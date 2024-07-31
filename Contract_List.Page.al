page 50998 Contract_List
{
    CardPageID = Contract_Card;
    PageType = List;
    SourceTable = Contract1;
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
                field("Contract Name"; Rec."Contract Name")
                {
                }
                field("Contract Category"; Rec."Contract Category")
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
