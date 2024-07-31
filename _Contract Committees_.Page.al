page 51416 "Contract Committees"
{
    Caption = 'Commitee Creation Card';
    PageType = Card;
    SourceTable = "Tender Committees";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = DocEditable;

                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                        Contract: Record "Project Header";
                    begin
                        Contract.RESET;
                        IF PAGE.RUNMODAL(Page::"Projects Verified", Contract) = ACTION::LookupOK THEN BEGIN
                            Rec."Contract No." := Contract."No.";
                            EXIT;
                        END;
                    end;
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                }
                field("Submission Time"; Rec."Submission Time")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    Caption = 'Contract Committee Type';
                    ToolTip = 'Specifies the value of the Contract Type field.';
                    ApplicationArea = All;
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
            }
            part("Committee Members"; "Committee Members")
            {
                Editable = DocEditable;
                ApplicationArea = all;
                SubPageLink = "Appointment No" = field("Appointment No");
            }
            part("Committee Suppliers"; "Committee Suppliers")
            {
                ApplicationArea = all;
                Visible = false;
                SubPageLink = "Tender No." = field("Tender/Quotation No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if ApprovalManagement.CheckTenderCommitteeRequestWorkflowEnabled(Rec) then ApprovalManagement.OnSendTenderCommitteeRequestApproval(Rec);
                    Commit;
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelTenderCommitteeApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Approvalentries: Page "Approval Entries";
                    Approvals: Record "Approval Entry";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Tender Committees");
                    Approvals.SetRange("Document No.", Rec."Appointment No");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
        }
        area(Reporting)
        {
            action("Commitee Scores")
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                Image = Report;
                Visible = false;

                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetFilter("Appointment No", Rec."Appointment No");
                    if CommiteeRec.FindFirst() then Report.Run(Report::"Tender Committee Scores", true, false, CommiteeRec);
                end;
            }
            action("Evaluation Scores")
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = all;
                Image = Report;

                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetFilter("Appointment No", Rec."Appointment No");
                    if CommiteeRec.FindFirst() then Report.Run(Report::"Tender Evaluation Scores", true, false, CommiteeRec);
                end;
            }
        }
    }
    var
        ProcMgt: Codeunit "Procurement Management";
        DocEditable: boolean;
        CommiteeRec: Record "Tender Committees";
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;

    trigger OnInit()
    begin
        DocEditable := true;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        Rec.Contract := true;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::Tender;
        Rec."Committee Type" := Rec."Committee Type"::Opening;
        Rec.Contract := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::Tender;
        Rec."Committee Type" := Rec."Committee Type"::Opening;
        Rec.Contract := true;
    end;

    local procedure SetControlAppearance()
    begin
        if Rec.Status = Rec.Status::Released then
            DocEditable := false
        else
            DocEditable := true;
    end;
}
