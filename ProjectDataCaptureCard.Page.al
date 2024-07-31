page 51360 ProjectDataCaptureCard
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = ProjectMan;
    Caption = 'Project Data Capture';
    PromotedActionCategories = 'New,Process,Report,Approvals,Approval';
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.';
                    ApplicationArea = All;
                    Editable = FALSE;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Type of Project"; Rec."Type of Project")
                {
                    ToolTip = 'Specifies the value of the Type of Project field.';
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Project Date field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Created By"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                    Caption = 'User Id';
                    editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ToolTip = 'Specifies the value of the Client Code field.';
                    ApplicationArea = All;
                    caption = 'Project Sponsor code';
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.';
                    ApplicationArea = All;
                    Caption = 'Project Sponsor Name';
                    editable = false;
                }
                field(ProjectApprovalStatus; Rec."Project Approval Status")
                {
                    ToolTip = 'Specifies the value of the ProjectApprovalStatus field.';
                    ApplicationArea = All;
                    Editable = false;
                    style = favorable;
                }
                field(Status; Rec."Project Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                    style = favorable;
                    visible = false;
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ToolTip = 'Specifies the value of the Project Start Date field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project Duration (Days)"; Rec."Project Duration")
                {
                    ToolTip = 'Specifies the value of the Project Duration (Days) field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ToolTip = 'Specifies the value of the Project End Date field.';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Project Manager"; Rec."Project Manager code")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project Manager Name"; Rec."Project Manager Name")
                {
                    ToolTip = 'Specifies the value of the Project Manager Name field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                    ShowMandatory = true;
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    Editable = false;
                }
                field("Project Estimated Cost"; Rec."Project Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Project Estimated Cost field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Project Actual Cost"; Rec."Project Actual Cost")
                {
                    ToolTip = 'Specifies the value of the Project Actual Cost field.';
                    ApplicationArea = All;
                    Editable = false;
                    visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                }
                field(Committed; Rec.Committed)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Committed field.';
                    ApplicationArea = All;
                }
            }
            part(ImplementationCommittee; "Project Imp Commitee")
            {
                Caption = 'Project Implementation Commitee';
                SubPageLink = "Project No." = FIELD("Project No.");
                //Visible = false;
            }
            part("ProjectG/LAccounts"; "Project_G/LAccounts")
            {
                Caption = 'Project G/L Accounts';
                SubPageLink = "Project NO." = FIELD("Project No.");
                visible = false;
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("Project No.");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("project No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Control53; Links)
            {
            }
            systempart(Control52; Notes)
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Upload Document")
            {
                Caption = 'Upload Documents';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                PromotedIsBig = true;
                ToolTip = 'Upload documents for the Project.';

                trigger OnAction()
                var
                begin
                    //  FromFile := DocumentManagement.UploadDocument(Rec."Project No.", CurrPage.Caption, Rec.RecordId);
                end;
            }
            Group(Approval)
            {
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Re&quest';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    visible = Rec."Project Approval Status" = Rec."Project Approval Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Project Name");
                        Rec.TestField("project start date");
                        Rec.TestField("Project End Date");
                        //TestField("Project Estimated Cost");
                        Rec.TestField("project Manager code");
                        if Confirm('Do you want to send this Project for approval?', false) = true then begin
                            Committment.CheckProjectCommittment(Rec);
                            Committment.ProjectCommittment(Rec, ErrorMsg);
                            if ErrorMsg <> '' then Error(ErrorMsg);
                            Commit;
                            if ApprovalsMgmt.CheckProjectManagementWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendProjectreqforApproval(Rec);
                            Commit;
                            CurrPage.Close;
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    visible = Rec."Project Approval Status" = Rec."Project Approval Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Cancel the Approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    begin
                        ApprovalsMgmt.OnCancelProjectreqforApproval(Rec);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'View Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", Database::Projectman);
                        ApprovalEntry.SetRange("Document No.", Rec."Project No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action(Print)
            {
                Caption = 'Print Project Information';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("Project No.", Rec."Project No.");
                    REPORT.Run(Report::"Purchase Request", true, true, PurchReq);
                    // Report.Run(51521571);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve Request for A New Project';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = "Project Approval Status" = "Project Approval Status"::"Pending Approval";
                visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Project Approval Status", Rec."Project Approval Status"::"Pending Approval");
                    if Confirm('Are you sure you want to approve Project No. %1 ?', false, Rec."Project No.") = true then begin
                        //"Cleared For RFQ" := true;
                        Rec.Modify;
                        Commit;
                        Message('%1 has been approved Successfully', Rec."Project No.");
                    end
                    else
                        exit;
                end;
            }
            action("Reject Approved Project")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RFQVisible;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject Project %1 ?', false, Rec."Project No.") = true then begin
                        IR.Reset;
                        IR.SetRange("Project No.", Rec."Project No.");
                        if IR.FindFirst then begin
                            //Check On the Lists Below 
                            RejectApprovedPRF.SetTableView(IR);
                            RejectApprovedPRF.RunModal;
                        end;
                    end
                    else
                        exit;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."Project No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        SetPageControls;
        commit;
    end;

    trigger OnInit()
    begin
        // ShowDim := true;
        // RFQVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        SetPageControls();
        Commit;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        if (Rec."Project Approval Status" = Rec."Project Approval Status"::open) or (Rec."Project Approval status" = Rec."Project Approval Status"::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        //currpage.update();
    end;

    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PurchReq: Record Projectman;
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Within Budget';
        [InDataSet]
        ShowDim: Boolean;
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        ApprovalEnabled: Boolean;
        PaymentRec: Record Payments;
        CombineVisible: Boolean;
        ShowCommentFactbox: Boolean;
        ApprovalEntry: Record "Approval Entry";
        RFQVisible: Boolean;
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
        CommentVisible: Boolean;
        RejectApprovedPRF: Report "Reject Approved PRF";
        IR: Record Projectman;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        IsOpen: Boolean;
        IsSubmitted: Boolean;
        IsApproved: Boolean;
        IsSuspended: Boolean;
        IsFinished: Boolean;
        IsPastDueDate: Boolean;
        ProjectTeam: Record "Project Team";
        ProjectTasks: Record "Project Tasks";
        Project: Record "Project Header";
        ApprovalsMgmt1: Codeunit "Approvals Mgmt.";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        TaskError: Label 'There must be at least one milestone for contract %1 before  you send for verification.';
        TaskStatusError: Label 'Milestone %1 must be finished or suspended before sending for verification.';

    local procedure SetPageControls()
    begin
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        IsPastDueDate := false;
        case Rec."Project approval Status" of
            Rec."Project approval Status"::Open:
                IsOpen := true;
            Rec."Project approval Status"::"Pending Approval":
                IsSubmitted := true;
            Rec."Project approval Status"::Approved:
                IsApproved := true;
        // "Project approval Status"::Finished:
        //     IsFinished := true;
        // "Project approval Status"::Suspended:
        //     IsSuspended := true;
        // "Project approval Status"::"Extended Contracts":
        //     IsPastDueDate := true;
        end;
    end;

    local procedure SetPageProjectControls()
    begin
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        IsPastDueDate := false;
        case Rec."Project Status" of
            Rec."Project Status"::Open:
                IsOpen := true;
            Rec."Project Status"::"Work in Progress":
                IsSubmitted := true;
            Rec."Project Status"::"Work in Progress (Overdue)":
                IsApproved := true;
            Rec."Project Status"::Closed:
                IsFinished := true;
        // "Project Status"::Suspended:
        //     IsSuspended := true;
        // "Project Status"::"Extended Contracts":
        //     IsPastDueDate := true;
        end;
    end;
}
