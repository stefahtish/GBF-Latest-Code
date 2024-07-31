report 50206 "Employee Objectives - New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeObjectivesNew.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Appraisal; "Employee Appraisal")
        {
            CalcFields = "Responsibilty Center";

            column(AppraisalNo_Appraisal; Appraisal."Appraisal No")
            {
            }
            column(EmployeeNo_Appraisal; Appraisal."Employee No")
            {
            }
            column(AppraisalType_Appraisal; Appraisal."AppraisalType")
            {
            }
            column(AppraisalPeriod_Appraisal; Appraisal."Appraisal Period")
            {
            }
            column(JobID_Appraisal; Appraisal."Job ID")
            {
            }
            column(AppraiserNo_Appraisal; Appraisal."Appraiser No")
            {
            }
            column(AppraisersName_Appraisal; Appraisal."Appraisers Name")
            {
            }
            column(AppraiseeID_Appraisal; Appraisal."Appraisee ID")
            {
            }
            column(AppraiserID_Appraisal; Appraisal."Appraiser ID")
            {
            }
            column(AppraiseeName_Appraisal; Appraisal."Appraisee Name")
            {
            }
            column(JobGroup_Appraisal; Appraisal."Job Group")
            {
            }
            column(AppraisersJobTitle_Appraisal; Appraisal."Appraiser's Job Title")
            {
            }
            column(AppraiseesJobTitle_Appraisal; Appraisal."Appraisee's Job Title")
            {
            }
            column(DepartmentCode_Appraisal; Appraisal."Department Code")
            {
            }
            column(PeriodStart_Appraisal; Appraisal."Period Start")
            {
            }
            column(PeriodEnd_Appraisal; Appraisal."Period End")
            {
            }
            column(UserDept; Appraisal."Responsibilty Center")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            column(OtherNames; Employee."First Name" + ' ' + Employee."Middle Name")
            {
            }
            column(Surname; Employee."Last Name")
            {
            }
            column(EmployementDate; Employee."Date Of Join")
            {
            }
            column(JobGroup; Employee."Salary Scale")
            {
            }
            dataitem(Goals; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = FIELD("Appraisal No");

                column(EmployeeNo_Goals; Goals."Employee No")
                {
                }
                column(KeyResponsibility_Goals; Goals."Key Responsibility")
                {
                }
                column(Description_Goals; Goals.Description)
                {
                }
                column(No_Goals; Goals."No.")
                {
                }
                column(KeyIndicators_Goals; Goals."Key Indicators")
                {
                }
                column(KPI_Goals; Goals.KPI)
                {
                }
                column(Weighting_Goals; Goals.Weighting)
                {
                }
                column(ResultsAchievedComments_Goals; Goals."Results Achieved Comments")
                {
                }
                column(ScorePoints_Goals; Goals."Score/Points")
                {
                }
                column(MidYearAppraisal_Goals; Goals."Mid-Year Appraisal")
                {
                }
                column(FinalSelfAppraisal_Goals; Goals."Final Self-Appraisal")
                {
                }
                column(AppraisalLineType_Goals; Goals."Appraisal Line Type")
                {
                }
                column(AgreedTargetDate_Goals; Goals."Agreed Target Date")
                {
                }
                column(Indentation_Goals; Goals.Indentation)
                {
                }
                column(LineTypeGoals; Goals."Appraisal Line Type")
                {
                }
                trigger OnPreDataItem()
                begin
                    Goals.SetFilter(Goals."Appraisal Line Type", '<>%1&<>%2', Goals."Appraisal Line Type"::"Objective Heading End", Goals."Appraisal Line Type"::"Sub-Heading End");
                end;
            }
            dataitem("GoalsJD"; "Appraisal Lines-JD")
            {
                DataItemLink = "Appraisal No" = FIELD("Appraisal No");

                column(EmployeeNo_GoalsJD; GoalsJD."Employee No")
                {
                }
                column(KeyResponsibility_GoalsJD; GoalsJD."Key Responsibility")
                {
                }
                column(No_GoalsJD; GoalsJD."No.")
                {
                }
                column(Weighting_GoalsJD; GoalsJD.Weighting)
                {
                }
                column(ScorePoints_GoalsJD; GoalsJD."Score/Points")
                {
                }
                column(FinalSelfAppraisal_GoalsJD; GoalsJD."Final Self-Appraisal")
                {
                }
                column(AppraisalLineType_GoalsJD; GoalsJD."Appraisal Line Type")
                {
                }
                column(AgreedTargetDate_GoalsJD; GoalsJD."Agreed Target Date")
                {
                }
                column(Indentation_GoalsJD; GoalsJD.Indentation)
                {
                }
                column(LineTypeGoalsJD; GoalsJD."Appraisal Line Type")
                {
                }
                trigger OnPreDataItem()
                begin
                    GoalsJD.SetFilter(GoalsJD."Appraisal Line Type", '<>%1&<>%2', GoalsJD."Appraisal Line Type"::"Objective Heading End", GoalsJD."Appraisal Line Type"::"Sub-Heading End");
                end;
            }
            dataitem(Comments; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = FIELD("Appraisal No");

                column(AppraisalNo_Comments; Comments."Appraisal No.")
                {
                }
                column(Person_Comments; Comments.Person)
                {
                }
                column(PerformanceRelatedDicussions_Comments; Comments."Performance Related Dicussions")
                {
                }
                column(ExtentofDiscussionHelp_Comments; Comments."Extent of Discussion Help")
                {
                }
                column(CommentsonPerformance_Comments; Comments."Comments on Performance")
                {
                }
                column(CommentsOnSupervisor_Comments; Comments."Comments On Supervisor")
                {
                }
                column(CommentsbySecondSuprvisor_Comments; Comments."Comments by Second Suprvisor")
                {
                }
                column(Date_Comments; Comments.Date)
                {
                }
            }
            dataitem("Training Request"; "Training Request")
            {
                DataItemLink = "Employee No" = FIELD("Employee No");
                DataItemTableView = WHERE(Status = FILTER(Released));

                column(EmployeeNo_TrainingRequest; "Training Request"."Employee No")
                {
                }
                column(Description_TrainingRequest; "Training Request".Description)
                {
                }
                trigger OnPreDataItem()
                begin
                    "Training Request".SetFilter("Planned Start Date", '>=%1', Appraisal."Period Start");
                    "Training Request".SetFilter("Planned End Date", '<=%1', Appraisal."Period End");
                end;
            }
            dataitem("Employee Qualification"; "Employee Qualification")
            {
                DataItemLink = "Employee No." = FIELD("Employee No");

                column(EmployeeNo_EmployeeQualification; "Employee Qualification"."Employee No.")
                {
                }
                column(QualificationCode_EmployeeQualification; "Employee Qualification"."Qualification Code")
                {
                }
                column(FromDate_EmployeeQualification; "Employee Qualification"."From Date")
                {
                }
                column(ToDate_EmployeeQualification; "Employee Qualification"."To Date")
                {
                }
                column(Description_EmployeeQualification; "Employee Qualification".Description)
                {
                }
                column(QualificationType_EmployeeQualification; "Employee Qualification"."Qualification Type")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Employee.Get(Appraisal."Employee No") then;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Employee: Record Employee;
        UserSetup: Record "User Setup";
}
