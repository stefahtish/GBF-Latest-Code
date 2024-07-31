page 50929 "Audit Report Card"
{
    Caption = 'Report Card';
    PageType = Card;
    SourceTable = "Audit Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Audit Program No."; Rec."Audit Program No.")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Audit WorkPaper No."; Rec."Audit WorkPaper No.")
                {
                    Caption = 'Select Workpaper(s)';
                    Editable = NOT AuditeeReport;
                    Enabled = NOT AuditeeReport;
                    // trigger OnLookup(var Text: Text): Boolean
                    // begin
                    //     SelectMultipleWorkpapers;
                    // end;
                }
                field(Description; Rec.Description)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period Start Date")
                {
                    Editable = NOT AuditeeReport;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Audit Firm"; Rec."Audit Firm")
                {
                    Visible = false;
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    Editable = false;
                }
                label("Auditee:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Auditee; Rec.Auditee)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Name of Auditee"; Rec."Name of Auditee")
                {
                    Editable = false;
                }
                field("Auditee User ID"; Rec."Auditee User ID")
                {
                    Editable = false;
                }
                field("User Reviewed"; Rec."User Reviewed")
                {
                    Editable = false;
                }
                label("Report Workpapers:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                part(Control37; "Audit Report Workpapers")
                {
                    Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                    SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Workpapers");
                }
            }
            part("Report Background"; "Audit Report Background")
            {
                Caption = 'Report Background';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Background");
            }
            part("Report Objectives"; "Audit Report Objectives")
            {
                Caption = 'Report Objectives';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Objectives");
            }
            part("Favourable Observation"; "Audit Report Fav Observation")
            {
                Caption = 'Favourable Observation';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Observation");
            }
            part("Unfavourable Observation"; "Audit Report UnFav Observation")
            {
                Caption = 'Unfavourable Observation';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Recommendation");
            }
            part(Conclusion; "Audit Report Opinion")
            {
                Caption = 'Conclusion';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Opinion");
            }
            part(Comments; "Audit Report Opinion")
            {
                Caption = 'Internal audit committee comments';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Comments);
            }
        }
        area(factboxes)
        {
            systempart(Control21; Links)
            {
            }
            systempart(Control18; Notes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Audit Report")
            {
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Internal Audit Report", TRUE, FALSE, AuditHead);
                end;
            }
            action("Dispatch Report")
            {
                Visible = false;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                // Visible = ("Report Status" <> "Report Status"::Auditee);
                trigger OnAction()
                begin
                    AuditMgt.MailAuditReport(Rec);
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                begin
                    IF ApprovalsMgt.IsAuditWorkflowEnabled(Rec) THEN ApprovalsMgt.OnSendAuditForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                Visible = false;
                Caption = 'Cancel Review';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //  Visible = ("Report Status" <> "Report Status"::Auditee);
                trigger OnAction()
                begin
                    ApprovalsMgt.OnCancelAuditApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Visible = false;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //  Visible = ("Report Status" <> "Report Status"::Auditee);
                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program";
                begin
                    DocumentType := DocumentType::"Audit Report";
                    ApprovalEntries.Setrecordfilters(DATABASE::"Audit Header", DocumentType, Rec."No.");
                    ApprovalEntries.RUN;
                end;
            }
            action("Close Report")
            {
                Visible = false;
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //  Visible = ("Report Status" <> "Report Status"::Auditee);
                trigger OnAction()
                begin
                    IF NOT CONFIRM(ConfirmCLose, FALSE, Rec."No.") THEN
                        EXIT
                    ELSE BEGIN
                        AuditMgt.InsertAuditRecommendation(Rec);
                        Rec.Archived := TRUE;
                        Rec.MODIFY;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(NotifyAuditor)
            {
                Visible = false;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Send To Auditee")
            {
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Report Status" <> Rec."Report Status"::Auditee;

                trigger OnAction()
                begin
                    //AuditMgt.MailAuditeeReport(Rec);
                    Rec."Report Status" := Rec."Report Status"::Auditee;
                    CurrPage.close;
                end;
            }
            action("Send To Auditor")
            {
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Report Status" = Rec."Report Status"::Auditee;

                trigger OnAction()
                begin
                    Rec."Report Status" := Rec."Report Status"::Audit;
                    CurrPage.close;
                    AuditMgt.MailAuditorReport(Rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Report";
        Rec."Report Status" := Rec."Report Status"::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Report";
        Rec."Report Status" := Rec."Report Status"::Audit;
    end;

    trigger OnOpenPage()
    begin
        //SetControlAppearance;
    end;

    var
        AuditHead: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        ConfirmCLose: Label 'Do you want to close the Audit Report %1?';
        ConfrimSendtoAuditee: Label 'Do you want to send the Audit Report %1 to the Auditee %2 - %3?';
        AuditeeReport: Boolean;
        ApprovalMgtExt: Codeunit ApprovalMgtCuExtension;

    local procedure SetControlAppearance()
    begin
        //AuditeeReport := ("Report Status" = "Report Status"::Auditee);
    end;
}
