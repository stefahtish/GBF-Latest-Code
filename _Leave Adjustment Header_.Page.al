page 50433 "Leave Adjustment Header"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Leave Bal Adjustment Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                }
                field(EnteredBy; Rec.EnteredBy)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                group(History)
                {
                    Editable = false;

                    field(Posted; Rec.Posted)
                    {
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                    }
                    field("Posted Date"; Rec."Posted Date")
                    {
                    }
                }
            }
            part(Control11; "Leave Adjustment Lines")
            {
                SubPageLink = "Header No." = FIELD(Code);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Update Employment Type")
            {
                ApplicationArea = all;
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    LeaveAdjLine: Record "Leave Bal Adjustment Lines";
                    EmpRec: Record Employee;
                begin
                    LeaveAdjLine.Reset();
                    LeaveAdjLine.SetRange("Header No.", Rec.Code);
                    If LeaveAdjLine.FindSet() then begin
                        repeat
                            EmpRec.Reset();
                            EmpRec.SetRange("No.", LeaveAdjLine."Staff No.");
                            If EmpRec.FindFirst() then;
                            LeaveAdjLine."Employment Type" := EmpRec."Employment Type";
                            LeaveAdjLine.Modify();
                            Message('Adjusted For %1', Emprec."No.");
                        until LeaveAdjLine.Next() = 0;
                    end;
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm(Text001, false) then HRMgnt.LeaveAdjustment(Rec.Code);
                    CurrPage.Close;
                    /*
                        IF CONFIRM(Text001) THEN
                          BEGIN

                            AdjustmentLines.RESET;
                            AdjustmentLines.SETRANGE("Header No.",Code);
                              IF AdjustmentLines.FIND('-') THEN
                                BEGIN
                                  REPEAT

                                  EmpLeaves.RESET;
                                  EmpLeaves.SETRANGE(EmpLeaves."Employee No",AdjustmentLines."Staff No.");
                                  EmpLeaves.SETRANGE(EmpLeaves."Maturity Date",AdjustmentLines."Maturity Date");
                                  EmpLeaves.SETRANGE(EmpLeaves."Leave Code",AdjustmentLines."Leave Code");
                                    IF EmpLeaves.FIND('-') THEN
                                       BEGIN
                                         EmpLeaves."Balance Brought Forward":=AdjustmentLines."New Bal. Brought Forward";
                                         EmpLeaves.Entitlement:= AdjustmentLines."New Entitlement";
                                         EmpLeaves.MODIFY(TRUE);
                                        END;
                                    UNTIL AdjustmentLines.NEXT=0;
                                 EmpLeaves.INSERT;
                                 END;

                              Posted:=TRUE;
                              "Posted By":= USERID;
                              "Posted Date":=TODAY;
                              MODIFY;

                              MESSAGE(Text002);
                            END;
                            CurrPage.CLOSE;
                        */
                    //HRMgnt.LeaveAdjustment(Code);
                end;
            }
            action("Send For Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Open";
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckLeaveAdjWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendLeaveAdjApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelLeaveAdjApproval(Rec);
                end;
            }
            action(Approval)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program","FA Disposal";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocType := DocType::LeaveAdjustment;
                    ApprovalEntries.Setrecordfilters(DATABASE::"Leave Bal Adjustment Header", DocType, Rec.Code);
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Leave Adjustment";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Leave Adjustment";
    end;

    var
        Text001: Label 'Are you sure you want to post the leave adjustments?';
        AdjustmentLines: Record "Leave Bal Adjustment Lines";
        EmpLeaves: Record "Employee Leave";
        Text002: Label 'Leave Adjustments Posted Successfully';
        HRMgnt: Codeunit "HR Management";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
}
