page 50877 "Archived Requisitions"
{
    CardPageID = "Purchase Request Approved Card";
    //  DeleteAllowed = false;
    //InsertAllowed = false;
    //ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approval Entries';
    SourceTable = "Internal Request Header";
    SourceTableView = WHERE("Document Type" = CONST(Purchase), Status = FILTER(Archived));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(MakeOrder)
            {
                Caption = 'Make Order From Selected';
                Image = BlanketOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    PopulateLines.MakeOrderFromSelected(Rec, true);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve For Request For Quotation';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve PFR No. %1 and send it to Request For Quotation?', false, Rec."No.") = true then begin
                        Rec."Cleared For RFQ" := true;
                        Rec.Archived := true;
                        Rec.Modify;
                        Commit;
                        Message('%1 Approved Successfully', Rec."No.");
                    end
                    else
                        exit;
                end;
            }
            action("Reject Approved PRF")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Released";

                trigger OnAction()
                var
                    RejectApprovedPRF: Report "Reject Approved PRF";
                begin
                    if Confirm('Are you sure you want to reject PRF No. %1 ?', false, Rec."No.") = true then begin
                        IR.Reset;
                        IR.SetRange("No.", Rec."No.");
                        if IR.FindFirst then begin
                            RejectApprovedPRF.SetTableView(IR);
                            RejectApprovedPRF.RunModal;
                        end;
                    end
                    else
                        exit;
                end;
            }
            action(Approvals)
            {
                Caption = 'View Approvals';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
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
        SetPageView;
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
