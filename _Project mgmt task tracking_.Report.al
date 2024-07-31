report 50448 "Project mgmt task tracking"
{
    ApplicationArea = All;
    Caption = 'Project mgmt task tracking';
    DefaultLayout = RDLC;
    RDLCLayout = 'Project Implementation.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ProjectIdentification; ProjectIdentification)
        {
            column(ProjectDuration_ProjectIdentification; "Project Duration")
            {
            }
            column(UserID_ProjectIdentification; "User ID")
            {
            }
            column(TitleOfAssignment_ProjectIdentification; "Project Name")
            {
            }
            column(CurrentStatus_ProjSchedule; CurrentStatusProjSchedule)
            {
            }
            column(PreviousStatus_ProjSchedule; PreviousStatusProjSchedule)
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
            dataitem(OverallProjectSummarry; OverallProjectSummarry)
            {
                DataItemLink = "Project No."=field("Project No.");

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
                DataItemLink = "Project No."=field("Project No.");

                column(Accomplishments_Accomplishments; Accomplishments)
                {
                }
                column(ProjectNo_Accomplishments; "Project No.")
                {
                }
            }
            dataitem(NextSteps; NextSteps)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(Nextsteps_NextSteps; "Next steps")
                {
                }
                column(ProjectNo_NextSteps; "Project No.")
                {
                }
            }
            dataitem(KeyRisks; KeyRisks)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(KeyRisks_KeyRisks; "Key Risks")
                {
                }
                column(ProjectNo_KeyRisks; "Project No.")
                {
                }
            }
            dataitem(KeyIssuesCurrent; KeyIssuesCurrent)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(CurrentKeyIssues_KeyIssuesCurrent; "Current Key Issues")
                {
                }
                column(ProjectNo_KeyIssuesCurrent; "Project No.")
                {
                }
            }
            dataitem(ProjectTasks; "Project Tasks Mgmt")
            {
                DataItemLink = "Project No."=field("Project No.");

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
            trigger OnafterGetRecord()
            begin
                ProjSche.Reset();
                ProjSche.SetRange("Project No.", "Project No.");
                If ProjSche.FindSet()then begin
                    repeat CurrentStatusProjSchedule:=ProjSche."Current Status";
                        PreviousStatusProjSchedule:=ProjSche."Previous Status";
                        SchedulePerfProjSchedule:=ProjSche."Schedule Perfomance";
                    until ProjSche.Next() = 0;
                end;
                ProjBudg.Reset();
                ProjBudg.SetRange("Project No.", "Project No.");
                If ProjBudg.FindSet()then begin
                    repeat CurrentStatusProjBudg:=ProjBudg."Current Status";
                        PreviousStatusProjBudg:=ProjBudg."Previous Status";
                        SchedulePerfProjBudg:=ProjBudg."Budget Perfomance";
                    until ProjSche.Next() = 0;
                end;
                ProjRisk.Reset();
                ProjRisk.SetRange("Project No.", "Project No.");
                If ProjRisk.FindSet()then begin
                    repeat CurrentStatusProjRisk:=Format(ProjRisk."Current Status 1");
                        PreviousStatusProjRisk:=Format(ProjRisk."Previous Status 1");
                        ProjRisks:=ProjRisk."Project Risks";
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
    var CompanyInfo: Record "Company Information";
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
