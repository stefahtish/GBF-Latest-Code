page 51453 "Open Contract Suspension Card"
{
    PageType = Card;
    SourceTable = "Project Header";
    Caption = 'Open Contract Suspension Card';
    InsertAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Project Date"; Rec."Project Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'Contract Date';
                }
                field("Tender No"; Rec."Tender No")
                {
                    ToolTip = 'Specifies the value of the Tender No field.';
                    ApplicationArea = All;
                    enabled = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Tender Description';
                    ApplicationArea = all;
                    ShowMandatory = TRUE;
                    Editable = false;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Code field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                group("Company")
                {
                    Caption = 'Company Details';

                    field("Company E-mail"; Rec."Company E-mail")
                    {
                        ToolTip = 'Specifies the value of the Company E-mail field.';
                        ApplicationArea = All;
                        // Editable = false;
                    }
                    field("Company PIN No."; Rec."Company PIN No.")
                    {
                        ToolTip = 'Specifies the value of the Company PIN No. field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Company Physical Address"; Rec."Company Physical Address")
                    {
                        ToolTip = 'Specifies the value of the Company Physical Address field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Company City"; Rec."Company City")
                    {
                        ToolTip = 'Specifies the value of the Company City field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Company Telephone No"; Rec."Company Telephone No")
                    {
                        ToolTip = 'Specifies the value of the Company Telephone No field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Contact)
                {
                    Caption = 'Contact Details';

                    field("Contact Person"; Rec."Contact Person")
                    {
                        ToolTip = 'Specifies the value of the Contact Person field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Contact E-Mail Address"; Rec."Contact E-Mail Address")
                    {
                        ToolTip = 'Specifies the value of the Contact E-Mail Address field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Contact Phone No."; Rec."Contact Phone No.")
                    {
                        ToolTip = 'Specifies the value of the Contact Phone No. field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                        ToolTip = 'Specifies the value of the Job Title field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Bank Code"; Rec."Bank Code")
                    {
                        ToolTip = 'Specifies the value of the Bank Code field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Branch Code"; Rec."Branch Code")
                    {
                        ToolTip = 'Specifies the value of the Branch Code field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                        ToolTip = 'Specifies the value of the Bank account No field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Commitee No."; Rec."Commitee No.")
                {
                    ToolTip = 'Specifies the value of the Commitee No. field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Suspension Status"; Rec."Suspension Status")
                {
                    Caption = 'Suspension Status';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reason for Suspension"; Rec."Reason for Suspension")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Reason for Suspension field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control7; "Bill of Quantities Sub Form")
            {
                Editable = not IsOpen;
                ApplicationArea = All;
                SubPageLink = "Quote No" = FIELD("Tender No");
                Caption = 'Bill of Quantities';
            }
            part(Control17; "Supplier Evaluation Scores")
            {
                ApplicationArea = All;
                Visible = false;
                // SubPageLink = "Supplier Code" = FIELD("Supplier Code");
                SubPageLink = "Tender No." = field("Tender No");
                Caption = 'Technical Specifications';
            }
            group("General Conditions")
            {
                field("Terms And Conditions"; Rec."Terms And Conditions")
                {
                    ToolTip = 'Specifies the value of the Terms And Conditions field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control117; "General Conditions")
            {
                ApplicationArea = All;
                Visible = false;
                SubPageLink = "Project no" = FIELD("No.");
                Caption = 'General Condition Of Contract';
            }
            part("Contract Terms"; "Contract Terms And Cond Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Contract no." = FIELD("No.");
                Caption = 'Terms and Condition Of Contract';
                Visible = false;
            }
            group("Contract Term Conditions")
            {
                field("Contract Conditions"; Rec."Contract Conditions")
                {
                    Caption = 'Terms and Condition Of Contract';
                    ToolTip = 'Specifies the value of the Contract Conditions field.';
                    ApplicationArea = All;
                }
            }
            part(Control07; "special conditions")
            {
                ApplicationArea = All;
                Visible = false;
                SubPageLink = "Project no" = FIELD("No.");
                Caption = 'Special Condition of Contract';
            }
            group("Special Term Conditions")
            {
                field("Special Conditions"; Rec."Special Conditions")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Special Conditions field.';
                    ApplicationArea = All;
                }
            }
            part(Control8; "Project Team")
            {
                Editable = not IsOpen;
                Applicationarea = all;
                SubPageLink = "Project No" = FIELD("No.");
                Caption = 'Contract Management Team';
                Visible = IsApproved;
            }
            part(Control9; "Project Tasks")
            {
                Editable = not IsOpen;
                Applicationarea = all;
                SubPageLink = "Project No" = FIELD("No.");
                Caption = 'Milestones';
                Visible = IsApproved;
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
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsOpen;

                trigger OnAction()
                begin
                    Rec.TestField("Project Name");
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Project Budget");
                    Rec.TestField("Commitee No.");
                    Rec.TestField("Company E-mail");
                    if Confirm('Do you want to send this contract for approval?', false) = true then begin
                        IF ApprovalsMgmt2.CheckcontractApprovalRequestWorkflowEnabled(Rec) THEN ApprovalsMgmt2.OnSendContractReqforApproval(Rec);
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = IsSubmitted;

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        if ApprovalsMgmt2.CheckcontractApprovalRequestWorkflowEnabled(Rec) THEN ApprovalsMgmt2.OnCancelContractreqforApproval(Rec);
                        // Modify();
                    end;
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
                        //   FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action(Suspend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                // ApplicationArea = all;
                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Suspended;
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
        Rec.Type := Rec.Type::Suspension;
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        case Rec."Status" of
            Rec."Status"::"Pending Suspension":
                IsOpen := true;
            Rec."Suspension Status"::Open:
                IsOpen := true;
            Rec."Suspension Status"::Approved:
                IsApproved := true;
        end;
    end;
}
