Page 51511 "Approval Comments Portal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Approval Comment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Record ID to Approve"; Rec."Record ID to Approve")
                {
                }
                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
            }
        }
    }
}
