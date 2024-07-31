page 51234 "Inspection Report"
{
    caption = 'Special Investigation Audit';
    PageType = Card;
    SourceTable = "Audit Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not DocReleased;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Audit Period"; Rec."Audit Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Audit Manager No."; Rec."Audit Manager No.")
                {
                    ApplicationArea = All;
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    Enabled = false;
                }
                // label("Cut Off Period:")
                // {
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Cut Off Start Date"; "Cut Off Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Cut Off End Date"; "Cut Off End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Audit Status"; Rec."Audit Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            field("Objectives Statement"; ObjectivesNotesText)
            {
                Editable = not DocReleased;
                Caption = 'Objectives';
                ApplicationArea = Basic, Suite;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.CALCFIELDS("Objectives Statement");
                    rec."Objectives Statement".CREATEINSTREAM(Instr);
                    ObjectivesNote.READ(Instr);
                    IF ObjectivesNotesText <> FORMAT(ObjectivesNote) THEN BEGIN
                        CLEAR(Rec."Objectives Statement");
                        CLEAR(ObjectivesNote);
                        ObjectivesNote.ADDTEXT(ObjectivesNotesText);
                        rec."Objectives Statement".CREATEOUTSTREAM(OutStr);
                        ObjectivesNote.WRITE(OutStr);
                    END;
                end;
            }
            field("Risk Likelihood"; Rec."Risk Likelihood")
            {
                Editable = not DocReleased;
                caption = 'Risk';
                ApplicationArea = All;
            }
            part(Findings; Objectives)
            {
                Editable = not DocReleased;
                Caption = 'Summary Findings';
                SubPageLink = "Document No." = field("No."), "Audit Line Type" = CONST(Findings);
                ApplicationArea = All;
            }
            part(Recommendation; "Audit Recommendation Subform")
            {
                Editable = not DocReleased;
                Caption = 'Recommendations';
                SubPageLink = "Document No." = field("No."), "Audit Line Type" = CONST("Report Recommendation");
                ApplicationArea = All;
            }
            label("Interview Worksheet")
            {
                Visible = false;
                Style = Strong;
            }
            field(Introduction; IntroNotesText)
            {
                Visible = false;
                Editable = not DocReleased;
                Caption = 'Purpose';
                ApplicationArea = Basic, Suite;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.CALCFIELDS(Introduction);
                    rec.Introduction.CREATEINSTREAM(Instr);
                    IntroNote.READ(Instr);
                    IF IntroNotesText <> FORMAT(IntroNote) THEN BEGIN
                        CLEAR(Rec.Introduction);
                        CLEAR(IntroNote);
                        IntroNote.ADDTEXT(IntroNotesText);
                        rec.Introduction.CREATEOUTSTREAM(OutStr);
                        IntroNote.WRITE(OutStr);
                    END;
                end;
            }
            field("Interviewee Name"; Rec."Interviewee Name")
            {
                Visible = false;
                Editable = not DocReleased;
                Caption = 'Person interviewed';
                ApplicationArea = All;
            }
            field("Audit WorkPaper No."; Rec."Audit WorkPaper No.")
            {
                Visible = false;
                Editable = not DocReleased;
                ApplicationArea = All;
            }
            part(Worksheet; "Audit Interview Worksheet")
            {
                Visible = false;
                Editable = not DocReleased;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Queries);
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
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
            action("Special investigation report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InspectionReport: report "Audit Inspection Report";
                begin
                    AuditHeader.RESET;
                    AuditHeader.SETRANGE("No.", Rec."No.");
                    InspectionReport.SetTableView(AuditHeader);
                    InspectionReport.RUN;
                end;
            }
            group(Approval)
            {
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
                        ApprovalEntry.SetRange("Table ID", 50497);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Inspection;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Inspection;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
        Rec.CALCFIELDS(Introduction, "Objectives Statement");
        rec.Introduction.CREATEINSTREAM(Instr);
        IntroNote.READ(Instr);
        IntroNotesText := Format(IntroNote);
        rec."Objectives Statement".CREATEINSTREAM(Instr);
        ObjectivesNote.READ(Instr);
        ObjectivesNotesText := Format(ObjectivesNote)
    end;

    var
        AuditHeader: Record "Audit Header";
        IntroNote: BigText;
        IntroNotesText: Text;
        ObjectivesNote: BigText;
        ObjectivesNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        DocReleased: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Released then
            DocReleased := true
        else
            DocReleased := false;
    end;
}
