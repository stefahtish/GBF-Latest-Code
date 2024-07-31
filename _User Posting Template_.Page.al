page 50114 "User Posting Template"
{
    PageType = List;
    SourceTable = "User Posting Template";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserID)
                {
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                }
                field("Petty Cash Journal Template"; Rec."Petty Cash Journal Template")
                {
                }
                field("Petty Cash Journal Batch"; Rec."Petty Cash Journal Batch")
                {
                }
                field("Bank Trans. Journal Template"; Rec."Bank Trans. Journal Template")
                {
                }
                field("Bank Trans. Journal Batch"; Rec."Bank Trans. Journal Batch")
                {
                }
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                }
                field("Payroll Journal Template"; Rec."Payroll Journal Template")
                {
                }
                field("Payroll Journal Batch"; Rec."Payroll Journal Batch")
                {
                }
                field("Job Journal Template"; Rec."Job Journal Template")
                {
                }
                field("Job Journal Batch"; Rec."Job Journal Batch")
                {
                }
            }
        }
    }
    actions
    {
    }
}
