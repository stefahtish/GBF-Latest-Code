page 50685 "Trustee Payment Reversals"
{
    CardPageID = "Trustee Payment Reversal";
    PageType = List;
    SourceTable = "Trustee Payment Reversal";
    SourceTableView = WHERE(Posted = FILTER(false));
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
                field("Created Date"; Rec."Created Date")
                {
                }
                field(Posted; Rec.Posted)
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
