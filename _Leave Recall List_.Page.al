page 50422 "Leave Recall List"
{
    CardPageID = "Leave Recall";
    PageType = List;
    SourceTable = "Employee Off/Holiday";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Recall Date"; Rec."Recall Date")
                {
                }
                field("Recalled By"; Rec."Recalled By")
                {
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                }
                field("Recalled From"; Rec."Recalled From")
                {
                }
            }
        }
    }
    actions
    {
    }
}
