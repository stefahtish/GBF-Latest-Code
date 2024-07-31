page 50274 "Budget Approved Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field';
                    ApplicationArea = All;
                }
                field("Time Created"; Rec."Time Created")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Created field';
                    ApplicationArea = All;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ToolTip = 'Specifies the value of the Budget Name field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                    ApplicationArea = All;
                }
            }
            part(Control9; "Budget Approval Lines")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("Document No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control14; Notes)
            {
                ApplicationArea = All;
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
                Visible = false;
                ToolTip = 'Executes the Send Approval Request action';
                ApplicationArea = All;

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
                Visible = false;
                ToolTip = 'Executes the Cancel Approval Request action';
                ApplicationArea = All;

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
                ToolTip = 'Executes the Approvals action';
                ApplicationArea = All;

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
