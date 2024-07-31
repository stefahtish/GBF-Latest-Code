page 50695 "Posted Loan Interests-Payroll"
{
    CardPageID = "Posted Loan Interest-Payroll";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Header";
    SourceTableView = WHERE(Posted = CONST(true), Reversed = CONST(false));
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
        area(processing)
        {
            group(Action13)
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
}
