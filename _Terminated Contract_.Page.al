page 51359 "Terminated Contract"
{
    PageType = Card;
    SourceTable = "Project Header";
    Caption = 'Terminated Contract Card';
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = IsOpen;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Contract Name';
                    ApplicationArea = all;
                }
                field("Project Date"; Rec."Project Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'Contract Date';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Control53; Links)
            {
            }
            systempart(Control52; Notes)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Team)
            {
                Image = TeamSales;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Team";
                RunPageLink = "Project No" = FIELD("No.");
                Visible = IsApproved;
            }
            action(Milestone)
            {
                Image = Task;
                Promoted = true;
                //ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Tasks";
                RunPageLink = "Project No" = FIELD("No.");
                Visible = IsApproved;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                // ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsOpen;

                trigger OnAction()
                begin
                    Rec.TestField("Project Name");
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Project Budget");
                    if Confirm('Do you want to send this contract for approval?', false) = true then begin
                        IF ApprovalsMgmt2.CheckcontractApprovalRequestWorkflowEnabled(Rec) THEN ApprovalsMgmt2.OnSendContractReqforApproval(Rec);
                        //Status := Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                //ApplicationArea = all;
                PromotedIsBig = true;
                Visible = IsSubmitted;

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        if ApprovalsMgmt2.CheckcontractApprovalRequestWorkflowEnabled(Rec) THEN ApprovalsMgmt2.OnCancelContractreqforApproval(Rec);
                        Rec.Modify();
                    end;
                    /*IF CONFIRM('Do you want to cancel the approval request?',FALSE)=TRUE THEN
                          BEGIN
                            IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnCancelProjectTaskRequestApproval(Rec);
                          END;

                        Approval Entries - OnAction()
                        ApprovalEntries.Setfilters(DATABASE::"Project Tasks",ApprovalEntry."Document Type"::"Project Tasks",No);
                        ApprovalEntries.RUN;
                        */
                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                //ApplicationArea = all;
                PromotedIsBig = true;
                Visible = IsSubmitted;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    //ApprovalEntries.Setfilters(DATABASE::"Project Header",ApprovalEntry."Document No."::"Project Header","No.");
                    //ApprovalEntries.Run;
                    ApprovalEntry.SetRange("Table ID", Database::"Project Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.RunModal();
                end;
            }
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //    FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action(Suspend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;

                // ApplicationArea = all;
                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Suspended;
                    end;
                end;
            }
            action(Extend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;

                // ApplicationArea = all;
                trigger OnAction()
                begin
                    if Confirm('Do you want to Extend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::"Extended Contracts";
                    end;
                end;
            }
            action(Resume)
            {
                Image = ReOpen;
                Promoted = true;
                //ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSuspended;

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Open;
                    end;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ApplicationArea = all;
                Visible = Rec."Status" = Rec."Status"::"Verified";

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec.Validate("Actual End Date", Today);
                    end;
                end;
            }
            action("Project Team")
            {
                Image = TeamSales;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = IsFinished;

                trigger OnAction()
                begin
                    Project.Reset;
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst then REPORT.Run(report::"Project Team", true, false, Project)
                end;
            }
            action("Contract Milestones")
            {
                Image = Task;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = IsFinished;

                trigger OnAction()
                begin
                    Project.Reset;
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst then REPORT.Run(report::"Project Tasks", true, false, Project)
                end;
            }
            action(Verify)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // ApplicationArea = all;
                Visible = Rec."Status" = Rec."Status"::"Pending Verification";

                trigger OnAction()
                begin
                    if Confirm('Do you want to verify this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Verified;
                    end;
                end;
            }
            action("Send for Verification")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                // ApplicationArea = all;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Approved";

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this Contract for verification?', false) = true then begin
                        ProjectTasks.Reset;
                        ProjectTasks.SetRange("Project No", Rec."No.");
                        if ProjectTasks.FindFirst then begin
                            repeat
                                if ProjectTasks.Status <> ProjectTasks.Status::Finished then if ProjectTasks.Status <> ProjectTasks.Status::Suspended then Error(TaskStatusError, ProjectTasks."Task No");
                            until ProjectTasks.Next = 0;
                        end
                        else
                            Error(TaskError, Rec."No.");
                        Rec.Status := Rec.Status::"Pending Verification";
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetPageControls;
    end;

    trigger OnOpenPage()
    begin
        SetPageControls;
    end;

    var
        IsOpen: Boolean;
        IsSubmitted: Boolean;
        IsApproved: Boolean;
        IsSuspended: Boolean;
        IsFinished: Boolean;
        ProjectTeam: Record "Project Team";
        ProjectTasks: Record "Project Tasks";
        Project: Record "Project Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmt2: codeunit ApprovalMgtCuExtension;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        TaskError: Label 'There must be at least one milestone for contract %1 before  you send for verification.';
        TaskStatusError: Label 'Milestone %1 must be finished or suspended before sending for verification.';

    local procedure SetPageControls()
    begin
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::"Pending Approval":
                IsSubmitted := true;
            Rec.Status::Approved:
                IsApproved := true;
            Rec.Status::Finished:
                IsFinished := true;
            Rec.Status::Suspended:
                IsSuspended := true;
        end;
    end;
}
