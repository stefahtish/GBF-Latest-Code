page 50130 "Posted Petty Cash Surrenders"
{
    CardPageID = "Approved Petty Cash Surrender";
    Editable = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Petty Cash Surrender"), Status = CONST(Released), Posted = CONST(true));
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
                field(Date; Rec.Date)
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Actual Petty Cash Amount Spent"; Rec."Actual Petty Cash Amount Spent")
                {
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
            }
            systempart(Control13; MyNotes)
            {
            }
            systempart(Control14; Links)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Navigate)
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DocStatus := Rec.FormatStatus(Rec.Status);
    end;

    trigger OnOpenPage()
    begin
        DocStatus := Rec.FormatStatus(Rec.Status);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
}
