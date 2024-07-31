page 50180 "Cash Office User Template"
{
    PageType = List;
    SourceTable = "Cash Office User Template";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = all;
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ApplicationArea = all;
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ApplicationArea = all;
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ApplicationArea = all;
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ApplicationArea = all;
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ApplicationArea = all;
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    ApplicationArea = all;
                }
                field("Inter Bank Template Name"; Rec."Inter Bank Template Name")
                {
                    ApplicationArea = all;
                }
                field("Inter Bank Batch Name"; Rec."Inter Bank Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ApplicationArea = all;
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ApplicationArea = all;
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ApplicationArea = all;
                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {
                    ApplicationArea = all;
                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {
                    ApplicationArea = all;
                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {
                    ApplicationArea = all;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = all;
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    ApplicationArea = all;
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    ApplicationArea = all;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ApplicationArea = all;
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    ApplicationArea = all;
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    ApplicationArea = all;
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    ApplicationArea = all;
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    ApplicationArea = all;
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    ApplicationArea = all;
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    ApplicationArea = all;
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    ApplicationArea = all;
                }
                field("Imprest Sur Template"; Rec."Imprest Sur Template")
                {
                    ApplicationArea = all;
                    Caption = 'Imprest Surrender Template';
                }
                field("Imprest Sur Batch"; Rec."Imprest Sur Batch")
                {
                    ApplicationArea = all;
                    Caption = 'Imprest Surrender Batch';
                }
            }
        }
    }
    actions
    {
    }
}
