page 50923 "Audit Working Paper"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Audit Program No."; Rec."Audit Program No.")
                {
                    trigger OnValidate()
                    begin
                        IF AuditHeader.GET(Rec."Audit Program No.") AND (AuditHeader.Type = AuditHeader.Type::"Audit Program") THEN AuditHeader.Archived := TRUE;
                        AuditHeader.MODIFY;
                    end;
                }
                // field("Select Working Scope"; "Working Paper Scope")
                // {
                // }
                label("Audit Program Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Done By"; Rec."Done By")
                {
                    Editable = false;
                }
                field("Done By Name"; Rec."Done By Name")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Date Completed"; Rec."Date Completed")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Audit Firm"; Rec."Audit Firm")
                {
                    Visible = false;
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                }
                field("Cut-Off Period"; Rec."Cut-Off Period")
                {
                }
                label("Reviewed By:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    Editable = false;
                }
                field("Reviewed By Name"; Rec."Reviewed By Name")
                {
                    Editable = false;
                }
                field("Date Reviewed"; Rec."Date Reviewed")
                {
                    Editable = false;
                }
            }
            part(Control36; "Audit Workpaper Scope")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Scope");
            }
            part("Audit Areas"; "Audit Areas")
            {
                Caption = 'Auditable Area/ System';
                SubPageLink = "No." = FIELD("No.");
            }
            part(Objectives; "WorkPaper Objectives")
            {
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Objectives");
            }
            part("SAMPLE DATA CHECKED"; "WorkPaper Others")
            {
                Caption = 'Data Checked';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Sample Data Checked");
            }
            part("TESTS DONE:"; "WorkPaper Others")
            {
                Caption = 'Tests done';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Test);
            }
            part(AuditQueries; "WorkPaper Others")
            {
                Caption = 'Audit Queries';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Queries);
            }
            part(Conclusion; "WorkPaper Conclusion")
            {
                Caption = 'Conclusion';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Conclusion");
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
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Working Paper")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ADHeader.RESET;
                    ADHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Working Paper", TRUE, FALSE, ADHeader);
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF AppprovalsMgt.IsAuditWorkflowEnabled(Rec) THEN AppprovalsMgt.OnSendAuditForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Review';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AppprovalsMgt.OnCancelAuditApprovalRequest(Rec);
                end;
            }
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Work Paper";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Work Paper";
    end;

    var
        ADHeader: Record "Audit Header";
        AppprovalsMgt: Codeunit ApprovalMgtCuExtension;
        AuditHeader: Record "Audit Header";
        ScopeNotes: BigText;
        Instr: InStream;
        ScopeNotesText: Text;
        OutStr: OutStream;
        AuditLines: Record "Audit Lines";
        ConfirmSelectScope: Label 'Once a Scope is Selected will not appear again.\Confirm the Scope is correct.\Do you want to use the Selected Scope?';
        AuditMgt: Codeunit "Internal Audit Management";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}
