page 50107 "Commitment Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "Commitment Entries";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Commitment No"; Rec."Commitment No")
                {
                }
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Commitment Date"; Rec."Commitment Date")
                {
                }
                field("Commitment Type"; Rec."Commitment Type")
                {
                }
                field(Account; Rec.Account)
                {
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                }
                field(User; Rec.User)
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                }
                field("Global Dimension 5"; Rec."Global Dimension 5")
                {
                }
                field("Global Dimension 7"; Rec."Global Dimension 7")
                {
                }
                field("Global Dimension 8"; Rec."Global Dimension 8")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Payment Posted"; Rec."Payment Posted")
                {
                }
                field("SRN Posted"; Rec."SRN Posted")
                {
                }
                field("Imprest Surrendered"; Rec."Imprest Surrendered")
                {
                }
                field("Invoice No"; Rec."Invoice No")
                {
                }
                field("Budget Code"; Rec."Budget Code")
                {
                }
            }
        }
    }
    actions
    {
    }
}
