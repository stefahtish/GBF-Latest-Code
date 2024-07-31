page 50443 "Employee Transfer Card"
{
    PageType = Card;
    SourceTable = "Employee Transfers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transfer No"; Rec."Transfer No")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Employee.Get(Rec."Transfer No") then begin
                            Employee.TestField("Date Of Join");
                        end;
                        Rec.County := Rec.GetAge(Employee."Date Of Join");
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Group"; Rec."Job Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Length of Stay"; Rec."Length of Stay")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1"; Rec."Shortcut Dimension 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2"; Rec."Shortcut Dimension 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sub County"; Rec."Sub County")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                label("Transfer Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                group(Control28)
                {
                    ShowCaption = false;
                    Visible = BranchVisible;

                    field("Branch To Transfer"; Rec."Station To Transfer")
                    {
                        MultiLine = false;
                        ApplicationArea = All;
                    }
                }
                group(Control29)
                {
                    ShowCaption = false;
                    Visible = DepVisible;

                    field("Department To Transfer"; Rec."Department Name")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Reason of Transfer"; Rec."Reason of Transfer")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                label("Head of Department:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    Editable = true;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exceed 50 km"; Rec."Exceed 50 km")
                {
                    ApplicationArea = All;
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
                Enabled = Rec.Status = Rec."Status"::New;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckEmployeeTransferWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendEmployeeTransferRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to cancel the approval request for %1?', false, Rec."Transfer No") = true then begin
                        ApprovalsMgmt.OnCancelEmployeeTransferApprovalRequest(Rec);
                    end;
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
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
                    Approvals.SetRange("Table ID", Database::"Employee Transfers");
                    Approvals.SetRange("Document No.", Rec."Transfer No");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
            action("Transfer Staff")
            {
                Image = ContactReference;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    if Rec."Transfer Type" = Rec."Transfer Type"::Department then begin
                        Rec.TestField("Department Name");
                        Rec.TestField("Employee No");
                    end;
                    if Rec."Transfer Type" = Rec."Transfer Type"::"Branch and Department" then begin
                        Rec.TestField("Department Name");
                        Rec.TestField("Employee No");
                        Rec.TestField("Station To Transfer");
                    end;
                    if Rec."Transfer Type" = Rec."Transfer Type"::Branch then begin
                        Rec.TestField("Employee No");
                        Rec.TestField("Station To Transfer");
                    end;
                    HRMgt.TransferEmployee(Rec."Transfer No", Rec."Employee No");
                    HRMgt.AssignTransferAllowance(Rec."Transfer No");
                    Message(Text002);
                    CurrPage.Close;
                    Rec.Transferred := true;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        BranchVisible: Boolean;
        DepVisible: Boolean;
        BothVisible: Boolean;
        Employee: Record Employee;
        HRMgt: Codeunit "HR Management";
        Text002: Label 'Employee has been transferred Successfully';

    procedure SetControlAppearance()
    begin
        if (Rec."Transfer Type" = Rec."Transfer Type"::Branch) or (Rec."Transfer Type" = Rec."Transfer Type"::"Branch and Department") then
            BranchVisible := true
        else
            BranchVisible := false;
        if (Rec."Transfer Type" = Rec."Transfer Type"::Department) or (Rec."Transfer Type" = Rec."Transfer Type"::"Branch and Department") then
            DepVisible := true
        else
            DepVisible := false;
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
}
