page 50723 "Observation Interaction Card"
{
    Caption = 'Client Interaction Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Close,Escalate,Archive';
    SourceTable = "Client Interaction Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                //   Editable = InitialEditable;
                field("Interact Code"; Rec."Interact Code")
                {
                    Editable = false;
                }
                field("Client Type"; Rec."Client Type")
                {
                    Editable = InitialEditable;

                    trigger OnValidate()
                    begin
                        IsClientNoVisible := Rec.CheckIfClientNoVisible();
                        // CurrPage.UPDATE;
                        // COMMIT;
                        IsClientDetailsEditable := Rec.CheckIfClientDetailsEditable;
                        // CurrPage.UPDATE;
                        // COMMIT;
                    end;
                }
                group(Control11)
                {
                    Editable = InitialEditable;
                    ShowCaption = false;
                    Visible = IsClientNoVisible;

                    field("Client No."; Rec."Client No.")
                    {
                        Caption = 'Client No.';
                    }
                }
                group(Control12)
                {
                    Editable = InitialEditable;
                    ShowCaption = false;

                    field("Client Name"; Rec."Client Name")
                    {
                        Caption = 'Client Name';
                        // Editable = IsClientDetailsEditable;
                    }
                    field("Client Phone No."; Rec."Client Phone No.")
                    {
                    }
                    field("Client Email"; Rec."Client Email")
                    {
                        // Editable = IsClientDetailsEditable;
                    }
                    field(Address; Rec.Address)
                    {
                    }
                }
                field("Datetime Claim Received"; Rec."Datetime Claim Received")
                {
                    Editable = InitialEditable;
                }
                field("Datetime Claim Assigned"; Rec."Datetime Claim Assigned")
                {
                    Enabled = false;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    Editable = false;
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                    Editable = InitialEditable;
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                        CurrPage.Update;
                    end;
                }
                field("Problem Reported"; ProblemNotesText)
                {
                    caption = 'Issue Reported';
                    Editable = InitialEditable;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Problem Reported");
                        rec."Problem Reported".CREATEINSTREAM(Instr);
                        ProblemNote.READ(Instr);
                        IF ProblemNotesText <> FORMAT(ProblemNote) THEN BEGIN
                            CLEAR(Rec."Problem Reported");
                            CLEAR(ProblemNote);
                            ProblemNote.ADDTEXT(ProblemNotesText);
                            rec."Problem Reported".CREATEOUTSTREAM(OutStr);
                            ProblemNote.WRITE(OutStr);
                        END;
                    end;
                }
                field("Last Updated Date and Time"; Rec."Last Updated Date and Time")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                        CurrPage.Update;
                    end;
                }
                group(Escalated)
                {
                    ShowCaption = true;
                    Visible = EscalateVisible;

                    field("Is Escalated"; Rec."Is Escalated")
                    {
                    }
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = InitialEditable;
                }
                field("Departmental Email"; Rec."Departmental Email")
                {
                    Editable = InitialEditable;
                }
                field("Assign Remarks"; Rec."Assign Remarks")
                {
                    Editable = InitialEditable;
                }
                group(Escalation)
                {
                    Caption = 'Escalation';
                    Visible = Rec."Is Escalated" and EscalateVisible;

                    field("Escalation Employee No."; Rec."Escalation Employee No.")
                    {
                        Editable = false;
                    }
                    field("Escalation Employee Name"; Rec."Escalation Employee Name")
                    {
                        Editable = false;
                    }
                    field("Escalation Employee Email"; Rec."Escalation Employee Email")
                    {
                        Editable = false;
                    }
                    field("Escalation To User ID"; Rec."Escalation To User ID")
                    {
                        Editable = false;
                    }
                    field("Escalation Remarks"; Rec."Escalation Remarks")
                    {
                    }
                }
                group(Closed)
                {
                    Caption = 'Closed';
                    Editable = false;
                    Visible = Rec."Status" = Rec."Status"::Complete;

                    field("Closed By"; Rec."Closed By")
                    {
                    }
                    field("Closed DateTime"; Rec."Closed DateTime")
                    {
                    }
                }
                group(remarks)
                {
                    ShowCaption = false;
                    Visible = Rec.Archived or ArchivedVisible;
                    Enabled = ArchivedVisible;

                    field("Remarks/ Observation"; Rec."Remarks/ Observation")
                    {
                    }
                }
                group(ResolveVisible)
                {
                    ShowCaption = false;
                    Visible = ResolvedVisible;

                    field(Resolve; Rec.Resolve)
                    {
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            SetControlAppearance();
                        end;
                    }
                }
                group(Resolved)
                {
                    ShowCaption = false;
                    Visible = Rec.Resolve and ResolvedVisible;

                    //Enabled  = 
                    field("Hr Comment"; ResolutionNotesText)
                    {
                        Caption = 'Resolution';
                        ApplicationArea = Basic, Suite;
                        Enabled = ResolvedEditable;
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CALCFIELDS("Hr Comment");
                            rec."Hr Comment".CREATEINSTREAM(Instr);
                            ResolutionNote.READ(Instr);
                            IF ResolutionNotesText <> FORMAT(ResolutionNote) THEN BEGIN
                                CLEAR(Rec."Hr Comment");
                                CLEAR(ResolutionNote);
                                ResolutionNote.ADDTEXT(ResolutionNotesText);
                                rec."Hr Comment".CREATEOUTSTREAM(OutStr);
                                ResolutionNote.WRITE(OutStr);
                            END;
                        end;
                    }
                }
                field(Notes; Rec.Notes)
                {
                    Editable = not Rec.Archived;
                    MultiLine = true;
                }
            }
            part(Control7; "Client Interaction Docs")
            {
                SubPageLink = "Client Interaction" = FIELD("Interact Code");
                Visible = false;
            }
            part("Escalation Subform"; "Interactions Escalations")
            {
                Editable = IsEditable;
                SubPageLink = "Interaction Code" = FIELD("Interact Code");
                Visible = Rec."Status" = Rec."Status"::"Pending for Action";
            }
            part(Control1000000002; "Resolution Subform")
            {
                Editable = IsEditable;
                SubPageLink = "Interaction Header No." = FIELD("Interact Code");
                SubPageView = SORTING("Step No.") ORDER(Ascending);
                Visible = ShowResolutionList;
            }
            group("Previous Interactions")
            {
                Caption = 'Previous Interactions';
                Visible = false;

                part(Control1000000040; "Client Interaction List")
                {
                    SubPageLink = "Client No." = FIELD("Client No.");
                }
            }
        }
        area(factboxes)
        {
            part(Control33; "Previous Interaction ListPart")
            {
                SubPageLink = "Client No." = FIELD("Client No.");
            }
            part(Control35; "Resolution Subform ListPart")
            {
                SubPageLink = "Interaction Header No." = FIELD("Interact Code");
                Visible = NOT ShowResolutionList;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Interaction")
            {
                Caption = '&Interaction';

                action("&Client Details")
                {
                    Image = Open;

                    trigger OnAction()
                    begin
                        Rec.OpenCard();
                    end;
                }
                separator(sdf)
                {
                    Caption = 'sdf';
                }
                action("Notify Assigned User")
                {
                    Caption = 'Notify Assigned Department';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Rec.Stage = Rec.Stage::Initial;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.TestField("Departmental Email");
                        CompanyInfo.get();
                        CompanyInfo.TestField("E-Mail");
                        Clear(Receipients);
                        Receipients.add(Rec."Departmental Email");
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyName;
                        Body := Rec."Assign Remarks" + '. Interaction No: ' + Rec."Interact Code" + ' Client:' + Rec."Client Name";
                        Subject := Format(Rec."Interaction Type");
                        SMTP.Create(Receipients, Subject, '', true);
                        SMTP.AppendtoBody(Body);
                        Email.Send(SMTP);
                        Rec.Stage := Rec.Stage::Department;
                        CurrPage.Close();
                    end;
                }
                action("Escalate Incident")
                {
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = EscalateVisible and Rec."Is Escalated";

                    trigger OnAction()
                    begin
                        Rec.SetRange("Interact Code", Rec."Interact Code");
                        Clear(EscalationCard);
                        EscalationCard.SetTableView(Rec);
                        // EscalationCard.LookupMode(true);                    
                        IF EscalationCard.RUNMODAL = ACTION::OK THEN BEGIN
                            EscalationCard.GetNewDetails(EscNo, EscName, EscEmail, EscUserID, EscRemarks);
                            if EscEmail = '' then Error('Escalation email must be entered');
                            ClaimAssignment.EscalateCRMInteraction(Rec."Interact Code", EscNo, EscName, EscEmail, EscUserID, EscRemarks);
                            // Status := Status::Escalated;
                            Rec."Escalation Clock" := CreateDateTime(Today, Time);
                            if Rec."Escalation Level No." < 5 then Rec."Escalation Level No." := Rec."Escalation Level No." + 1;
                        end;
                    end;
                }
                action("Forward to HOD")
                {
                    Image = ClosePeriod;
                    Visible = HODVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Resolve);
                        Rec.TestField("Hr Comment");
                        Rec.Stage := Rec.Stage::HOD;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                }
                action("Forward to Corporate Department")
                {
                    Visible = Rec.Stage = Rec.Stage::HOD;
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // "Datetime Claim Assigned" := CreateDateTime(Today, Time);
                        Rec.Stage := Rec.Stage::Corporate;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                }
                action(Close)
                {
                    Caption = 'C&lose Interaction';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = CloseVisible;

                    trigger OnAction()
                    begin
                        if (Rec.Status = Rec.Status::Complete) then Error(CloseClaimError);
                        if Confirm('Do you want to close the current interaction?', false) = true then begin
                            // InsertDetailLine('System', 'Assigned', txtLineDescription);
                            //CloseClaimLog(Rec);
                            Rec."Closed By" := UserId;
                            Rec."Closed DateTime" := CreateDateTime(Today, Time);
                            Rec.Status := Rec.Status::Complete;
                            Rec.Stage := Rec.Stage::Closed;
                            Rec.Modify();
                        end;
                        CurrPage.Close;
                    end;
                }
                action(Archive)
                {
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = ArchivedVisible;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to archive the current interaction?', false) = true then begin
                            // InsertDetailLine('System', 'Assigned', txtLineDescription);
                            //CloseClaimLog(Rec);
                            Rec."Archived By" := UserId;
                            Rec."Archived DateTime" := CreateDateTime(Today, Time);
                            Rec.Archived := true;
                            Rec.Stage := Rec.Stage::Archived;
                            Rec.Modify();
                        end;
                        CurrPage.Close;
                    end;
                }
                action("Update Operations")
                {
                    Enabled = IsUpdated;
                    Visible = false;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Registry Notes");
                        InteractionSetup.Get();
                        if (InteractionSetup."Auto Assign on Registry") and (Rec."Assigned to User" = '') then
                            Error('Cannot update Operations on the closure of this claim until its Auto Assigned to an Operations User')
                        else
                            Rec.NotifyOperationsOnCreatedDoc(Rec);
                        //  Status := Status::Assigned;
                        Rec.Modify;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                // action("Complaint Form")
                // {
                //     Image = Report;
                //     Promoted = true;
                //     PromotedCategory = Report;
                //     PromotedIsBig = true;
                //     trigger OnAction()
                //     var
                //         ComplaintForm: report "Complaints Form";
                //     begin
                //         Rec.SetRange("Interact Code", "Interact Code");
                //         ComplaintForm.SetTableView(Rec);
                //         ComplaintForm.Run();
                //     end;
                // }
                action(Acknowledge)
                {
                    Image = Allocate;
                    Promoted = true;
                    Visible = Rec.Stage = Rec.Stage::Initial;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CompanyInfo: Record "Company Information";
                        CRMSetup: Record "Interaction Setup";
                    begin
                        if confirm('Are you sure?', false) then begin
                            Rec."Datetime Claim Assigned" := CreateDateTime(Today, Time);
                            CRMSetup.Get;
                            CRMSetup.TestField("MD Email");
                            Rec."Datetime Claim Assigned" := CreateDateTime(Today, Time);
                            Rec.TestField("Global Dimension 2 Code");
                            Rec.TestField("Departmental Email");
                            CompanyInfo.get();
                            CompanyInfo.TestField("E-Mail");
                            //Notify complainant
                            Clear(Receipients);
                            Receipients.add(Rec."Client Email");
                            SenderAddress := CompanyInfo."E-Mail";
                            SenderName := CompanyName;
                            Rec.CalcFields("Problem Reported");
                            AcknowledgeBody := 'The observation ' + ProblemNotesText + ' has been received and is being acted upon';
                            Subject := Format(Rec."Interaction Type");
                            SMTP.Create(Receipients, Subject, '', true);
                            SMTP.AppendtoBody(AcknowledgeBody);
                            email.Send(SMTP);
                            //Notify MD
                            AcknowledgeBody := 'The observation ' + ProblemNotesText + 'by' + Rec."Client Name" + 'has been received and is being acted upon';
                            Clear(Receipients);
                            Receipients.add(CRMSetup."MD Email");
                            SenderAddress := CompanyInfo."E-Mail";
                            SenderName := CompanyName;
                            Subject := Format(Rec."Interaction Type");
                            SMTP.Create(Receipients, Subject, '', true);
                            SMTP.AppendtoBody(AcknowledgeBody);
                            email.Send(SMTP);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("Show Resolutions Lines")
                {
                    Image = Indent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Hides the Resolution Lines';
                    Visible = NOT ShowResolutionList;

                    trigger OnAction()
                    begin
                        ShowResolutionList := true;
                    end;
                }
                action("Hide Resolution Lines")
                {
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Hides the Resolution Lines';
                    Visible = ShowResolutionList;

                    trigger OnAction()
                    begin
                        ShowResolutionList := false;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IsClaim := false;
        IsEditable := Rec.CheckifEditable();
        IsUpdated := Rec.AtRegistry();
        IsAssigned := Rec.Assigned();
        IsCleared := Rec.Cleared();
        IsClientDetailsEditable := Rec.CheckIfClientDetailsEditable;
        IsClientNoVisible := Rec.CheckIfClientNoVisible();
        DocumentCanAttach := true;
        Rec.CALCFIELDS("Problem Reported", "Hr Comment");
        rec."Problem Reported".CREATEINSTREAM(Instr);
        ProblemNote.READ(Instr);
        ProblemNotesText := FORMAT(ProblemNote);
        rec."Hr Comment".CREATEINSTREAM(Instr);
        ResolutionNote.READ(Instr);
        ResolutionNotesText := FORMAT(ResolutionNote);
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    trigger OnClosePage()
    begin
    end;

    trigger OnInsertRecord(BelowXRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."Interaction Type" := Rec."Interaction Type"::Observation;
    end;

    var
        ForceEscalation: Codeunit "Interaction Individual";
        SMTP: Codeunit "Email Message";
        Email: codeunit Email;
        ClaimAssignment: Codeunit "Claim Assignment";
        CompInceHdr: Record "Client Interaction Header";
        recClientInteractLine: Record "Client Interaction Line";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        InteractionSetup: Record "Interaction Setup";
        txtLineDescription: Text[30];
        SenderAddress: Text[80];
        Receipients: List of [Text];
        Subject: Text[150];
        Body: Text;
        AcknowledgeBody: Text;
        ProblemNote: BigText;
        ProblemNotesText: Text;
        ResolutionNote: BigText;
        ResolutionNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        SenderName: Text[80];
        SenderFullName: Text;
        [InDataSet]
        IsClaim: Boolean;
        [InDataSet]
        IsEditable: Boolean;
        [InDataSet]
        IsUpdated: Boolean;
        [InDataSet]
        IsAssigned: Boolean;
        [InDataSet]
        IsCleared: Boolean;
        ResolvedVisible: Boolean;
        ResolvedEditable: Boolean;
        ArchivedVisible: Boolean;
        HODVisible: Boolean;
        IsClientDetailsEditable: Boolean;
        DocumentCanAttach: Boolean;
        InitialEditable: Boolean;
        EscNo: code[20];
        EscName: code[100];
        EscUserID: Code[100];
        EscEmail: Text[100];
        IsClientNoVisible: Boolean;
        EscRemarks: Text[200];
        Text00001: Label 'Are you sure you want to send this Member %1, Claim as a %2 Clearance?';
        Text00002: Label 'Opening this record will update it on your account. Would you like to continue?';
        ShowResolutionList: Boolean;
        EscalationCard: Page "CRM Escalation card";
        EscalateVisible: Boolean;
        RegistryNotification: Notification;
        Text00003: Label 'Ensure you update the Scanned Documents in ADA and Assign to the Operations User updated in this record.';
        Text00004: Label 'This case has been handled by %1 at Registry and should be updated to Operations. Would you like to Update Operations?';
        Text00005: Label 'This is a Claim Document. Assigning it will create the Interaction Type Document and Assign the Operations User Selected. Do you want to Proceed?';
        MailTxt: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,</p><p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that Client Interaction No.<b>%2</b> has been escalated to you for futher action.Escalation Remark : "%3".</p> <p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>%4</p>';
        CloseVisible: Boolean;
        CloseClaimError: Label 'You cannot close a Claim at this stage.';

    procedure InsertDetailLine1(ptxtLineType: Text[30]; ptxtActionType: Text[30]; ptxtDescription: Text[30])
    var
        lintLineNo: Integer;
        lClIntHdr: Record "Client Interaction Header";
    begin
        //C004
        recClientInteractLine.Reset;
        recClientInteractLine.SetRange("Client Interaction No.", Rec."Interact Code");
        if recClientInteractLine.FindLast then
            lintLineNo := recClientInteractLine."Line No." + 10000
        else
            lintLineNo := 10000;
        recClientInteractLine.Init;
        recClientInteractLine."Client Interaction No." := Rec."Interact Code";
        recClientInteractLine."Line No." := lintLineNo;
        Evaluate(recClientInteractLine."Line Type", ptxtLineType);
        Evaluate(recClientInteractLine."Action Type", ptxtActionType);
        recClientInteractLine."User ID" := UserId;
        recClientInteractLine."Date and Time" := CreateDateTime(WorkDate, Time);
        recClientInteractLine.Description := ptxtDescription;
        recClientInteractLine.Insert;
        if (ptxtActionType = 'Assigned') or (ptxtActionType = 'Escalated') or (ptxtActionType = 'Response Out') or (ptxtActionType = 'Reply In') then Rec."Escalation Clock" := CreateDateTime(WorkDate, Time);
        Rec."Last Updated Date and Time" := CreateDateTime(WorkDate, Time);
        Rec.Modify;
    end;

    procedure GetNextLineNo1(CompLine: Record "Client Interaction Line"; BelowxRec: Boolean): Integer
    var
        CompLine2: Record "Client Interaction Line";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo := 0;
        LineStep := 10000;
        CompLine2.Reset;
        CompLine2.SetRange("Client Interaction No.", Rec."Interact Code");
        if CompLine2.FindLast then
            NextLineNo := CompLine2."Line No." + LineStep
        else
            NextLineNo := LineStep;
        exit(NextLineNo);
    end;

    local procedure GetRegistryNotification()
    begin
        RegistryNotification.Message(Text00003);
        RegistryNotification.Send;
    end;

    local procedure SendEscalationMail()
    begin
    end;

    local procedure GetUserFullName(UserName: Code[100]): Text
    var
        User: Record User;
    begin
        User.Reset;
        User.SetRange("User Name", UserName);
        if User.FindFirst then exit(User."Full Name");
    end;

    local procedure SetControlAppearance()
    begin
        if ((Rec.Stage = Rec.Stage::Initial) and (Rec.Resolve)) or (Rec.Stage = Rec.Stage::Corporate) then
            CloseVisible := true
        else
            CloseVisible := false;
        if (Rec.Stage = Rec.Stage::Initial) then
            InitialEditable := true
        else
            InitialEditable := false;
        if (Rec.Stage = Rec.Stage::HOD) or (Rec.Stage = Rec.Stage::Department) or (Rec.Stage = Rec.Stage::Escalated) then
            EscalateVisible := true
        else
            EscalateVisible := false;
        if (Rec.Stage = Rec.Stage::HOD) or (Rec.Stage = Rec.Stage::Corporate) or (Rec.Stage = Rec.Stage::Escalated) or (Rec.Stage = Rec.Stage::Initial) then
            ResolvedVisible := true
        else
            ResolvedVisible := false;
        if (Rec.Stage = Rec.Stage::Escalated) or (Rec.Stage = Rec.Stage::Initial) or (Rec.Stage = Rec.Stage::Department) then
            ResolvedEditable := true
        else
            ResolvedEditable := false;
        if (Rec.Stage = Rec.Stage::Escalated) then
            HODVisible := true
        else
            HODVisible := false;
        if (Rec.Stage = Rec.Stage::Closed) then
            ArchivedVisible := true
        else
            ArchivedVisible := false;
    end;
}
