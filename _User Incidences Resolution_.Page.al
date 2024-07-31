page 50561 "User Incidences Resolution"
{
    PageType = Card;
    SourceTable = "User Support Incident";
    SourceTableView = WHERE("Incident Status" = FILTER(Unresolved));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Editable = false;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field("User email Address"; Rec."User email Address")
                {
                    Editable = false;
                }
                field("Incidence Location"; Rec."Incidence Location")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group(Incident)
            {
                field("Incident Description"; Rec."Incident Description")
                {
                    Editable = false;
                    MultiLine = true;
                }
                field("Screen Shot"; Rec."Screen Shot")
                {
                    Editable = false;
                }
            }
            group("Incidence Action")
            {
                group(Control25)
                {
                    Editable = (Rec."Status" = Rec."Status"::Pending) OR (Rec."Status" = Rec."Status"::Escalated);
                    ShowCaption = false;

                    field("Action Date"; Rec."Action Date")
                    {
                        Editable = false;
                    }
                    field("Incident Status"; Rec."Incident Status")
                    {
                        Editable = false;
                    }
                    field("Action taken"; Rec."Action taken")
                    {
                        MultiLine = true;
                        ShowMandatory = true;
                    }
                }
                group(Control24)
                {
                    ShowCaption = false;
                    Visible = Rec."Status" = Rec."Status"::Solved;

                    field("User Remarks"; Rec."User Remarks")
                    {
                        MultiLine = true;
                        ShowMandatory = true;
                    }
                }
            }
            group("Incidence Escalation")
            {
                Visible = false;

                field("Escalate To"; Rec."Escalate To")
                {
                }
                field("Ecalation Date"; Rec."Ecalation Date")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Resolve)
            {
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Incident Status" = Rec."Incident Status"::Resolved then Error(Error0001);
                    Rec.TestField("Action taken");
                    Rec."Action By" := UserId;
                    Rec."Action Date" := Today;
                    Rec."Action Time" := Time;
                    GetActionBy(Rec."Action By");
                    GetActionName(Rec."Action By");
                    Rec."Incidence Resolved" := true;
                    Rec.Status := Rec.Status::Solved;
                    Rec."Incident Status" := Rec."Incident Status"::Resolved;
                    Rec.Modify;
                    IncidentResolved(Rec."Incident Reference");
                    CurrPage.Close;
                end;
            }
            action(EscalateAction)
            {
                Image = MoveUp;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec."Action By" := UserId;
                    if Confirm('Do you want to escalate this incident?') then Escalate(Rec."Incident Reference");
                    Rec.Status := Rec.Status::Escalated;
                    Message('Incident %1 has been escalated successfully');
                    CurrPage.Close;
                end;
            }
        }
    }
    var
        Error0001: Label 'This Incident has already been resolved';
        Incident: Record "User Support Incident";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        SMTP: Codeunit "email message";
        Email: Codeunit Email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [Text];
        RecipientBCC: list of [text];
        Attachment: Text;
        ErrorMsg: Text;
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        ICTSetup: Record "ICT Setup";

    procedure IncidentResolved(IncidentNo: Code[20])
    var
        Text0001: Label 'Hi, <br><br>You Incident %1 has been resolved. Kindly verify and close the Incident. <br><br>Thank you.<br><br>Regards,<br><br>%2';
    begin
        Incident.Reset;
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            SenderAddress := GetActionName(Incident."Action By");
            SenderAddress := GetActionBy(Incident."Action By");
            SenderName := GetActionName(Incident."Action By");
            Receipient.Add(Incident."User email Address");
            RecipientCC.Add(ICTSetup."Security E-Mail");
            RecipientBCC.add(ICTSetup."Registry BCC");
            Subject := Incident."Incident Reference" + ' Resolved';
            TimeNow := (Format(Time));
            SMTP.Create(Receipient, Subject, '', true);
            //if RecipientCC <> '' then SMTP.AddCC(RecipientCC);
            //if RecipientBCC <> '' then SMTP.AddBCC(RecipientBCC);
            SMTP.AppendtoBody(StrSubstNo(Text0001, Incident."Incident Reference", SenderName));
            Email.Send(SMTP);
            Message('Incident Successfully Logged');
        end;
    end;

    procedure GetActionBy(UserrID: Code[50]): Text
    var
        ActionByName: Text[250];
        ActionByEmail: Text[250];
    begin
        if UserSetup.Get(UserrID) then
            if Employee.Get(UserSetup.Picture) then begin
                ActionByEmail := Employee."E-Mail";
            end;
        exit(ActionByEmail);
    end;

    procedure GetActionName(UserrID: Code[50]): Text
    var
        ActionByName: Text[250];
    begin
        if UserSetup.Get(UserrID) then
            if Employee.Get(UserSetup.Picture) then begin
                ActionByName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        exit(ActionByName);
    end;

    procedure Escalate(IncidentNo: Code[20])
    var
        Text0001: Label 'text';
        Text002: Label 'Incident has been escalated Successfully';
    begin
        Incident.Reset;
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-') then begin
            ICTSetup.Get;
            SenderAddress := GetActionBy(Rec."Action By");
            SenderName := GetActionName(Rec."Action By");
            Receipient.add(ICTSetup."Escalation E-mail");
            RecipientCC.Add(ICTSetup."Security E-Mail");
            RecipientBCC.Add(ICTSetup."Registry BCC");
            Subject := 'Incident Escalation';
            Attachment := (ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
            TimeNow := Format(Time);
            SMTP.Create(Receipient, Subject, '', true);
            SMTP.AppendtoBody(StrSubstNo(Text0001));
            SMTP.AddAttachment(Attachment, FileName, '');
            Email.Send(SMTP);
            Message(Text002);
        end;
    end;
}
