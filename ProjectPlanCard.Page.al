page 51349 ProjectPlanCard
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = ProjectIdentification;
    Caption = 'Project Implementation Card';
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
                    editable = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                field(ProjectApprovalStatus; Rec."Project Approval Status")
                {
                    ToolTip = 'Specifies the value of the ProjectApprovalStatus field.';
                    ApplicationArea = All;
                    Editable = false;
                    visible = false;
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
                    editable = false;
                }
                field("Project Duration (Days)"; Rec."Project Duration")
                {
                    ToolTip = 'Specifies the value of the Project Duration (Days) field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ToolTip = 'Specifies the value of the Project End Date field.';
                    ApplicationArea = All;
                    Editable = False;
                    //editable=false;
                }
                field("Project Manager"; Rec."Project Manager name")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Project Estimated Cost"; Rec."Project Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Project Estimated Cost field.';
                    ApplicationArea = All;
                    Editable = false;
                    style = favorable;
                }
                field("Project Actual Cost"; Rec."Project Actual Cost")
                {
                    ToolTip = 'Specifies the value of the Project Actual Cost field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Accounting Period"; Rec."Accounting Period")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Accounting Period field.';
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                    ApplicationArea = All;
                }
                field("Under Implementation"; Rec."Under Implementation")
                {
                    ToolTip = 'Specifies the value of the Under Implementation field.';
                    ApplicationArea = All;
                    editable = false;
                    visible = false;
                }
                field("Under Monitoring & Evaluation"; Rec."Under Monitoring & Evaluation")
                {
                    ToolTip = 'Specifies the value of the Under Monitoring & Evaluation field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Project Account"; Rec."Project Account")
                {
                    ApplicationArea = all;
                }
            }
            part(ImplementationCommittee; "Project Imp Commitee")
            {
                Caption = 'Project Implementation Commitee';
                SubPageLink = "Project No." = FIELD("Project No.");
            }
            // Group("Project Tracking Matrix")
            // {
            //     field(Period; Rec.Period)
            //     {
            //         ToolTip = 'Specifies the value of the Period field.';
            //         ApplicationArea = All;
            //     }
            //     field("Submitted By"; Rec."Submitted By")
            //     {
            //         ToolTip = 'Specifies the value of the Submitted By field.';
            //         ApplicationArea = All;
            //     }
            //     field("Distribution List"; Rec."Distribution List")
            //     {
            //         ToolTip = 'Specifies the value of the Distribution List field.';
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            //     field("Overal Project Status"; Rec."Overal Project Status")
            //     {
            //         ToolTip = 'Specifies the value of the Overal Project Status field.';
            //         ApplicationArea = All;
            //         //MultiLine = true;
            //     }
            //     field("Overal Status Summary"; Rec."Overal Status Summary")
            //     {
            //         ToolTip = 'Specifies the value of the Overal Status Summary field.';
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            //     field(Schedule; Rec.Schedule)
            //     {
            //         ToolTip = 'Specifies the value of the Schedule field.';
            //         ApplicationArea = All;
            //     }
            //     field("Schedule Perfomance Text"; Rec."Schedule Perfomance Text")
            //     {
            //         ToolTip = 'Specifies the value of the Schedule Perfomance Text field.';
            //         ApplicationArea = All;
            //         Caption = 'Schedule Perfomance Salary';
            //         MultiLine = true;
            //     }
            //     field(Budget; Rec.Budget)
            //     {
            //         ToolTip = 'Specifies the value of the Budget field.';
            //         ApplicationArea = All;
            //         visible = false;
            //     }
            //     field("Project Budget"; Rec."Project Budget")
            //     {
            //         ToolTip = 'Specifies the value of the Project Budget field.';
            //         ApplicationArea = All;
            //     }
            //     field("Budget Perfomance"; Rec."Budget Perfomance")
            //     {
            //         ToolTip = 'Specifies the value of the Budget Perfomance field.';
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            //     field("Project Risk"; Rec."Project Risk")
            //     {
            //         ToolTip = 'Specifies the value of the Project Risk field.';
            //         ApplicationArea = All;
            //     }
            //     field("Project Risk Summary"; Rec."Project Risk Summary")
            //     {
            //         ToolTip = 'Specifies the value of the Project Risk Summary field.';
            //         ApplicationArea = All;
            //         Multiline = true;
            //     }
            //     field(AccomplishmentsSincelast; Rec.AccomplishmentsSincelast)
            //     {
            //         ToolTip = 'Specifies the value of the Accomplishment since Last Report field.';
            //         ApplicationArea = All;
            //         Multiline = true;
            //     }
            //     field(UpcomingSteps; Rec.UpcomingSteps)
            //     {
            //         ToolTip = 'Specifies the value of the UpcomingSteps field.';
            //         ApplicationArea = All;
            //         Multiline = true;
            //     }
            //     field("Key Issues"; Rec."Key Issues")
            //     {
            //         ToolTip = 'Specifies the value of the Key Issues field.';
            //         ApplicationArea = All;
            //         Caption = 'Possible Key Issues';
            //         MultiLine = true;
            //     }
            //     field("Key Issues Current"; Rec."Key Issues Current")
            //     {
            //         ToolTip = 'Specifies the value of the Key Risks Currently Affecting Project field.';
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            // }
            part("Project Task Management"; "Project Deliverable")
            {
                Caption = 'Project Task Management';
                SubPageLink = "Project NO." = FIELD("Project No.");
                UpdatePropagation = Both;
                visible = false;
            }
            part(ProjectDeliverables1; "ProjectStatus")
            {
                Caption = 'Overall Project Status';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverable2; "Schedule")
            {
                Caption = 'Schedule';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverables3; "ProjBudget")
            {
                Caption = 'Budget';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverables4; "Project Risk")
            {
                Caption = 'Project Risk';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverables5; "Accomplishments")
            {
                Caption = 'Accomplishement Since Last Project';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverable6; "Upcoming NextStep")
            {
                Caption = 'Upcoming/Next Steps';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverable7; "Key Risks")
            {
                Caption = 'Key Issues That May Affect Project';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverable8; "Current Key Issues")
            {
                Caption = 'Key Issues Currently Affecting Project';
                SubPageLink = "Project NO." = FIELD("Project No.");
            }
            part(ProjectDeliverables; "Upcoming Milestones")
            {
                Caption = 'Key Upcoming Milestones';
                SubPageLink = "Project NO." = FIELD("Project No.");
                UpdatePropagation = Both;
            }
            part("Workplan"; PMWorkPlan)
            {
                ApplicationArea = all;
                SubPageLink = "Project No." = field("Project No.");
                Editable = false;
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
            action("Monitoring & Evaluate")
            {
                Image = MapAccounts;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Monitor & Evaluate Project';
                Enabled = not Rec."Under Monitoring & Evaluation";

                trigger OnAction()
                begin
                    if Confirm('Do you want to Send this Project For Monitoring and Evaluation?', false) = true then begin
                        //"Project Status" := "project Status"::"Work in Progress";
                        Rec."Under Monitoring & Evaluation" := true;
                    end;
                    Message('Project %1 Sent For Monitoring and Evaluation Succesfuly', Rec."Project No.");
                    currpage.close();
                end;
            }
            action("Create Sales Invoice")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //Visible = "Invoice Created" = false;
                trigger OnAction()
                var
                    ProjectMgmt: Codeunit ProjectManagement;
                begin
                    if Confirm('Do you want to Create a Sales Invoice?', false) = true then begin
                        Rec.TestField("Project Account");
                        ProjectMgmt.CreateInvoicePerMilestone(Rec."Project No.");
                    end;
                    Rec."Invoice Created" := true;
                    Rec.Modify();
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
                        // Committment.CheckPurchReqCommittment(Rec);
                        // Committment.PurchReqCommittment(Rec, ErrorMsg);
                        // IF ErrorMsg <> '' THEN
                        //     ERROR(ErrorMsg);
                        // InternalRequestLine.reset;
                        // InternalRequestLine.SetRange("Document No.", "No.");
                        // InternalRequestLine.SetFilter(Type, '<>%1', InternalRequestLine.Type::"G/L Account");
                        // if InternalRequestLine.Find('-') then
                        //     repeat
                        //         InternalRequestLine.TestField(Quantity);
                        //     until InternalRequestLine.Next = 0;
                        //if ApprovalsMgmt.CheckProjectManagementWorkflowEnabled(Rec) then
                        //ApprovalsMgmt.OnSendProjectreqforApproval(Rec);
                        //Check HOD approver
                        // if UserSetup.Get(UserId) then begin
                        //     if UserSetup."HOD User" then begin
                        //         ApprovalEntry.Reset;
                        //         ApprovalEntry.SetRange("Table ID", 50126);
                        //         ApprovalEntry.SetRange("Document No.", "project No.");
                        //         ModifyHODApprovals.SetTableView(ApprovalEntry);
                        //         ModifyHODApprovals.RunModal;
                        //     end;
                        // end; 
                        Commit;
                        CurrPage.Close;
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
                Caption = 'Project Mgmt. task tracking';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProjectIdentification: Record ProjectIdentification;
                begin
                    ProjectIdentification.Reset;
                    ProjectIdentification.SetRange("Project No.", Rec."Project No.");
                    REPORT.Run(Report::"Project mgmt task tracking", true, true, ProjectIdentification);
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
            group(Action10)
            {
                Visible = false;

                action("Raise RFQ")
                {
                    Caption = 'Raise RFQ';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    end;
                }
                // action("Create RFQ")
                // {
                //     Image = MakeOrder;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = false;
                //     trigger OnAction()
                //     begin
                //         if Confirm('Are you sure you want to create an RFQ for this requisition?', false) = true then begin
                //             TestField(Status, Status::Released);
                //             ProcurementMgt.CreateRFQ(Rec);
                //         end;
                //         Commit;
                //         CurrPage.Close;
                //     end;
                // }
                action("Create LPO")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // IF CONFIRM('Are you sure you want to create an RFQ for this requisition?',FALSE)=TRUE THEN
                        //  BEGIN
                        //    TESTFIELD(Status,Status::Released);
                        //    ProcurementMgt.CreateRFQ(Rec);
                        //  END;
                        //
                        // COMMIT;
                        // CurrPage.CLOSE;
                    end;
                }
                action("Raise RFP")
                {
                    Caption = 'Raise RFP';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                            DocManager.CreateRFPRequest(Rec);
                            */
                    end;
                }
                action("Raise Tender")
                {
                    Caption = 'Raise Tender';
                    Image = DocInBrowser;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                            DocManager.CreateTenderRequest(Rec);
                            */
                    end;
                }
                action("Check Budget")
                {
                    Image = BreakRulesOff;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*BudgetControl.CheckBudgetPurchase(Rec);
                            MESSAGE(Text001);
                            */
                    end;
                }
                action("Request Over Expenditure")
                {
                    Image = BreakRulesOn;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('Complete');
                        //BudgetControl.CheckBudgetPurchase();
                    end;
                }
                // action("Reverse Committment")
                // {
                //     trigger OnAction()
                //     begin
                //         Committment.ReversePurchReqCommittment(Rec);
                //     end;
                // }
                // action("Commit Erroneous Entries")
                // {
                //     trigger OnAction()
                //     begin
                //         Committment.CheckPurchReqCommittment(Rec);
                //         Committment.PurchReqCommittment(Rec, ErrorMsg);
                //     end;
                // }
                // action(Archive)
                // {
                //     Image = Archive;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     trigger OnAction()
                //     begin
                //         if Confirm('Are you sure you want to archive this document?', false) = true then begin
                //             Status := Status::Archived;
                //             Modify;
                //         end;
                //     end;
                // }
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
        // ShowDimFields();
        // COMMIT;
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        //
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    trigger OnInit()
    begin
        ShowDim := true;
        RFQVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Document Type" := "Document Type"::Purchase;
    end;

    trigger OnOpenPage()
    begin
        //ShowDimFields();
        SetControlAppearance;
        Commit;
        /*Carol
            IF (Status=Status::Released) THEN Field supplier Enabled TRUE
            ELSE IF (Status=Status::Open); Enabled FALSE
            END
            */
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //GetDueDate();
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        if (Rec."Project Approval Status" = Rec."Project Approval Status"::open) or (Rec."Project Approval status" = Rec."Project Approval Status"::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        // if Status <> Status::Released then
        //     RFQVisible := false
        // else
        //     RFQVisible := true;
        // if "Rejection Comment" <> '' then
        //     CommentVisible := true
        // else
        //     CommentVisible := false;
    end;
    // local procedure ShowDimFields()
    // begin
    //     if "Multi-Donor" then
    //         ShowDim := false
    //     else
    //         ShowDim := true;
    //     CurrPage.Update;
    // end;
    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        PurchReq: Record Projectman;
        Text001: Label 'Within Budget';
        [InDataSet]
        ShowDim: Boolean;
        ProcurementMgt: Codeunit "Procurement Management";
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        ApprovalEnabled: Boolean;
        Text002: Label 'This document must be fully approved before making the order!!!';
        DocStatus: Option New,"HOD Approved","Finance Approved","Approval Pending",Rejected,"DED/DFA Approved",Released,Fulfilled;
        PaymentRec: Record Payments;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program","FA Disposal",Equity,Money_Market,Property,TPS,"Service Charge","Service Charge Claim";
        CombineVisible: Boolean;
        InternalRequestLine: Record "Internal Request Line";
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
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}
