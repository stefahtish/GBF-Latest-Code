page 51353 ProjectClosedcard
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Projectidentification;
    Caption = 'Project Closed Card';
    PromotedActionCategories = 'New,Process,Report,Approvals,Approval';
    RefreshOnActivate = true;
    Editable = false;
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
                    //style = favorable;
                }
                field(Status; Rec."Project Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Editable = false;
                    //style = favorable;
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
                    editable = false;
                }
                field("Project Actual Cost"; Rec."Project Actual Cost")
                {
                    ToolTip = 'Specifies the value of the Project Actual Cost field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Project Closed"; Rec."Project Closed")
                {
                    ToolTip = 'Specifies the value of the Project Closed field.';
                    ApplicationArea = All;
                    editable = false;
                }
            }
            part(ImplementationCommittee; "Project Imp Commitee")
            {
                Caption = 'Project Implementation Commitee';
                SubPageLink = "Project No." = FIELD("Project No.");
                //Visible = false;
                editable = false;
            }
            Group(Evaluation)
            {
                field("Project Relevance"; Rec."Project Relevance")
                {
                    ToolTip = 'Specifies the value of the Project Relevance field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Project Performance"; Rec."Project Performance")
                {
                    ToolTip = 'Specifies the value of the Project Performance field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Substantive Contribution"; Rec."Substantive Contribution")
                {
                    ToolTip = 'Specifies the value of the Substantive Contribution field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Audit Comments"; Rec."Audit Comments")
                {
                    ToolTip = 'Specifies the value of the Audit Comments field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(ProjectDeliverables; "Project Deliverable")
            {
                Caption = 'Project Task Management';
                SubPageLink = "Project NO." = FIELD("Project No.");
                UpdatePropagation = Both;
                Visible = false;
            }
            part(ProjectSponsors; Project_Sponsor)
            {
                Caption = 'Project Sponsor';
                SubPageLink = "Project No." = FIELD("Project No.");
                Visible = false;
                editable = false;
            }
            part("ProjectG/LAccounts"; "Project_G/LAccounts")
            {
                Caption = 'Project G/L Accounts';
                SubPageLink = "Project NO." = FIELD("Project No.");
                editable = false;
                Visible = false;
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
                        // if ApprovalsMgmt.CheckProjectManagementWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnSendProjectreqforApproval(Rec);
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                    begin
                        //ApprovalsMgmt.OnCancelProjectreqforApproval(Rec);
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
                Caption = 'Project Overrall Report';
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
                    REPORT.Run(Report::"Project Overall Report", true, true, ProjectIdentification);
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
