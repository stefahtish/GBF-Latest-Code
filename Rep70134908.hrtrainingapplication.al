report 50518 "hr training application"
{
    // version HRMIS

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/HR Training Application.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("HR Training Application"; "Training Request")
        {
            DataItemtableView = SORTING("Request No.");
            RequestFilterFields = "Request No.";
            column(CourseTitle_HRTrainingApplications; "HR Training Application"."Course Title")
            {
                IncludeCaption = true;
            }
            column(FromDate_HRTrainingApplications; "HR Training Application"."Planned Start Date")
            {
                IncludeCaption = true;
            }
            column(ToDate_HRTrainingApplications; "HR Training Application"."Planned End Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingApplications; "HR Training Application".Period)
            {
                IncludeCaption = true;
            }
            column(Duration_HRTrainingApplications; "HR Training Application".Period)
            {
                IncludeCaption = true;
            }
            column(CostOfTraining_HRTrainingApplications; "HR Training Application"."Cost Of Training")
            {
                IncludeCaption = true;
            }
            column(Location_HRTrainingApplications; "HR Training Application".Venue)
            {
                IncludeCaption = true;
            }
            column(ApplicationNo_HRTrainingApplications; "HR Training Application"."Request No.")
            {
                IncludeCaption = true;
            }
            column(EmployeeNo_HRTrainingApplications; "HR Training Application"."Employee No")
            {
                IncludeCaption = true;
            }
            column(EmployeeName_HRTrainingApplications; "HR Training Application"."Employee Name")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRTrainingApplications; "HR Training Application"."Request Date")
            {
                IncludeCaption = true;
            }
            column(EmployeeDepartment_HRTrainingApplications; "HR Training Application"."Department Code")
            {
                IncludeCaption = true;
            }
            column(Description_HRTrainingApplications; "HR Training Application".Description)
            {
            }
            column(PurposeofTraining_HRTrainingApplications; "HR Training Application"."Training Objectives")
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("Request No.");
                DataItemLinkReference = "HR Training Application";
                DataItemtableView = SORTING("table ID", "Document Type", "Document No.");
                column(UserID_ApprovalCommentLine; "Approval Comment Line"."User ID")
                {
                    IncludeCaption = true;
                }
                column(Comment_ApprovalCommentLine; "Approval Comment Line".Comment)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Request No.");
                DataItemLinkReference = "HR Training Application";
                DataItemtableView = SORTING("table ID", "Document Type", "Document No.", "Sequence No.");
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                    IncludeCaption = true;
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                    IncludeCaption = true;
                }
                // dataitem(DataItem7968; table91)
                // {
                //     DataItemLink = User ID=FIELD(Approver ID);
                //     DataItemtableView = SORTING(User ID);
                // }

                trigger OnAfterGetRecord();
                begin
                    HREmp.RESET;
                    HREmp.SETRANGE(HREmp."User ID", "Approval Entry"."Approver ID");
                    IF HREmp.FIND('-') THEN
                        ApproverName := HREmp.FullName
                    ELSE
                        ApproverName := '';
                end;
            }
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

    trigger OnPreReport();
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HREmp: Record "Employee";
        ApproverName: Text[30];
        HR_Training_ApplicationsCaptionLbl: Label 'HR Training Applications';
        CurrReport_PAGENOCaptionLbl: Label 'page';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Training_Application_FormCaptionLbl: Label 'Training Application Form';
        Name_of_Training_CourseCaptionLbl: Label 'Name of Training Course';
        From__Date_CaptionLbl: Label 'From (Date)';
        Duration_CaptionLbl: Label '"Duration "';
        To__Date_CaptionLbl: Label 'To (Date)';
        Cost_of_TrainingCaptionLbl: Label 'Cost of Training';
        How_the_Training_Course_Will_Complement_Enhance_my_Skills_in_Relation_to_the_Job_RequirementsCaptionLbl: Label 'How the Training Course Will Complement/Enhance my Skills in Relation to the Job Requirements';
        Brief_Description_of_Training_CourseCaptionLbl: Label 'Brief Description of Training Course';
        CommentsCaptionLbl: Label 'Comments';
        Comments_By_CaptionLbl: Label 'Comments By:';
        End_of_CommentsCaptionLbl: Label 'End of Comments';
        Approved_ByCaptionLbl: Label 'Approved By';
        ApprovalsCaptionLbl: Label 'Approvals';
        SignatureCaptionLbl: Label 'Signature';
}

