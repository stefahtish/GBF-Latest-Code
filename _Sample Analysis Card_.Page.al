page 50972 "Sample Analysis Card"
{
    Caption = 'Sample Transmission';
    PageType = Card;
    SourceTable = "Sample analysis and reporting";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec."Submit results";

                field("Analysis No."; Rec."Analysis No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group(Schedule)
                {
                    Visible = ScheduleVisible;
                    ShowCaption = false;

                    field("Schedule No."; Rec."Schedule No.")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    field("Cluster Option"; Rec."Cluster Option")
                    {
                        ApplicationArea = All;
                    }
                }
                group(ClientDetails)
                {
                    Visible = ClientVisible;
                    ShowCaption = false;

                    field(Client; Rec.Client)
                    {
                        ApplicationArea = All;
                    }
                    field("Client Name"; Rec."Client Name")
                    {
                        ApplicationArea = All;
                    }
                    field("KDB License number"; Rec."KDB License number")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Cluster Details")
                {
                    ShowCaption = false;
                    Visible = clustered;

                    field(Cluster; Rec.Cluster)
                    {
                        ApplicationArea = All;
                    }
                }
                field("Testing date"; Rec."Testing date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Testing officer No."; Rec."Testing officer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Testing officer"; Rec."Testing officer")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                }
                field("Authorization officer"; Rec."Authorization officer")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Result authorization date"; Rec."Result authorization date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Result verification date"; Rec."Result verification date")
                // {
                //     ApplicationArea = All;
                // }
                field("Results date"; Rec."Results date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("COA No."; Rec."COA No.")
                {
                    ApplicationArea = All;
                }
                field("Manufacture Date"; Rec."Manufacture Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Checklist)
            {
                Visible = Pending;

                field("Correct Entries"; Rec."Correct Entries")
                {
                    Caption = 'Are the sample reception entries correct?';
                    ApplicationArea = All;
                }
                field("Correct Label"; Rec."Correct Label")
                {
                    Caption = 'Has the sample been correctly labelled?';
                    ApplicationArea = All;
                }
                field("Resource Availability"; Rec."Resource Availability")
                {
                    Caption = 'Resource availability?';
                    ApplicationArea = All;
                }
            }
            part("Sample Conditions Lines"; "Sample Conditions Lab Lines")
            {
                Editable = not Rec."Submit results";
                SubPageLink = "Entry No." = field("Analysis No.");
            }
            part("Tests conducted"; "Sample Targeted Tests Analysis")
            {
                Editable = not Rec."Submit results";
                Caption = 'Tests conducted';
                SubPageLink = "Entry No." = field("Analysis No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if ApprovalManagement.CheckSampleWorkflowEnabled(Rec) then ApprovalManagement.OnSendSampleRequestforApproval(Rec);
                    Commit;
                end;
            }
            action("Cancel Approval request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");
                //Enabled = "Status" = "Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                //  PromotedIsBig = true;
                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelSampleApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                //PromotedIsBig = true;
                trigger OnAction()
                var
                    Approvalentries: Page "Approval Entries";
                    Approvals: Record "Approval Entry";
                    DocumentType: Enum "Approval Document Type";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Sample Analysis And Reporting");
                    Approvals.SetRange("Document No.", Rec."Analysis No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
            action("Sent To lab")
            {
                Visible = not Rec."Sent to Lab";
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    LabManagement: Codeunit "Laboratory Management";
                begin
                    LabManagement.TransferSampleToLab(Rec);
                    CurrPage.Close();
                end;
            }
            action("Draft Certificate of Analysis")
            {
                Visible = false;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Report;

                //PromotedIsBig = true;
                trigger OnAction()
                var
                    SampleAnalysis: Record "Sample analysis and reporting";
                begin
                    SampleAnalysis.RESET;
                    SampleAnalysis.SETRANGE("Analysis No.", Rec."Analysis No.");
                    REPORT.RUN(Report::"COA Analysis", TRUE, FALSE, SampleAnalysis);
                end;
            }
            action("Final Certificate of Analysis")
            {
                Visible = false;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Report;

                //PromotedIsBig = true;
                trigger OnAction()
                var
                    SampleAnalysis: Record "Sample Test Lines";
                begin
                    SampleAnalysis.RESET;
                    SampleAnalysis.SETRANGE("Entry No.", Rec."Analysis No.");
                    REPORT.RUN(Report::"Final COA Analysis", TRUE, FALSE, SampleAnalysis);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;
        Pending: Boolean;
        AuthorizerName: Code[100];
        TesterName: Code[100];
        ClientVisible: Boolean;
        ScheduleVisible: Boolean;
        clustered: Boolean;

    local procedure SetControlAppearance()
    begin
        if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::"Pending Approval") then
            Pending := true
        else
            Pending := false;
        if Rec."Sample Type" = Rec."Sample Type"::"From Schedule" then
            ScheduleVisible := true
        else
            ScheduleVisible := false;
        if Rec."Sample Type" = Rec."Sample Type"::Client then
            ClientVisible := true
        else
            ClientVisible := false;
        if Rec."Cluster Option" = Rec."Cluster Option"::Cluster then
            clustered := true
        else
            clustered := false;
    end;
}
