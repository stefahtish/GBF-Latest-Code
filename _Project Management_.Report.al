report 50442 "Project Management"
{
    DefaultLayout = RDLC;
    Caption = 'Project Management Reporting';
    RDLCLayout = './ProjectReports.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ProjectMan1; "ProjectMan")
        {
            RequestFilterFields = "Project No.";

            column(CompPic; CompanyInformation.Picture)
            {
            }
            column(Abstractcode_ProjectMan1; Abstractcode)
            {
            }
            column(AbstractContent_ProjectMan1; AbstractContent)
            {
            }
            column(ActualProjectDuration_ProjectMan1; "Actual Project Duration")
            {
            }
            column(ActualProjectEndDate_ProjectMan1; "Actual Project End Date")
            {
            }
            column(ActualProjectStartDate_ProjectMan1; "Actual Project Start Date")
            {
            }
            column(Amount_ProjectMan1; Amount)
            {
            }
            column(AmountDueIntheCertVAT_ProjectMan1; "Amount Due In the Cert(VAT)")
            {
            }
            column(AmountofAdvancePayment_ProjectMan1; "Amount of Advance Payment")
            {
            }
            column(AmountPaid_ProjectMan1; "Amount Paid")
            {
            }
            column(Balance_ProjectMan1; Balance)
            {
            }
            column(Client_ProjectMan1; Client)
            {
            }
            column(ClientCode_ProjectMan1; "Client Code")
            {
            }
            column(ConsultancyFee_ProjectMan1; "Consultancy Fee")
            {
            }
            column(ContactPerson_ProjectMan1; "Contact Person")
            {
            }
            column(Content_ProjectMan1; Content)
            {
            }
            column(Contigencies_ProjectMan1; Contigencies)
            {
            }
            column(ContractValue_ProjectMan1; "Contract Value")
            {
            }
            column(ContractorAddress_ProjectMan1; "Contractor Address")
            {
            }
            column(ContractorName_ProjectMan1; "Contractor Name")
            {
            }
            column(CreatedBy_ProjectMan1; "Created By")
            {
            }
            column(CutomerCode_ProjectMan1; "Cutomer Code")
            {
            }
            column(DateCreated_ProjectMan1; "Date Created")
            {
            }
            column(DateofCertificate_ProjectMan1; "Date of Certificate")
            {
            }
            column(DesignActivity_ProjectMan1; DesignActivity)
            {
            }
            column(DesignCode_ProjectMan1; DesignCode)
            {
            }
            column(DesignContent_ProjectMan1; DesignContent)
            {
            }
            column(DesignGoal_ProjectMan1; DesignGoal)
            {
            }
            column(DesignOutcome_ProjectMan1; DesignOutcome)
            {
            }
            column(Dim3_ProjectMan1; Dim3)
            {
            }
            column(Email_ProjectMan1; Email)
            {
            }
            column(EvaluationCode_ProjectMan1; EvaluationCode)
            {
            }
            column(EvaluationContent_ProjectMan1; EvaluationContent)
            {
            }
            column(Experience_ProjectMan1; Experience)
            {
            }
            column(LastModifiedBy_ProjectMan1; "Last Modified By")
            {
            }
            column(LastPaymentCertificate_ProjectMan1; "Last Payment Certificate")
            {
            }
            column(LineNo_ProjectMan1; "Line No")
            {
            }
            column(ModeofDissemination_ProjectMan1; "Mode of Dissemination")
            {
            }
            column(ModeofMarketing_ProjectMan1; "Mode of Marketing")
            {
            }
            column(NeedCode_ProjectMan1; NeedCode)
            {
            }
            column(NeedContent_ProjectMan1; NeedContent)
            {
            }
            column(NoSeries_ProjectMan1; "No. Series")
            {
            }
            column(OriginalContractPrice_ProjectMan1; "Original Contract Price")
            {
            }
            column(PhoneNumber_ProjectMan1; "Phone Number")
            {
            }
            column(PreviousGrossWorkDone_ProjectMan1; "Previous Gross Work Done")
            {
            }
            column(PreviousRetention_ProjectMan1; "Previous Retention")
            {
            }
            column(ProgressofWork_ProjectMan1; "Progress of Work")
            {
            }
            column(ProjectActualCost_ProjectMan1; "Project Actual Cost")
            {
            }
            column(ProjectApprovalStatus_ProjectMan1; "Project Approval Status")
            {
            }
            column(ProjectCode_ProjectMan1; "Project Code")
            {
            }
            column(ProjectDuration_ProjectMan1; "Project Duration")
            {
            }
            column(ProjectEndDate_ProjectMan1; "Project End Date")
            {
            }
            column(ProjectEstimatedCost_ProjectMan1; "Project Estimated Cost")
            {
            }
            column(ProjectManagerCode_ProjectMan1; "Project Manager Code")
            {
            }
            column(ProjectManagerName_ProjectMan1; "Project Manager Name")
            {
            }
            column(ProjectName_ProjectMan1; "Project Name")
            {
            }
            column(ProjectNo_ProjectMan1; "Project No.")
            {
            }
            column(ProjectStartDate_ProjectMan1; "Project Start Date")
            {
            }
            column(ProjectStatus_ProjectMan1; "Project Status")
            {
            }
            column(ProvisionalSum_ProjectMan1; "Provisional Sum")
            {
            }
            column(PurposeCode_ProjectMan1; PurposeCode)
            {
            }
            column(PurposeContent_ProjectMan1; PurposeContent)
            {
            }
            column(PurposeGoal_ProjectMan1; PurposeGoal)
            {
            }
            column(PurposeOutcome_ProjectMan1; PurposeOutcome)
            {
            }
            column(Qualification_ProjectMan1; Qualification)
            {
            }
            column(RecorgisedLiablity_ProjectMan1; "Recorgised Liablity")
            {
            }
            column(RevisedPrice_ProjectMan1; "Revised Price")
            {
            }
            column(ShortcutDimension3Code_ProjectMan1; "Shortcut Dimension 3 Code")
            {
            }
            column(SustainabilityContent_ProjectMan1; SustainabilityContent)
            {
            }
            column(SustainabiliyCode_ProjectMan1; SustainabiliyCode)
            {
            }
            column(SystemCreatedAt_ProjectMan1; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy_ProjectMan1; SystemCreatedBy)
            {
            }
            column(SystemId_ProjectMan1; SystemId)
            {
            }
            column(SystemModifiedAt_ProjectMan1; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy_ProjectMan1; SystemModifiedBy)
            {
            }
            column(TargetGroup_ProjectMan1; "Target Group")
            {
            }
            column(TeamMemberName_ProjectMan1; "Team Member Name")
            {
            }
            column(Tenderno_ProjectMan1; "Tender no.")
            {
            }
            column(TitleOfAssignment_ProjectMan1; "Title Of Assignment")
            {
            }
            column(TypeofProject_ProjectMan1; "Type of Project")
            {
            }
            column(UnitofMeasure_ProjectMan1; "Unit of Measure")
            {
            }
            column(UserID_ProjectMan1; "User ID")
            {
            }
            dataitem("Project Tasks"; "ProjectIdentification")
            {
                DataItemLink = "Project No." = FIELD("Project No.");
                RequestFilterFields = "Project No.";

                column(AbstractContent_ProjectTasks; AbstractContent)
                {
                }
                column(AccomplishmentsSincelast_ProjectTasks; AccomplishmentsSincelast)
                {
                }
                column(AuditComments_ProjectTasks; "Audit Comments")
                {
                }
                column(Abstractcode_ProjectTasks; Abstractcode)
                {
                }
                column(Amount_ProjectTasks; Amount)
                {
                }
                column(AmountDueIntheCertVAT_ProjectTasks; "Amount Due In the Cert(VAT)")
                {
                }
                column(AmountPaid_ProjectTasks; "Amount Paid")
                {
                }
                column(AmountofAdvancePayment_ProjectTasks; "Amount of Advance Payment")
                {
                }
                column(BackgroundContext_ProjectTasks; "Background/Context")
                {
                }
                column(Balance_ProjectTasks; Balance)
                {
                }
                column(Budget_ProjectTasks; Budget)
                {
                }
                column(BudgetPerfomance_ProjectTasks; "Budget Perfomance")
                {
                }
                column(Client_ProjectTasks; Client)
                {
                }
                column(ClientCode_ProjectTasks; "Client Code")
                {
                }
                column(CompletionDates_ProjectTasks; "Completion Dates")
                {
                }
                column(ConsultancyFee_ProjectTasks; "Consultancy Fee")
                {
                }
                column(ContactPerson_ProjectTasks; "Contact Person")
                {
                }
                column(Content_ProjectTasks; Content)
                {
                }
                column(Contigencies_ProjectTasks; Contigencies)
                {
                }
                column(ContractValue_ProjectTasks; "Contract Value")
                {
                }
                column(ContractorAddress_ProjectTasks; "Contractor Address")
                {
                }
                column(ContractorName_ProjectTasks; "Contractor Name")
                {
                }
                column(CreatedBy_ProjectTasks; "Created By")
                {
                }
                column(CurrentStatus_ProjectTasks; "Current Status")
                {
                }
                column(CutomerCode_ProjectTasks; "Cutomer Code")
                {
                }
                column(DataCollection_ProjectTasks; "Data Collection")
                {
                }
                column(DateCreated_ProjectTasks; "Date Created")
                {
                }
                column(DateofCertificate_ProjectTasks; "Date of Certificate")
                {
                }
                column(DesignActivity_ProjectTasks; DesignActivity)
                {
                }
                column(DesignCode_ProjectTasks; DesignCode)
                {
                }
                column(DesignContent_ProjectTasks; DesignContent)
                {
                }
                column(DesignGoal_ProjectTasks; DesignGoal)
                {
                }
                column(DesignOutcome_ProjectTasks; DesignOutcome)
                {
                }
                column(DistributionList_ProjectTasks; "Distribution List")
                {
                }
                column(Email_ProjectTasks; Email)
                {
                }
                column(EvaluationCode_ProjectTasks; EvaluationCode)
                {
                }
                column(EvaluationContent_ProjectTasks; EvaluationContent)
                {
                }
                column(Experience_ProjectTasks; Experience)
                {
                }
                column(Initiated_ProjectTasks; Initiated)
                {
                }
                column(KeyIssues_ProjectTasks; "Key Issues")
                {
                }
                column(KeyIssuesCurrent_ProjectTasks; "Key Issues Current")
                {
                }
                column(LastModifiedBy_ProjectTasks; "Last Modified By")
                {
                }
                column(LastPaymentCertificate_ProjectTasks; "Last Payment Certificate")
                {
                }
                column(Limitations_ProjectTasks; Limitations)
                {
                }
                column(LineNo_ProjectTasks; "Line No")
                {
                }
                column(LogisticsSupport_ProjectTasks; "Logistics/Support")
                {
                }
                column(ModeofDissemination_ProjectTasks; "Mode of Dissemination")
                {
                }
                column(ModeofMarketing_ProjectTasks; "Mode of Marketing")
                {
                }
                column(NeedCode_ProjectTasks; NeedCode)
                {
                }
                column(NeedContent_ProjectTasks; NeedContent)
                {
                }
                column(NoSeries_ProjectTasks; "No. Series")
                {
                }
                column(Objective_ProjectTasks; Objective)
                {
                }
                column(OriginalContractPrice_ProjectTasks; "Original Contract Price")
                {
                }
                column(OveralProjectStatus_ProjectTasks; "Overal Project Status")
                {
                }
                column(OveralStatusSummary_ProjectTasks; "Overal Status Summary")
                {
                }
                column(Period_ProjectTasks; Period)
                {
                }
                column(PhoneNumber_ProjectTasks; "Phone Number")
                {
                }
                column(PreliminaryFindings_ProjectTasks; "Preliminary Findings")
                {
                }
                column(PreviousGrossWorkDone_ProjectTasks; "Previous Gross Work Done")
                {
                }
                column(PreviousRetention_ProjectTasks; "Previous Retention")
                {
                }
                column(PreviousStatus_ProjectTasks; "Previous Status")
                {
                }
                column(ProgressofWork_ProjectTasks; "Progress of Work")
                {
                }
                column(ProjectActualCost_ProjectTasks; "Project Actual Cost")
                {
                }
                column(ProjectApprovalStatus_ProjectTasks; "Project Approval Status")
                {
                }
                column(ProjectBudget_ProjectTasks; "Project Budget")
                {
                }
                column(ProjectClosed_ProjectTasks; "Project Closed")
                {
                }
                column(ProjectCode_ProjectTasks; "Project Code")
                {
                }
                column(ProjectDuration_ProjectTasks; "Project Duration")
                {
                }
                column(ProjectEndDate_ProjectTasks; "Project End Date")
                {
                }
                column(ProjectEstimatedCost_ProjectTasks; "Project Estimated Cost")
                {
                }
                column(ProjectManagerCode_ProjectTasks; "Project Manager Code")
                {
                }
                column(ProjectManagerContact_ProjectTasks; "Project Manager Contact")
                {
                }
                column(ProjectManagerContact2_ProjectTasks; "Project Manager Contact2")
                {
                }
                column(ProjectManagerEmail_ProjectTasks; "Project Manager Email")
                {
                }
                column(ProjectManagerName_ProjectTasks; "Project Manager Name")
                {
                }
                column(ProjectName_ProjectTasks; "Project Name")
                {
                }
                column(ProjectNo_ProjectTasks; "Project No.")
                {
                }
                column(ProjectPerformance_ProjectTasks; "Project Performance")
                {
                }
                column(ProjectRelevance_ProjectTasks; "Project Relevance")
                {
                }
                column(ProjectRisk_ProjectTasks; "Project Risk")
                {
                }
                column(ProjectRiskSummary_ProjectTasks; "Project Risk Summary")
                {
                }
                column(ProjectStartDate_ProjectTasks; "Project Start Date")
                {
                }
                column(ProjectStatus_ProjectTasks; "Project Status")
                {
                }
                column(ProjectUnderReview_ProjectTasks; "Project Under Review")
                {
                }
                column(ProvisionalSum_ProjectTasks; "Provisional Sum")
                {
                }
                column(PurposeCode_ProjectTasks; PurposeCode)
                {
                }
                column(PurposeContent_ProjectTasks; PurposeContent)
                {
                }
                column(PurposeGoal_ProjectTasks; PurposeGoal)
                {
                }
                column(PurposeOutcome_ProjectTasks; PurposeOutcome)
                {
                }
                column(Qualification_ProjectTasks; Qualification)
                {
                }
                column(RecorgisedLiablity_ProjectTasks; "Recorgised Liablity")
                {
                }
                column(RevisedPrice_ProjectTasks; "Revised Price")
                {
                }
                column(Sampling_ProjectTasks; Sampling)
                {
                }
                column(Schedule_ProjectTasks; Schedule)
                {
                }
                column(SchedulePerfomanceText_ProjectTasks; "Schedule Perfomance Text")
                {
                }
                column(SubmittedBy_ProjectTasks; "Submitted By")
                {
                }
                column(SubstantiveContribution_ProjectTasks; "Substantive Contribution")
                {
                }
                column(SustainabilityContent_ProjectTasks; SustainabilityContent)
                {
                }
                column(SustainabiliyCode_ProjectTasks; SustainabiliyCode)
                {
                }
                column(SystemCreatedAt_ProjectTasks; SystemCreatedAt)
                {
                }
                column(SystemCreatedBy_ProjectTasks; SystemCreatedBy)
                {
                }
                column(SystemId_ProjectTasks; SystemId)
                {
                }
                column(SystemModifiedAt_ProjectTasks; SystemModifiedAt)
                {
                }
                column(SystemModifiedBy_ProjectTasks; SystemModifiedBy)
                {
                }
                column(TargetGroup_ProjectTasks; "Target Group")
                {
                }
                column(TeamMemberName_ProjectTasks; "Team Member Name")
                {
                }
                column(Tenderno_ProjectTasks; "Tender no.")
                {
                }
                column(TitleOfAssignment_ProjectTasks; "Title Of Assignment")
                {
                }
                column(TypeofProject_ProjectTasks; "Type of Project")
                {
                }
                column(UnderImplementation_ProjectTasks; "Under Implementation")
                {
                }
                column(UnderMonitoringEvaluation_ProjectTasks; "Under Monitoring & Evaluation")
                {
                }
                column(UnitofMeasure_ProjectTasks; "Unit of Measure")
                {
                }
                column(UpcomingMileStones_ProjectTasks; "Upcoming MileStones")
                {
                }
                column(UpcomingSteps_ProjectTasks; UpcomingSteps)
                {
                }
                column(userid_ProjectTasks; userid)
                {
                }
                column(FullName; FullName)
                {
                }
                dataitem("Project Task Components"; "Project Task Components")
                {
                    // DataItemLink = "Project No" = FIELD("Project No"), "Task No" = FIELD("Task No");
                    // column(ProgressLevel_ProjectTaskComponents; "Project Task Components"."Progress Level")
                    // {
                    // }
                }
                trigger OnAfterGetRecord()
                begin
                    ProjectRecord.Reset;
                    ProjectRecord.SetRange("Project No.", "ProjectRecord"."Project No.");
                    if ProjectRecord.FindFirst then FullName := ProjectRecord."Project Manager Name";
                end;
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                if StartDate <> 0D then Projectman.SetFilter("Actual Project Start Date", '>=%1', StartDate);
                if EndDate <> 0D then Projectman.SetFilter("Actual Project End Date", '<=%1', EndDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var //ProjectTeam: Record "Project Team";
        FullName: Text[70];
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        Projectman: Record projectman;
        ProjectRecord: Record ProjectIdentification;
}
