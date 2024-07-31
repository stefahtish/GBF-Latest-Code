page 50271 "Budget Approval Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Budget Approval Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::"Open";

                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field("Time Created"; Rec."Time Created")
                {
                    Editable = false;
                }
                field("Budget Option"; Rec."Budget Option")
                {
                }
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
            }
            part(Control17; "Budget Approval Lines")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
            }
            systempart(Control16; MyNotes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Enabled = NOT OpenApprovalsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckBudgetWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendBudgetApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalRequest;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelBudgetApproval(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::"Budget Approval Header");
                    ApprovalEntry.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalsExist: Boolean;
        OpenApprovalsExistForCurrUser: Boolean;
        CanCancelApprovalRequest: Boolean;

    local procedure SetControlAppearance()
    var
        BudgetApprovalHeader: Record "Budget Approval Header";
        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
    begin
        if BudgetApprovalHeader.Get(Rec."Document No.") then begin
            OpenApprovalsExistForCurrUser := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            OpenApprovalsExist := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            CanCancelApprovalRequest := ApprovalsMgmt2.CanCancelApprovalForRecord(BudgetApprovalHeader.RecordId);
        end;
    end;
}
