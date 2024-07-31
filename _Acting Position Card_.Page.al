page 50504 "Acting Position Card"
{
    PageType = Card;
    SourceTable = "Employee Acting Position";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Promotion Type"; Rec."Promotion Type")
                {
                    Editable = false;
                }
                field(Position; Rec.Position)
                {
                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = false;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Duties Taken Over By"; Rec."Employee No.")
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                // field("Qualified"; Qualified)
                // {
                // }
                field("Qualified for position"; Rec."Qualified for position")
                {
                }
                field(Promoted; Rec.Promoted)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Reason For Acting")
            {
                Caption = 'Reason For Acting';

                field(Reason; Rec.Reason)
                {
                    MultiLine = true;
                }
            }
            group("Financial Implication")
            {
                Editable = false;

                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("Acting Amount"; Rec."Acting Amount")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Send for Approval?', true) = false then
                        exit
                    else IF ApprovalsMgmt.CheckEmpActingAndPromotionWorkflowEnabled(Rec) THEN ApprovalsMgmt.OnSendEmpActingAndPromotionRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelEmpActingAndPromotionRequestApproval(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'View Approvals';
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
                    Approvals.SetRange("Table ID", Database::"Employee Acting Position");
                    Approvals.SetRange("Document No.", Rec.No);
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
            action("Get Acting Allowance")
            {
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Qualified := true;
                    Rec.Modify();
                    NoofDays := Rec."End Date" - Rec."Start Date";
                    if NoofDays >= 30 then
                        HrMgmt.GetActingAllowance(Rec.No)
                    else
                        Error('Number of acting days must be equal to or more than 30 days to get an acting allowance');
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Promotion Type" := Rec."Promotion Type"::"Acting Position";
    end;

    var
        Employee: Record Employee;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Workflow: Codeunit "Workflow Responses";
        HrMgmt: Codeunit "HR Management";
        NoofDays: Integer;
}
