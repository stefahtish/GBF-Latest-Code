page 51000 "Contract All List"
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
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}
