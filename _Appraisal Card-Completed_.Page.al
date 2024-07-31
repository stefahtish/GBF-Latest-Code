page 50589 "Appraisal Card-Completed"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Appraisal,Approvals';
    SourceTable = "Employee Appraisal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT OpenApprovalEntriesExist;

                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                }
                group("Period Under Review:")
                {
                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                    }
                    field("Period Start"; Rec."Period Start")
                    {
                        Caption = 'From';
                        Editable = false;
                    }
                    field("Period End"; Rec."Period End")
                    {
                        Caption = 'To';
                        Editable = false;
                    }
                    field(AppraisalType; Rec.AppraisalType)
                    {
                        Visible = false;
                    }
                }
                group("Personal Details")
                {
                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                    }
                    field("Appraisee Name"; Rec."Appraisee Name")
                    {
                        Editable = false;
                    }
                    field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                    {
                        Editable = false;
                    }
                    field("Job Grade"; Rec."Job Group")
                    {
                        Editable = false;
                    }
                    field(Directorate; Rec.Directorate)
                    {
                        ToolTip = 'Specifies the value of the Directorate field.';
                        ApplicationArea = All;
                    }
                    field(Department; Rec.Department)
                    {
                        ToolTip = 'Specifies the value of the Department field.';
                        ApplicationArea = All;
                    }
                    field("Division/Section"; Rec."Division/Section")
                    {
                        ToolTip = 'Specifies the value of the Division/Section field.';
                        ApplicationArea = All;
                    }
                    field("Current Grade Of Supervisee"; Rec."Current Grade Of Supervisee")
                    {
                        ToolTip = 'Specifies the value of the Current Grade Of Supervisee field.';
                        ApplicationArea = All;
                    }
                    field("Date Of Current Designation"; Rec."Date Of Current Designation")
                    {
                        ToolTip = 'Specifies the value of the Date Of Current Designation field.';
                        ApplicationArea = All;
                    }
                    field("Terms Of Service"; Rec."Terms Of Service")
                    {
                        ToolTip = 'Specifies the value of the Terms Of Service field.';
                        ApplicationArea = All;
                    }
                    field("Acting Appointments"; Rec."Acting Appointments")
                    {
                        ToolTip = 'Specifies the value of the Acting Appointments field.';
                        ApplicationArea = All;
                    }
                }
                group("Appraiser:")
                {
                    field("Appraiser No"; Rec."Appraiser No")
                    {
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                    }
                    field("Appraisers Name"; Rec."Appraisers Name")
                    {
                        Editable = false;
                    }
                    field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                    {
                        Editable = false;
                    }
                }
                group("Performance Score")
                {
                    field("Total Score"; Rec."Total Score")
                    {
                    }
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                    }
                    /*group(Control39)
                    {
                        ShowCaption = false;
                        Visible = "Type" = "Type"::"Mid-Year";
                        field("Total Mid-Year"; "Total Mid-Year")
                        {
                        }
                    }
                    group(Control44)
                    {
                        ShowCaption = false;
                        Visible = "Type" = "Type"::"Final Year";
                        field("Total Final Self"; "Total Final Self")
                        {
                        }
                        field("Total Final Rating"; "Total Final Rating")
                        {
                        }
                    }
                    */
                    field(Status; Rec.Status)
                    {
                        Editable = false;

                        trigger OnValidate()
                        begin
                            //SetControlAppearance;
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Visible = false;

                        trigger OnValidate()
                        begin
                            //SetControlAppearance;
                        end;
                    }
                }
            }
            part("Target Lines"; "Appraisal Target Lines")
            {
                Caption = 'Targets Setup';
                SubPageLink = "Target No" = FIELD("Target No");
                Editable = false;
            }
            part("Core Values/Competencies"; "Core Value/Competence")
            {
                Caption = 'Core Values/Competence';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = false;
            }
            part("Managerial Competencies"; "Managerial Values/Competence")
            {
                Caption = 'Managerial Core Values/Competence';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Visible = Rec.Manager = true;
                Editable = false;
            }
            part("Apprasisee Additional Assign."; "Apprasisee Additional Assign.")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Editable = false;
            }
            part("Adhoc Appraisee''s' Additional Assignment"; "Appraisee Additional Assign. 2")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Editable = false;
            }
            part(Control13; "Appraisal Goals Self")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                UpdatePropagation = Both;
                Visible = false;
            }
            part("Substantial Achievements"; "Second Supervisor Comments")
            {
                Caption = ' List the major achievements made to to the station for the period under review.';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Substantial Achievements"));
                Visible = (UnderReview) or (UnderFurtherReview);
            }
            part("Significant issues that affected Performance during the period (positive)"; "Appraisal Achievements")
            {
                // Caption = '2.	State the constraints that affected your performance positively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                Caption = 'State any other major achievement and/or contributions which the job-holder made to the station, section, department or division in the last 12 month';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Positive Issues"));
                Visible = (UnderReview) or (UnderFurtherReview);
            }
            part("Significant issues that affected Performance during the period (negative)"; "Appraisal Achievements")
            {
                // Caption = '3.	State the circumstances that affected your performance negatively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                Caption = 'List down any constraints which made it difficult for the job-holder to perform at his/her best ';
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Negative Issues"));
                Editable = false;
                Visible = (UnderReview) or (UnderFurtherReview);
            }
            part("Recommendations"; "Appraisal Recommendations")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = false;
                Visible = (UnderReview) or (UnderFurtherReview);
            }
            label("Performance Improvement")
            {
                Caption = 'PART IV: - ACTION PLANS TO IMPROVE PERFORMANCE';
                Visible = false;
                Style = Strong;
                StyleExpr = true;
            }
            group("Performance Improvement Actions")
            {
                Editable = false;
                Caption = 'Training Needs';
                Visible = (UnderReview) or (UnderFurtherReview);

                part("Trainings"; "Perf. Improvement Trainings")
                {
                    SubPageLink = "Appraisal No" = field("Appraisal No"), "Action Type" = filter(Training);
                }
                part("Non-Trainings"; "Perf Improvement Non-Training")
                {
                    SubPageLink = "Appraisal No" = field("Appraisal No"), "Action Type" = filter("Non Training");
                }
            }
            part("Next Period Duties"; "Next Period Assignment")
            {
                Caption = 'Duties To Be Performed Over The Next 12 Months';
                SubPageLink = "Appraisal No" = field("Appraisal No"), "Next Year Duties" = filter(true);
                Editable = false;
                Visible = (UnderReview) or (UnderFurtherReview);
            }
            group("Appraiser And Appraisee Comments")
            {
                Visible = (UnderReview) or (UnderFurtherReview);

                part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisers Comments")
                {
                    Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                    Editable = false;
                    Visible = (UnderReview) or (UnderFurtherReview);
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                    SubPageView = WHERE(Person = FILTER(Appraisee));
                }
                part("Appraiser's Comments On The Performance Appraisal"; "Appraisers Comments")
                {
                    Caption = 'Appraiser''s Comments On The Performance Appraisal';
                    Editable = false;
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                    SubPageView = WHERE(Person = FILTER(Appraiser));
                    Visible = (UnderReview) or (UnderFurtherReview);
                }
            }
            label("Superiors Recommendations")
            {
                Caption = 'PART VI- NEXT SUPERIORS REPORT';
                Visible = False;
                Style = Strong;
                StyleExpr = true;
            }
            part("Departmental Head's Comments (If not the APPRAISER)"; "Second Supervisor Comments")
            {
                Caption = 'Next Superiors comments';
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("Second Supervisor"));
                Editable = false;
            }
            label("HOD Recommendations")
            {
                Caption = 'PART VII – DECISION/REMARKS OF HEAD OF DEPARTMENT';
                Visible = false;
                Style = Strong;
                StyleExpr = true;
            }
            part("Decision/Remarks Head of Department"; "HOD Appraisal Decision")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = false;
            }
            part("Decision By Managing Director"; "MD Appraisal Decision")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Print Objectives")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    EmployeeObjectives.RunModal;
                end;
            }
            action("Post Training Effectiveness")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //Visible = (UnderReview) or (UnderFurtherReview) or (CompletedAppraisal);
                Visible = false;

                trigger OnAction()
                var
                    PostTraining: Report "Post Training Effectiveness";
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    PostTraining.SetTableView(EmployeeApp);
                    PostTraining.RunModal;
                end;
            }
            action("Staff Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = (UnderReview) or (UnderFurtherReview) or (CompletedAppraisal);

                trigger OnAction()
                var
                    StaffAppraisal: Report "Staff Appraisal Report";
                begin
                    Clear(StaffAppraisal);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    StaffAppraisal.SetTableView(EmployeeApp);
                    StaffAppraisal.RunModal;
                end;
            }
            separator(Action34)
            {
            }
            action("Send For Approval")
            {
                Caption = 'Send Appraisal For Review';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WorkflowResponses: Codeunit "Workflow Responses";
                begin
                    //CalcFields("Total Final Self", "Total Mid-Year", "Total Weighting");
                    /*IF (("Total Final Self" <= 0) OR ("Total Mid-Year" <= 0) OR ("Total Weighting" <= 0)) THEN
                      ERROR('Kindly define appraisal goals');*/
                    Rec.TestField("Appraisal Period");
                    Rec.TestField("Employee No");
                    Rec.TestField("Appraiser No");
                    if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
                    //   "Appraisal Status" := "Appraisal Status"::Review;
                    // WorkflowResponses.ReleaseEmployeeAppraisalRequest(Rec);
                    // Message('Approved Successfully');
                    Commit;
                    CurrPage.Close;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Review Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelNewEmpAppraisalRequestApproval(Rec);
                    Commit;
                    CurrPage.Close;
                end;
            }
            action(ViewApprovals)
            {
                Visible = false;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    Clear(ApprovalEntries);
                    ApprovalEntries.Setfilters2(Database::"Employee Appraisal", ApprovalEntry."Document Type"::"Employee Appraisal", Rec."Appraisal No");
                    ApprovalEntries.Run;
                end;
            }
            separator(Action35)
            {
            }
            group("Appraisal")
            {
                action("Send for Further Review")
                {
                    PromotedCategory = Category6;
                    Promoted = true;
                    Visible = (UnderReview);

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you wnat to move this appraisal for further review?', false) then begin
                            Rec."Appraisal Status" := Rec."Appraisal Status"::"Further review";
                            Rec.Modify();
                            CurrPage.Close();
                        end;
                    end;
                }
                action("Complete Appraisal")
                {
                    PromotedCategory = Category6;
                    Promoted = true;
                    Visible = UnderFurtherReview;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to complete this appraisal', false) then begin
                            Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;
                            Rec.Modify();
                            CurrPage.Close();
                        end;
                    end;
                }
            }
            action("Create a training need")
            {
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (UnderFurtherReview) or (CompletedAppraisal);

                trigger OnAction()
                var
                    TrainingNeedRequest: Record "Training Needs Request";
                begin
                    TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                    if TrainingNeedRequest.FindFirst() then begin
                        PAGE.RUN(PAGE::"Training Needs Request", TrainingNeedRequest);
                    end
                    else begin
                        TrainingNeedRequest.Reset();
                        TrainingNeedRequest.Init;
                        TrainingNeedRequest.No := '';
                        TrainingNeedRequest."Employee No" := Rec."Employee No";
                        TrainingNeedRequest.Validate("Employee No");
                        TrainingNeedRequest."Source Document No" := Rec."Appraisal No";
                        TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Appraisal;
                        TrainingNeedRequest.Insert(true);
                        TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                        if Rec.FindFirst() then PAGE.RUN(Page::"Training Needs Request", TrainingNeedRequest);
                    end;
                end;
            }
            action("Assign Bonus")
            {
                Caption = 'Assign bonus';
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Process;
                Visible = UnderFurtherReview;

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) = false then exit;
                    AssignmentMatrixX.Reset;
                    AssignmentMatrixX.SetRange("Employee No", Rec."Employee No");
                    AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Payment);
                    AssignmentMatrixX.SetRange(Closed, false);
                    Earnings.SetTableView(AssignmentMatrixX);
                    Commit;
                    Earnings.RunModal;
                end;
            }
            action("Print Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = (UnderReview) or (UnderFurtherReview);

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    EmployeeAppraisals.RunModal;
                end;
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Set;
                    Message('Performance Locked');
                end;
            }
            action("Review Targets")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
                    Message('Appraisal has been opened for Review');
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        OpenApprovalsExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        DocReleased: Boolean;
        UnderReview: Boolean;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        HRManagement: Codeunit "HR Management";
        Employee: Record Employee;
        Jobs: Record "Company Job";
        EmployeeApp: Record "Employee Appraisal";
        AppraisalCompetences: Record "Appraisal Competences";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        EmployeeObjectives: Report "Employee Objectives - New";
        UnderFurtherReview: Boolean;
        UnderFurtherReview2: Boolean;
        CompletedAppraisal: Boolean;
        AssignmentMatrixX: record "Assignment Matrix-X";
        Earnings: Page "Appraisal Bonus Allowance";

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        UnderFurtherReview := false;
        UnderFurtherReview2 := false;
        UnderReview := false;
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then UnderReview := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review" then UnderFurtherReview := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Escalated then UnderFurtherReview2 := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Completed then CompletedAppraisal := true;
    end;
}
