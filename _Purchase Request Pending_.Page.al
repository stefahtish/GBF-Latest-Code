page 50777 "Purchase Request Pending"
{
    CardPageID = "Purchase Request Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approval Entries';
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase), "Fully Ordered" = CONST(false), Status = FILTER("Pending Approval"), Archived = CONST(false));
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
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Reason Description"; Rec."Reason Description")
                {
                }
                field(Selected; Rec.Selected)
                {
                }
                field(Status; Rec.Status)
                {
                }
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
        SetPageView;
    end;

    trigger OnInit()
    begin
        RfqVisible := false;
    end;

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Requested By", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved",Released,Fulfilled;
        PaymentsRec: Record Payments;
        UserSetup: Record "User Setup";
        IR: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        PopulateLines: Codeunit "Procurement Management";
        RfqVisible: Boolean;
        ApprovalEntry: Record "Approval Entry";
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;

    local procedure SetPageView()
    begin
        if Rec.Status = Rec.Status::Released then
            RfqVisible := true
        else
            RfqVisible := false;
    end;
}
