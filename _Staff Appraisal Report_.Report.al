report 50465 "Staff Appraisal Report"
{
    ApplicationArea = All;
    Caption = 'Staff Appraisal Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    //WordLayout = 'Staff Appraisal Report.docx';
    RDLCLayout = './Reports/StaffAppraisalReport.rdl';

    dataset
    {
        dataitem(EmployeeAppraisal; "Employee Appraisal")
        {
            RequestFilterFields = "Appraisal No";

            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(Title; Title)
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(PreparedBy; GetApproverName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetApproverName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetApproverName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetApproverName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(Approved5; GetApproverName(Approver[5]))
            {
            }
            column(DateApproved5; ApproverDate[5])
            {
            }
            column(Approver5_Signature; UserSetup3.Signature)
            {
            }
            column(AppraisalNo_EmployeeAppraisal; "Appraisal No")
            {
            }
            column(EmployeeNo_EmployeeAppraisal; "Employee No")
            {
            }
            column(JobGroup_EmployeeAppraisal; "Job Group")
            {
            }
            column(AppraisalPeriod_EmployeeAppraisal; "Appraisal Period")
            {
            }
            column(AppraisalTypeDescription_EmployeeAppraisal; "Appraisal Type Description")
            {
            }
            column(AppraisalType_EmployeeAppraisal; AppraisalType)
            {
            }
            column(AppraiseeID_EmployeeAppraisal; "Appraisee ID")
            {
            }
            column(AppraiseesJobTitle_EmployeeAppraisal; "Appraisee's Job Title")
            {
            }
            column(AgreementWithRating_EmployeeAppraisal; "Agreement With Rating")
            {
            }
            column(AppraiserID_EmployeeAppraisal; "Appraiser ID")
            {
            }
            column(AppraiserNo_EmployeeAppraisal; "Appraiser No")
            {
            }
            column(AppraisersJobTitle_EmployeeAppraisal; "Appraiser's Job Title")
            {
            }
            column(JobID_EmployeeAppraisal; "Job ID")
            {
            }
            column(Manager_EmployeeAppraisal; Manager)
            {
            }
            column(PeriodEnd_EmployeeAppraisal; format("Period End", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PeriodStart_EmployeeAppraisal; format("Period Start", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(ShortcutDimension2Code_EmployeeAppraisal; "Shortcut Dimension 2 Code")
            {
            }
            column(TargetScore_EmployeeAppraisal; "Target Score")
            {
            }
            column(TargetNo_EmployeeAppraisal; "Target No")
            {
            }
            column(AppraiseeName_EmployeeAppraisal; "Appraisee Name")
            {
            }
            column(UserID; UserId)
            {
            }
            column(Directorate; Directorate)
            {
            }
            column(Division_Section; "Division/Section")
            {
            }
            column(Current_Grade_Of_Supervisee; "Current Grade Of Supervisee")
            {
            }
            column(Date_Of_Current_Designation; format("Date Of Current Designation", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Terms_Of_Service; "Terms Of Service")
            {
            }
            column(Acting_Appointments; "Acting Appointments")
            {
            }
            column(Appraisers_Name; "Appraisers Name")
            {
            }
            column(ManagerialCompetencies_EmployeeAppraisal; "Managerial Competencies")
            {
            }
            column(CoreValues_EmployeeAppraisal; "Core Values")
            {
            }
            //  column(PerformanceTargetScore_EmployeeAppraisal; "Performance Target Score")
            // {
            // }
            // column(AdditionalAssignment_EmployeeAppraisal; "Additional Assignment")
            // {
            // }
            dataitem("Target Setup Lines"; "Target Setup Lines")
            {
                DataItemLink = "Target No" = field("Target No");
                DataItemTableView = SORTING("SNo.");

                column(SNo_TargetSetupLines; "SNo.")
                {
                }
                column(Description_TargetSetupLines; Description)
                {
                }
                column(MaxScore_TargetSetupLines; "Max Score")
                {
                }
                column(ModeratedScore_TargetSetupLines; "Moderated Score")
                {
                }
                column(TotalTargetScore; TotalTargetScore)
                {
                }
                dataitem("Performance Indicators"; "Strategic Imp Initiatives")
                {
                    DataItemLink = "Target No." = field("Target No"), ObjectiveCode = field("SNo.");

                    column(SNo_PerformanceIndicators; "SNo.")
                    {
                    }
                    column(Initiatives_PerformanceIndicators; Initiatives)
                    {
                    }
                    column(ObjectiveCode_PerformanceIndicators; ObjectiveCode)
                    {
                    }
                    column(SelfRating_PerformanceIndicators; "Self Rating")
                    {
                    }
                    column(PerformanceAppraisalScore_PerformanceIndicators; "Performance Appraisal Score")
                    {
                    }
                    column(ModeratedScore_PerformanceIndicators; "Moderated Score")
                    {
                    }
                    column(Remarks_PerformanceIndicators; Remarks)
                    {
                    }
                    column(Timelines_PerformanceIndicators; Timelines)
                    {
                    }
                    column(Date_PerformanceIndicators; "Date")
                    {
                    }
                }
                trigger OnAfterGetRecord()
                var
                    PerformanceIndicators: Record "Strategic Imp Initiatives";
                begin
                    TotalTargetScore := 0;
                    PerformanceIndicators.SetRange("Target No.", "Target No");
                    //PerformanceIndicators.SetRange(ObjectiveCode, "SNo.");
                    if PerformanceIndicators.FindSet then begin
                        repeat
                            TotalTargetScore += PerformanceIndicators."Moderated Score";
                        until PerformanceIndicators.Next() = 0;
                    end;
                end;
            }
            dataitem("Appraisee Additional Assign."; "Appraisee Additional Assign.")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(AppraisalNo_AppraiseeAdditionalAssign; "Appraisal No")
                {
                }
                column(AchievedResults_AppraiseeAdditionalAssign; "Achieved Results")
                {
                }
                column(AgreedPerformanceTarget_AppraiseeAdditionalAssign; "Agreed Performance Target")
                {
                }
                column(Adhoc_AppraiseeAdditionalAssign; Adhoc)
                {
                }
                column(ModeratedScore_AppraiseeAdditionalAssign; "Moderated Score")
                {
                }
                column(PerformanceAppraisalScore_AppraiseeAdditionalAssign; "Performance Appraisal Score")
                {
                }
                column(PerformanceIndicator_AppraiseeAdditionalAssign; "Performance Indicator")
                {
                }
                column(RatingsOfLevel_AppraiseeAdditionalAssign; "Ratings Of % Level")
                {
                }
                column(DateAssigned_AppraiseeAdditionalAssign; format("Date Assigned", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(DateOfCompletion_AppraiseeAdditionalAssign; format("Date Of Completion", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(AssignedBy_AppraiseeAdditionalAssign; "Assigned By")
                {
                }
                column(Assignment_AppraiseeAdditionalAssign; Assignment)
                {
                }
                column(Evidence_AppraiseeAdditionalAssign; Evidence)
                {
                }
                column(ImplementationStatus_AppraiseeAdditionalAssign; "Implementation Status")
                {
                }
                column(No_AppraiseeAdditionalAssign; "No.")
                {
                }
                column(Remarks_AppraiseeAdditionalAssign; Remarks)
                {
                }
            }
            dataitem("Appraisal Competences"; "Appraisal Competences")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Core Value/Competence" = filter("Core Values/Competences"));

                column(SNo_AppraisalCompetences; "SNo.")
                {
                }
                column(CoreValuesComptences; "Core Value/Competence")
                {
                }
                column(Comments_CoreValuesComptences; Comments)
                {
                }
                column(Description_CoreValuesComptences; Description)
                {
                }
                column(DoesnotDemonstrate_AppraisalCompetences; "Does not Demonstrate")
                {
                }
                column(Demonstrates_AppraisalCompetences; Demonstrates)
                {
                }
                column(FairlyDemonstrates_AppraisalCompetences; "Fairly Demonstrates")
                {
                }
                column(SelfRating_AppraisalCompetences; "Self Rating")
                {
                }
                column(Score_CoreValuesComptences; Score)
                {
                }
            }
            dataitem("Managerial Appraisal Competences"; "Appraisal Competences")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Core Value/Competence" = filter("Core Managerial Values/Competence"));

                column(Mg_SNo_AppraisalCompetences; "SNo.")
                {
                }
                column(Mg_CoreValuesComptences; "Core Value/Competence")
                {
                }
                column(Mg_Comments_CoreValuesComptences; Comments)
                {
                }
                column(Mg_Description_CoreValuesComptences; Description)
                {
                }
                column(Mg_DoesnotDemonstrate_AppraisalCompetences; "Does not Demonstrate")
                {
                }
                column(Mg_Demonstrates_AppraisalCompetences; Demonstrates)
                {
                }
                column(Mg_FairlyDemonstrates_AppraisalCompetences; "Fairly Demonstrates")
                {
                }
                column(Mg_SelfRating_AppraisalCompetences; "Self Rating")
                {
                }
                column(Mg_Score_CoreValuesComptences; Score)
                {
                }
            }
            dataitem("Appraisal Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");

                column(AnnualIncrement_AppraisalComments; "Annual Increment")
                {
                }
                column(Recognition_AppraisalComments; Recognition)
                {
                }
                column(PromotionalPotential_AppraisalComments; "Promotional Potential")
                {
                }
                column(TotalRating_AppraisalComments; "Total Rating")
                {
                }
                column(AppraisalNo_AppraisalComments; "Appraisal No.")
                {
                }
                column(AppraisalReportComment_AppraisalComments; "Appraisal Report Comment")
                {
                }
                column(AverageRating_AppraisalComments; "Average Rating")
                {
                }
                column(CommentType_AppraisalComments; "Comment Type")
                {
                }
                column(CommentsOnSupervisor_AppraisalComments; "Comments On Supervisor")
                {
                }
                column(CommentsbySecondSuprvisor_AppraisalComments; "Comments by Second Suprvisor")
                {
                }
                column(CommentsonPerformance_AppraisalComments; "Comments on Performance")
                {
                }
                column(Date_AppraisalComments; format("Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(EndYearRating_AppraisalComments; "End Year Rating")
                {
                }
                column(MeritIncrement_AppraisalComments; "Merit Increment")
                {
                }
                column(PerformanceRelatedDicussions_AppraisalComments; "Performance Related Dicussions")
                {
                }
                column(PerformanceRewardComments_AppraisalComments; "Performance Reward Comments")
                {
                }
                column(PerformanceRewardDecision_AppraisalComments; "Performance Reward Decision")
                {
                }
                column(Person_AppraisalComments; Person)
                {
                }
            }
            dataitem("Appraisal Lines"; "Appraisal Lines")
            {
                DataItemLinkReference = EmployeeAppraisal;

                column(Activitycode_AppraisalLines; "Activity code")
                {
                }
                column(Actualtargets_AppraisalLines; "Actual targets")
                {
                }
                column(AgreedTargetDate_AppraisalLines; "Agreed Target Date")
                {
                }
                column(Agreedperfomancetargets_AppraisalLines; "Agreed perfomance targets")
                {
                }
                column(AppraisalHeader_AppraisalLines; "Appraisal Header")
                {
                }
                column(AppraisalHeadingType_AppraisalLines; "Appraisal Heading Type")
                {
                }
                column(AppraisalLineType_AppraisalLines; "Appraisal Line Type")
                {
                }
                column(AppraisalNo_AppraisalLines; "Appraisal No")
                {
                }
                column(AppraisalPeriod_AppraisalLines; "Appraisal Period")
                {
                }
                column(AppraisalType_AppraisalLines; "Appraisal Type")
                {
                }
                column(AppraiseeNo_AppraisalLines; "Appraisee No")
                {
                }
                column(Appraiseescomments_AppraisalLines; "Appraisee's comments")
                {
                }
                column(AppraisersComments_AppraisalLines; "Appraiser's Comments")
                {
                }
                column(Bold_AppraisalLines; Bold)
                {
                }
                column(Description_AppraisalLines; Description)
                {
                }
                column(DutiesandResponsibility_AppraisalLines; "Duties and Responsibility")
                {
                }
                column(EmployeeNo_AppraisalLines; "Employee No")
                {
                }
                column(EmployeesMarks_AppraisalLines; "Employee's Marks")
                {
                }
                column(FinalSelfAppraisal_AppraisalLines; "Final Self-Appraisal")
                {
                }
                column(Indentation_AppraisalLines; Indentation)
                {
                }
                column(Initiativecode_AppraisalLines; "Initiative code")
                {
                }
                column(FYTarget_AppraisalLines; "FY Target")
                {
                }
                column(JobID_AppraisalLines; "Job ID")
                {
                }
                column(KPI_AppraisalLines; KPI)
                {
                }
                column(KeyIndicators_AppraisalLines; "Key Indicators")
                {
                }
                column(KeyResponsibility_AppraisalLines; "Key Responsibility")
                {
                }
            }
            dataitem("Appraisal Recommendations"; "Appraisal Recommendations")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");

                column(AppraisalNo_AppraisalRecommendations; "Appraisal No.")
                {
                }
                column(CapableofPerformingpresent_AppraisalRecommendations; "Capable of Performing present")
                {
                }
                column(HasPotentialforPromotion_AppraisalRecommendations; "Has Potential for Promotion")
                {
                }
                column(IncrementUntilDate_AppraisalRecommendations; "Increment Until Date")
                {
                }
                column(OtherRecognition_AppraisalRecommendations; "Other Recognition")
                {
                }
                column(PerformanceReward_AppraisalRecommendations; "Performance Reward")
                {
                }
                column(Person_AppraisalRecommendations; Person)
                {
                }
                column(ReadyforPromotion_AppraisalRecommendations; "Ready for Promotion")
                {
                }
                column(RecognitionBy_AppraisalRecommendations; "Recognition By")
                {
                }
                column(RecognitionReason_AppraisalRecommendations; "Recognition Reason")
                {
                }
                column(RecommendationType_AppraisalRecommendations; "Recommendation Type")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Approver[1] := EmployeeAppraisal."Appraisee ID";
                ApproverDate[1] := CreateDateTime(EmployeeAppraisal."Period Start", EmployeeAppraisal."Time Inserted");
                UserSetup1.CalcFields(Signature);
                ApprovalEntries.Reset;
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", 51521582);
                ApprovalEntries.SetRange("Document No.", EmployeeAppraisal."Target No");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            UserSetup2.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            UserSetup3.CalcFields(Signature);
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            UserSetup3.CalcFields(Signature);
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                        end;
                    until ApprovalEntries.Next = 0;
                end;
            end;
        }
        dataitem("Appraisal Preamble Setup"; "Appraisal Preamble Setup")
        {
            column(SNo_AppraisalPreambleSetup; "SNo.")
            {
            }
            column(Description_AppraisalPreambleSetup; Description)
            {
            }
        }
        dataitem("Rating Scale"; "Rating Scale")
        {
            column(AchievementPerformanceTarget_RatingScale; "Achievement Performance Target")
            {
            }
            column(RatingScaleDescription_RatingScale; "Rating Scale Description")
            {
            }
            column(RatingScaleRange_RatingScale; "Rating Scale Range")
            {
            }
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
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Title: Label 'STAFF PERFORMANCE APPRAISAL REPORT';
        ApprovalEntries: Record "Approval Entry";
        Approver: array[50] of Code[50];
        ApproverDate: array[10] of DateTime;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        TotalTargetScore: Decimal;

    procedure GetApproverName(ApproverID: code[50]): Text
    var
        User: Record User;
    begin
        User.Reset();
        User.SetRange("User Name", ApproverID);
        if User.FindFirst() then exit(User."Full Name");
    end;
}
