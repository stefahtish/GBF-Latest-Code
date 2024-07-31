page 51484 "Direct Contract Card"
{
    PageType = Card;
    SourceTable = "Project Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = IsOpen;
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
                field("Nature Of Contract"; Rec."Nature Of Contract")
                {
                    ApplicationArea = all;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Scope of Contract"; Rec."Scope of Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scope of Contract field.';
                }
                field("Responsibilty Holder"; Rec."Responsibilty Holder")
                {
                    ApplicationArea = all;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Responsibilty Holder Name"; Rec."Responsibilty Holder Name")
                {
                    ApplicationArea = all;
                }
                field(Parties; Rec.Parties)
                {
                    ApplicationArea = all;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                group("Company")
                {
                    Caption = 'Company Details';

                    field("Company E-mail"; Rec."Company E-mail")
                    {
                        ToolTip = 'Specifies the value of the Company E-mail field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Company PIN No."; Rec."Company PIN No.")
                    {
                        ToolTip = 'Specifies the value of the Company PIN No. field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Company Physical Address"; Rec."Company Physical Address")
                    {
                        ToolTip = 'Specifies the value of the Company Physical Address field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Company City"; Rec."Company City")
                    {
                        ToolTip = 'Specifies the value of the Company City field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Company Telephone No"; Rec."Company Telephone No")
                    {
                        ToolTip = 'Specifies the value of the Company Telephone No field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                }
                group(Contact)
                {
                    Caption = 'Liason';

                    field("Contact Person"; Rec."Contact Person")
                    {
                        ToolTip = 'Specifies the value of the Contact Person field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Contact E-Mail Address"; Rec."Contact E-Mail Address")
                    {
                        ToolTip = 'Specifies the value of the Contact E-Mail Address field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Contact Phone No."; Rec."Contact Phone No.")
                    {
                        ToolTip = 'Specifies the value of the Contact Phone No. field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                        ToolTip = 'Specifies the value of the Job Title field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
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
                        Editable = Rec.Status = Rec.Status::Open;
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                        ToolTip = 'Specifies the value of the Bank account No field.';
                        ApplicationArea = All;
                        Editable = Rec.Status = Rec.Status::Open;
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
                    Caption = 'Effective Date';
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                    showmandatory = true;
                    Editable = Rec.Status = Rec.Status::Open;
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
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                group("Contract Extension")
                {
                    Visible = false;

                    field("Extension duration"; Rec."Extension duration")
                    {
                        ApplicationArea = all;
                    }
                    field("Project Extension Date"; Rec."Project Extension Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Extension Reason"; Rec."Extension Reason")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            part(Control7; "Bill of Quantities Sub Form")
            {
                Visible = false;
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
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Stage = Rec.Stage::Creation;

                trigger OnAction()
                begin
                    //TestField("Project Name");
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Project Budget");
                    Rec.TestField("Project Extension Date");
                    Rec.TestField("Extension duration");
                    //TestField("Commitee No.");
                    Rec.TestField("Company E-mail");
                    Rec.TestField("Extension Reason");
                    if Confirm('Do you want to send this contract for approval?', false) = true then begin
                        IF ApprovalsMgmt2.CheckcontractApprovalRequestWorkflowEnabled(Rec) THEN ApprovalsMgmt2.OnSendContractReqforApproval(Rec);
                    end;
                end;
            }
            action("Start Contract")
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Stage = Rec.Stage::Verification;
                ApplicationArea = all;

                trigger OnAction()
                var
                    ContractTable: record "Project Header";
                    NoOfRec: integer;
                begin
                    if Not Rec."Direct Contract" then Rec.TestField("Project Name"); //Contract Name shows
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Estimated Duration");
                    Rec.TestField("Project Budget");
                    NoOfRec := 0;
                    contracttable.setrange("tender no", Rec."tender no");
                    if Confirm('Do you want to Commence this contract?', false) = true then begin
                        Rec.Stage := Rec.Stage::Running;
                        Rec.Modify();
                    end;
                    CurrPage.Close();
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
            action("Project Team")
            {
                Image = TeamSales;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Finished;

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
                Visible = Rec.Status = Rec.Status::Finished;

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
                ApplicationArea = all;
                Visible = Rec.Stage = Rec.Stage::Creation;

                trigger OnAction()
                begin
                    if Confirm('Do you want to verify this contract?', false) = true then begin
                        Rec.TestField("Estimated Start Date");
                        PurchSetup.Get();
                        PurchSetup.TestField("Contract Verification Duration");
                        VerificationDuration := CalcDate(PurchSetup."Contract Verification Duration", Rec."Estimated Start Date");
                        If Today >= VerificationDuration then begin
                            Rec.Stage := Rec.Stage::Verification;
                            Rec.Modify();
                            CurrPage.Close();
                            Message('Contract No. %1 has been Verified', Rec."No.");
                        end
                        else begin
                            Error('Contract Cannot be Verified before %1.', VerificationDuration);
                        end;
                        ;
                    end;
                end;
            }
            action(Extend)
            {
                Image = ExtendedDataEntry;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Approved;
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
                Visible = Rec.Status = Rec.Status::Approved;
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
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec.Validate("Actual End Date", Today);
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowXrec: Boolean)
    begin
        Rec."Direct Contract" := true;
    end;

    trigger OnInsertRecord(BelowXrec: Boolean): Boolean
    begin
        Rec."Direct Contract" := true;
    end;

    trigger OnAfterGetRecord()
    begin
        //SetPageControls;
    end;

    trigger OnOpenPage()
    begin
        //SetPageControls;
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
        VerificationDuration: Date;
        PurchSetup: Record "Purchases & Payables Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmt2: codeunit ApprovalMgtCuExtension;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        TaskError: Label 'There must be at least one milestone for contract %1 before  you send for verification.';
        TaskStatusError: Label 'Milestone %1 must be finished or suspended before sending for verification.';

    local procedure SetPageControls()
    begin
        Rec.Type := Rec.Type::Running;
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
