page 50495 "Employee Promotion Card"
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
                label("Request:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                }
                field("Request Name"; Rec."Request Name")
                {
                    Editable = false;
                }
                label("Employee:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                label("Desired Position:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Desired Position"; Rec."Desired Position")
                {
                }
                field("Position Name"; Rec."Position Name")
                {
                    Editable = false;
                }
                field("New Job Group"; Rec."New Scale")
                {
                }
                field("New Pointer"; Rec."New Pointer")
                {
                }
                field(Promoted; Rec.Promoted)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Reason For Promotion")
            {
                Caption = 'Reason For Promotion';

                field(Reason; Rec.Reason)
                {
                    MultiLine = true;
                }
            }
            group("Promotion Benefits")
            {
                Editable = false;

                field("Current Job Group"; Rec."Current Scale")
                {
                    Caption = 'Current Job Group';
                }
                field("Current Pointer"; Rec."Current Pointer")
                {
                }
                field("Current Benefits"; Rec."Current Benefits")
                {
                }
                label("Grade Benefits")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("New Benefits"; Rec."New Benefits")
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
                    if Confirm('Do you want to the send the promotion request for approval?', true) = false then
                        exit
                    else if ApprovalsMgmt.CheckEmpActingAndPromotionWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendEmpActingAndPromotionRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval")
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
            action(ViewApporvals)
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
                    ApprovalEntry.SetRange("Document No.", Rec.No);
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            action(Promote)
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                var
                    Employee: Record Employee;
                    Job: Record "Company Job";
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."Employee No.");
                    if Employee.FindFirst() then begin
                        Employee."Job Position" := Rec."Desired Position";
                        Employee."Job Position Title" := Rec."Position Name";
                        Employee."Salary Scale" := Rec."New Scale";
                        Employee.Present := Rec."New Pointer";
                        Employee.Halt := Rec."Current Pointer";
                        Employee.Modify();
                    end;
                    Assign.Reset();
                    Assign.SetRange("Employee No", Rec."Employee No.");
                    Assign.SetRange("Basic Salary Code", true);
                    Assign.SetRange(Closed, false);
                    if Assign.FindFirst() then begin
                        Assign.Amount := Rec."New Benefits";
                        Assign.Modify();
                    end;
                    Rec.Promoted := true;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Promotion Type" := Rec."Promotion Type"::Promotion;
    end;

    var
        Employee: Record Employee;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Assign: Record "Assignment Matrix-X";
}
