page 50788 "Emp Leave Application Card Mod"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date of Application';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Editable = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                label(Balances)
                {
                    Caption = 'Balances';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    Editable = false;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field(LeaveAdjustments; Rec.LeaveAdjustments)
                {
                    Caption = 'Leave Adjustments';
                    Editable = false;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    Caption = 'No of Days Taken To Date';
                    Editable = false;
                    ShowCaption = true;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Editable = false;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    Editable = false;
                }
                field("Off Days"; Rec."Off Days")
                {
                    Caption = 'Off Days';
                    Editable = false;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    Caption = 'Available Leave Balance';
                    Editable = false;
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

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'From';
                    NotBlank = true;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'To';
                    Editable = false;
                    NotBlank = true;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = false;
                    NotBlank = true;
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    Caption = 'Leave Balance';
                    Editable = false;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    Visible = false;
                }
                field("Relieving Name"; Rec."Relieving Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    Visible = false;
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    Visible = true;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    Caption = 'Approval Status';
                    Editable = false;
                }
            }
            part(Control3; "Leave Relievers")
            {
                SubPageLink = "Leave Code" = FIELD("Application No");
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("Application No");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Action34)
            {
                action("Send For Approval")
                {
                    Caption = 'Send Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*IF ApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendLeaveRequestApproval(Rec);*/
                        Commit;
                        Message(Rec."Employee No");
                        //Check HOD approver
                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."Employee No.", Rec."Employee No");
                        if UserSetup.FindFirst then begin
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset;
                                ApprovalEntry.SetRange("Table ID", 51519310);
                                ApprovalEntry.SetRange("Document No.", Rec."Application No");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal;
                            end;
                        end;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //ApprovalManagement.OnCancelLeaveRequestApproval(Rec);
                    end;
                }
                action(ViewApprovals)
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
                        ApprovalEntry.SetRange("Document No.", Rec."Application No");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.Run;
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
        }
        area(creation)
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
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."Application No");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    var
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text19004241: Label 'Application';
        Text19009930: Label 'Balances';
        Text19042981: Label 'Current Application Details';
        Text19051012: Label 'No. Of days to Apply';
        ApprovalManagement: Codeunit "Approvals Mgmt.";
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
}
