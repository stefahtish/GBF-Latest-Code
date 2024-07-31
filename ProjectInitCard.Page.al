page 51342 ProjectInitCard
{
    DeleteAllowed = false;
    PageType = Card;
    // SourceTable = ProjectMan;
    SourceTable = ProjectIdentification;
    Caption = 'Project Initiation Card';
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
                    editable = false;
                }
                field("Cutomer Code"; Rec."Cutomer Code")
                {
                    ToolTip = 'Specifies the value of the Client Code field.';
                    ApplicationArea = All;
                    editable = false;
                    Caption = 'ProjectSponsor Code';
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.';
                    ApplicationArea = All;
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
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ToolTip = 'Specifies the value of the Project Start Date field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    editable = false;
                }
                field("Project Duration (Days)"; Rec."Project Duration")
                {
                    ToolTip = 'Specifies the value of the Project Duration (Days) field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    editable = false;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ToolTip = 'Specifies the value of the Project End Date field.';
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Project Manager"; Rec."Project Manager name")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    editable = false;
                }
                field("Project Estimated Cost"; Rec."Project Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Project Estimated Cost field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    editable = false;
                }
                field("Project Actual Cost"; Rec."Project Actual Cost")
                {
                    ToolTip = 'Specifies the value of the Project Actual Cost field.';
                    ApplicationArea = All;
                    editable = false;
                    Visible = false;
                }
                field("Under Implemetation"; Rec."Under Implementation")
                {
                    ToolTip = 'Specifies the value of the Under Implemetation field.';
                    ApplicationArea = All;
                    editable = false;
                }
            }
            Group(Introduction)
            {
                field("Background/Context"; Rec."Background/Context")
                {
                    ToolTip = 'Specifies the value of the Background/Context field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Objective; Rec.Objective)
                {
                    ToolTip = 'Specifies the value of the Objective field.';
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = false;
                }
            }
            part("Project Objectives"; "Project Objectives Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Project No." = field("Project No.");
            }
            part("Data collection Method"; "Project Data Collection")
            {
                ApplicationArea = all;
                SubPageLink = "Project No." = field("Project No.");
            }
            Group(Methodology)
            {
                field("Data Collection"; Rec."Data Collection")
                {
                    ToolTip = 'Specifies the value of the Data Collection field.';
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = false;
                }
                field(Sampling; Rec.Sampling)
                {
                    ToolTip = 'Specifies the value of the Sampling field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Limitations; Rec.Limitations)
                {
                    ToolTip = 'Specifies the value of the Limitations field.';
                    ApplicationArea = All;
                    MultiLine = true;
                    Visible = false;
                }
            }
            part("Limitation"; "Project Limitations")
            {
                ApplicationArea = all;
                SubPageLink = "Project No." = field("Project No.");
            }
            Group("Preliminary Findings")
            {
                Visible = false;

                field("Preliminary Findings1"; Rec."Preliminary Findings")
                {
                    ToolTip = 'Specifies the value of the Preliminary Findings field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(ManagementPlan; "Pmworkplan")
            {
                SubPageLink = "Project No." = FIELD("Project No.");
                visible = true;
            }
            // Group("Work Plan")
            // {
            // }
            Group("Logistics And Support")
            {
                field("Logistics/Support"; Rec."Logistics/Support")
                {
                    ToolTip = 'Specifies the value of the Logistics/Support field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
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
            action("Project Initiation")
            {
                Image = Start;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;
                Enabled = not Rec."Under Implementation";
                Caption = 'Start Implementation';

                trigger OnAction()
                begin
                    if Confirm('Do you want to Begin Implementing This Project?', false) = true then begin
                        Rec."Project Status" := Rec."project Status"::"Work in Progress";
                        Rec."Under Implementation" := true;
                    end;
                end;
            }
            Group(Approval)
            {
                caption = 'Approval';
                visible = false;

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Re&quest';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Project Name");
                        Rec.TestField("project start date");
                        Rec.TestField("Project End Date");
                        Rec.TestField("Project Estimated Cost");
                        Rec.TestField("project Manager name");
                        if Confirm('Do you want to send this Project for approval?', false) = true then begin
                            // if ApprovalsMgmt.CheckProjectManagementWorkflowEnabled(Rec) then
                            // ApprovalsMgmt.OnSendProjectreqforApproval(Rec);
                            Commit;
                            CurrPage.Close;
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Cancel the Approval request.';
                    visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    begin
                        // ApprovalsMgmt.OnCancelProjectreqforApproval(Rec);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'View Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;
                    Visible = false;

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
                Caption = 'Project Inception Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchReq: Record ProjectIdentification;
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("Project No.", Rec."Project No.");
                    REPORT.Run(Report::"Project Inception", true, true, PurchReq);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve Request for A New Project';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Project Approval Status" = Rec."Project Approval Status"::"Pending Approval";

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
            //ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
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
        ShowDim := true;
        RFQVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
        SetPageControls;
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
