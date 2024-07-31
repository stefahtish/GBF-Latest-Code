page 50583 "Appraisal Card-New"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    caption = 'Appraisal Card';
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
                    Editable = false;

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
                }
                group("Personal Details")
                {
                    Editable = false;

                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                        Editable = false;
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
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Terms Of Service"; Rec."Terms Of Service")
                    {
                        ToolTip = 'Specifies the value of the Terms Of Service field.';
                        ApplicationArea = All;
                    }
                    field(Directorate; Rec.Directorate)
                    {
                        ToolTip = 'Specifies the value of the Directorate field.';
                        ApplicationArea = All;
                    }
                    field("Division/Section"; Rec."Division/Section")
                    {
                        ToolTip = 'Specifies the value of the Division/Section field.';
                        ApplicationArea = All;
                    }
                    field("Acting Appointments"; Rec."Acting Appointments")
                    {
                        ToolTip = 'Specifies the value of the Acting Appointments field.';
                        ApplicationArea = All;
                    }
                    field("Date Of Current Designation"; Rec."Date Of Current Designation")
                    {
                        ToolTip = 'Specifies the value of the Date Of Current Designation field.';
                        ApplicationArea = All;
                    }
                }
                group("Appraiser:")
                {
                    Editable = false;

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
                    Editable = false;

                    field("Total Score"; Rec."Total Score")
                    {
                        Caption = 'Total Max Score';
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Editable = false;
                    }
                }
            }
            part("Target Lines"; "Appraisal Target Lines")
            {
                Caption = 'Targets Setup';
                SubPageLink = "Target No" = field("Target No");
            }
            part("Core Values/Competencies"; "Core Value/Competence")
            {
                Caption = 'Core Values/Competence';
                SubPageLink = "Appraisal No." = field("Appraisal No");
            }
            part("Managerial Competencies"; "Managerial Values/Competence")
            {
                Caption = 'Managerial Core Values/Competence';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Visible = Rec.Manager = true;
            }
            part("Details of Additional Assignment"; "Apprasisee Additional Assign.")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }
            part("Ad Hoc Assignments"; "Appraisee Additional Assign. 2")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }
            part("Substantial Achievements"; "Second Supervisor Comments")
            {
                Caption = ' List the major achievements made to to the station for the period under review.';
                Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Substantial Achievements"));
                Visible = (Rec."Appraisal Status" = Rec."Appraisal Status"::Review) or (Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review");
            }
            part("Significant issues that affected Performance during the period (positive)"; "Appraisal Achievements")
            {
                // Caption = '2.	State the constraints that affected your performance positively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                Caption = 'State any other major achievement and/or contributions which the job-holder made to the station, section, department or division in the last 12 month';
                Editable = UnderFurtherReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Positive Issues"));
                Visible = UnderFurtherReview;
            }
            part("Significant issues that affected Performance during the period (negative)"; "Appraisal Achievements")
            {
                // Caption = '3.	State the circumstances that affected your performance negatively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                Caption = 'List down any constraints which made it difficult for the job-holder to perform at his/her best ';
                Editable = UnderFurtherReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Negative Issues"));
                Visible = UnderFurtherReview;
            }
            part("Recommendations"; "Appraisal Recommendations")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = UnderFurtherReview;
                Visible = UnderFurtherReview;
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
                Caption = 'Training Needs';
                Visible = (UnderReview) or (UnderFurtherReview);
                Editable = UnderReview;

                part("Trainings"; "Perf. Improvement Trainings")
                {
                    SubPageLink = "Appraisal No" = field("Appraisal No");
                }
                part("Non-Trainings"; "Perf Improvement Non-Training")
                {
                    SubPageLink = "Appraisal No" = field("Appraisal No");
                }
            }
            part("Next Period Duties"; "Next Period Assignment")
            {
                Caption = 'Duties To Be Performed Over The Next 12 Months';
                SubPageLink = "Appraisal No" = field("Appraisal No"), "Next Year Duties" = filter(true);
                Visible = (UnderReview) or (UnderFurtherReview);
                Editable = UnderReview;
            }
            group("Appraiser and Appraisee Comments")
            {
                part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisers Comments")
                {
                    Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                    Editable = Rec."Appraisal Status" = Rec."Appraisal Status"::Setting;
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                    SubPageView = WHERE(Person = FILTER(Appraisee));
                }
                part("Appraiser's Comments On The Performance Appraisal"; "Appraisers Comments")
                {
                    Caption = 'Appraiser''s Comments On The Performance Appraisal';
                    Editable = (UnderReview) or (UnderFurtherReview);
                    Visible = (UnderReview) or (UnderFurtherReview);
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                    SubPageView = WHERE(Person = FILTER(Appraiser));
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
                Editable = UnderFurtherReview;
                Visible = UnderFurtherReview;
            }
            label("HOD Recommendations")
            {
                Caption = 'PART VII – DECISION/REMARKS OF HEAD OF DEPARTMENT';
                Visible = false;
                Style = Strong;
                StyleExpr = true;
            }
            part("Rewards Recognition & Sanction"; "Rewards Recognition & Sanction")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
                Visible = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
            }
            part("Decision/Remarks Head of Department"; "HOD Appraisal Decision")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
                Visible = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
            }
            part("Decision By Managing Director"; "MD Appraisal Decision")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Editable = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
                Visible = Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review";
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
            action("Staff Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = (UnderReview) or (UnderFurtherReview);

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
                    Rec.TestField("Appraisal Period");
                    Rec.TestField("Employee No");
                    Rec.TestField("Appraiser No");
                    if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
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
            action("Escalate  Appraisal")
            {
                PromotedCategory = Category5;
                Promoted = true;
                Visible = UnderFurtherReview;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Escalate this appraisal', false) then begin
                        Rec."Appraisal Status" := Rec."Appraisal Status"::Escalated;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                end;
            }
            group("Appraisal")
            {
                action("Send Appraisal for Further Review")
                {
                    PromotedCategory = Category5;
                    Promoted = true;
                    Visible = UnderReview;

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
                    PromotedCategory = Category5;
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
                action("Complete Escalated Appraisal")
                {
                    PromotedCategory = Category5;
                    Promoted = true;
                    Visible = UnderFurtherReview2;

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
                Visible = Setting;

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
                //Visible = UnderFurtherReview;
                Visible = false;

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
                Visible = false;

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    EmployeeAppraisals.RunModal;
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
        Setting: Boolean;
        AssignmentMatrixX: record "Assignment Matrix-X";
        Earnings: Page "Appraisal Bonus Allowance";

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        UnderFurtherReview := false;
        UnderFurtherReview2 := false;
        UnderReview := false;
        Setting := false;
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Setting then Setting := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then UnderReview := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review" then UnderFurtherReview := true;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::"Escalated" then UnderFurtherReview2 := true;
    end;
}
