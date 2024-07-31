page 50697 "Posted Loan Interest-Payroll"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = Rec.Reversed;

                    field(Reversed; Rec.Reversed)
                    {
                    }
                    field("Reversed By"; Rec."Reversed By")
                    {
                    }
                    field("Date Reversed"; Rec."Date Reversed")
                    {
                    }
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
                Visible = false;

                action(Suggest)
                {
                    Caption = 'Suggest Interest Lines';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //InvestmentPropertyMgt.SuggestPropertyInterestLines(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'Post Interest';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // IF CONFIRM(PostConfirm,FALSE) THEN
                        //  InvestmentPropertyMgt.PostPropertyInterest(Rec);
                    end;
                }
            }
            group(Action18)
            {
                action(Reverse)
                {
                    Caption = 'Reverse Interest Batch';
                    Enabled = NOT Rec.Reversed;
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                        GLRegister: Record "G/L Register";
                        GLRegister2: Record "G/L Register";
                    begin
                        if Confirm('Are you sure you want to reverse Batch No. %1 ?', false, Rec."No.") then begin
                            GLRegister.Reset;
                            GLRegister.SetRange("Journal Batch Name", Rec."No.");
                            if GLRegister.Find('-') then begin
                                Clear(ReversalEntry);
                                ReversalEntry.SetHideDialog(false);
                                ReversalEntry.ReverseRegister(GLRegister."No.");
                                Commit;
                                //Check if fully reversed
                                GLRegister2.Reset;
                                GLRegister2.SetRange("No.", GLRegister."No.");
                                GLRegister2.SetRange(Reversed, true);
                                if GLRegister2.Find('-') then begin
                                    Rec.Reversed := true;
                                    Rec."Reversed By" := UserId;
                                    Rec."Date Reversed" := Today;
                                    Rec.Modify;
                                    Message('Successfully Reversed');
                                end;
                            end;
                        end;
                        CurrPage.Update;
                        CurrPage.Close;
                    end;
                }
            }
        }
    }
    var
        PostConfirm: Label 'Are you sure you want to post?';
}
