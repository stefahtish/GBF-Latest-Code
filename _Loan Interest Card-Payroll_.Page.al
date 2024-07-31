page 50693 "Loan Interest Card-Payroll"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Post';
    SourceTable = "Loan Interest Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Period Reference"; Rec."Period Reference")
                {
                }
                field("Period Narration"; Rec."Period Narration")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
            part(Control11; "Loan Interest Lines-Payroll")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Action14)
            {
                action(Suggest)
                {
                    Caption = 'Suggest Interest Lines';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Payroll.SuggestLoanInterestLines(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'Post Interest';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm(PostConfirm, false) then Payroll.PostLoanInterest(Rec);
                    end;
                }
                action(Clear)
                {
                    Caption = 'Clear Lines';
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanInterestLines.SetRange("Document No.", Rec."No.");
                        LoanInterestLines.DeleteAll;
                    end;
                }
            }
        }
    }
    var
        Payroll: Codeunit Payroll;
        PostConfirm: Label 'Are you sure you want to post?';
        LoanInterestHeader: Record "Loan Interest Header";
        LoanInterestLines: Record "Loan Interest Lines";
}
