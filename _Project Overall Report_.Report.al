report 50463 "Project Overall Report"
{
    Caption = 'Project Overall Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'ProjectReports.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ProjectIdentification; ProjectIdentification)
        {
            RequestFilterFields = "Project No.";

            column(TitleOfAssignment_ProjectIdentification; "Project Name")
            {
            }
            column(ContactPerson_ProjectIdentification; "Contact Person")
            {
            }
            column(Email_ProjectIdentification; Email)
            {
            }
            column(PhoneNumber_ProjectIdentification; "Phone Number")
            {
            }
            column(Abstractcode_ProjectIdentification; Abstractcode)
            {
            }
            column(AbstractContent_ProjectIdentification; AbstractContent)
            {
            }
            column(NeedContent_ProjectIdentification; NeedContent)
            {
            }
            column(PurposeContent_ProjectIdentification; PurposeContent)
            {
            }
            column(DesignActivity_ProjectIdentification; DesignActivity)
            {
            }
            column(ModeofDissemination_ProjectIdentification; "Mode of Dissemination")
            {
            }
            column(EvaluationContent_ProjectIdentification; EvaluationContent)
            {
            }
            column(SustainabilityContent_ProjectIdentification; SustainabilityContent)
            {
            }
            column(ProjectBudget_ProjectIdentification; "Project Budget")
            {
            }
            column(TitlePage; TitlePage)
            {
            }
            column(AbstractLable; AbstractLable)
            {
            }
            column(StatementLabel; StatementLabel)
            {
            }
            column(PurposeLabel; PurposeLabel)
            {
            }
            column(ProjectDesign; ProjectDesign)
            {
            }
            column(ManagementPlanLabel; ManagementPlanLabel)
            {
            }
            column(EvaluationPlanLabel; EvaluationPlanLabel)
            {
            }
            column(DisseminationPlanLabel; DisseminationPlanLabel)
            {
            }
            column(ProjectTeamLabel; ProjectTeamLabel)
            {
            }
            column(BudgetLabel; BudgetLabel)
            {
            }
            column(SustainabilityLabel; SustainabilityLabel)
            {
            }
            column(AttachmentsLabel; AttachmentsLabel)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TIME; Time)
            {
            }
            column(ProjectName_ProjectIdentification; "Project Name")
            {
            }
            column(BackgroundContext_ProjectIdentification; "Background/Context")
            {
            }
            column(Sampling_ProjectIdentification; Sampling)
            {
            }
            column(PreliminaryFindings_ProjectIdentification; "Preliminary Findings")
            {
            }
            column(LogisticsSupport_ProjectIdentification; "Logistics/Support")
            {
            }
            column(ProjectDuration_ProjectIdentification; "Project Duration")
            {
            }
            column(UserID_ProjectIdentification; "User ID")
            {
            }
            column(PreviousStatus_ProjSchedule; PreviousStatusProjSchedule)
            {
            }
            column(CurrentStatus_ProjSchedule; CurrentStatusProjSchedule)
            {
            }
            column(SchedulePerfomance_ProjSchedule; SchedulePerfProjSchedule)
            {
            }
            column(CurrentStatus_ProjBudget; CurrentStatusProjBudg)
            {
            }
            column(BudgetPerfomance_ProjBudget; SchedulePerfProjBudg)
            {
            }
            column(PreviousStatus_ProjBudget; PreviousStatusProjBudg)
            {
            }
            column(CurrentStatus_ProjectRisk; CurrentStatusProjRisk)
            {
            }
            column(PreviousStatus_ProjectRisk; PreviousStatusProjRisk)
            {
            }
            column(ProjectRisks_ProjectRisk; ProjRisks)
            {
            }
            column(AccountingPeriod_ProjectIdentification; "Period")
            {
            }
            column(ProjectNo_ProjectIdentification; "Project No.")
            {
            }
            column(ProjectStatus_ProjectIdentification; "Project Status")
            {
            }
            column(ProjectManagerName_ProjectIdentification; "Project Manager Name")
            {
            }
            column(ProjectStartDate_ProjectIdentification; "Project Start Date")
            {
            }
            column(ProjectEndDate_ProjectIdentification; "Project End Date")
            {
            }
            column(ProjectEstimatedCost_ProjectIdentification; "Project Estimated Cost")
            {
            }
            column(ProjectRelevance_ProjectIdentification; "Project Relevance")
            {
            }
            column(ProjectPerformance_ProjectIdentification; "Project Performance")
            {
            }
            column(AuditComments_ProjectIdentification; "Audit Comments")
            {
            }
            column(SubstantiveContribution_ProjectIdentification; "Substantive Contribution")
            {
            }
            dataitem(OverallProjectSummarry; OverallProjectSummarry)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(CurrentStatus_OverallProjectSummarry; "Current Status")
                {
                }
                column(PreviousStatus_OverallProjectSummarry; "Previous Status")
                {
                }
                column(OveralStatusSummary_OverallProjectSummarry; "Overal Status Summary")
                {
                }
            }
            dataitem(Accomplishments; Accomplishments)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(Accomplishments_Accomplishments; Accomplishments)
                {
                }
                column(ProjectNo_Accomplishments; "Project No.")
                {
                }
            }
            dataitem(NextSteps; NextSteps)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(Nextsteps_NextSteps; "Next steps")
                {
                }
                column(ProjectNo_NextSteps; "Project No.")
                {
                }
            }
            dataitem(KeyRisks; KeyRisks)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(KeyRisks_KeyRisks; "Key Risks")
                {
                }
                column(ProjectNo_KeyRisks; "Project No.")
                {
                }
            }
            dataitem(KeyIssuesCurrent; KeyIssuesCurrent)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(CurrentKeyIssues_KeyIssuesCurrent; "Current Key Issues")
                {
                }
                column(ProjectNo_KeyIssuesCurrent; "Project No.")
                {
                }
            }
            dataitem(ProjectTasks; "Project Tasks Mgmt")
            {
                DataItemLink = "Project No." = field("Project No.");

                column(ProjectDeliverable_ProjectTasks; ProjectDeliverable)
                {
                }
                column(DeliverableNumber_ProjectTasks; "Deliverable Number")
                {
                }
                column(ProjectTaskStartDate_ProjectTasks; ProjectTaskStartDate)
                {
                }
                column(ProjectTaskEndDate_ProjectTasks; ProjectTaskEndDate)
                {
                }
            }
            dataitem(ProjectManagementPlan; ProjectManagementPlan)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(PersonelNumber_ProjectManagementPlan; PersonelNumber)
                {
                }
                column(ProjectPersonel_ProjectManagementPlan; "Project Personel")
                {
                }
                column(ProjectResposibilities_ProjectManagementPlan; "Project Resposibilities")
                {
                }
            }
            dataitem(ProjectTeamQualification; ProjectTeamQualification)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(TeamMemberName_ProjectTeamQualification; "Team Member Name")
                {
                }
                column(EmpNo_ProjectTeamQualification; "Emp No.")
                {
                }
                column(Qualification_ProjectTeamQualification; Qualification)
                {
                }
            }
            dataitem("Document Attachment"; "Document Attachment")
            {
                DataItemLink = "No." = field("Project No.");

                column(FileName_RecordLinks; "File Name")
                {
                }
            }
            dataitem(PMWorkPlan; PMWorkPlan)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(Phase_PMWorkPlan; Phase)
                {
                }
                column(Deliverable_PMWorkPlan; Deliverable)
                {
                }
                column(ResponsiblePerson_PMWorkPlan; "Responsible Person")
                {
                }
                column(TimelineinDays_PMWorkPlan; "Timeline in Days")
                {
                }
            }
            dataitem(ProjectLines; "Project Lines")
            {
                DataItemLink = "Project No." = field("Project No.");

                column(Limitations_ProjectIdentification; Limitation)
                {
                }
                column(DataCollection_ProjectIdentification; "Data Collection Method")
                {
                }
                column(Objective_ProjectIdentification; Objective)
                {
                }
            }
            dataitem(ProjectManagementImplCommittee; ProjectManagementImplCommittee)
            {
                DataItemLink = "Project No." = field("Project No.");

                column(FullName_ProjectManagementImplCommittee; "Full Name")
                {
                }
                column(IDNumber_ProjectManagementImplCommittee; "ID Number")
                {
                }
                column(Contact_ProjectManagementImplCommittee; Contact)
                {
                }
                column(EmailAddress_ProjectManagementImplCommittee; "Email Address")
                {
                }
                column(InstitutionOrganizationName_ProjectManagementImplCommittee; "Institution/Organization Name")
                {
                }
                column(ProjectNo_ProjectManagementImplCommittee; "Project No.")
                {
                }
            }
            trigger OnafterGetRecord()
            begin
                ProjSche.Reset();
                ProjSche.SetRange("Project No.", "Project No.");
                If ProjSche.FindSet() then begin
                    repeat
                        CurrentStatusProjSchedule := ProjSche."Current Status";
                        PreviousStatusProjSchedule := ProjSche."Previous Status";
                        SchedulePerfProjSchedule := ProjSche."Schedule Perfomance";
                    until ProjSche.Next() = 0;
                end;
                ProjBudg.Reset();
                ProjBudg.SetRange("Project No.", "Project No.");
                If ProjBudg.FindSet() then begin
                    repeat
                        CurrentStatusProjBudg := ProjBudg."Current Status";
                        PreviousStatusProjBudg := ProjBudg."Previous Status";
                        SchedulePerfProjBudg := ProjBudg."Budget Perfomance";
                    until ProjSche.Next() = 0;
                end;
                ProjRisk.Reset();
                ProjRisk.SetRange("Project No.", "Project No.");
                If ProjRisk.FindSet() then begin
                    repeat
                        CurrentStatusProjRisk := Format(ProjRisk."Current Status 1");
                        PreviousStatusProjRisk := Format(ProjRisk."Previous Status 1");
                        ProjRisks := ProjRisk."Project Risks";
                    until ProjSche.Next() = 0;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        TitlePage: Label 'Title page';
        CompanyInfo: Record "Company Information";
        AbstractLable: Label 'Abstract';
        StatementLabel: Label 'Statement of need';
        PurposeLabel: Label 'Statement of purpose';
        ProjectDesign: Label 'Project design';
        ManagementPlanLabel: Label 'Management plan';
        EvaluationPlanLabel: Label 'Evaluation plan';
        DisseminationPlanLabel: Label 'Dissemination plan';
        ProjectTeamLabel: Label 'Project team - Qualifications';
        BudgetLabel: Label 'Budget';
        SustainabilityLabel: Label 'Sustainability plan';
        AttachmentsLabel: Label 'Attachments';
        ProjSche: Record ProjSchedule;
        CurrentStatusProjSchedule: Integer;
        PreviousStatusProjSchedule: Integer;
        SchedulePerfProjSchedule: Text;
        ProjBudg: Record ProjBudget;
        ProjRisk: Record ProjectRisk;
        CurrentStatusProjBudg: Integer;
        PreviousStatusProjBudg: Integer;
        SchedulePerfProjBudg: Text;
        CurrentStatusProjRisk: Text;
        PreviousStatusProjRisk: Text;
        ProjRisks: Text;
}
