page 50688 "Trustee Payment Reversals-Post"
{
    CardPageID = "Trustee Payment Reversal";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Trustee Payment Reversal";
    SourceTableView = WHERE(Posted = CONST(true));
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
