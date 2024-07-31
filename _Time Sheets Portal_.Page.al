page 51510 "Time Sheets Portal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Time Sheet Header";
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
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Resource No."; Rec."Resource No.")
                {
                }
                field("Resource Name"; Rec."Resource Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Owner User ID"; Rec."Owner User ID")
                {
                }
                field("Approver User ID"; Rec."Approver User ID")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Quantity Open"; Rec."Quantity Open")
                {
                }
                field("Quantity Approved"; Rec."Quantity Approved")
                {
                }
                field("Quantity Rejected"; Rec."Quantity Rejected")
                {
                }
                field("Quantity Submitted"; Rec."Quantity Submitted")
                {
                }
                field("Posted Quantity"; Rec."Posted Quantity")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }
}
