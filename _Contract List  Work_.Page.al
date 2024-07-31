page 51002 "Contract List  Work"
{
    CardPageID = Contract_Card;
    PageType = List;
    SourceTable = Contract1;
    SourceTableView = WHERE("Contract Category" = FILTER(Work));
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
                field("Contract Type"; Rec."Contract Type")
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
