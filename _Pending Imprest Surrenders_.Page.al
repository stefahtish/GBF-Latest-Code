page 50209 "Pending Imprest Surrenders"
{
    CardPageID = "Approved/Post Imp Surr. Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = WHERE("Payment Type" = CONST("Imprest Surrender"), Status = CONST("Pending Approval"), Posted = CONST(false));
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
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
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
            part("FactBox"; "Payments FactBox Test")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Approval Entries")
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

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
        //DocStatus:=FormatStatus(Status);
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2", "Actual Amount Spent 1", "Actual Amount Spent 2", "Cash Receipt Amount 1", "Cash Receipt Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec."Actual Amount Spent" := Rec."Actual Amount Spent 1" + Rec."Actual Amount Spent 2";
        Rec."Cash Receipt Amount" := Rec."Cash Receipt Amount 1" + Rec."Cash Receipt Amount 2";
        Rec.Modify(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CalcFields("Impress Amount 1", "Impress Amount 2", "Actual Amount Spent 1", "Actual Amount Spent 2", "Cash Receipt Amount 1", "Cash Receipt Amount 2");
        Rec."Imprest Amount" := Rec."Impress Amount 1" + Rec."Impress Amount 2";
        Rec."Actual Amount Spent" := Rec."Actual Amount Spent 1" + Rec."Actual Amount Spent 2";
        Rec."Cash Receipt Amount" := Rec."Cash Receipt Amount 1" + Rec."Cash Receipt Amount 2";
        Rec.Modify(true);
    end;

    trigger OnOpenPage()
    begin
        // DocStatus:=FormatStatus(Status);
        // IF UserSetup.GET(USERID) THEN
        //  BEGIN
        //    IF UserSetup."Show All"=FALSE THEN
        //      SETRANGE("Created By",USERID);
        //  END;
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved";
        UserSetup: Record "User Setup";
}
