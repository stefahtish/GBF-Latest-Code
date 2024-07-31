page 51365 ProjectIdentificationCard
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = ProjectIdentification;
    Caption = 'Project Identification Card';
    PromotedActionCategories = 'New,Process,Report,Approvals,Approval';
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

                    trigger OnValidate()
                    var
                        ProjeIdentification: Record ProjectIdentification;
                    begin
                        // if ProjeIdentification.FindFirst()
                        // then begin
                        //     error('The Project %1 Has already been Identified', ProjeIdentification."Project No.")
                        // end;
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Project Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                group("Contact Person Details")
                {
                    field("Contact Person"; Rec."Contact Person")
                    {
                        ToolTip = 'Specifies the value of the Contact Person field.';
                        ApplicationArea = All;
                    }
                    field("Project Manager Email"; Rec."Project Manager Email")
                    {
                        ToolTip = 'Specifies the value of the Contact Person Enail field.';
                        ApplicationArea = All;
                        Caption = 'Email';
                    }
                    field("Project Manager Contact"; Rec."Project Manager Contact")
                    {
                        ToolTip = 'Specifies the value of the Mobile Number field.';
                        ApplicationArea = All;
                        Caption = 'Mobile Number';
                    }
                    field("Project Manager Contact2"; Rec."Project Manager Contact2")
                    {
                        ToolTip = 'Specifies the value of the Mobile Number 2 field.';
                        ApplicationArea = All;
                        Caption = 'Mobile Number 2';
                        Visible = false;
                    }
                    field(Initiated; Rec.Initiated)
                    {
                        ToolTip = 'Specifies the value of the Initiated field.';
                        ApplicationArea = All;
                        editable = false;
                    }
                }
            }
            group("Abstract")
            {
                field(Abstractcode; Rec.Abstractcode)
                {
                    ToolTip = 'Specifies the value of the Abstractcode field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(AbstractContent; Rec.AbstractContent)
                {
                    ToolTip = 'Specifies the value of the AbstractContent field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group("Statement of Need")
            {
                field(NeedCode; Rec.NeedCode)
                {
                    ToolTip = 'Specifies the value of the NeedCode field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(NeedContent; Rec.NeedContent)
                {
                    ToolTip = 'Specifies the value of the NeedContent field.';
                    ApplicationArea = All;
                    Caption = 'Statement of Need';
                    MultiLine = true;
                }
            }
            group("Statement of Purpose")
            {
                field(PurposeCode; Rec.PurposeCode)
                {
                    ToolTip = 'Specifies the value of the PurposeCode field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(PurposeGoal; Rec.PurposeGoal)
                {
                    ToolTip = 'Specifies the value of the PurposeGoal field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(PurposeContent; Rec.PurposeContent)
                {
                    ToolTip = 'Specifies the value of the PurposeContent field.';
                    ApplicationArea = All;
                    Caption = 'Statement Of Purpose';
                    MultiLine = true;
                }
                field(PurposeOutcome; Rec.PurposeOutcome)
                {
                    ToolTip = 'Specifies the value of the PurposeOutcome field.';
                    ApplicationArea = All;
                    visible = false;
                }
            }
            group("Project Design")
            {
                field(DesignGoal; Rec.DesignGoal)
                {
                    ToolTip = 'Specifies the value of the DesignGoal field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(DesignCode; Rec.DesignCode)
                {
                    ToolTip = 'Specifies the value of the DesignCode field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(DesignContent; Rec.DesignContent)
                {
                    ToolTip = 'Specifies the value of the DesignContent field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(DesignOutcome; Rec.DesignOutcome)
                {
                    ToolTip = 'Specifies the value of the DesignOutcome field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field(DesignActivity; Rec.DesignActivity)
                {
                    ToolTip = 'Specifies the value of the DesignActivity field.';
                    ApplicationArea = All;
                    Caption = 'Project Design';
                    MultiLine = true;
                }
            }
            part(ManagementPlan; "Project Management Plan")
            {
                Caption = 'Project Management Plan';
                SubPageLink = "Project No." = FIELD("Project No.");
                visible = true;
            }
            group("Evaluation Plan")
            {
                field(EvaluationContent; Rec.EvaluationContent)
                {
                    ToolTip = 'Specifies the value of the EvaluationContent field.';
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Evaluation Plan';
                }
            }
            group("Dissemination Plan")
            {
                field("Mode of Dissemination"; Rec."Mode of Dissemination")
                {
                    ToolTip = 'Specifies the value of the Mode of Dissemination field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(ImplementationCommittee; "Project Team Qualifications")
            {
                Caption = 'Project Team Qualifications';
                SubPageLink = "Project No." = FIELD("Project No.");
                visible = true;
            }
            group("Budget")
            {
                field("Project Budget"; Rec."Project Budget")
                {
                    ToolTip = 'Specifies the value of the Project Budget field.';
                    ApplicationArea = All;
                    Caption = 'Estimated Budget';
                    Editable = false;
                }
            }
            group("Sustainability Plan")
            {
                field(SustainabilityContent; Rec.SustainabilityContent)
                {
                    ToolTip = 'Specifies the value of the SustainabilityContent field.';
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Sustainability Plan';
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
                    //   FromFile := DocumentManagement.UploadDocument(Rec."Project No.", CurrPage.Caption, Rec.RecordId);
                end;
            }
            action("Send For Initiation")
            {
                Image = ReOpen;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Project Approval Status" = Rec."Project Approval Status"::Approved;
                Enabled = not Rec.Initiated;

                trigger OnAction()
                var
                    ProjectInception: Record "Project Inception";
                begin
                    if Confirm('Do you want to send this contract for initiation?', false) = true then begin
                        Rec."Project Status" := Rec."project Status"::Open;
                        Rec.Initiated := True;
                    end;
                    CurrPage.CLOSE();
                end;
            }
            Group(Approval)
            {
                caption = 'Approval';

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Re&quest';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Project Name");
                        Rec.TestField("project start date");
                        Rec.TestField("Project End Date");
                        Rec.TestField("Project Estimated Cost");
                        Rec.TestField("project Manager name");
                        if Confirm('Do you want to send this Project for approval?', false) = true then begin
                            // if ApprovalsMgmt.CheckProjectManagementWorkflowEnabled(Rec) then
                            //     ApprovalsMgmt.OnSendProjectreqforApproval(Rec);
                            // Commit;
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
                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    // begin
                    //     ApprovalsMgmt.OnCancelProjectreqforApproval(Rec);
                    // end;
                }
                action(Approvals)
                {
                    Caption = 'View Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;
                    visible = false;

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
                Caption = 'Project Proposal Identification';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchReq: Record "ProjectIdentification";
                begin
                    PurchReq.Reset;
                    PurchReq.SetRange("Project No.", Rec."Project No.");
                    REPORT.Run(Report::"Project Identification", true, true, PurchReq);
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
