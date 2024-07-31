page 50587 "Appraisal Card-Review"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                    field("Appraisal Type"; Rec.AppraisalType)
                    {
                    }
                    field("Appraisal Type Description"; Rec."Appraisal Type Description")
                    {
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
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                    }
                    field(Rating; Rec.Rating)
                    {
                        Editable = false;
                    }
                    group(Control46)
                    {
                        Visible = false;
                        ShowCaption = false;

                        field("Total Mid-Year Rating"; Rec."Total Mid-Year")
                        {
                        }
                        field("Total Final Year Rating"; Rec."Total FY Rating")
                        {
                            Visible = FinalVisible;
                        }
                        field("Final Year Percentage Score"; Rec."Total Percentage FY Rating")
                        {
                            Visible = FinalVisible;
                        }
                        field("Final Year Grade"; Rec."Grade final year rating")
                        {
                            Visible = FinalVisible;
                        }
                        field("Total score(Appraisal goals + Attributes"; Rec."Total score")
                        {
                            Visible = FinalVisible;
                        }
                    }
                    /*group(Control12)
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
                            SetControlAppearance;
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Editable = false;

                        trigger OnValidate()
                        begin
                            SetControlAppearance;
                        end;
                    }
                }
            }
            part(Control8; "Appraisal Goals")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                UpdatePropagation = Both;
            }
            part(Control9; "Appraisal Goals Self")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                UpdatePropagation = Both;
                Visible = false;
            }
            part("Substantial Achievements"; "Appraisee's Appraisal Comments")
            {
                Caption = '1.	List your outstanding achievements for the period under review.';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Substantial Achievements"));
                Visible = FinalVisible;
            }
            part("Significant issues that affected Performance during the period (positive)"; "Appraisee's Appraisal Comments")
            {
                Caption = '2.	State the circumstances that affected your performance positively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Positive Issues"));
                Visible = FinalVisible;
            }
            part("Significant issues that affected Performance during the period (negative)"; "Appraisee's Appraisal Comments")
            {
                Caption = '3.	State the circumstances that affected your performance negatively for the period under review (circumstances may be related to Supervisor/organization/personal/external etc.)';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Significant Negative Issues"));
                Visible = FinalVisible;
            }
            part("WorkRelatedAttributes"; "Appraisal work related attr")
            {
                Caption = 'c)	Assessment on Work Related Attributes';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                Visible = FinalVisible;
                UpdatePropagation = both;
            }
            field("Total Rating"; Rec."Total FY Attributes")
            {
                Visible = FinalVisible;
            }
            field("Expected Rating"; Rec."Expected TR -attributes")
            {
                Visible = FinalVisible;
            }
            field("Total Percentage Score"; Rec."Total Percentage-Attributes")
            {
                Visible = FinalVisible;
            }
            field("Grade"; Rec."Grade-Attributes")
            {
                Visible = FinalVisible;
            }
            label("SECTION V:  PERFORMANCE IMPROVEMENT PLAN/PROGRAMME")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
                Visible = FinalVisible;
            }
            part("PerfomanceImprovement"; "Second Supervisor Comments")
            {
                Caption = 'To be completed jointly, by the Appraisee and the Appraiser at the end of the appraisal period (Comment on appropriate performance improvement plan e.g. training, job rotation, appropriate placement, counselling, etc)';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Perfomance Improvement Plan"));
                Visible = FinalVisible;
            }
            label("SECTION VI:  STAFF TRAINING AND DEVELOPMENT NEEDS")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
                Visible = FinalVisible;
            }
            part("StaffTraining"; "Second Supervisor Comments")
            {
                Caption = 'Appraisee Training and Development needs in order of priority as identified by appraisee and supervisor based on performance gaps to be completed jointly at the end of the appraisal period.';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = CONST("Perfomance Improvement Plan"));
                Visible = FinalVisible;
            }
            part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisee's Appraisal Comments")
            {
                Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER(Appraisee));
                Visible = false;
            }
            part("Appraiser's Comments On The Performance Appraisal"; "HR Appraisal Comments")
            {
                Caption = 'Appraiser''s Comments On The Performance Appraisal';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER(Appraiser));
                Visible = false;
            }
            label("SECTION VI:  COMMENTS BY THE HEAD OF DEPARTMENT")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
                Visible = FinalVisible;
            }
            label("Please comment appropriately:")
            {
                Style = None;
                StyleExpr = false;
                ApplicationArea = Basic, Suite;
                Visible = FinalVisible;
            }
            part("HOD"; "HR Appraisal Comments")
            {
                Caption = 'a)	I agree/disagree with the Appraiser’s rating for the following reason(s): ';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("Second Supervisor"));
                Visible = FinalVisible;
            }
            label("SECTION VII:  HUMAN RESOURCES DEPARTMENT ")
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
                Visible = FinalVisible;
            }
            part("Other recommended interventions"; "HR Appraisal Comments")
            {
                Caption = 'c)	Other recommended interventions (specify)';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("HR"));
                Visible = FinalVisible;
            }
            part("Recommendations"; "HR Appraisal Comments")
            {
                Caption = 'd)	Recommendations to the CEO, KMRC, by the Performance Management Committee.';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("Other interventions"));
                Visible = FinalVisible;
            }
            part("Developmental Action To Be Taken"; "HR Appraisal Comments")
            {
                Caption = 'Developmental Action To Be Taken';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("Dev Action"));
                Visible = FinalVisible;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Create a training need")
            {
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
                PromotedCategory = Category4;

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
            action("Print Objectives")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    EmployeeObjectives.RunModal;
                end;
            }
            action("Print Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    EmployeeAppraisals.RunModal;
                end;
            }
            separator(Action34)
            {
            }
            action("Send For Approval")
            {
                Caption = 'Send For further Review';
                Enabled = DocReleased;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // if Status = Status::"Pending Approval" then
                    //     Error('Document already pending approval');
                    // if Status = Status::Completed then
                    //     Error('Appraisal is already complete');
                    // if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
                    Rec."Appraisal Status" := Rec."Appraisal Status"::"Further review";
                    Commit;
                    CurrPage.Close;
                end;
            }
            action("Return for review")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec."Appraisal Status" = Rec."Appraisal Status"::Completed) and (Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review");

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
                    Message('Appraisal has been returned to Review');
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
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program","FA Disposal",Equity,Money_Market,Property,TPS;
                begin
                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.Setrecordfilters(DATABASE::"Employee Appraisal", DocumentType, Rec."Appraisal No");
                    ApprovalEntries.Run;
                end;
            }
            separator(Action35)
            {
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
            action("Complete Appraisal")
            {
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = FinalVisible;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to complete this appraisal?', true) then begin
                        Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;
                        Rec.Modify;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Send to next quarter")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                //Visible = MidVisible;
                trigger OnAction()
                begin
                    IF Rec.AppraisalType = Rec.AppraisalType::Q1 THEN HRManagement.SendToQ2(Rec);
                    IF Rec.AppraisalType = Rec.AppraisalType::Q2 THEN HRManagement.SendToQ3(Rec);
                    IF Rec.AppraisalType = Rec.AppraisalType::Q3 THEN HRManagement.SendToQ4(Rec);
                end;
            }
            action(SendToFinal)
            {
                Caption = 'Send To Final Year Review';
                Enabled = UnderReview AND MidVisible;
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    HRManagement.SendToFinalYearAppraisal(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        // CurrPage.UPDATE;
        SetControlAppearance;
        HRManagement.GetTotalRating(Rec);
    end;

    trigger OnOpenPage()
    begin
        //HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        //CurrPage.UPDATE;
        SetControlAppearance;
    end;

    var
        OpenApprovalsExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        DocReleased: Boolean;
        UnderReview: Boolean;
        Completed: Boolean;
        FinalVisible: Boolean;
        MidVisible: Boolean;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        HRManagement: Codeunit "HR Management";
        Employee: Record Employee;
        Jobs: Record "Company Job";
        EmployeeApp: Record "Employee Appraisal";
        AppraisalCompetences: Record "Appraisal Competences";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        EmployeeObjectives: Report "Employee Objectives - New";
        AssignmentMatrixX: Record "Assignment Matrix-X";
        Earnings: Page "Appraisal Bonus Allowance";

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then
            UnderReview := true
        else
            UnderReview := false;
        if Rec."Appraisal Status" = Rec."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;
        if Rec.AppraisalType = Rec.AppraisalType::Q4 then
            FinalVisible := true
        else
            FinalVisible := false;
        // if AppraisalType = AppraisalType::"Mid-Year" then
        //     MidVisible := true
        // else
        //     MidVisible := false;
    end;
}
