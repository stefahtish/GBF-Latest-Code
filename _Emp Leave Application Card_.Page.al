page 50417 "Emp Leave Application Card"
{
    Caption = 'Employee Leave Application Card';
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Leave Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                label("Application Details")
                {
                    Caption = 'Application Details';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Application No"; Rec."Application No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Application No field';
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date of Application';
                    ToolTip = 'Specifies the value of the Date of Application field';
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                    ApplicationArea = All;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Mobile No field';
                    ApplicationArea = All;
                }
                // field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                // {
                //     Enabled = false;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                //     ApplicationArea = All;
                // }
                // field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                // {
                //     Enabled = false;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                //     ApplicationArea = All;
                // }
                field("Department Code"; Rec."Department Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Department Code field';
                    ApplicationArea = All;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Leave Period field';
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                    ToolTip = 'Specifies the value of the Leave Type field';
                    ApplicationArea = All;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Status field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Leave Reliever"; Rec."Leave Reliever")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Reliever field.', Comment = '%';
                }
                label(Balances)
                {
                    Caption = 'Balances';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Leave Entitlment field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Balance brought forward field';
                    ApplicationArea = All;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Earned to Date field';
                    ApplicationArea = All;
                }
                field(LeaveAdjustments; Rec.LeaveAdjustments)
                {
                    Caption = 'Leave Adjustments';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Leave Adjustments field';
                    ApplicationArea = All;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    Caption = 'No of Days Taken To Date';
                    Enabled = false;
                    ShowCaption = true;
                    ToolTip = 'Specifies the value of the No of Days Taken To Date field';
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Recalled Days field';
                    ApplicationArea = All;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Days Absent field';
                    ApplicationArea = All;
                }
                field("Off Days"; Rec."Off Days")
                {
                    Caption = 'Off Days';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Off Days field';
                    ApplicationArea = All;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    Caption = 'Available Leave Balance';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Available Leave Balance field';
                    ApplicationArea = All;
                }
                label("Current Application Details")
                {
                    Caption = 'Current Application Details';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Days Applied field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'From';
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the From field';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'To';
                    Enabled = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the To field';
                    ApplicationArea = All;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Enabled = false;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Resumption Date field';
                    ApplicationArea = All;
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    Caption = 'New Balance';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the New Balance field';
                    ApplicationArea = All;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duties Taken Over By field';
                    ApplicationArea = All;
                }
                field("Relieving Name"; Rec."Relieving Name")
                {
                    Caption = 'Name';
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Leave Allowance Payable field';
                    ApplicationArea = All;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    Caption = 'Approval Status';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Approval Status field';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                }
            }
            part(Control47; "Leave Relievers")
            {
                SubPageLink = "Leave Code" = FIELD("Application No");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("Application No");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Handover Notes';
                Visible = false;
                SubPageLink = "Table ID" = CONST(51519310), "No." = field("Application No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Action34)
            {
                action("Send For Reliever Approval")
                {
                    Caption = 'Send For Reliever Approval';
                    Enabled = Rec."Leave Reliever";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Leave Period");
                        Rec.TestField("Days Applied");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("Leave Code");
                        if Confirm('Do you want to Send For Reliever Approval?', false) = true then begin
                            HRMgnt.SendLeaveRelieverNotice(Rec."Application No");
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Reliever Approval")
                {
                    Caption = 'Reliever Approval';
                    //  Enabled = Rec.Status = Rec.Status::"Reliever Open";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //if not (Status in [Status::"Reliever Open"]) then exit;
                        if Confirm('Do you want to Approve?', false) = true then begin
                            // Rec.Status := Rec.Status::"Reliever Approved";
                            HRMgnt.SendLeaveNotice(Rec."Application No");
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Cancel Reliever Approval")
                {
                    Caption = 'Cancel Reliever Approval';
                    // Enabled = Rec."Status" = Rec."Status"::"Reliever Open";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Cancel Approval?', false) = true then begin
                            Rec.Status := Rec.Status::"Open";
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Send For Approval")
                {
                    Caption = 'Send Approval Request';
                    //Enabled = "Status" in ["Status"::Open, Status::"Reliever Approved"];
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Leave Period");
                        Rec.TestField("Days Applied");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("Leave Code");
                        // if Rec."Leave Reliever" then begin
                        //  if Rec.Status in [Rec.Status::"Reliever Approved"] then begin
                        if ApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendLeaveRequestApproval(Rec);
                        Commit;
                        // end else
                        //     Message('The application must first be approved by your Reliever(s)!')
                        // end
                        // else begin
                        //     if ApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Rec) then
                        //         ApprovalsMgmt.OnSendLeaveRequestApproval(Rec);
                        //     Commit;
                        // end;
                        /*
                        //MESSAGE("Employee No");
                        //Check HOD approver
                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."Employee No.","Employee No");
                        IF UserSetup.FINDFIRST THEN
                          BEGIN
                            IF UserSetup."HOD User" THEN
                              BEGIN
                                ApprovalEntry.RESET;
                                ApprovalEntry.SETRANGE("Table ID",51519310);
                                ApprovalEntry.SETRANGE("Document No.","Application No");
                                ModifyHODApprovals.SETTABLEVIEW(ApprovalEntry);
                                ModifyHODApprovals.RUNMODAL;
                              END;
                          END;
                          */
                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    //Enabled = "Status" = "Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ApprovalManagement.OnCancelLeaveRequestApproval(Rec);
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'Approvals';
                    //Enabled = "Status" = "Status"::"Pending Approval";
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
                        Approvals.SetRange("Table ID", Database::"Leave Application");
                        Approvals.SetRange("Document No.", Rec."Application No");
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action("Notify Empoyees")
            {
                Image = Holiday;

                trigger OnAction()
                begin
                    //HRMgnt.SendLeaveNotice(HRMgnt.GetEmail("Employee No"),Employee.Name,"Application No","Employee No");
                end;
            }
            action("Assign leave commutation")
            {
                Image = AssessFinanceCharges;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                PromotedIsBig = true;
                ToolTip = 'Assign leave commutation to employee.';

                trigger OnAction()
                var
                    HrMgmt: Codeunit "HR Management";
                begin
                    HrMgmt.AssignLeaveAllowance(Rec."Application No");
                    Message('Leave commutation assigned successfully');
                end;
            }
        }
        area(Navigation)
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
                    //   FromFile := DocumentManagement.UploadDocument(Rec."Application No", CurrPage.Caption, Rec.RecordId);
                end;
            }
        }
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LeaveApp.Reset;
                    LeaveApp.SetRange("Application No", Rec."Application No");
                    REPORT.Run(Report::"Leave Report", true, false, LeaveApp);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        /* 
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", "Application No");
                    if ApprovalEntry.Find('-') then begin
                        ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
                    end; */
    end;

    trigger OnAfterGetRecord()
    begin
        //RelieverEdit();
        /*CALCFIELDS("Leave balance");
            CALCFIELDS("Balance brought forward");
            "Annual Leave Entitlement Bal":="Leave balance"+"Balance brought forward";*/
    end;

    local procedure LeaveReliever(): Boolean
    begin
        Rec.Reset();
        Rec.SetRange(Status, Rec.Status::Open);
        Rec.SetRange("Leave Reliever", true);
        if Rec.FindFirst() then
            exit(true)
        else
            exit(false);
    end;
    // local procedure RelieverEdit()
    // begin
    //    // CalcFields("Reliever No.");
    //     if UserSetup.Get(UserId) then begin
    //         if not UserSetup."Show All" then begin
    //             if "User ID" = UserId then
    //                 AbleToEdit := false
    //             else
    //                 if "Reliever No." = UserSetup."Employee No." then
    //                     AbleToEdit := true
    //         end else
    //             AbleToEdit := true;
    //     end;
    // end;
    trigger OnInit()
    begin
        AbleToEdit := false;
    end;

    var
        AbleToEdit: Boolean;
        d: Date;
        Mail: Codeunit Mail;
        Body: Text[250];
        days: Decimal;
        LeaveAllowancePaid: Boolean;
        FiscalStart: Date;
        FiscalEnd: Date;
        assmatrix: Record "Assignment Matrix-X";
        AccPeriod: Record "Payroll PeriodX";
        HRSetup: Record "Human Resources Setup";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        Text19004241: Label 'Application';
        Text19009930: Label 'Balances';
        Text19042981: Label 'Current Application Details';
        Text19051012: Label 'No. Of days to Apply';
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        yes: Boolean;
        Gender: Option;
        HRMgnt: Codeunit "HR Management";
        Employee: Record Employee;
        ApprovalEntry: Record "Approval Entry";
        ShowCommentFactbox: Boolean;
        HRMagt: Codeunit "HR Management";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        LeaveApp: Record "Leave Application";
        //[RunOnClient]
        //EDDIE DocManagement: DotNet BCDocumentManagement;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}
