page 50914 "Risk Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Risk Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                label("Raised By:")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'User ID';
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Identified"; Rec."Date Identified")
                {
                    Caption = 'Date Identified';
                    ApplicationArea = Basic, Suite;
                    Enabled = NewVisible;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Risk Type';
                    ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                    Enabled = NewVisible;

                    trigger OnValidate()
                    begin
                        CheckVisibility;
                    end;
                }
                field("Risk Code"; Rec."Risk Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Risk Description"; RiskNotesText)
                // {
                //     ApplicationArea = Basic, Suite;
                //     MultiLine = true;
                //     trigger OnValidate()
                //     begin
                //         CALCFIELDS("Risk Description");
                //         "Risk Description".CREATEINSTREAM(Instr);
                //         RiskNote.READ(Instr);
                //         IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                //             CLEAR("Risk Description");
                //             CLEAR(RiskNote);
                //             RiskNote.ADDTEXT(RiskNotesText);
                //             "Risk Description".CREATEOUTSTREAM(OutStr);
                //             RiskNote.WRITE(OutStr);
                //         END;
                //     end;
                // }
                field("Risk Opportunity Assessment"; Rec."Risk Opportunity Assessment")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = Rec."Type" = Rec."Type"::"Risk Opportunity";
                }
                label("Risk Area:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Risk Region"; Rec."Risk Region")
                {
                    Caption = 'Risk Department Code';
                    ApplicationArea = Basic, Suite;
                    Enabled = NewVisible;
                }
                field("Risk Region Name"; Rec."Risk Region Name")
                {
                    Caption = 'Risk Department Name';
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Responsible Officer No."; Rec."Responsible Officer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer Name"; Rec."Responsible Officer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                // field("HOD User ID"; "HOD User ID")
                // {
                //     Caption = 'Risk Department Champion';
                //     ApplicationArea = Basic, Suite;
                //     Enabled = false;
                // }
                field("Review Date"; Rec."Review Date")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Mark Okay"; Rec."Mark Okay")
                {
                    Caption = 'Confirm all pre-requsites have been met';
                    ApplicationArea = Basic, Suite;
                    Enabled = ChampionEnabled;
                }
                field("Risk Description2"; Rec."Risk Description2")
                {
                    Caption = 'Prerequisites that have been met';
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Enabled = ChampionEnabled;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    Enabled = ChampionEnabled;
                    ApplicationArea = Basic, Suite;
                }
                field("Linked Incident"; Rec."Linked Incident")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Previous Incident';
                    Enabled = NewVisible;
                }
                field("Linked Incident Description"; Rec."Linked Incident Description")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Previous Incident Description';
                    Enabled = false;
                }
            }
            group(RiskDefinition)
            {
                Caption = 'Risk Details';

                field("Root Cause Analysis"; RootCauseTxt)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Root Cause Analysis");
                        REC."Root Cause Analysis".CREATEINSTREAM(Instr);
                        RootCauseBigTxt.READ(Instr);
                        IF RootCauseTxt <> FORMAT(RootCauseBigTxt) THEN BEGIN
                            CLEAR(Rec."Root Cause Analysis");
                            CLEAR(RootCauseBigTxt);
                            RootCauseBigTxt.ADDTEXT(RootCauseTxt);
                            REC."Root Cause Analysis".CREATEOUTSTREAM(OutStr);
                            RootCauseBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
                field("Mitigation Suggestions"; MitigationTxt)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Mitigation Suggestions");
                        REC."Mitigation Suggestions".CREATEINSTREAM(Instr);
                        MitigationBigTxt.READ(Instr);
                        IF MitigationTxt <> FORMAT(MitigationBigTxt) THEN BEGIN
                            CLEAR(Rec."Mitigation Suggestions");
                            CLEAR(MitigationBigTxt);
                            MitigationBigTxt.ADDTEXT(MitigationTxt);
                            REC."Mitigation Suggestions".CREATEOUTSTREAM(OutStr);
                            MitigationBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
                // part(RiskDrivers; "Risk Drivers")
                // {
                //     Caption = 'Root Cause Analysis';
                //     SubPageLink = "Document No." = FIELD("No."), Type = CONST(Drivers);
                // }
                // part(RiskMitigationPropose; "Risk Mitigation Propose")
                // {
                //     Caption = 'Mitigation Suggestions';
                //     SubPageLink = "Document No." = FIELD("No."), Type = CONST("Mitigation Proposal");
                // }
            }
            group("Risk Assessment")
            {
                Caption = 'Assesment & Valuation';

                group("GROSS CATEGORY")
                {
                    field("Risk Category"; Rec."Risk Category")
                    {
                        Caption = 'Risk Category';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Category Description"; Rec."Risk Category Description")
                    {
                        Caption = 'Risk Category Description';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                }
                group("GROSS RISK")
                {
                    group("RISK VALUE")
                    {
                        field("Value at Risk (Amount)"; Rec."Value at Risk")
                        {
                            Caption = 'Value at Risk';
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    field("Risk Probability"; Rec."Risk Probability")
                    {
                        Caption = 'Risk probability(%)';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Likelihood Value"; Rec."Risk Likelihood Value")
                    {
                        Caption = 'Likelihood Score';
                        Enabled = false;
                    }
                    field("Risk Likelihood"; Rec."Risk Likelihood")
                    {
                        Caption = 'Risk Likelihood';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Risk Impact Value"; Rec."Risk Impact Value")
                    {
                        Caption = 'Impact Score';
                        Enabled = false;
                    }
                    field("Risk Impact"; Rec."Risk Impact")
                    {
                        Caption = 'Risk Impact';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Risk (L * I)"; Rec."Risk (L * I)")
                    {
                        Caption = 'Gross Risk Score';
                        Enabled = false;
                    }
                    field("RAG Status"; Rec."RAG Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                }
                group(ControlGroup)
                {
                    Caption = 'RISK CONTROL';

                    field("Existing Risk Controls"; ExistingTxt)
                    {
                        ApplicationArea = All;
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CALCFIELDS("Existing Risk Controls");
                            rec."Existing Risk Controls".CREATEINSTREAM(Instr);
                            ExistingBigTxt.READ(Instr);
                            IF ExistingTxt <> FORMAT(ExistingBigTxt) THEN BEGIN
                                CLEAR(Rec."Existing Risk Controls");
                                CLEAR(ExistingBigTxt);
                                ExistingBigTxt.ADDTEXT(ExistingTxt);
                                rec."Existing Risk Controls".CREATEOUTSTREAM(OutStr);
                                ExistingBigTxt.WRITE(OutStr);
                            END;
                        end;
                    }
                    field("Additional mitigation controls"; Rec."Additional mitigation controls")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                group(Controls)
                {
                    field("Value after Control"; Rec."Value after Control")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Control Risk Probability"; Rec."Control Risk Probability")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Control Evaluation Likelihood"; Rec."Control Evaluation Likelihood")
                    {
                        Caption = 'Control risk likelihood value';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Control Risk Likelihood"; Rec."Control Risk Likelihood")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Control Evaluation Impact"; Rec."Control Evaluation Impact")
                    {
                        Caption = 'Control risk impact value';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Control Risk Impact"; Rec."Control Risk Impact")
                    {
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Control Risk (L * I)"; Rec."Control Risk (L * I)")
                    {
                        Caption = 'Control Gross risk';
                        ApplicationArea = Basic, Suite;
                        Enabled = false;
                    }
                    field("Control RAG Status"; Rec."Control RAG Status")
                    {
                        Enabled = false;
                    }
                }
                group("RESIDUAL RISK")
                {
                    field("Residual Value"; Rec."Residual Value")
                    {
                        Enabled = false;
                    }
                    field("Residual Risk Likelihood"; Rec."Residual Risk Likelihood")
                    {
                        Caption = 'Residual Likelihood Value';
                        Enabled = false;
                    }
                    field("Residual Risk Likelihood Cat"; Rec."Residual Risk Likelihood Cat")
                    {
                        Enabled = false;
                    }
                    field("Residual Likelihood Impact"; Rec."Residual Likelihood Impact")
                    {
                        Caption = 'Residual Impact Value';
                        Enabled = false;
                    }
                    field("Residual Risk Impact"; Rec."Residual Risk Impact")
                    {
                        Enabled = false;
                    }
                    field("Residual Risk (L * I)"; Rec."Residual Risk (L * I)")
                    {
                        Caption = 'Residual Risk Score';
                        Enabled = false;
                    }
                    field("Residual RAG Status"; Rec."Residual RAG Status")
                    {
                        Enabled = false;
                    }
                }
                field("Risk Acceptance Decision"; Rec."Risk Acceptance Decision")
                {
                    ApplicationArea = All;
                }
                field("Board Recommendation"; Rec."board Recommendation")
                {
                    ApplicationArea = All;
                }
            }
            part(RiskKRIs; "Risk KRI(s)")
            {
                Caption = 'Risk KRI(s)';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Type = CONST("KRI(s)");
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = LinksVisible;
            }
            systempart(Notes; Notes)
            {
                Visible = LinksVisible;
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if ApprovalsMgmt.CheckRiskHeaderWorkflowEnabled(Rec) then begin
                            ApprovalsMgmt.OnSendRiskHeaderForApproval(Rec);
                            Rec."Document Status" := Rec."Document Status"::HOD;
                            CurrPage.CLOSE;
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1';
                    begin
                        ApprovalsMgmt.OnCancelRiskHeaderApprovalRequest(Rec);
                        CurrPage.Close;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", Database::"Risk Header");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action(SendRisk)
            {
                Caption = 'Report Risk';
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NewVisible;

                trigger OnAction()
                begin
                    // TestField("Risk Description");
                    //TestField("Risk Region");
                end;
            }
            action("Send To Board")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = sendToBoardVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::"Board Review";
                    // AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Send To MD")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = sendToMDVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::MD;
                    //AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Send To User")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = sendToUserVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::HOD;
                    //AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Send To Auditor")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = sendToUAuditorVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::Auditor;
                    //AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Resolve")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ResolveVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::Resolved;
                    //AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Close")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ResolveVisible;

                trigger OnAction()
                begin
                    Rec."Document Status" := Rec."Document Status"::Closed;
                    //AuditMgt.RiskRegistersSTRNMenu(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(ShowLinks)
            {
                Caption = 'Show Links';
                Image = Link;
                ApplicationArea = Basic, Suite;
                Promoted = false;
                Visible = not LinksVisible;

                trigger OnAction()
                begin
                    ShowLinksPage();
                end;
            }
            action(HideLinks)
            {
                Caption = 'Hide Links';
                Image = Link;
                ApplicationArea = Basic, Suite;
                Promoted = false;
                Visible = LinksVisible;

                trigger OnAction()
                begin
                    HidePageLinks();
                end;
            }
            action("Escalate")
            {
                Visible = ChampionEnabled;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.SendMailtoRiskChampion2(Rec);
                    Rec.Modify(true);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Risk';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = ChampionEnabled;

                trigger OnAction()
                begin
                    if Rec."Rejection Reason" = '' then Error('Please input reject reason');
                    AuditMgt.NotifySenderOnChanges(Rec);
                    Rec."Document Status" := Rec."Document Status"::New;
                    Rec.Modify();
                    CurrPage.CLOSE;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CheckVisibility;
        SetControlAppearance();
        Rec.CALCFIELDS("Risk Description", "Root Cause Analysis", "Mitigation Suggestions", "Existing Risk Controls");
        rec."Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);
        rec."Root Cause Analysis".CREATEINSTREAM(Instr);
        RootCauseBigTxt.READ(Instr);
        RootCauseTxt := FORMAT(RootCauseBigTxt);
        rec."Mitigation Suggestions".CREATEINSTREAM(Instr);
        MitigationBigTxt.READ(Instr);
        MitigationTxt := FORMAT(MitigationBigTxt);
        rec."Existing Risk Controls".CREATEINSTREAM(Instr);
        ExistingBigTxt.READ(Instr);
        ExistingTxt := FORMAT(ExistingBigTxt);
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        CheckVisibility;
    end;

    var
        NewVisible: Boolean;
        ChampionEnabled: Boolean;
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        RootCauseBigTxt: BigText;
        RootCauseTxt: Text;
        MitigationBigTxt: BigText;
        MitigationTxt: Text;
        ExistingBigTxt: BigText;
        ExistingTxt: Text;
        AuditMgt: Codeunit "Internal Audit Management";
        UserSetup: Record "User Setup";
        SendToRegister: Boolean;
        SendToHOD: Boolean;
        SendToChampion: Boolean;
        SendToPM: Boolean;
        SendBackToChamp: Boolean;
        CurrUserCanEdit: Boolean;
        RiskAssessment: Boolean;
        RiskME: Boolean;
        RiskResponse: Boolean;
        RiskValue: Boolean;
        RiskOpportunity: Boolean;
        [InDataSet]
        LinksVisible: Boolean;
        sendToBoardVisible: Boolean;
        sendToMDVisible: Boolean;
        sendToUserVisible: Boolean;
        sendToUAuditorVisible: Boolean;
        ResolveVisible: Boolean;
        closeVisible: Boolean;
        sendToAuditor: Boolean;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;

    local procedure CheckVisibility()
    begin
        HidePageLinks();
    end;

    procedure SetControlAppearance()
    begin
        if (Rec."Document Status" = Rec."Document Status"::New) then
            NewVisible := true
        else
            NewVisible := false;
        if Rec."Document Status" = Rec."Document Status"::New then
            SendToChampion := true
        else
            SendToChampion := false;
        if (Rec."Document Status" = Rec."Document Status"::HOD) or (Rec."Document Status" = Rec."Document Status"::MD) then
            sendToBoardVisible := true
        else
            sendToBoardVisible := false;
        if (Rec."Document Status" = Rec."Document Status"::HOD) then
            sendToBoardVisible := true
        else
            sendToBoardVisible := false;
        if (Rec."Document Status" = Rec."Document Status"::HOD) then
            sendToMDVisible := true
        else
            sendToMDVisible := false;
        if (Rec."Document Status" = Rec."Document Status"::HOD) then
            sendToMDVisible := true
        else
            sendToMDVisible := false;
        if (Rec."Document Status" = Rec."Document Status"::MD) or (Rec."Document Status" = Rec."Document Status"::"Board Review") then
            sendToUserVisible := true
        else
            sendToUserVisible := false;
        if (Rec."Document Status" = Rec."Document Status"::HOD) or (Rec."Document Status" = Rec."Document Status"::MD) or (Rec."Document Status" = Rec."Document Status"::"Board Review") then
            ResolveVisible := true
        else
            ResolveVisible := false;
    end;

    procedure ShowLinksPage()
    begin
        LinksVisible := true;
    end;

    procedure HidePageLinks()
    begin
        LinksVisible := false;
    end;
}
