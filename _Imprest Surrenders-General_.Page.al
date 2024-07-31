page 50184 "Imprest Surrenders-General"
{
    CardPageID = "Imprest Surrender";
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type"=CONST("Imprest Surrender"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = all;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = all;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = all;
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    ApplicationArea = all;
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
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
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = all;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2", "Actual Amount Spent 1", "Actual Amount Spent 2", "Cash Receipt Amount 1", "Cash Receipt Amount 2");
        Rec."Imprest Amount":=Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec."Actual Amount Spent":=Rec."Actual Amount Spent 1" + Rec."Actual Amount Spent 2";
        Rec."Cash Receipt Amount":=Rec."Cash Receipt Amount 1" + Rec."Cash Receipt Amount 2";
        Rec.Modify(true);
    end;
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId)then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Created By", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;
    var DocStatus: Option New, "HOD Approved", "Finance Approved", "Approval Pending", Rejected, "DED/DFA Approved";
    UserSetup: Record "User Setup";
}
