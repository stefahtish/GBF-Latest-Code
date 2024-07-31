page 50936 "Risk Survey"
{
    PageType = Card;
    SourceTable = "Audit Header";
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                }
                field("Sender E-Mail"; Rec."Sender E-Mail")
                {
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                    Enabled = false;
                }
            }
            part(Control11; "Operations Risk")
            {
                Caption = 'Risk Category';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Internal Risk");
                UpdatePropagation = both;
            }
            part(Control12; "External Risks")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("External Risk");
                UpdatePropagation = both;
            }
            part(Control13; "Risk Mitigation Proposal")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Mitigation");
                Visible = false;
            }
            part(Control14; "Risk Opportunities")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Opportunities");
                Visible = false;
            }
        }
        area(factboxes)
        {
            part(Comments; "Approval Comments FactBox")
            {
                SubPageLink = "Document No." = field("No.");
            }
            systempart(Control23; Links)
            {
            }
            systempart(Control22; Notes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Survey Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Risk Survey", TRUE, FALSE, AuditHead);
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = not OpenApprovalEntriesExist;

                trigger OnAction()
                var
                begin
                    if ApprovalMgt.CheckAuditWorkflowEnabled(rec) then ApprovalMgt.OnSendAuditForApproval(rec);
                    CurrPage.close;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForPayment;

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelAuditApprovalRequest(rec);
                    CurrPage.Close();
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: page "Approval Entries";
                    Approvals: Record "Approval Entry";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Audit Header");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Risk Survey";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Risk Survey";
    end;

    var
        AuditHead: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;

    local procedure SetControlApperance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Released) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := true
        else
            OpenApprovalEntriesExist := false;
        if (Rec."Status" = Rec."Status"::"Pending Approval") then
            OpenApprovalEntriesExist := true
        else
            OpenApprovalEntriesExist := false;
        //Get Doc count
    end;
}
