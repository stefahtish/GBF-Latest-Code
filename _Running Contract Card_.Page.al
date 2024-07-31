page 51437 "Running Contract Card"
{
    PageType = Card;
    SourceTable = "Project Header";
    Caption = 'Running Contract Card';
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
                        Editable = false;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    style = favorable;
                    visible = false;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                    showmandatory = true;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                group("Actual Date")
                {
                    Visible = false;

                    field("Actual Start Date"; Rec."Actual Start Date")
                    {
                        ToolTip = 'Specifies the value of the Actual Start Date field.';
                        ApplicationArea = All;
                    }
                    field("Actual Duration"; Rec."Actual Duration")
                    {
                        ToolTip = 'Specifies the value of the Actual Duration field.';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Actual End Date"; Rec."Actual End Date")
                    {
                        ToolTip = 'Specifies the value of the Actual End Date field.';
                        ApplicationArea = All;
                    }
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    Caption = 'Contract Cost';
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            part(Control7; "Bill of Quantities Sub Form")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No" = FIELD("Tender No");
                Caption = 'Bill of Quantities';
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
                Applicationarea = all;
                SubPageLink = "Project No" = FIELD("No.");
                Caption = 'Contract Management Team';
                Visible = IsApproved;
            }
            part(Control9; "Project Tasks")
            {
                Applicationarea = all;
                SubPageLink = "Project No" = FIELD("No.");
                Caption = 'Milestones';
                Visible = IsApproved;
            }
            part("Contract Change Entries"; "Contract Change Entries")
            {
                ApplicationArea = all;
                SubPageLink = "Contract No." = field("No.");
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
                        // FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action(Extend)
            {
                Image = ExtendedDataEntry;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;
                ApplicationArea = all;
                Caption = 'Request Contract Extension';

                trigger OnAction()
                begin
                    if Confirm('Do you want to Extend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::"Open Extensions";
                    end;
                    CurrPage.Close();
                end;
            }
            action(Suspend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this contract?', false) = true then begin
                        Rec.Status := Rec.Status::"Pending Suspension";
                        Rec."Suspension Status" := Rec."Suspension Status"::Open;
                    end;
                    CurrPage.Close();
                end;
            }
            action("Terminate")
            {
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Terminate this contract?', false) = true then begin
                        Rec.Status := Rec.Status::"Terminated Contracts";
                        Rec.Modify();
                    end;
                    CurrPage.Close();
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = Rec.Verified;

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
        IsPastDueDate: Boolean;
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
        IsPastDueDate := false;
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
            Rec.Status::"Extended Contracts":
                IsPastDueDate := true;
        end;
    end;
}
