page 50659 "Payroll Change Adjustment"
{
    PageType = Card;
    SourceTable = "Payroll Change Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field(Time; Rec.Time)
                {
                    Caption = 'Time';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Control10; "Emp. Payment Req Lines")
            {
                SubPageLink = "Document No" = FIELD(No);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Import Pay Change")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ExportPayChange);
                    ExportPayChange.GetHeaderNo(Rec);
                    ExportPayChange.Run;
                end;
            }
            action("send approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if ApprovalMgt.CheckPayrollChangeWorkflowEnabled(Rec) then ApprovalMgt.OnSendPayrollChangeforApproval(Rec);
                end;
            }
            action("cancel approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelPayrollChangeApproval(Rec);
                end;
            }
            action(approval)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change";
                begin
                    DocType := DocType::"Payroll Change";
                    ApprovalEntries.Setrecordfilters(DATABASE::"Payroll Change Header", DocType, Rec.No);
                    ApprovalEntries.Run;
                end;
            }
        }
    }
    var
        ExportPayChange: XMLport "Export Payroll Change";
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
}
