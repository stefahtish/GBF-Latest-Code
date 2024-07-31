page 50916 "Audit Program"
{
    Caption = 'Audit Program';
    PageType = Card;
    SourceTable = "Audit Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" <> Rec."Status"::Released;

                field("No."; Rec."No.")
                {
                    enabled = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Audit Plan No."; Rec."Audit Plan No.")
                {
                }
                field("Audit Notification No."; Rec."Audit Notification No.")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Audit Period"; Rec."Audit Period Start Date")
                {
                }
                field("Audit Manager No."; Rec."Audit Manager No.")
                {
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    Enabled = false;
                }
                field("Send Attachment"; Rec."Send Attachment")
                {
                    Visible = false;
                }
            }
            part(Control17; "Auditor(s)")
            {
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Auditor);
            }
            part(Scope; "Audit Scope")
            {
                Caption = 'Scope';
                //Editable = "Status" <> "Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Scope);
            }
            part(Objectives; Objectives)
            {
                Caption = 'Objectives';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Objectives);
            }
            part("Planning Procedures"; "Audit Planning Procedures")
            {
                Caption = 'Pre-field work planning and review';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = FILTER(Planning);
            }
            part("Audit Step"; "Audit Step")
            {
                Caption = 'Field Work';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Field work step");
            }
            part("Review Procedures"; "Audit Review")
            {
                Caption = 'Audit Test Procedure';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Review);
            }
            part("Post-Review"; "Audit Post-Review Procedures")
            {
                Caption = 'Reporting Results';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Post Reveiw");
            }
        }
        area(factboxes)
        {
            systempart(Control35; Links)
            {
            }
            systempart(Control34; Notes)
            {
            }
            part("Audit FactBox Test"; "Audit FactBox Test")
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Plan)
            {
                Caption = 'Program';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ADHeader.RESET;
                    ADHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Program", TRUE, FALSE, ADHeader);
                end;
            }
            action("Send Audit Plan")
            {
                Caption = 'Send Audit Program';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                //  Visible = false;
                trigger OnAction()
                begin
                    AuditMgt.SendAuditPlanNotice(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF ApprovalsMgt.CheckAuditWorkflowEnabled(Rec) THEN ApprovalsMgt.OnSendAuditForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgt.OnCancelAuditApprovalRequest(Rec);
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
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            action(ReOpen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" <> Rec."Status"::Open;

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ReOpeConfirm, FALSE, Rec."No.") THEN
                        EXIT
                    ELSE BEGIN
                        Rec.Status := Rec.Status::Open;
                    END;
                end;
            }
            action(Archive)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Released;

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ArchiveConfirm, FALSE, Rec."No.") THEN
                        EXIT
                    ELSE
                        Rec.Archived := true;
                    CASE Rec.Type OF
                        Rec.Type::"Audit Plan":
                            BEGIN
                                IF ADHeader.GET(Rec."Audit Plan No.") THEN BEGIN
                                    ADHeader."Audit Status" := ADHeader."Audit Status"::Done;
                                    ADHeader.MODIFY;
                                END;
                            end;
                    end;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    var
        ADHeader: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        ReOpeConfirm: Label 'Do you want to ReOpen the Document %1?';
        ArchiveConfirm: Label 'Do you want to archive the Document %1?';
}
