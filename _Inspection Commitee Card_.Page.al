page 50314 "Inspection Commitee Card"
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
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    Caption = 'Reference No.';
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                var
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::Tender;
        Rec."Committee Type" := Rec."Committee Type"::Inspection;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Procurement Method" := Rec."Procurement Method"::Tender;
        Rec."Committee Type" := Rec."Committee Type"::Inspection;
    end;

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

    local procedure SetControlAppearance()
    begin
        if Rec.Status = Rec.Status::Released then
            DocEditable := false
        else
            DocEditable := true;
    end;
}
