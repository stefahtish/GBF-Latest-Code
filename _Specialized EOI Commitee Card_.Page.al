page 50347 "Specialized EOI Commitee Card"
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
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
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
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                    //Editable = false;
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
                SubPageLink = "Appointment No" = field("Appointment No");
            }
        }
        area(FactBoxes)
        {
            part("Attachments"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Table ID" = const(50139), "No." = field("Appointment No");
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

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelTenderCommitteeApproval(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
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
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::EOI;
        Rec."Committee Type" := Rec."Committee Type"::Specialized;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::EOI;
        Rec."Committee Type" := Rec."Committee Type"::Specialized;
    end;

    local procedure SetControlAppearance()
    begin
        if Rec.Status = Rec.Status::Released then
            DocEditable := false
        else
            DocEditable := true;
    end;
}
