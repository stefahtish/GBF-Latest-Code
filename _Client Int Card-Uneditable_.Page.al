page 50846 "Client Int Card-Uneditable"
{
    Caption = 'Client Interaction Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Close,Escalate';
    SourceTable = "Client Interaction Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Interact Code"; Rec."Interact Code")
                {
                    Editable = false;
                }
                field("Client Type"; Rec."Client Type")
                {
                    Editable = Rec."Status" = Rec."Status"::"Pending for Action";

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
                // group(Control11)
                // {
                //     Editable = "Status" = "Status"::Logged;
                //     ShowCaption = false;
                //     Visible = IsClientNoVisible;
                //     field("Client No."; "Client No.")
                //     {
                //         Caption = 'Client No.';
                //     }
                // }
                group(Control12)
                {
                    Editable = IsClientDetailsEditable;
                    ShowCaption = false;

                    field("Client Name"; Rec."Client Name")
                    {
                        Caption = 'Client Name';
                        Editable = IsClientDetailsEditable;
                    }
                    field("Client Phone No."; Rec."Client Phone No.")
                    {
                    }
                    field("Client Email"; Rec."Client Email")
                    {
                        Editable = IsClientDetailsEditable;
                    }
                }
                group(Control29)
                {
                    ShowCaption = false;

                    field("Client Log Name"; Rec."Client Log Name")
                    {
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'This specifies the name of the client coming to fill in the details for the case';
                    }
                    field("Client Communication Phone No."; Rec."Client Communication Phone No.")
                    {
                        ExtendedDatatype = PhoneNo;
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                    }
                    field("Client Comminication E-Mail"; Rec."Client Comminication E-Mail")
                    {
                        ExtendedDatatype = EMail;
                    }
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Editable = IsEditable;
                    Visible = false;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    Editable = false;
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                    Editable = IsEditable;
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    Editable = IsEditable;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                        CurrPage.Update;
                    end;
                }
                field("Interaction Type No."; Rec."Interaction Type No.")
                {
                    Caption = 'Interaction Document';
                    Editable = IsEditable;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Interaction Type Desc."; Rec."Interaction Type Desc.")
                {
                    Caption = 'Interaction Doc. Desc.';
                    Editable = false;
                }
                field("Interaction Resolution No."; Rec."Interaction Resolution No.")
                {
                    Visible = false;
                }
                field("Interaction Resolution Desc."; Rec."Interaction Resolution Desc.")
                {
                    Visible = false;
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
                group("User Assigning")
                {
                    Caption = 'User Assigning';
                    Editable = false;

                    field("User ID"; Rec."User ID")
                    {
                        Editable = false;
                    }
                    field("User DateTime Received"; Rec."User DateTime Received")
                    {
                    }
                    field("User DateTime Closed"; Rec."User DateTime Closed")
                    {
                    }
                }
                field("Assign/Escalate"; Escalate)
                {
                    trigger OnValidate()
                    begin
                        if not Escalate then Rec."Escalation To User ID" := '';
                        Rec."Escalation Remarks" := '';
                    end;
                }
                group(Escalation)
                {
                    Caption = 'Escalation';
                    Visible = "Escalate" OR Rec."Is Escalated";

                    field("Escalation To User ID"; Rec."Escalation To User ID")
                    {
                    }
                    field("Escalation Remarks"; Rec."Escalation Remarks")
                    {
                    }
                }
                group(Control41)
                {
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;

                    field("Escalation Level No."; Rec."Escalation Level No.")
                    {
                        Editable = false;
                    }
                    field("Escalation Level Name"; Rec."Escalation Level Name")
                    {
                        Editable = false;
                    }
                    field("Escalation Clock"; Rec."Escalation Clock")
                    {
                        Editable = false;
                    }
                }
                group("Registry Assigning")
                {
                    Caption = 'Registry Assigning';
                    Editable = false;
                    Visible = false;

                    field("Registry User"; Rec."Registry User")
                    {
                    }
                    field("Registry User DateTime Receive"; Rec."Registry User DateTime Receive")
                    {
                    }
                    field("Registry User DateTime Closed"; Rec."Registry User DateTime Closed")
                    {
                    }
                }
                group("Operations Assigning")
                {
                    Caption = 'Operations Assigning';
                    Visible = false;

                    field("Assigned to User"; Rec."Assigned to User")
                    {
                        Editable = false;
                    }
                    field("Assign Remarks"; Rec."Assign Remarks")
                    {
                        Editable = false;
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
                group(Control14)
                {
                    ShowCaption = false;
                    Visible = false;

                    field("Registry Notes"; Rec."Registry Notes")
                    {
                        MultiLine = true;
                    }
                }
                field(Notes; Rec.Notes)
                {
                    Editable = IsEditable;
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
                //  Visible = "Status" = "Status"::"Pending for Action";
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
                    Caption = 'Notify Assigned User';

                    trigger OnAction()
                    begin
                        Rec.TestField("Assigned to User");
                        if UserSetup.Get(Rec."Assigned to User") then Receipients.add(UserSetup."E-Mail");
                        if UserSetup.Get(UserId) then begin
                            SenderAddress := UserSetup."E-Mail";
                            SenderName := CompanyName;
                        end;
                        Body := Rec."Assign Remarks" + ' Interaction No. ' + Rec."Interact Code" + ' Client' + Rec."Client No.";
                        Subject := Format(Rec."Interaction Type");
                        SMTP.Create(Receipients, Subject, '', true);
                        SMTP.AppendtoBody(Body);
                        Email.Send(SMTP);
                    end;
                }
                action(Escalate)
                {
                    Caption = '&Escalate';
                    Enabled = Escalate;
                    Image = MoveToNextPeriod;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Please confirm that you would like to change the status of the interaction to Escalated.', false) = true then begin
                            Rec.TestField("Escalation Remarks");
                            Rec.TestField("Escalation To User ID");
                            if UserSetup2.Get(Rec."Escalation To User ID") then Receipients.add(UserSetup2."E-Mail");
                            if UserSetup.Get(UserId) then begin
                                SenderAddress := UserSetup."E-Mail";
                                SenderName := UserId;
                                //UserSetup.CalcFields("Full Name");
                                SenderFullName := UserSetup."Full Name";
                            end;
                            Body := StrSubstNo(MailTxt, GetUserFullName(Rec."Escalation To User ID"), Rec."Interact Code", Rec."Escalation Remarks", SenderFullName);
                            Subject := 'Escalation: ' + Format(Rec."Interact Code");
                            //Send Mail
                            //ClaimAssignment.SendInteractionMail(Receipients, SenderFullName, SenderAddress, Body, Subject);
                            // Status := Status::Escalated;
                            Rec."Escalation Clock" := CreateDateTime(Today, Time);
                            if Rec."Escalation Level No." < 5 then Rec."Escalation Level No." := Rec."Escalation Level No." + 1;
                            Rec.Modify;
                            //Insert Log
                            Rec.CreateResolutionLogs(Rec, '', 0, Rec."Escalation To User ID", Rec."Escalation Remarks", 0, Rec.Status, CreateDateTime(WorkDate, Time));
                            Rec.CloseResolutionLog(Rec, Rec.GetPreviousStepNo(Rec), UserId, CreateDateTime(Today, Time));
                            Commit;
                            CurrPage.Close;
                        end;
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
                            // CloseClaimLog(Rec);
                            Rec.Status := Rec.Status::Complete;
                        end;
                        Commit;
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
                        Rec.Modify;
                        Commit;
                        CurrPage.Close;
                    end;
                }
                action(Assign)
                {
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Move to Assignment';

                    trigger OnAction()
                    begin
                        if confirm('Are you sure?', false) then begin
                            Rec.Modify();
                            CurrPage.Close();
                        end;
                        /*EscaletAndAssignInteraction(Rec);
                            CreateResolutionLogs(Rec, '', 0, Rec."Escalation To User ID", Rec."Escalation Remarks", 0, 1, CreateDateTime(Today, Time));
                            CloseResolutionLog(Rec, 1, UserId, CreateDateTime(Today, Time));
                            "Is Escalated" := true;
                            Commit;
                            CurrPage.Close;*/
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
        SetControlAppearance;
    end;

    trigger OnClosePage()
    begin
        // IF ("Registry User"<>'') AND
        //  (Status=Status::Registry) AND
        //  (("Claim Created Document"=FALSE) OR ("Created Document No."=''))
        //  THEN
        //  BEGIN
        //    IF CONFIRM(Text00004,FALSE,"Registry User") THEN
        //      BEGIN
        //          TESTFIELD("Registry Notes");
        //        InteractionSetup.GET();
        //        IF (InteractionSetup."Auto Assign on Registry") AND ("Assigned to User"='') THEN
        //          ERROR('Cannot update Operations on the closure of this claim until its Auto Assigned to an Operations User')
        //        ELSE
        //          RecordUpdated_Registry(Rec);
        //          COMMIT;
        //          CurrPage.CLOSE;
        //          MESSAGE('Updated Operations Successful');
        //        END;
        //    END;
    end;

    trigger OnOpenPage()
    begin
        IsClaim := false;
        IsEditable := Rec.CheckifEditable();
        IsUpdated := Rec.AtRegistry();
        IsAssigned := Rec.Assigned();
        IsCleared := Rec.Cleared();
        IsClientDetailsEditable := Rec.CheckIfClientDetailsEditable();
        IsClientNoVisible := Rec.CheckIfClientNoVisible();
        DocumentCanAttach := true;
        ShowResolutionList := false;
        // if ("Registry User" = '') and (Status = Status::Registry) then begin
        //     if UserSetup.Get(UserId) then begin
        //         if UserSetup."Registry Handler" then begin
        //             Message('As a registry user, this record will be updated under your Account');
        //             UpdateRegistryUserDetails(Rec);
        //             //GetRegistryNotification;
        //             //    IF NOT CONFIRM(Text00002,FALSE) THEN
        //             //    CurrPage.CLOSE
        //             //   ELSE
        //             //    UpdateRegistryUserDetails(Rec);
        //             //    MESSAGE('Here');
        //         end;
        //     end;
        // end;
        // IF ("Registry User"<>'') AND (Status=Status::Registry) THEN
        // GetRegistryNotification;
        SetControlAppearance;
    end;

    var
        ForceEscalation: Codeunit "Interaction Individual";
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
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
        IsClientDetailsEditable: Boolean;
        DocumentCanAttach: Boolean;
        IsClientNoVisible: Boolean;
        Text00001: Label 'Are you sure you want to send this Member %1, Claim as a %2 Clearance?';
        Text00002: Label 'Opening this record will update it on your account. Would you like to continue?';
        ShowResolutionList: Boolean;
        Escalate: Boolean;
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
        // if ptxtActionType = 'Response Out' then
        //     Status := Status::"Awaiting 3rd Party";
        // if ptxtActionType = 'Reply In' then
        //     if "Escalation Level No." > 0 then
        //         Status := Status::Escalated
        //     else
        //         Status := Status::Assigned;
        // if ptxtActionType = 'Closed' then
        //     Status := Status::Closed;
        Rec."Last Updated Date and Time" := CreateDateTime(WorkDate, Time);
        Rec.Modify;
        /*
            ComplaintLine.RESET;
            ComplaintLine.INIT;
            ComplaintLine."Line No." := GetNextLineNo(ComplaintLine,FALSE);
            ComplaintLine."Client Interaction No." := "No.";
            ComplaintLine."Client Code" := "Client No.";
            ComplaintLine."User Id (Reg. By)" := "User ID";
            ComplaintLine."Assigned to User" := "Assigned to User";
            ComplaintLine.Status := Status;
            ComplaintLine."Escalation Level No." := "Escalation Level No.";
            ComplaintLine.Notes := Notes;
            ComplaintLine.INSERT;
            */
        //C004
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
        // if (Status = Status::Logged) or (Status = Status::Closed) then
        //     CloseVisible := false
        // else
        CloseVisible := true;
    end;
}
