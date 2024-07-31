page 51005 Contract2_List
{
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
            }
        }
    }
    actions
    {
    }
}
