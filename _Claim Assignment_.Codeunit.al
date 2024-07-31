codeunit 50129 "Claim Assignment"
{
    trigger OnRun()
    begin
        AssignClaim();
    end;
    var Text000: Label 'Please handle this claim. Note that this assignment is an automated process without any human intervention!!';
    TotalCaseHandlers: Integer;
    InteractionSetup: Record "Interaction Setup";
    local procedure AssignClaim()
    var
        CaseRec: Record "Client Interaction Header";
        CaseHandlerRec: Record "User Setup";
        AssignedUsers: Text;
        i: Integer;
        Assigned: Boolean;
        y: Integer;
        Resolution: Record "Resolution of Tasks Status";
        StepNo: Integer;
        Resolution2: Record "Resolution of Tasks Status";
    begin
        AssignedUsers:='';
        UpdateTempActives();
        InteractionSetup.Get;
        i:=1;
        y:=0;
        CaseRec.Reset;
        CaseRec.SetFilter(CaseRec."Assigned to User", '%1', '');
        // CaseRec.SetRange(Status, CaseRec.Status::"Awaiting Assignment");
        if CaseRec.Find('-')then repeat Assigned:=false;
                CaseHandlerRec.Reset;
                CaseHandlerRec.SetCurrentKey("Case Handler", "Temp Active Cases");
                CaseHandlerRec.SetRange("Case Handler", true);
                if InteractionSetup."Assign Claims to Oper./ Branch" then CaseHandlerRec.SetRange("Global Dimension 1 Code", CaseRec."Global Dimension 1 Code");
                if CaseHandlerRec.Find('-')then repeat if not(CaseHandlerRec."User ID" in[AssignedUsers])then begin
                            CaseRec."Assigned to User":=CaseHandlerRec."User ID";
                            CaseRec."Assign Remarks":=Text000;
                            CaseRec."Datetime Claim Assigned":=CreateDateTime(Today, Time);
                            // if InteractionSetup."Auto Assign on Operations" then
                            //     CaseRec.Status := CaseRec.Status::Assigned;
                            CaseRec.Modify;
                            NotifyUser(CaseRec);
                            Commit;
                            //Insert Log
                            Resolution.Reset;
                            Resolution.SetCurrentKey("Step No.");
                            Resolution.SetRange("Interaction Header No.", CaseRec."Interact Code");
                            if Resolution.FindLast then StepNo:=Resolution."Step No."
                            else
                                StepNo:=0;
                            Resolution2.Reset;
                            Resolution2.SetRange("Interaction Header No.", CaseRec."Interact Code");
                            Resolution2.SetRange("Header Status", Resolution2."Header Status"::"Awaiting Assignment");
                            if Resolution2.Find('-')then begin
                                Resolution2."Resolution Description":='Claim Assigned';
                                Resolution2."Assigned User From":=CaseRec."Registry User";
                                Resolution2."Assigned Date From":=CaseRec."Registry User DateTime Receive";
                                Resolution2."Assigned User To":=CaseRec."Assigned to User";
                                Resolution2."Assigned Date To":=CaseRec."Datetime Claim Assigned";
                                Resolution2."Header Status":=Resolution2."Header Status"::Assigned;
                                Resolution2."Resolution Status":=Resolution2."Resolution Status"::Completed;
                                Resolution2.Modify;
                            end;
                            Commit;
                            if i = 1 then AssignedUsers:=CaseHandlerRec."User ID"
                            else
                                AssignedUsers:=AssignedUsers + ',' + CaseHandlerRec."User ID";
                            Assigned:=true;
                            UpdateTempActives();
                            y:=y + 1;
                            if y = TotalCaseHandlers then AssignedUsers:='';
                            UpdateAssgnMovt(CaseRec."Interact Code", CaseHandlerRec."User ID", 0, 0);
                        end;
                    until(CaseHandlerRec.Next = 0) or Assigned;
                i:=i + 1;
            until CaseRec.Next = 0;
    end;
    procedure NotifyUser(CaseR: Record "Client Interaction Header")
    var
        CompanyInfo: record "Company Information";
        CaseRec: Record "Client Interaction Header";
        UserSetup: Record "User Setup";
        Emailmessage: Codeunit "Email Message";
        Email: Codeunit Email;
        SenderAddress: Text[80];
        Receipients: List of[Text];
        Subject: Text[150];
        Body: Text;
        SenderName: Text[80];
    begin
        CaseR.TestField("Assigned to User");
        UserSetup.Reset();
        UserSetup.SetRange("User ID", CaseR."Assigned to User");
        if UserSetup.Find('-')then begin
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderAddress:=CompanyInfo."E-Mail";
            SenderName:=CompanyName;
            Receipients.add(UserSetup."E-Mail");
            Body:=CaseR."Assign Remarks" + ' Interaction No. ' + CaseR."Interact Code" + ' Client' + CaseR."Client No.";
            Subject:='Interaction Assignment';
            Emailmessage.create(Receipients, Subject, '', true);
            Emailmessage.AppendToBody(Body);
            Email.Send(Emailmessage);
            Message('User Notified Successfully');
            // CaseR.Status := CaseR.Status::Assigned;
            CaseR.Modify();
        end;
    end;
    local procedure UpdateTempActives()
    var
        CaseHandlerRec: Record "User Setup";
    begin
        InteractionSetup.Get;
        TotalCaseHandlers:=0;
        CaseHandlerRec.Reset;
        CaseHandlerRec.SetRange("Case Handler", true);
        if CaseHandlerRec.Find('-')then repeat if InteractionSetup."Auto Assign on Registry" then begin
                    CaseHandlerRec.CalcFields("Active Registry Cases");
                    //CaseHandlerRec."Temp Active Cases":=CaseHandlerRec."Active Registry Cases";
                    CaseHandlerRec."Temp Active Cases":=GetActiveCasesAcrossCompanies(CaseHandlerRec."User ID", 0);
                end
                else if InteractionSetup."Auto Assign on Operations" then begin
                        CaseHandlerRec.CalcFields("Active Assigned Cases");
                        //CaseHandlerRec."Temp Active Cases":=CaseHandlerRec."Active Assigned Cases";
                        CaseHandlerRec."Temp Active Cases":=GetActiveCasesAcrossCompanies(CaseHandlerRec."User ID", 1);
                    end;
                CaseHandlerRec.Modify;
                TotalCaseHandlers:=TotalCaseHandlers + 1;
            until CaseHandlerRec.Next = 0;
    end;
    local procedure UpdateAssgnMovt(CaseNo: Code[20]; AssgnUser: Code[50]; InStatus: Option Assigned, Escalated; OutStatus: Option Closed, Escalated)
    var
        ClaimAssgnMovt: Record "Claim Assignment Movement";
    begin
        ClaimAssgnMovt.Init;
        ClaimAssgnMovt."Case Handler":=AssgnUser;
        ClaimAssgnMovt."Case No.":=CaseNo;
        ClaimAssgnMovt."Case Receipt Status":=InStatus;
        ClaimAssgnMovt."Case Clearance Status":=OutStatus;
        if not ClaimAssgnMovt.Get(AssgnUser, CaseNo)then ClaimAssgnMovt.Insert;
    end;
    procedure SendInteractionMail(Recipient: list of[text]; SenderName: Text; SenderAddress: Text; Body: Text; Subject: Text)
    var
        EmailmessageMail: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        EmailmessageMail.Create(Recipient, Subject, Body, TRUE);
        EMAIL.Send(EmailmessageMail);
    end;
    local procedure GetActiveCasesAcrossCompanies(CaseHandler: Code[70]; Type: Option Registry, Assigned, Payment): Decimal var
        ActiveCases: Integer;
        RegistryCases: Integer;
        Company: Record Company;
        UserSetup: Record "User Setup";
    begin
        Company.Reset;
        if Company.FindSet then begin
            repeat UserSetup.Reset;
                UserSetup.ChangeCompany(Company.Name);
                if UserSetup.Get(CaseHandler)then;
                UserSetup.CalcFields("Active Assigned Cases", "Active Registry Cases");
                ActiveCases:=ActiveCases + UserSetup."Active Assigned Cases";
                RegistryCases:=RegistryCases + UserSetup."Active Registry Cases";
            until Company.Next = 0;
        end;
        //Return Values
        case Type of Type::Registry: exit(RegistryCases);
        Type::Assigned: exit(ActiveCases);
        end;
    end;
    procedure SendIncident(IncidentNo: Code[50])
    var
        Emailmessage: Codeunit "Email Message";
        compinfo: Record "Company Information";
        Users: Record "User Setup";
        Employee: Record Employee;
        emp2: Record Employee;
        Body: Text[250];
        RSetup: Record "Resources Setup";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Text001: Label 'Are you sure you want to close this incident?';
        Text002: Label 'You want to resend the incident?';
        Text003: Label '\Attachment.%1';
        InStr: InStream;
        Fullname: Text[1024];
        FileRec: File;
        OutStr: OutStream;
        ICTSetup: Record "ICT Setup";
        Err0003: Label 'The issues has not been reolved.';
        jpg: Label '.jpg';
        FileMgnt: Codeunit "File Management";
        FileName: Text;
        Attachment: Text;
        Email: Codeunit Email;
        Incident: Record "User Support Incident";
        SenderName: Text[250];
        SenderAddress: Text[250];
        Receipient: list of[text];
        Subject: Text[250];
        TimeNow: Text;
        ReceipientCC: List of[text];
        ReceipientBCC: list of[text];
        UserSetup: Record "User Setup";
        CCRecipients: Integer;
        BCCRecipients: Integer;
        CompanyInfo: Record "Company Information";
        IncEscalation: Record "ICT Escalations";
    begin
        Incident.Reset;
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-')then begin
            ICTSetup.Get;
            ICTSetup.TestField("Security E-Mail");
            ICTSetup.TestField("Registry E-Mail");
            SenderName:=Incident."Employee Name";
            SenderAddress:=Incident."User email Address";
            Receipient.Add(ICTSetup."Registry E-Mail");
            ReceipientCC.Add(ICTSetup."Security E-Mail");
            ReceipientBCC.Add(ICTSetup."Registry BCC");
            Subject:=Incident."Incident Reference" + '' + CompanyName;
            Body:=Incident."Incident Description";
            FileName:=(ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
            TimeNow:=(Format(Time));
            Emailmessage.Create(Receipient, Subject, '', true);
            CCRecipients:=ReceipientCC.Count;
            if CCRecipients > 0 then //Emailmessage.AddCC(ReceipientCC);
                BCCRecipients:=ReceipientBCC.Count;
            if BCCRecipients > 0 then //Emailmessage.AddBCC(ReceipientBCC);
                Emailmessage.AppendToBody(StrSubstNo(Body));
            if Incident."Screen Shot".HasValue then begin
                Emailmessage.AddAttachment(FileName, Attachment, '');
            end;
            Email.Send(Emailmessage);
        end;
    end;
    procedure EscalateIncident(IncidentNo: Code[50]; EscOption: option; EscNo: code[20]; EscName: code[100]; EscEmail: text[100])
    var
        Space: Label '     ';
        NewBody: Label 'This is to notify you that the incident %1: %2 has been escalated to you.';
        Emailmessage: Codeunit "Email Message";
        compinfo: Record "Company Information";
        Users: Record "User Setup";
        Employee: Record Employee;
        emp2: Record Employee;
        Body: Text[250];
        RSetup: Record "Resources Setup";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Text001: Label 'Are you sure you want to close this incident?';
        Text002: Label 'You want to resend the incident?';
        Text003: Label '\Attachment.%1';
        InStr: InStream;
        Fullname: Text[1024];
        FileRec: File;
        OutStr: OutStream;
        ICTSetup: Record "ICT Setup";
        Err0003: Label 'The issues has not been reolved.';
        jpg: Label '.jpg';
        FileMgnt: Codeunit "File Management";
        FileName: Text;
        Attachment: Text;
        Incident: Record "User Support Incident";
        SenderName: Text[250];
        SenderAddress: Text[250];
        Receipient: list of[text];
        Subject: Text[250];
        TimeNow: Text;
        ReceipientCC: List of[text];
        ReceipientBCC: list of[text];
        UserSetup: Record "User Setup";
        CCRecipients: Integer;
        BCCRecipients: Integer;
        CompanyInfo: Record "Company Information";
        IncEscalation: Record "ICT Escalations";
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
    begin
        Incident.Reset;
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-')then begin
            Incident.CALCFIELDS("E-Mail Body");
            Incident."E-Mail Body".CREATEINSTREAM(InStrm);
            EmailBigTxt.READ(InStrm);
            EmailTxt:=FORMAT(EmailBigTxt);
            Incident."Escalate To Name":=EscName;
            Incident."Escalation option":=EscOption;
            Incident."Escalation email Address":=EscEmail;
            Incident.Status:=Incident.Status::Escalated;
            Incident.Modify();
            IncEscalation.Init();
            IncEscalation."No.":=IncidentNo;
            IncEscalation."Escalation date":=Today;
            IncEscalation."Escalation Time":=time;
            IncEscalation."Escalator No.":=EscNo;
            IncEscalation."Escalator Name":=EscName;
            IncEscalation."Escalation Email":=EscEmail;
            IncEscalation."Escalation Option":=EscOption;
            IncEscalation.Insert();
            if GuiAllowed then Message('The Incident %1 has been escalated successfully', Incident."Incident Reference");
        end;
    end;
    procedure NotifyEscalatedIncident(IncidentNo: Code[50])
    var
        Space: Label '     ';
        NewBody: Label 'This is to notify you that the incident %1: %2 has been escalated to you.';
        Emailmessage: Codeunit "Email Message";
        compinfo: Record "Company Information";
        Users: Record "User Setup";
        Employee: Record Employee;
        emp2: Record Employee;
        Body: Text[250];
        RSetup: Record "Resources Setup";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Text001: Label 'Are you sure you want to close this incident?';
        Text002: Label 'You want to resend the incident?';
        Text003: Label '\Attachment.%1';
        InStr: InStream;
        Fullname: Text[1024];
        FileRec: File;
        OutStr: OutStream;
        email: Codeunit Email;
        ICTSetup: Record "ICT Setup";
        Err0003: Label 'The issues has not been reolved.';
        jpg: Label '.jpg';
        FileMgnt: Codeunit "File Management";
        FileName: Text;
        FileName2: Text;
        Attachment: Text;
        Incident: Record "User Support Incident";
        SenderName: Text[250];
        SenderAddress: Text[250];
        Receipient: list of[text];
        Subject: Text[250];
        TimeNow: Text;
        ReceipientCC: List of[text];
        ReceipientBCC: list of[text];
        UserSetup: Record "User Setup";
        CCRecipients: Integer;
        BCCRecipients: Integer;
        CompanyInfo: Record "Company Information";
        IncEscalation: Record "ICT Escalations";
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        IncidentRecID: RecordId;
        EmailTxt: Text;
        RecLink: Record "Record Link";
    begin
        Incident.Reset;
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.Find('-')then begin
            IncidentRecID:=Incident.RecordId;
            Incident.CALCFIELDS("E-Mail Body");
            Incident."E-Mail Body".CREATEINSTREAM(InStrm);
            EmailBigTxt.READ(InStrm);
            EmailTxt:=FORMAT(EmailBigTxt);
            Clear(FileName2);
            Clear(Receipient);
            RecLink.Reset();
            RecLink.SetRange("Record ID", IncidentRecID);
            if RecLink.FindLast()then FileName2:=RecLink.URL1;
            Incident.CalcFields("E-Mail Body");
            ICTSetup.Get();
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Subject:=Incident."Incident Reference" + Space + Incident."Incident Description";
            Receipient.Add(Incident."Escalation email Address");
            Body:=EmailTxt;
            FileName:=(ICTSetup."Screenshot Path" + Incident."Incident Reference" + '.jpg');
            TimeNow:=(Format(Time));
            Emailmessage.Create(Receipient, Subject, '', true);
            Emailmessage.AppendToBody(StrSubstNo(Body, (Incident."Incident Reference"), Incident."Incident Description"));
            if Incident."Escalation option" <> Incident."Escalation option"::External then begin
                if Incident."Screen Shot".HasValue then Emailmessage.AddAttachment(FileName, Attachment, '');
            end;
            if Incident."Escalation option" = Incident."Escalation option"::External then begin
                if FileName2 <> '' then Emailmessage.AddAttachment(FileName2, Attachment, '');
            end;
            email.Send(Emailmessage);
            if email.Send(Emailmessage)then Message('The escalatee has been notified');
        end;
    end;
    procedure EscalateCRMInteraction(IncidentNo: Code[50]; EscNo: code[20]; EscName: code[100]; EscEmail: text[100]; EscUseriD: Code[50]; EscRemarks: Text[200])
    var
        Space: Label '     ';
        NewBody: Label 'This is to notify you that the client interaction %1 has been escalated to you.';
        Emailmessage: Codeunit "Email Message";
        compinfo: Record "Company Information";
        Users: Record "User Setup";
        Employee: Record Employee;
        emp2: Record Employee;
        Body: Text[250];
        RSetup: Record "Resources Setup";
        Err0001: Label 'Resources setup doesn''t exist';
        Err0002: Label 'The incidence has already been sent!';
        Text001: Label 'Are you sure you want to close this incident?';
        Text002: Label 'You want to resend the incident?';
        Text003: Label '\Attachment.%1';
        InStr: InStream;
        Fullname: Text[1024];
        FileRec: File;
        OutStr: OutStream;
        Err0003: Label 'The issues has not been reolved.';
        jpg: Label '.jpg';
        FileMgnt: Codeunit "File Management";
        FileName: Text;
        Attachment: Text;
        Incident: Record "Client Interaction Header";
        SenderName: Text[250];
        SenderAddress: Text[250];
        Receipient: list of[text];
        email: Codeunit email;
        Subject: Text[250];
        TimeNow: Text;
        ReceipientCC: List of[text];
        ReceipientBCC: list of[text];
        UserSetup: Record "User Setup";
        CCRecipients: Integer;
        BCCRecipients: Integer;
        CompanyInfo: Record "Company Information";
        IncEscalation: Record "Interaction Escalations";
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
    begin
        Incident.Reset;
        Incident.SetRange("Interact Code", IncidentNo);
        if Incident.Find('-')then begin
            // with Incident do begin
            //     CALCFIELDS("E-Mail Body");
            //     "E-Mail Body".CREATEINSTREAM(InStrm);
            //     EmailBigTxt.READ(InStrm);
            //     EmailTxt := FORMAT(EmailBigTxt);
            // end;
            //Incident.CalcFields("E-Mail Body");
            CompanyInfo.Get;
            CompanyInfo.TestField(Name);
            CompanyInfo.TestField("E-Mail");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Subject:=Incident."Interact Code";
            Receipient.Add(EscEmail);
            Body:=EmailTxt;
            TimeNow:=(Format(Time));
            Emailmessage.Create(Receipient, Subject, '', true);
            CCRecipients:=ReceipientCC.Count;
            if CCRecipients > 0 then //eddieEmailmessage.AddCC(ReceipientCC);
                BCCRecipients:=ReceipientBCC.Count;
            if BCCRecipients > 0 then //eddieEmailmessage.AddBCC(ReceipientBCC);
                Emailmessage.AppendtoBody(StrSubstNo(Body, (Incident."Interact Code")));
            email.Send(Emailmessage);
            IncEscalation.Init();
            IncEscalation."Interaction Code":=IncidentNo;
            IncEscalation.User:=Incident."Escalation To User ID";
            IncEscalation."Escalation Employee No.":=EscNo;
            IncEscalation.Remarks:=EscRemarks;
            IncEscalation.DateTime:=CreateDateTime(Today, Time);
            IncEscalation."Escalation Employee Name":=EscName;
            IncEscalation.Notes:=Incident.Notes;
            IncEscalation.Insert();
            // Incident.Status := Incident.Status::Escalated;
            Incident."Escalation Employee No.":=EscNo;
            Incident.Validate("Escalation Employee No.");
            Incident."Escalation Employee Name":=EscName;
            //Incident.Escalate := true;
            Incident."Escalation Employee Email":=EscEmail;
            Incident."Escalation To User ID":=EscUseriD;
            Incident."Escalation Remarks":=EscRemarks;
            Incident.Stage:=Incident.Stage::Escalated;
            Incident."Is Escalated":=true;
            Incident.Notes:='';
            Incident.Modify();
            if GuiAllowed then Message('The interaction %1 has been escalated successfully', Incident."Interact Code");
        end;
    end;
}
