page 51461 "Target Setup Header"
{
    Caption = 'Target Setup Header';
    PageType = Card;
    SourceTable = "Target Setup Header";
    DeleteAllowed = true;
    PromotedActionCategories = 'New,Process,Reports,Appraisal,Approvals,Appraisals';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT OpenApprovalEntriesExist;

                field("Target No"; Rec."Target No")
                {
                    ToolTip = 'Specifies the value of the Target No field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                group("Period Under Review")
                {
                    Editable = Rec."Target Status" = Rec."Target Status"::Setting;

                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                        trigger OnValidate()
                        begin
                            //CurrPage.Update();
                        end;
                    }
                    field("Period Description"; Rec."Period Description")
                    {
                        ToolTip = 'Specifies the value of the Period Description field.';
                        ApplicationArea = All;
                        Editable = false;
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
                group("Personal Information")
                {
                    Editable = Rec."Target Status" = Rec."Target Status"::Setting;

                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                        Editable = true;
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
                group("Appraiser Information")
                {
                    Editable = Rec."Target Status" = Rec."Target Status"::Setting;

                    field("Appraiser No"; Rec."Appraiser No")
                    {
                        Caption = 'Supervisor No.';
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                        Caption = 'Supervisor Id';
                    }
                    field("Appraisers Name"; Rec."Appraisers Name")
                    {
                        Editable = false;
                        Caption = 'Supervisor Name';
                    }
                    field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                    {
                        Editable = false;
                        Caption = 'Supervisor Job Tittle';
                    }
                }
                group("Performance Score")
                {
                    field("Total Score"; Rec."Total Score")
                    {
                    }
                    field("Target Status"; Rec."Target Status")
                    {
                        Editable = false;
                    }
                }
            }
            part("Target Lines"; "Target Setup Lines")
            {
                Caption = 'Targets Setup';
                SubPageLink = "Target No" = FIELD("Target No"), "Employee No" = field("Employee No"), "Appraisal Period" = field("Appraisal Period");
                UpdatePropagation = Both;
                Editable = Rec."Target Status" = Rec."Target Status"::Setting;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Review")
            {
                Caption = 'Send Targets to Supervisor For Review';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WorkflowResponses: Codeunit "Workflow Responses";
                    Text001: Label 'Are you sure you want to Send document %1 for approval?';
                    LowerMarginError: Decimal;
                begin
                    LowerMarginError := 0;
                    HrSetup.Get();
                    HrSetup.TestField("Max Appraisal Score");
                    Rec.TestField("Appraisal Period");
                    Rec.TestField("Employee No");
                    Rec.CalcFields("Total score");
                    IF ((Rec."Total score" <= 0)) THEN ERROR('Kindly Define Appraisal goals');
                    //setup based
                    LowerMarginError := HrSetup."Max Appraisal Score" - 0.05;
                    if (Rec."Total score" >= LowerMarginError) AND (Rec."Total score" <= HrSetup."Max Appraisal Score") then begin
                    end
                    else
                        Error('Total Score must be equal to %1', HrSetup."Max Appraisal Score");
                    if Confirm(Text001, false, Rec."Target No") then
                        IF ApprovalsMgmt.CheckTargetSetupHeaderApprovalsWorkflowEnabled(Rec) THEN begin
                            ApprovalsMgmt.OnSendTargetSetupHeaderForApproval(Rec);
                        end;
                    CurrPage.Close();
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
                    ApprovalsMgmt.OnCancelTargetSetupHeaderApprovalRequest(Rec);
                    CurrPage.Close();
                end;
            }
            action("Review Targets")
            {
                Image = Process;
                Promoted = true;
                Caption = 'Review Targets';
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec."Target Status" = Rec."Target Status"::Approved;

                trigger OnAction()
                begin
                    Rec."Target Status" := Rec."Target Status"::Setting;
                    Message('Appraisal has been opened for Mid_Year Review');
                    CurrPage.Close();
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
                    ApprovalEntries.Setfilters2(Database::"Target Setup Header", ApprovalEntry."Document Type"::" ", Rec."Target No");
                    ApprovalEntries.Run;
                end;
            }
            action("Initiate Appraisal")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec."Target Status" = Rec."Target Status"::"Approved");
                Enabled = Rec.Initiated = false;

                trigger OnAction()
                begin
                    ReleaseRec.AppraisalInitiation(Rec);
                    Rec.Initiated := true;
                    Message('The Appraisal has been initiated Successfully');
                    CurrPage.Close();
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
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ReleaseRec: Codeunit "Document Release";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        HrSetup: Record "Human Resources Setup";

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Target Status" = Rec."Target Status"::Approved) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}
