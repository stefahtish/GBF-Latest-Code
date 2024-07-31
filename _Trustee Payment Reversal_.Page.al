page 50686 "Trustee Payment Reversal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Trustee Payment Reversal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT Rec.posted;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                group(History)
                {
                    Editable = false;

                    field(Posted; Rec.Posted)
                    {
                    }
                    field(Status; Rec.Status)
                    {
                    }
                    field("User ID"; Rec."User ID")
                    {
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                    }
                    field("Posted Date-Time"; Rec."Posted Date-Time")
                    {
                    }
                }
            }
            part(Control10; "Trustee Payment Lines")
            {
                Editable = NOT Rec.posted;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Post Reversal")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NOT Rec.posted;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post this reversal?', false) then Payroll.ReverseTrusteePayment(Rec);
                end;
            }
        }
    }
    var
        Payroll: Codeunit Payroll;
}
