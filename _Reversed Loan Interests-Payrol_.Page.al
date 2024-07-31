page 50696 "Reversed Loan Interests-Payrol"
{
    CardPageID = "Posted Loan Interest-Payroll";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Header";
    SourceTableView = WHERE(Posted = CONST(true), Reversed = CONST(true));
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
                field("Date Entered"; Rec."Date Entered")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Period Reference"; Rec."Period Reference")
                {
                }
                field("Period Narration"; Rec."Period Narration")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }
    actions
    {
    }
}
