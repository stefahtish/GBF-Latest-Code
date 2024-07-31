page 50999 Contract_Work_List
{
    CardPageID = Contract_Work;
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
                field("Total Due inc(VAT)"; Rec."Total Due inc(VAT)")
                {
                }
            }
        }
    }
    actions
    {
    }
}
